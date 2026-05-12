'use strict';

const RANK_EVENT_NAMES = [
  'user.registered',
  'user_profile.visibility_updated',
  'flashcard.created',
  'flashcard.reviewed',
  'flashcard.review_tier_promoted',
  'article.created',
];

const pickUserId = (payload = {}) =>
  payload.userid
  || payload.userId
  || null;

const pickUsername = (payload = {}) =>
  payload.username
  || payload.userName
  || null;

const adaptPluginEvent = (event) => {
  const payload = event?.payload || {};
  const userid = pickUserId(payload);
  const username = pickUsername(payload);

  return {
    event_name: event.event_name,
    event_id: event.event_id || event.id,
    userid: userid == null ? null : String(userid),
    username,
    flashcard_id: payload.flashcardId || null,
    article_id: payload.articleId || null,
    payload,
  };
};

module.exports = ({ strapi }) => ({
  async register() {
    const eventBus = strapi.plugin('event-bus').service('event-bus');
    const handleRankEvent = strapi.plugin('rank-system').service('handle-event');

    for (const eventName of RANK_EVENT_NAMES) {
      eventBus.unsubscribe(eventName, 'rank');
      eventBus.subscribe(eventName, 'rank', async (event) => {
        strapi.log.info(`[Rank] handling event: ${event.event_name}`);
        const adaptedEvent = adaptPluginEvent(event);
        await handleRankEvent(adaptedEvent);
      });
    }

    strapi.log.info('[Rank] registered event-bus subscribers');
  },
});

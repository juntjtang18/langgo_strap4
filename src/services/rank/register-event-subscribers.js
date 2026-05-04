'use strict';

const handleRankEvent = require('./handle-event');

const RANK_EVENT_NAMES = [
  'user.register',
  'flashcard.create',
  'flashcard.review',
  'flashcard.review_tier_promote',
  'article.create',
];

const pickUserId = (payload = {}) =>
  payload.userid
  || payload.userId
  || payload.review?.userid
  || payload.review?.userId
  || payload.flashcard?.userid
  || payload.flashcard?.userId
  || payload.article?.userid
  || payload.article?.userId
  || null;

const pickUsername = (payload = {}) =>
  payload.username
  || payload.userName
  || payload.review?.username
  || payload.review?.userName
  || payload.flashcard?.username
  || payload.flashcard?.userName
  || payload.article?.username
  || payload.article?.userName
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
    flashcard_id: payload.flashcardId || payload.flashcard?.flashcardId || payload.review?.flashcardId || null,
    article_id: payload.articleId || payload.article?.articleId || payload.article?.userArticleId || null,
    review: payload.review || null,
    flashcard: payload.flashcard || null,
    article: payload.article || null,
  };
};

module.exports = async ({ strapi }) => {
  const eventBus = strapi.plugin('event-bus').service('event-bus');

  for (const eventName of RANK_EVENT_NAMES) {
    eventBus.unsubscribe(eventName, 'rank');
    eventBus.subscribe(eventName, 'rank', async (event) => {
      strapi.log.info(`[Rank] handling event: ${event.event_name}`);
      const adaptedEvent = adaptPluginEvent(event);
      await handleRankEvent({ strapi, event: adaptedEvent });
    });
  }

  strapi.log.info('[Rank] registered event-bus subscribers');
};

'use strict';

const ACHIEVEMENT_EVENT_NAMES = [
  'user.register',
  'flashcard.create',
  'flashcard.review',
  'flashcard.review_tier_promote',
  'article.create',
];

module.exports = ({ strapi }) => ({
  async register() {
    const eventBus = strapi.plugin('event-bus').service('event-bus');
    const handleAchievementEvent = strapi.plugin('achievement').service('handle-event');

    for (const eventName of ACHIEVEMENT_EVENT_NAMES) {
      eventBus.unsubscribe(eventName, 'achievement');
      eventBus.subscribe(eventName, 'achievement', async (event) => {
        strapi.log.info(`[Achievement] handling event: ${event.event_name}`);
        await handleAchievementEvent(event);
      });
    }

    strapi.log.info('[Achievement] registered event-bus subscribers');
  },
});

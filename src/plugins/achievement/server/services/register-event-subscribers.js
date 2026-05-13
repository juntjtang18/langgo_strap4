'use strict';

module.exports = ({ strapi }) => ({
  async register() {
    const eventBus = strapi.plugin('event-bus').service('event-bus');
    const handleAchievementEvent = strapi.plugin('achievement').service('handle-event');
    const eventRows = await strapi.entityService.findMany('plugin::achievement.as-event-list', {
      fields: ['event_name'],
      sort: [{ id: 'asc' }],
      limit: 1000,
    });
    const eventNames = Array.from(new Set(
      eventRows
        .map((row) => row.event_name)
        .filter((eventName) => typeof eventName === 'string' && eventName.length > 0)
    ));

    for (const eventName of eventNames) {
      eventBus.unsubscribe(eventName, 'achievement');
      eventBus.subscribe(eventName, 'achievement', async (event) => {
        strapi.log.info(`[Achievement] handling event: ${event.event_name}`);
        await handleAchievementEvent(event);
      });
    }

    strapi.log.info('[Achievement] registered event-bus subscribers');
  },
});

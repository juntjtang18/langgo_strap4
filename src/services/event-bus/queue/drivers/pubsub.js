'use strict';

// Pub/Sub driver — fire-and-forget producer.
// The consumer (Cloud Run / Cloud Function) is responsible for calling
// POST /rank/events on its own.  waitForIdle is a no-op because delivery
// is async; callers that need local consistency should use the internal driver.
module.exports = ({ strapi }) => {
  const topicName = process.env.EVENT_BUS_TOPIC || 'langgo-events';

  return {
    enqueue(eventObj) {
      const pubsub = strapi.service('pubsub');
      if (!pubsub?.isConfigured()) {
        strapi.log.warn('[EventBus/pubsub] Pub/Sub not configured — dropping event:', eventObj.event_name);
        return;
      }
      pubsub.publish(topicName, eventObj).catch((err) => {
        strapi.log.error(`[EventBus/pubsub] Publish failed for "${eventObj.event_name}": ${err.message}`);
      });
    },

    waitForIdle() {
      return Promise.resolve();
    },
  };
};

'use strict';

const getTopicName = () =>
  process.env.EVENT_QUEUE_TOPIC ||
  process.env.REVIEW_EVENT_QUEUE_TOPIC ||
  'flashcard-review-events';

module.exports = ({ strapi }) => ({
  name: 'pubsub',

  async enqueue(event) {
    const topicName = getTopicName();

    const messageId = await strapi.service('pubsub').publishJson(
      topicName,
      event,
      {
        eventType: event?.event || 'unknown',
        source: 'langgo-strapi4',
      }
    );

    return {
      queued: true,
      driver: 'pubsub',
      topicName,
      messageId,
    };
  },
});

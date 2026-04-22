'use strict';

module.exports = ({ strapi }) => ({
  async dispatchEvent(event) {
    return strapi.service('review-event-queue').dispatch(event);
  },

  async dispatchReviewCompleted(event) {
    return strapi.service('review-event-queue').dispatchReviewCompleted(event);
  },

  async dispatchWordDefinitionCreated(event) {
    return strapi.service('review-event-queue').dispatchWordDefinitionCreated(event);
  },

  async waitForIdle(timeoutMs) {
    return strapi.service('review-event-queue').waitForIdle(timeoutMs);
  },
});

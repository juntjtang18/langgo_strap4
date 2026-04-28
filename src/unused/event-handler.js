'use strict';

module.exports = ({ strapi }) => ({
  async handle(event) {
    return strapi.service('review-event-handler').handleEvent(event);
  },

  async handleReviewCompleted(event) {
    return strapi.service('review-event-handler').handleReviewCompleted(event);
  },

  async handleWordDefinitionCreated(event) {
    return strapi.service('review-event-handler').handleWordDefinitionCreated(event);
  },

  async handleArticleCreated(event) {
    return strapi.service('review-event-handler').handleArticleCreated(event);
  },
});

'use strict';

module.exports = ({ strapi }) => ({
  getRecordDate(...args) {
    return strapi.service('review-reward-service').getRecordDate(...args);
  },

  getPointRule(...args) {
    return strapi.service('review-reward-service').getPointRule(...args);
  },

  getHonorTitleRule(...args) {
    return strapi.service('review-reward-service').getHonorTitleRule(...args);
  },

  getHonorTitles(...args) {
    return strapi.service('review-reward-service').getHonorTitles(...args);
  },

  getPointGroupRule(...args) {
    return strapi.service('review-reward-service').getPointGroupRule(...args);
  },

  getGroupRanks(...args) {
    return strapi.service('review-reward-service').getGroupRanks(...args);
  },

  calculatePeriodPoints(...args) {
    return strapi.service('review-reward-service').calculatePeriodPoints(...args);
  },

  splitPointGroupIfNeeded(...args) {
    return strapi.service('review-reward-service').splitPointGroupIfNeeded(...args);
  },

  syncUserPointGroupAssignment(...args) {
    return strapi.service('review-reward-service').syncUserPointGroupAssignment(...args);
  },

  syncHonorTitle(...args) {
    return strapi.service('review-reward-service').syncHonorTitle(...args);
  },

  calculateReviewPoints(...args) {
    return strapi.service('review-reward-service').calculatePoints(...args);
  },

  calculateWordDefinitionPoints(...args) {
    return strapi.service('review-reward-service').calculateWordDefinitionPoints(...args);
  },

  calculateArticlePoints(...args) {
    return strapi.service('review-reward-service').calculateArticlePoints(...args);
  },

  applyReviewEvent(...args) {
    return strapi.service('review-reward-service').applyReviewEvent(...args);
  },

  applyWordDefinitionCreatedEvent(...args) {
    return strapi.service('review-reward-service').applyWordDefinitionCreatedEvent(...args);
  },

  applyArticleCreatedEvent(...args) {
    return strapi.service('review-reward-service').applyArticleCreatedEvent(...args);
  },
});

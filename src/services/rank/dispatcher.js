'use strict';

const { v4: uuidv4 } = require('uuid');

module.exports = ({ strapi }) => ({
  async dispatch(eventName, userid, payload = {}) {
    try {
      return await strapi.service('rank-event-processor').processEvent({
        event_id: uuidv4(),
        event_name: eventName,
        userid: String(userid),
        payload,
      });
    } catch (error) {
      strapi.log.error(`[Rank] Dispatch failed for "${eventName}" / user "${userid}": ${error.message}`);
    }
  },

  async onUserRegister(userid) {
    return this.dispatch('user.register', userid);
  },

  async onFlashcardCreate(userid, flashcardId) {
    return this.dispatch('flashcard.create', userid, { flashcardId });
  },

  async onFlashcardReview(userid, flashcardId, review = null) {
    return this.dispatch('flashcard.review', userid, {
      flashcardId,
      ...(review ? { review } : {}),
    });
  },

  async onFlashcardReviewTierPromote(userid, flashcardId, review = null) {
    return this.dispatch('flashcard.review_tier_promote', userid, {
      flashcardId,
      ...(review ? { review } : {}),
    });
  },

  async onArticleCreate(userid, articleId) {
    return this.dispatch('article.create', userid, { articleId });
  },
});

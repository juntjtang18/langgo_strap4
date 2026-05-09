'use strict';

const { v4: uuidv4 } = require('uuid');

module.exports = ({ strapi }) => ({
  async dispatch(eventName, userid, payload = {}, username = null, eventId = null) {
    try {
      return await strapi.plugin('rank-system').service('event-processor').processEvent({
        event_id: eventId || uuidv4(),
        event_name: eventName,
        userid: String(userid),
        ...(username ? { username } : {}),
        payload,
      });
    } catch (error) {
      strapi.log.error(`[Rank] Dispatch failed for "${eventName}" / user "${userid}": ${error.message}`);
    }
  },

  async onUserRegister(userid, username = null, eventId = null, payload = {}) {
    return this.dispatch('user.register', userid, {
      ...(username ? { username } : {}),
      ...payload,
    }, username, eventId);
  },

  async onUserProfileUpdate(userid, username = null, eventId = null, payload = {}) {
    return this.dispatch('user.profile.update', userid, {
      ...(username ? { username } : {}),
      ...payload,
    }, username, eventId);
  },

  async onFlashcardCreate(userid, flashcardId, username = null, eventId = null, flashcard = null) {
    return this.dispatch('flashcard.create', userid, {
      flashcardId,
      ...(flashcard ? { flashcard } : {}),
      ...(username ? { username } : {}),
    }, username, eventId);
  },

  async onFlashcardReview(userid, flashcardId, review = null, username = null, eventId = null) {
    return this.dispatch('flashcard.review', userid, {
      flashcardId,
      ...(review ? { review } : {}),
      ...(username ? { username } : {}),
    }, username, eventId);
  },

  async onFlashcardReviewTierPromote(userid, flashcardId, review = null, username = null, eventId = null) {
    return this.dispatch('flashcard.review_tier_promote', userid, {
      flashcardId,
      ...(review ? { review } : {}),
      ...(username ? { username } : {}),
    }, username, eventId);
  },

  async onArticleCreate(userid, articleId, username = null, eventId = null, article = null) {
    return this.dispatch('article.create', userid, {
      articleId,
      ...(article ? { article } : {}),
      ...(username ? { username } : {}),
    }, username, eventId);
  },
});

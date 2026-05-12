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
    return this.dispatch('user.registered', userid, {
      ...(username ? { username } : {}),
      ...payload,
    }, username, eventId);
  },

  async onUserProfileUpdate(userid, username = null, eventId = null, payload = {}) {
    return this.dispatch('user_profile.visibility_updated', userid, {
      ...(username ? { username } : {}),
      ...payload,
    }, username, eventId);
  },

  async onFlashcardCreate(userid, flashcardId, username = null, eventId = null, flashcard = null) {
    return this.dispatch('flashcard.created', userid, {
      flashcardId,
      ...(flashcard || {}),
      ...(username ? { username } : {}),
    }, username, eventId);
  },

  async onFlashcardReview(userid, flashcardId, review = null, username = null, eventId = null) {
    return this.dispatch('flashcard.reviewed', userid, {
      flashcardId,
      ...(review || {}),
      ...(username ? { username } : {}),
    }, username, eventId);
  },

  async onFlashcardReviewTierPromote(userid, flashcardId, review = null, username = null, eventId = null) {
    return this.dispatch('flashcard.review_tier_promoted', userid, {
      flashcardId,
      ...(review || {}),
      ...(username ? { username } : {}),
    }, username, eventId);
  },

  async onArticleCreate(userid, articleId, username = null, eventId = null, article = null) {
    return this.dispatch('article.created', userid, {
      articleId,
      ...(article || {}),
      ...(username ? { username } : {}),
    }, username, eventId);
  },
});

'use strict';

const { v4: uuidv4 } = require('uuid');

module.exports = ({ queue, strapi }) => {
  const loadUsername = async (userId, fallback = null) => {
    const numericId = Number(userId);
    if (!Number.isInteger(numericId)) {
      return fallback || null;
    }

    try {
      const user = await strapi.entityService.findOne('plugin::users-permissions.user', numericId, {
        fields: ['username'],
      });
      return user?.username || fallback || null;
    } catch (error) {
      strapi.log.warn?.(`[EventBus] Unable to resolve username for user ${userId}: ${error.message}`);
      return fallback || null;
    }
  };

  return {
    async dispatchFlashcardReviewCompleted(event) {
      const { review, eventId } = event;
      const id = eventId || uuidv4();
      const userid = String(review.userId);
      const username = await loadUsername(review.userId, review.username || review.userName || null);

      queue.enqueue({
        event_name: 'flashcard.review',
        event_id: id,
        userid,
        username,
        flashcard_id: review.flashcardId,
        review: {
          ...review,
          userId: review.userId,
          userid,
          username,
        },
      });
    },

    async dispatchFlashcardReviewTierPromote(event) {
      const { review, eventId } = event;
      const id = eventId || uuidv4();
      const userid = String(review.userId);
      const username = await loadUsername(review.userId, review.username || review.userName || null);

      queue.enqueue({
        event_name: 'flashcard.review_tier_promote',
        event_id: id,
        userid,
        username,
        flashcard_id: review.flashcardId,
        review: {
          ...review,
          userId: review.userId,
          userid,
          username,
        },
      });
    },

    async dispatchFlashcardCreate(event) {
      const { flashcard, eventId } = event;
      const username = await loadUsername(flashcard.userId, flashcard.username || null);

      queue.enqueue({
        event_name: 'flashcard.create',
        event_id: eventId || uuidv4(),
        userid: String(flashcard.userId),
        username,
        flashcard_id: flashcard.flashcardId,
        flashcard: {
          ...flashcard,
          userId: flashcard.userId,
          userid: String(flashcard.userId),
          username,
        },
      });
    },

    async dispatchArticleCreate(event) {
      const { article, eventId } = event;
      const username = await loadUsername(article.userId, article.username || null);

      queue.enqueue({
        event_name: 'article.create',
        event_id: eventId || uuidv4(),
        userid: String(article.userId),
        username,
        article_id: article.userArticleId,
        article: {
          ...article,
          userId: article.userId,
          userid: String(article.userId),
          username,
        },
      });
    },

    async dispatchUserRegister(userid) {
      const username = await loadUsername(userid);

      queue.enqueue({
        event_name: 'user.register',
        event_id: uuidv4(),
        userid: String(userid),
        username,
      });
    },

    waitForIdle(timeoutMs = 5000) {
      return queue.waitForIdle(timeoutMs);
    },
  };
};

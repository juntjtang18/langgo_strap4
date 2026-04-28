'use strict';

const TIER_ORDER = ['new', 'warmup', 'daily', 'weekly', 'monthly', 'remembered'];
const tierRank = (level) => TIER_ORDER.indexOf((level || '').toLowerCase());

module.exports = ({ strapi }) => {
  const rank = () => strapi.service('rank-dispatcher');

  return {
    // flashcard.review.completed
    //   → review-event-queue  (reviewlog creation — still active)
    //   → rank: flashcard.review
    //   → rank: flashcard.review_tier_promote  (when tier level went up)
    async dispatchReviewCompleted(event) {
      await strapi.service('review-event-queue').dispatchReviewCompleted(event);

      const { review } = event || {};
      if (!review?.userId) return;

      const userid = String(review.userId);
      await rank().onFlashcardReview(userid, review.flashcardId);

      if (tierRank(review.newlevel) > tierRank(review.level)) {
        await rank().onFlashcardReviewTierPromote(userid, review.flashcardId);
      }
    },

    // word_definition.created
    //   → review-event-queue  (handler is now a stub, but kept for compatibility)
    //   → rank: flashcard.create
    async dispatchWordDefinitionCreated(event) {
      await strapi.service('review-event-queue').dispatchWordDefinitionCreated(event);

      const { wordDefinition } = event || {};
      if (!wordDefinition?.userId) return;

      await rank().onFlashcardCreate(
        String(wordDefinition.userId),
        wordDefinition.flashcardId
      );
    },

    // user_article.created
    //   → review-event-queue  (handler is now a stub, but kept for compatibility)
    //   → rank: article.create
    async dispatchArticleCreated(event) {
      await strapi.service('review-event-queue').dispatchArticleCreated(event);

      const { article } = event || {};
      if (!article?.userId) return;

      await rank().onArticleCreate(String(article.userId), article.userArticleId);
    },

    async waitForIdle(timeoutMs) {
      return strapi.service('review-event-queue').waitForIdle(timeoutMs);
    },
  };
};

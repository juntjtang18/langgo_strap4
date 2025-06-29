'use strict';

/**
 * flashcard controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::flashcard.flashcard', ({ strapi }) => ({
  /**
   * Custom controller action to find flashcards ready for review.
   * This implements the spaced repetition logic.
   *
   * @param {object} ctx - The Koa context.
   */
  async findForReview(ctx) {
    // 1. Ensure a user is authenticated
    const { user } = ctx.state;
    if (!user) {
      strapi.log.warn('Attempt to access review flashcards without authentication.');
      return ctx.unauthorized('You must be logged in to review flashcards.');
    }

    strapi.log.info(`Starting review session fetch for user: ${user.id}`);

    const now = new Date();

    // 2. Calculate date cutoffs for weekly and monthly reviews
    const sevenDaysAgo = new Date(now);
    sevenDaysAgo.setDate(now.getDate() - 7);

    const thirtyDaysAgo = new Date(now);
    thirtyDaysAgo.setDate(now.getDate() - 30);
    
    strapi.log.debug(`Date cutoffs - 7 days ago: ${sevenDaysAgo.toISOString()}, 30 days ago: ${thirtyDaysAgo.toISOString()}`);

    try {
      // **PERFORMANCE OPTIMIZATION 1: More Specific Population**
      // This object now specifies the exact fields needed, avoiding over-fetching of metadata
      // like user permissions, createdBy, updatedBy, etc., which significantly reduces query complexity.
      const commonPopulate = {
        content: {
          populate: {
            word: {
              populate: ['tags', 'verb_meta', 'audio'],
            },
            sentence: {
              populate: ['tags', 'words', 'target_audio'],
            },
            user_word: {
              populate: {
                fields: ['word', 'base_text', 'part_of_speech'],
              },
            },
            user_sentence: {
              populate: {
                fields: ['target_text', 'base_text'],
              },
            },
          },
        },
      };

      // **PERFORMANCE OPTIMIZATION 2: Single Database Query**
      // Instead of three separate queries, we combine the logic into a single query using $or.
      // This drastically reduces database overhead.
      strapi.log.info(`[User: ${user.id}] Fetching all review cards in a single query...`);
      const allReviewCards = await strapi.entityService.findMany('api::flashcard.flashcard', {
        where: {
          user: user.id,
          is_remembered: { $ne: true },
          $or: [
            // Daily tier condition
            {
              $or: [
                { daily_streak: { $lt: 3 } },
                { daily_streak: { $null: true } }
              ]
            },
            // Weekly tier condition
            {
              daily_streak: { $gte: 3 },
              weekly_streak: { $lt: 3 },
              last_reviewed_at: { $lte: sevenDaysAgo.toISOString() },
            },
            // Monthly tier condition
            {
              weekly_streak: { $gte: 3 },
              monthly_streak: { $lt: 2 },
              last_reviewed_at: { $lte: thirtyDaysAgo.toISOString() },
            }
          ]
        },
        populate: commonPopulate,
      });

      // The results are already unique since they come from a single query.
      strapi.log.info(`[User: ${user.id}] Total unique cards to be returned: ${allReviewCards.length}`);

      // 5. Return the combined list of cards
      const sanitizedResults = await this.transformResponse(allReviewCards);
      return sanitizedResults;

    } catch (err) {
      strapi.log.error(`[User: ${user.id}] Error fetching review flashcards: ${err.message}`, err.stack);
      ctx.body = err;
      return ctx.internalServerError('An error occurred while fetching review flashcards.');
    }
  }
}));

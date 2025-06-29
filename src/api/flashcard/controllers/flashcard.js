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
      // **REFACTOR**: Switched from `strapi.db.query` to `strapi.entityService` for more robust querying.
      const commonPopulate = {
        content: {
          populate: '*',
        },
      };

      // 3. Query for each tier of flashcards separately
      strapi.log.info(`[User: ${user.id}] Fetching DAILY review cards...`);
      const dailyCards = await strapi.entityService.findMany('api::flashcard.flashcard', {
        where: {
          user: user.id,
          is_remembered: { $ne: true },
          $or: [
            { daily_streak: { $lt: 3 } },
            { daily_streak: { $null: true } }
          ]
        },
        populate: commonPopulate,
      });
      strapi.log.info(`[User: ${user.id}] Found ${dailyCards.length} DAILY cards.`);

      strapi.log.info(`[User: ${user.id}] Fetching WEEKLY review cards...`);
      const weeklyCards = await strapi.entityService.findMany('api::flashcard.flashcard', {
        where: {
          user: user.id,
          is_remembered: { $ne: true },
          daily_streak: { $gte: 3 },
          weekly_streak: { $lt: 3 },
          last_reviewed_at: { $lte: sevenDaysAgo.toISOString() },
        },
        populate: commonPopulate,
      });
      strapi.log.info(`[User: ${user.id}] Found ${weeklyCards.length} WEEKLY cards.`);

      strapi.log.info(`[User: ${user.id}] Fetching MONTHLY review cards...`);
      const monthlyCards = await strapi.entityService.findMany('api::flashcard.flashcard', {
        where: {
          user: user.id,
          is_remembered: { $ne: true },
          weekly_streak: { $gte: 3 },
          monthly_streak: { $lt: 2 },
          last_reviewed_at: { $lte: thirtyDaysAgo.toISOString() },
        },
        populate: commonPopulate,
      });
      strapi.log.info(`[User: ${user.id}] Found ${monthlyCards.length} MONTHLY cards.`);

      // 4. Combine and sanitize the results
      const allReviewCards = [...dailyCards, ...weeklyCards, ...monthlyCards];

      // Use a Map to ensure no duplicates if a card somehow matches multiple criteria
      const uniqueCards = new Map(allReviewCards.map(card => [card.id, card]));
      const results = Array.from(uniqueCards.values());
      
      strapi.log.info(`[User: ${user.id}] Total unique cards to be returned: ${results.length}`);

      // 5. Return the combined list of cards
      const sanitizedResults = await this.transformResponse(results);
      return sanitizedResults;

    } catch (err) {
      strapi.log.error(`[User: ${user.id}] Error fetching review flashcards: ${err.message}`, err.stack);
      ctx.body = err;
      return ctx.internalServerError('An error occurred while fetching review flashcards.');
    }
  }
}));

'use strict';

/**
 * flashcard controller
 */

const { createCoreController } = require('@strapi/strapi').factories;
// Helper function to find the correct review tier based on a streak
const findTierForStreak = (streak, tiers) => {
  // Tiers should be sorted by min_streak ascending
  return tiers.find(tier => streak >= tier.min_streak && streak <= tier.max_streak) || tiers[tiers.length - 1];
};

// Helper function to determine the review level for logging
const getReviewLevel = (tier) => {
  if (!tier || !tier.tier) return null;
  const tierName = tier.tier.toLowerCase();
  if (["daily", "warmup"].includes(tierName)) return "daily";
  if (["weekly", "monthly"].includes(tierName)) return tierName;
  return null;
};

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
  },
  /**
   * Handles a review action for a single flashcard.
   * This implements the full spaced repetition logic.
   *
   * @param {object} ctx The Koa context.
   */
  async review(ctx) {
    const { user } = ctx.state;
    if (!user) {
      return ctx.unauthorized('Authentication required.');
    }

    const { id } = ctx.params;
    const { result } = ctx.request.body;

    if (!['correct', 'wrong'].includes(result)) {
      return ctx.badRequest('Invalid "result" parameter. Must be "correct" or "wrong".');
    }

    strapi.log.info(`Review started for card ${id} by user ${user.id} with result: ${result}`);

    try {
      const [updatedFlashcard] = await strapi.db.transaction(async () => { // The trx object is not needed here
        // CORRECTED: Use strapi.db.query, not trx.query.
        // Strapi handles the transaction context automatically inside this block.
        const flashcard = await strapi.db.query('api::flashcard.flashcard').findOne({ where: { id, user: user.id } });
        const reviewTiers = await strapi.db.query('api::review-tire.review-tire').findMany({ orderBy: { min_streak: 'asc' } });

        if (!flashcard) {
          throw new Error('Flashcard not found or user mismatch.');
        }

        const now = new Date();
        const currentTier = findTierForStreak(flashcard.correct_streak, reviewTiers);
        if (!currentTier) {
            throw new Error(`No valid review tier found for correct_streak: ${flashcard.correct_streak}`);
        }

        const cooldownHours = currentTier.cooldown_hours;
        const lastReviewedAt = new Date(flashcard.last_reviewed_at);
        const hoursSinceLastReview = (now - lastReviewedAt) / (1000 * 60 * 60);
        const isEffective = !flashcard.last_reviewed_at || hoursSinceLastReview > cooldownHours;

        const updateData = {};

        if (isEffective) {
          strapi.log.info(`Effective review for card ${id}. Updating streaks.`);
          updateData.last_reviewed_at = now.toISOString();

          if (result === 'correct') {
            updateData.correct_streak = (flashcard.correct_streak || 0) + 1;
            updateData.wrong_streak = 0;
          } else { // result === 'wrong'
            const newWrongStreak = (flashcard.wrong_streak || 0) + 1;
            updateData.wrong_streak = newWrongStreak;

            if (newWrongStreak >= currentTier.demote_bar) {
              strapi.log.info(`Demotion triggered for card ${id}.`);
              const currentTierIndex = reviewTiers.findIndex(t => t.id === currentTier.id);
              const previousTier = currentTierIndex > 0 ? reviewTiers[currentTierIndex - 1] : reviewTiers[0];
              
              updateData.correct_streak = previousTier.min_streak;
              updateData.wrong_streak = 0;
            }
          }
        } else {
            strapi.log.warn(`Ineffective review for card ${id}. Cooldown not met. Logging only.`);
        }

        // CORRECTED: Use strapi.db.query here as well
        await strapi.db.query('api::reviewlog.reviewlog').create({
          data: {
            user: user.id,
            flashcard: id,
            reviewed_at: now.toISOString(),
            result: result,
            level: getReviewLevel(currentTier),
            publishedAt: now.toISOString(),
          }
        });

        if (Object.keys(updateData).length > 0) {
            // CORRECTED: And here for the update
            const updated = await strapi.db.query('api::flashcard.flashcard').update({
                where: { id },
                data: updateData
            });
            return [updated];
        }

        return [flashcard];
      });

      return this.transformResponse(updatedFlashcard);

    } catch (err) {
      strapi.log.error(`Error during review for card ${id}: ${err.message}`, err.stack);
      return ctx.internalServerError('An error occurred during the review process.');
    }
  },
}));

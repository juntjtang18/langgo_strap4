'use strict';

/**
 * flashcard controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

// Helper function to find the correct review tier based on a streak
const findTierForStreak = (streak, tiers) => {
  // Ensure streak is a number, default to 0 if null/undefined
  const currentStreak = streak || 0;
  return tiers.find(tier => currentStreak >= tier.min_streak && currentStreak <= tier.max_streak) || tiers[tiers.length - 1];
};

// Helper function to determine the review level for logging
const getReviewLevel = (tier) => {
  if (!tier || !tier.tier) return null;
  const tierName = tier.tier.toLowerCase();
  if (["daily", "warmup"].includes(tierName)) return "daily";
  if (["weekly", "monthly"].includes(tierName)) return "weekly"; // Corrected from monthly
  if (["monthly"].includes(tierName)) return "monthly";
  return null;
};

module.exports = createCoreController('api::flashcard.flashcard', ({ strapi }) => ({
  /**
   * REVISED: Uses corrected application-level filtering to ensure accurate review lists.
   */
  async findForReview(ctx) {
    const { user } = ctx.state;
    if (!user) {
      return ctx.unauthorized('You must be logged in to review flashcards.');
    }
    strapi.log.info(`Starting review session fetch for user: ${user.id}`);

    try {
      const reviewTiers = await strapi.db.query('api::review-tire.review-tire').findMany({
        orderBy: { min_streak: 'asc' },
      });

      strapi.log.debug(`[Trace] Fetched ${reviewTiers.length} review tiers from the database.`);

      const commonPopulate = {
        content: {
          populate: {
            word: { populate: ['tags', 'verb_meta', 'audio'] },
            sentence: { populate: ['tags', 'words', 'target_audio'] },
            user_word: { populate: { fields: ['word', 'base_text', 'part_of_speech'] } },
            user_sentence: { populate: { fields: ['target_text', 'base_text'] } },
          },
        },
      };

      if (!reviewTiers || reviewTiers.length === 0) {
        strapi.log.warn(`No review tiers configured. Returning all flashcards for user ${user.id} as a fallback.`);
        const allUserCards = await strapi.entityService.findMany('api::flashcard.flashcard', {
            where: { user: user.id },
            populate: commonPopulate,
        });
        strapi.log.info(`[Fallback] Found ${allUserCards.length} cards for user ${user.id}.`);
        return this.transformResponse(allUserCards);
      }

      // --- NEW, CORRECTED LOGIC ---
      // 1. Fetch ALL cards for the user. We will do all filtering in the application.
      strapi.log.debug(`[Trace] Fetching all cards for user ${user.id} to filter in application.`);
      const allUserCards = await strapi.entityService.findMany('api::flashcard.flashcard', {
        where: { user: user.id },
        populate: commonPopulate,
      });
      strapi.log.debug(`[Trace] Fetched ${allUserCards.length} candidate cards. Now filtering...`);

      const now = new Date();
      const allReviewCards = allUserCards.filter(card => {
        // First, find the correct tier for the card based on its streak.
        const tier = findTierForStreak(card.correct_streak, reviewTiers);

        // --- FIX: Use unified logic for all tiers ---
        // If a card's streak is so high it doesn't fit into any defined tier, exclude it.
        if (!tier) {
          strapi.log.debug(`[Trace] Excluding card #${card.id} (streak ${card.correct_streak} is out of all tier ranges).`);
          return false;
        }
        // The specific check for `tier.tier === 'remembered'` is now removed to apply the same cooldown rule to all tiers.

        // If the card has never been reviewed, it's always due.
        if (!card.last_reviewed_at) {
          strapi.log.debug(`[Trace] Including card #${card.id} (new card).`);
          return true;
        }

        // Finally, check if the cooldown has passed for its tier.
        const cooldownDate = new Date(now.getTime() - tier.cooldown_hours * 3600 * 1000);
        const lastReviewed = new Date(card.last_reviewed_at);

        if (lastReviewed <= cooldownDate) {
          strapi.log.debug(`[Trace] Including card #${card.id} (cooldown passed).`);
          return true;
        }
        
        // If none of the above, exclude it.
        strapi.log.debug(`[Trace] Excluding card #${card.id} (cooldown not met).`);
        return false;
      });
      // --- END NEW LOGIC ---

      strapi.log.debug(`[Trace] Final filtered list contains ${allReviewCards.length} cards.`);
      strapi.log.info(`[User: ${user.id}] Found ${allReviewCards.length} cards due for review.`);
      
      return this.transformResponse(allReviewCards);

    } catch (err) {
      strapi.log.error(`[User: ${user.id}] Error fetching review flashcards: ${err.message}`, { stack: err.stack });
      return ctx.internalServerError('An error occurred while fetching review flashcards.');
    }
  },
  
  /**
   * Handles a review action for a single flashcard.
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
      const [updatedFlashcard] = await strapi.db.transaction(async () => {
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
        const lastReviewedAt = flashcard.last_reviewed_at ? new Date(flashcard.last_reviewed_at) : null;
        const hoursSinceLastReview = lastReviewedAt ? (now - lastReviewedAt) / (1000 * 60 * 60) : Infinity;
        const isEffective = !lastReviewedAt || hoursSinceLastReview > cooldownHours;

        const updateData = {};

        if (isEffective) {
          strapi.log.info(`Effective review for card ${id}. Updating streaks.`);
          updateData.last_reviewed_at = now.toISOString();

          if (result === 'correct') {
            const newCorrectStreak = (flashcard.correct_streak || 0) + 1;
            updateData.correct_streak = newCorrectStreak;
            updateData.wrong_streak = 0;

            const newTier = findTierForStreak(newCorrectStreak, reviewTiers);
            if (newTier && newTier.tier === 'remembered') {
                updateData.is_remembered = true;
                strapi.log.info(`Card ${id} has been promoted to 'remembered' tier.`);
            }

          } else { // result === 'wrong'
            const newWrongStreak = (flashcard.wrong_streak || 0) + 1;
            updateData.wrong_streak = newWrongStreak;

            if (newWrongStreak >= currentTier.demote_bar) {
              strapi.log.info(`Demotion triggered for card ${id}.`);
              const currentTierIndex = reviewTiers.findIndex(t => t.id === currentTier.id);
              const previousTier = currentTierIndex > 0 ? reviewTiers[currentTierIndex - 1] : reviewTiers[0];
              
              updateData.correct_streak = previousTier.min_streak;
              updateData.wrong_streak = 0;
              updateData.is_remembered = false;
            }
          }
        } else {
            strapi.log.warn(`Ineffective review for card ${id}. Cooldown not met. Logging only.`);
        }

        await strapi.db.query('api::reviewlog.reviewlog').create({
          data: {
            user: user.id,
            flashcard: id,
            reviewed_at: now.toISOString(),
            result: result,
            level: getReviewLevel(currentTier),
          }
        });

        if (Object.keys(updateData).length > 0) {
            const updated = await strapi.db.query('api::flashcard.flashcard').update({
                where: { id },
                data: updateData,
                populate: ['content']
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

    // --- NEW STATISTICS ENDPOINT ---
    async getStatistics(ctx) {
      const { user } = ctx.state;
      if (!user) {
        return ctx.unauthorized('You must be logged in to view statistics.');
      }
  
      strapi.log.info(`Fetching statistics for user: ${user.id}`);
  
      try {
        const allUserCards = await strapi.entityService.findMany('api::flashcard.flashcard', {
          where: { user: user.id },
          fields: ['is_remembered', 'correct_streak', 'wrong_streak'],
        });
  
        if (!allUserCards) {
          return ctx.notFound('Could not find flashcards for the user.');
        }
        
        const totalCards = allUserCards.length;
  
        // --- MODIFICATION START ---
        // A card is "remembered" if the flag is true OR its streak is 11 or higher.
        // This handles inconsistent data like Card ID #2.
        const remembered = allUserCards.filter(c => c.is_remembered || c.correct_streak >= 11).length;
  
        // "Active" cards are now strictly those that do not meet the new remembered definition.
        const activeCards = allUserCards.filter(c => !c.is_remembered && c.correct_streak < 11);
        // --- MODIFICATION END ---
        
        // These calculations now operate on a correctly filtered set of active cards.
        const newCards = activeCards.filter(c => c.correct_streak >= 0 && c.correct_streak <= 3).length;
        const warmUp = activeCards.filter(c => c.correct_streak >= 4 && c.correct_streak <= 6).length;
        const weekly = activeCards.filter(c => c.correct_streak >= 7 && c.correct_streak <= 8).length;
        const monthly = activeCards.filter(c => c.correct_streak >= 9 && c.correct_streak <= 10).length;
        const hardToRemember = activeCards.filter(c => c.wrong_streak >= 3).length;
  
        const stats = {
          totalCards,
          remembered,
          newCards,
          warmUp,
          weekly,
          monthly,
          hardToRemember,
        };
        
        return ctx.send({ data: stats });
  
      } catch (err) {
        strapi.log.error(`Error fetching statistics for user ${user.id}: ${err.message}`);
        return ctx.internalServerError('An error occurred while fetching statistics.');
      }
    },
}));

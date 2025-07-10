'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

// Helper: find the correct review tier for a given streak
const findTierForStreak = (streak, tiers) => {
  const currentStreak = streak ?? 0;
  return (
    tiers.find(
      (tier) => currentStreak >= tier.min_streak && currentStreak <= tier.max_streak
    ) || tiers[tiers.length - 1]
  );
};

// Helper: derive the log level string
const getReviewLevel = (tier) => {
  return tier?.tier?.toLowerCase() || null;
};

// Helper: shorten cooldowns for testing in development environment
const getEffectiveCooldown = (hours) => {
  // If in development mode, divide cooldown by a large number to make it seconds/minutes long.
  // Set NODE_ENV=development in your .env file to enable.
  if (process.env.NODE_ENV === 'development') {
    return (hours || 0) / 3600; // e.g., 6 hours becomes 6 seconds
  }
  return hours || 0;
};

module.exports = createCoreController(
  'api::flashcard.flashcard',
  ({ strapi }) => ({
    // Centralized populate to include review_tire relation everywhere
    _commonPopulate() {
      return {
        content: {
          populate: {
            word:      { populate: ['tags', 'verb_meta', 'audio'] },
            sentence:  { populate: ['tags', 'words', 'target_audio'] },
            user_word: { populate: { fields: ['target_text', 'base_text', 'part_of_speech'] } },
            user_sentence: { populate: { fields: ['target_text', 'base_text'] } },
          },
        },
        review_tire: {
          populate: ['tier', 'min_streak', 'max_streak', 'cooldown_hours', 'demote_bar'],
        },
      };
    },

    /**
     * GET /flashcards/:id
     */
    async findOne(ctx) {
      const { user } = ctx.state;
      if (!user) return ctx.unauthorized('You must be logged in.');

      const { id } = ctx.params;
      const entity = await strapi.entityService.findOne(
        'api::flashcard.flashcard',
        id,
        { populate: this._commonPopulate(), filters: { user: user.id } }
      );
      return this.transformResponse(entity);
    },

    /**
     * GET /flashcards/findForReview
     */
    async findForReview(ctx) {
      const { user } = ctx.state;
      if (!user) return ctx.unauthorized('You must be logged in.');

      // 1. Get pagination params from query string, with defaults
      const page = parseInt(ctx.query.pagination?.page || '1', 10);
      const pageSize = parseInt(ctx.query.pagination?.pageSize || '25', 10);

      try {
        const allTiers = await strapi.entityService.findMany('api::review-tire.review-tire', {
          sort: { min_streak: 'asc' },
        });

        // Fetch all cards lightweight to determine which are due
        const allCards = await strapi.entityService.findMany(
          'api::flashcard.flashcard',
          { 
            filters: { user: user.id },
            populate: { review_tire: true }
          }
        );

        const now = new Date();
        const dueCardIds = allCards
          .filter((card) => {
            let tierForCheck;
            if (card.review_tire) {
              tierForCheck = card.review_tire;
            } else {
              tierForCheck = findTierForStreak(card.correct_streak, allTiers);
            }

            if (!tierForCheck) return false;
            if (!card.last_reviewed_at) return true;
            
            const effectiveCooldown = getEffectiveCooldown(tierForCheck.cooldown_hours);
            const cutoff = new Date(now - effectiveCooldown * 3600e3);
            return new Date(card.last_reviewed_at) <= cutoff;
          })
          .map(card => card.id);

        // 2. Paginate the list of due card IDs
        const totalDue = dueCardIds.length;
        if (totalDue === 0) {
          return this.transformResponse([], {
            pagination: { page, pageSize, pageCount: 0, total: 0 },
          });
        }
        
        const pageCount = Math.ceil(totalDue / pageSize);
        const start = (page - 1) * pageSize;
        const paginatedDueCardIds = dueCardIds.slice(start, start + pageSize);

        if (paginatedDueCardIds.length === 0) {
          return this.transformResponse([], {
            pagination: { page, pageSize, pageCount, total: totalDue },
          });
        }
        
        // 3. Fetch only the fully populated cards for the current page
        const populatedDueCards = await strapi.entityService.findMany('api::flashcard.flashcard', {
            filters: { id: { $in: paginatedDueCardIds } },
            populate: this._commonPopulate()
        });
        
        // 4. Return the paginated data and metadata
        const pagination = { page, pageSize, pageCount, total: totalDue };
        return this.transformResponse(populatedDueCards, { pagination });

      } catch (err) {
        strapi.log.error(`findForReview error: ${err.message}`, { stack: err.stack });
        return ctx.internalServerError('Error fetching review flashcards.');
      }
    },

    /**
     * POST /flashcards/:id/review
     */
    async review(ctx) {
      const { user } = ctx.state;
      if (!user) return ctx.unauthorized('Authentication required.');

      const { id } = ctx.params;
      const { result } = ctx.request.body;
      if (!['correct', 'wrong'].includes(result)) {
        return ctx.badRequest('result must be "correct" or "wrong".');
      }

      try {
        const finalCard = await strapi.db.transaction(async () => {
          const flashcard = await strapi.entityService.findOne(
            'api::flashcard.flashcard',
            id,
            {
              filters: { user: user.id },
              populate: { review_tire: true },
            }
          );

          if (!flashcard) throw new Error('Flashcard not found.');
          
          const reviewTiers = await strapi.entityService.findMany(
            'api::review-tire.review-tire',
            { sort: { min_streak: 'asc' } }
          );

          // Fallback Logic to Determine the Current Tier
          let currentTier;
          if (flashcard.review_tire) {
            // 1. If the tier exists, use it.
            currentTier = flashcard.review_tire;
          } else {
            // 2. If it's null, fall back to calculating it from the streak.
            currentTier = findTierForStreak(flashcard.correct_streak, reviewTiers);
          }
          
          // The effective check now uses the correctly determined tier and respects development mode
          const effectiveCooldown = getEffectiveCooldown(currentTier?.cooldown_hours);
          const reviewIsOnCooldown = currentTier && flashcard.last_reviewed_at
            ? (new Date() - new Date(flashcard.last_reviewed_at)) / 3600e3 <= effectiveCooldown
            : false;
            
          const effective = !reviewIsOnCooldown;
            
          const now = new Date();
          const updateData = {};
            
          if (effective) {
            updateData.last_reviewed_at = now.toISOString();

            if (result === 'correct') {
              const newStreak = (flashcard.correct_streak ?? 0) + 1;
              updateData.correct_streak = newStreak;
              updateData.wrong_streak = 0;

              const newTier = findTierForStreak(newStreak, reviewTiers);
              if (newTier && newTier.id !== currentTier?.id) {
                updateData.review_tire = newTier.id;
              }
              if (newTier?.tier === 'remembered') {
                updateData.is_remembered = true;
              }
            } else { // result === 'wrong'
              const newWrong = (flashcard.wrong_streak ?? 0) + 1;
              updateData.wrong_streak = newWrong;

              if (currentTier && newWrong >= currentTier.demote_bar) {
                const idx = reviewTiers.findIndex((t) => t.id === currentTier.id);
                const prevTier = idx > 0 ? reviewTiers[idx - 1] : reviewTiers[0];
                updateData.correct_streak = prevTier.min_streak;
                updateData.wrong_streak = 0;
                updateData.review_tire = prevTier.id;
                updateData.is_remembered = false;
              }
            }
          }

          // Always log the review
          await strapi.entityService.create('api::reviewlog.reviewlog', {
            data: {
              user: user.id,
              flashcard: id,
              reviewed_at: now.toISOString(),
              result,
              level: getReviewLevel(currentTier),
            },
          });

          if (Object.keys(updateData).length > 0) {
            await strapi.entityService.update(
              'api::flashcard.flashcard',
              id,
              { data: updateData }
            );
          }

          return strapi.entityService.findOne(
            'api::flashcard.flashcard',
            id,
            { populate: this._commonPopulate() }
          );
        });

        return this.transformResponse(finalCard);
      } catch (err) {
        strapi.log.error(`review error: ${err.message}`, err.stack);
        return ctx.internalServerError('Error during review.');
      }
    },

    /**
     * GET /flashcards/statistics
     */
    async getStatistics(ctx) {
      const { user } = ctx.state;
      if (!user) return ctx.unauthorized('You must be logged in to view statistics.');

      try {
        const allCards = await strapi.entityService.findMany(
          'api::flashcard.flashcard',
          {
            where: { user: user.id },
            fields: ['is_remembered', 'correct_streak', 'wrong_streak'],
          }
        );

        const total = allCards.length;
        const remembered = allCards.filter(
          (c) => c.is_remembered || c.correct_streak >= 11
        ).length;

        const active = allCards.filter(
          (c) => !c.is_remembered && c.correct_streak < 11
        );
        const newCards = active.filter((c) => c.correct_streak <= 3).length;
        const warmUp = active.filter((c) => c.correct_streak <= 6).length;
        const weekly = active.filter((c) => c.correct_streak <= 8).length;
        const monthly = active.filter((c) => c.correct_streak <= 10).length;
        const hardToRemember = active.filter((c) => c.wrong_streak >= 3).length;

        return ctx.send({ data: { totalCards: total, remembered, newCards, warmUp, weekly, monthly, hardToRemember } });
      } catch (err) {
        strapi.log.error(`getStatistics error: ${err.message}`);
        return ctx.internalServerError('An error occurred while fetching statistics.');
      }
    },

    /**
     * GET /flashcards/mine?pagination[page]&pagination[pageSize]
     */
    async findMine(ctx) {
      const { user } = ctx.state;
      if (!user) return ctx.unauthorized('You must be logged in.');

      const page = Math.max(1, parseInt(ctx.query.pagination?.page || '1', 10));
      const pageSize = Math.max(1, parseInt(ctx.query.pagination?.pageSize || '10', 10));
      const start = (page - 1) * pageSize;

      // common populate to include review_tire
      const commonPopulate = this._commonPopulate();

      // fetch page of flashcards
      const [results, total] = await Promise.all([
        strapi.entityService.findMany('api::flashcard.flashcard', {
          filters: { user: user.id },
          populate: commonPopulate,
          sort: { createdAt: 'asc' },
          start,
          limit: pageSize,
        }),
        strapi.entityService.count('api::flashcard.flashcard', {
          filters: { user: user.id },
        }),
      ]);

      // ensure every card has a review_tire (compute for new ones)
      const allTiers = await strapi.entityService.findMany('api::review-tire.review-tire', { sort: { min_streak: 'asc' } });
      const enriched = results.map((card) => {
        if (!card.review_tire) {
          const tier = findTierForStreak(card.correct_streak, allTiers);
          card.review_tire = tier;
        }
        return card;
      });

      const pagination = {
        page,
        pageSize,
        pageCount: Math.ceil(total / pageSize),
        total,
      };

      return this.transformResponse(enriched, { pagination });
    },
  })
);
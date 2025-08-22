'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

// Helper: derive the log level string
const getReviewLevel = (tier) => {
  return tier?.tier?.toLowerCase() || null;
};

// Helper: shorten cooldowns for testing in development environment
const getEffectiveCooldown = (hours) => {
  if (process.env.SHORT_TIME_FOR_REVIEW === 'true') {
    return (hours || 0) / 180;
  }
  return hours || 0;
};

module.exports = createCoreController(
  'api::flashcard.flashcard',
  ({ strapi }) => ({
    /**
     * Centralized population object to fetch flashcards with their core relations.
     */
    _commonPopulate() {
      return {
        word_definition: {
          populate: {
            word: {
              populate: ['audio', 'tags'],
            },
            part_of_speech: true,  // ✅ include POS
            tags: true,            // (optional) component
            verb_meta: true,       // (optional) component
          },
        },
        review_tire: true,
      };
    },
    /**
     * GET /flashcards/:id
     */
    async findOne(ctx) {
      const { user } = ctx.state;
      if (!user) return ctx.unauthorized('You must be logged in.');

      const { id } = ctx.params;
      const entity = await strapi.entityService.findOne('api::flashcard.flashcard', id, {
        populate: this._commonPopulate(),
        filters: { user: user.id },
        locale: 'all',
      });

      // 🔎 Debug log for this single flashcard
      if (entity?.word_definition?.data?.attributes) {
        const wd = entity.word_definition.data.attributes;
        const word = wd.word?.data?.attributes?.target_text;
        const pos = wd.part_of_speech?.data?.attributes?.name;
        strapi.log.debug(`🧩 findOne card=${id} word='${word}' pos='${pos}'`);
      }

      return this.transformResponse(entity);
    },

    /**
     * GET /flashcards/findForReview
     */
    async findForReview(ctx) {
      const { user } = ctx.state;
      if (!user) return ctx.unauthorized('You must be logged in.');

      const page = parseInt(ctx.query.pagination?.page || '1', 10);
      const pageSize = parseInt(ctx.query.pagination?.pageSize || '25', 10);

      try {
        const tierService = strapi.service('tier-service');
        const allTiers = await tierService.getAllTiers();

        // We don't need word_definition here; just tire for the due calculation
        const allCards = await strapi.entityService.findMany('api::flashcard.flashcard', {
          filters: { user: user.id, word_definition: { $not: null } },
          populate: { review_tire: true },
          locale: 'all',
        });

        const now = new Date();
        const dueCardIds = allCards
          .filter((card) => {
            if (!card.last_reviewed_at) return true;
            const tierForCheck = card.review_tire || tierService.findTierForStreakWithRules(card.correct_streak, allTiers);
            if (!tierForCheck) return false;
            const effectiveCooldown = getEffectiveCooldown(tierForCheck.cooldown_hours);
            const dueTime = new Date(new Date(card.last_reviewed_at).getTime() + (effectiveCooldown * 3600 * 1000));
            return now >= dueTime;
          })
          .map((card) => card.id);

        const totalDue = dueCardIds.length;
        if (totalDue === 0) {
          return this.transformResponse([], { pagination: { page, pageSize, pageCount: 0, total: 0 } });
        }

        const pageCount = Math.ceil(totalDue / pageSize);
        const start = (page - 1) * pageSize;
        const paginatedDueCardIds = dueCardIds.slice(start, start + pageSize);

        if (paginatedDueCardIds.length === 0) {
          return this.transformResponse([], { pagination: { page, pageSize, pageCount, total: totalDue } });
        }

        // ✅ Fetch due cards WITH the full word-definition details now (includes POS).
        const populatedDueCards = await strapi.entityService.findMany('api::flashcard.flashcard', {
          filters: { id: { $in: paginatedDueCardIds } },
          populate: this._commonPopulate(),
          locale: 'all',
        });

        // 🔎 Log a quick preview so you can confirm POS is present
        try {
          const preview = populatedDueCards.slice(0, 5).map((c) => {
            const wd = c?.word_definition?.data?.attributes;
            return {
              id: c.id,
              word: wd?.word?.data?.attributes?.target_text,
              pos: wd?.part_of_speech?.data?.attributes?.name || null,
            };
          });
          strapi.log.debug(`📦 review-flashcards page=${page} size=${pageSize} preview=${JSON.stringify(preview)}`);
        } catch (e) { /* ignore logging errors */ }

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
    
          const tierService = strapi.service('tier-service');
          const reviewTiers = await tierService.getAllTiers();
          let currentTier = flashcard.review_tire || tierService.findTierForStreakWithRules(flashcard.correct_streak, reviewTiers);
    
          const effectiveCooldown = getEffectiveCooldown(currentTier?.cooldown_hours || 0);
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
    
              const newTier = tierService.findTierForStreakWithRules(newStreak, reviewTiers);
              updateData.review_tire = newTier.id;
              if (newTier.tier === 'remembered') {
                updateData.is_remembered = true;
              }
            } else {
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
    
          return await strapi.entityService.findOne(
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
     * Fast, tier-driven counters (no per-card loop)
     */
    async getStatistics(ctx) {
      const { user } = ctx.state;
      if (!user) return ctx.unauthorized('You must be logged in to view statistics.');

      try {
        const tierService = strapi.service('tier-service');
        // [{ id, tier, min_streak, max_streak, cooldown_hours, demote_bar, display_name }, ...]
        const tiers = await tierService.getAllTiers();

        const baseFilter = { user: user.id, word_definition: { $not: null } };
        const totalCards = await strapi.entityService.count('api::flashcard.flashcard', { filters: baseFilter });
        const now = new Date();

        // Build a membership filter for one tier:
        // either linked to this tier OR (no link && streak is within [min, max]).
        const membershipForTier = (t) => ({
          $or: [
            { review_tire: t.id },
            {
              $and: [
                { review_tire: null },
                { correct_streak: { $gte: t.min_streak } },
                { correct_streak: { $lte: t.max_streak } },
              ],
            },
          ],
        });

        // Per-tier counts in parallel
        const perTier = await Promise.all(
          tiers.map(async (t) => {
            const membership = membershipForTier(t);
            const hours = getEffectiveCooldown(t.cooldown_hours);
            const thresholdIso = new Date(now.getTime() - hours * 3600 * 1000).toISOString();

            // total in this tier
            const count = await strapi.entityService.count('api::flashcard.flashcard', {
              filters: { ...baseFilter, ...membership }, // only one $or at top-level here
            });

            // due in this tier: never reviewed OR last_reviewed_at <= threshold
            const dueCount = await strapi.entityService.count('api::flashcard.flashcard', {
              filters: {
                ...baseFilter,
                $and: [
                  membership, // keep membership intact
                  {
                    $or: [
                      { last_reviewed_at: null },
                      { last_reviewed_at: { $lte: thresholdIso } },
                    ],
                  },
                ],
              },
            });

            // hard-to-remember in this tier (use tier.demote_bar)
            const hardToRememberCount = await strapi.entityService.count('api::flashcard.flashcard', {
              filters: {
                ...baseFilter,
                $and: [
                  membership,
                  { wrong_streak: { $gte: t.demote_bar } },
                ],
              },
            });

            return { t, count, dueCount, hardToRememberCount };
          })
        );

        // Remembered (global): explicit flag OR belongs to remembered tier (by relation or by streak range)
        const rememberedTier = tiers.find((x) => x.tier === 'remembered');
        let remembered = 0;
        if (rememberedTier) {
          const rememberedFilters = {
            ...baseFilter,
            $or: [
              { is_remembered: true },
              { review_tire: rememberedTier.id },
              {
                $and: [
                  { review_tire: null },
                  { correct_streak: { $gte: rememberedTier.min_streak } },
                ],
              },
            ],
          };
          remembered = await strapi.entityService.count('api::flashcard.flashcard', { filters: rememberedFilters });
        } else {
          // Fallback: only explicit flag
          remembered = await strapi.entityService.count('api::flashcard.flashcard', {
            filters: { ...baseFilter, is_remembered: true },
          });
        }

        // Fold results
        const byTier = perTier.map(({ t, count, dueCount, hardToRememberCount }) => ({
          id: t.id,
          tier: t.tier,
          display_name: t.display_name || null,
          min_streak: t.min_streak,
          max_streak: t.max_streak,
          cooldown_hours: t.cooldown_hours,
          count,
          dueCount,
          hardToRememberCount,
        }));

        const countBySlug = Object.fromEntries(byTier.map((x) => [x.tier, x.count]));
        const dueForReview  = byTier.reduce((s, x) => s + x.dueCount, 0);
        const hardToRemember = byTier.reduce((s, x) => s + x.hardToRememberCount, 0);

        // Reviewed = total - due - remembered (clamped to >= 0)
        const reviewed = Math.max(0, totalCards - dueForReview - remembered);

        // Legacy buckets (derived from tiers; no hard-coded ranges)
        const newCards = countBySlug['new'] || 0;
        const warmUp   = countBySlug['warmup'] || 0;
        const weekly   = countBySlug['weekly'] || 0;
        const monthly  = countBySlug['monthly'] || 0;

        return ctx.send({
          data: {
            totalCards,
            remembered,
            newCards,
            warmUp,
            weekly,
            monthly,
            hardToRemember,
            dueForReview,
            reviewed,
            byTier,
          },
        });
      } catch (err) {
        strapi.log.error(`getStatistics error: ${err.message}`, { stack: err.stack });
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

      // ✅ --- FIX: Use the robust, centralized population helper ---
      const populate = this._commonPopulate();

      const [results, total] = await Promise.all([
        strapi.entityService.findMany('api::flashcard.flashcard', {
          filters: { user: user.id, word_definition: { $not: null } },
          populate, // Use the helper's result here
          sort: { createdAt: 'asc' },
          start,
          limit: pageSize,
        }),
        strapi.entityService.count('api::flashcard.flashcard', {
          filters: { user: user.id, word_definition: { $not: null } },
        }),
      ]);

      // 🔎 Preview log (should now include the POS)
      try {
        const preview = results.slice(0, 5).map((c) => {
          const wd = c?.word_definition; // Note: data is not nested here with this populate
          return {
            id: c.id,
            word: wd?.word?.target_text ?? null,
            pos: wd?.part_of_speech?.name ?? null // Adjusted for direct access
          };
        });
        strapi.log.debug(`📦 mine[fixed] page=${page} size=${pageSize} preview=${JSON.stringify(preview)}`);
      } catch (_) {}
      
      // The complex manual hydration block is no longer needed and has been removed.

      // Your existing tier enrichment logic remains the same
      const tierService = strapi.service('tier-service');
      const allTiers = await tierService.getAllTiers();
      const enriched = results.map((card) => {
        if (!card.review_tire) {
          card.review_tire = tierService.findTierForStreakWithRules(card.correct_streak, allTiers);
        }
        return card;
      });

      const pagination = { page, pageSize, pageCount: Math.ceil(total / pageSize), total };
      return this.transformResponse(enriched, { pagination });
    },


   /**
   * POST /flashcards/:id/validate
   */
    async validate(ctx) {
      const { user } = ctx.state;
      if (!user) return ctx.unauthorized('Authentication required.');

      const { id } = ctx.params;
      
      try {
        const validationService = strapi.service('flashcard-validate');
        
        const updatedFlashcard = await validationService.validateAndFix(id);
        
        return this.transformResponse(updatedFlashcard);

      } catch (err) {
        strapi.log.error(`Flashcard validation error: ${err.message}`, { stack: err.stack });
        return ctx.internalServerError('An error occurred during flashcard validation.');
      }
    },
  })
);
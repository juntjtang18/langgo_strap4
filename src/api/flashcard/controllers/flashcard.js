'use strict';

const { createCoreController } = require('@strapi/strapi').factories;
const { calculateReviewOutcome } = require('./review-logic');

// Helper: shorten cooldowns for testing in development environment
const getEffectiveCooldown = (hours) => {
  if (process.env.SHORT_TIME_FOR_REVIEW === 'true') {
    return (hours || 0) / 180;
  }
  return hours || 0;
};

const buildReviewCompletedEvent = ({
  flashcardId,
  user,
  reviewedAt,
  result,
  level,
  effective,
  newlevel,
}) => ({
  event: 'flashcard.review.completed',
  eventId: `flashcard-review:${flashcardId}:${reviewedAt}:${user.id}`,
  occurredAt: reviewedAt,
  review: {
    flashcardId,
    userId: user.id,
    username: user.username || user.email || `user-${user.id}`,
    email: user.email || null,
    reviewedAt,
    result,
    level,
    effective,
    newlevel,
  },
});

const getTierMembership = (card, tiers, tierById) => {
  if (card.review_tire_id && tierById.has(card.review_tire_id)) {
    return tierById.get(card.review_tire_id);
  }

  const streak = card.correct_streak ?? 0;

  return (
    tiers.find((tier) => streak >= tier.min_streak && streak <= tier.max_streak)
    || tiers[tiers.length - 1]
    || null
  );
};

module.exports = createCoreController(
  'api::flashcard.flashcard',
  ({ strapi }) => ({
    _flashcardStatsLinkTables: null,

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
        const reviewResult = await strapi.db.transaction(async ({ trx }) => {
          const flashcard = await strapi.entityService.findOne(
            'api::flashcard.flashcard',
            id,
            {
              filters: { user: user.id },
              populate: { review_tire: true, word_definition: true },
              db: trx,
            }
          );
    
          if (!flashcard) throw new Error('Flashcard not found.');
    
          const tierService = strapi.service('tier-service');
          const reviewTiers = await tierService.getAllTiers();
          let currentTier = flashcard.review_tire || tierService.findTierForStreakWithRules(flashcard.correct_streak, reviewTiers);
    
          const effectiveCooldown = getEffectiveCooldown(currentTier?.cooldown_hours || 0);
          const now = new Date();
          const {
            effective,
            currentLevel,
            newLevel,
            updateData,
          } = calculateReviewOutcome({
            flashcard,
            currentTier,
            reviewTiers,
            result,
            effectiveCooldownHours: effectiveCooldown,
            now,
          });

          const shouldUpdateFlashcardStat =
            effective
            && flashcard.word_definition?.id
            && currentTier?.id
            && currentTier.id !== (updateData.review_tire || currentTier.id);
    
          if (Object.keys(updateData).length > 0) {
            await strapi.entityService.update(
              'api::flashcard.flashcard',
              id,
              {
                data: updateData,
                db: trx,
              }
            );
          }

          if (shouldUpdateFlashcardStat) {
            await strapi
              .service('api::flashcard-stat.flashcard-stat')
              .move(user.id, currentTier.id, updateData.review_tire, trx);
          }

          return {
            reviewedAt: now.toISOString(),
            reviewEvent: buildReviewCompletedEvent({
              flashcardId: flashcard.id,
              user,
              reviewedAt: now.toISOString(),
              result,
              level: currentLevel,
              effective,
              newlevel: newLevel,
            }),
          };
        });

        const finalCard = await strapi.entityService.findOne(
          'api::flashcard.flashcard',
          id,
          { populate: this._commonPopulate() }
        );

        try {
          await strapi.service('event-api').dispatchReviewCompleted(reviewResult.reviewEvent);
        } catch (dispatchError) {
          strapi.log.error(`review event dispatch error: ${dispatchError.message}`, dispatchError.stack);
        }
    
        return this.transformResponse(finalCard);
      } catch (err) {
        strapi.log.error(`review error: ${err.message}`, err.stack);
        return ctx.internalServerError('Error during review.');
      }
    },

    /**
     * POST /flashcards/:id/remove
     * Deletes a flashcard and its related word-definition if it's also owned by the user.
     */
    async remove(ctx) {
      const { user } = ctx.state;
      if (!user) return ctx.unauthorized('Authentication required.');

      const { id } = ctx.params;

      try {
        const flashcard = await strapi.entityService.findOne('api::flashcard.flashcard', id, {
          filters: { user: user.id },
          populate: { word_definition: true },
        });

        // 1. Verify the flashcard exists and is owned by the current user
        if (!flashcard) {
          return ctx.notFound('Flashcard not found or you do not have permission to delete it.');
        }

        let deletedFlashcard = null;
        let deletedWordDefinition = null;

        // 2. Perform deletion within a database transaction to ensure atomicity
        await strapi.db.transaction(async () => {
          const wdId = flashcard.word_definition?.id;
          if (wdId) {
            // Check if the related word-definition is also owned by the user
            const wordDefinition = await strapi.entityService.findOne('api::word-definition.word-definition', wdId, {
              filters: { user: user.id },
            });

            if (wordDefinition) {
              // Only delete the word-definition if it's owned by the user
              deletedWordDefinition = await strapi.entityService.delete('api::word-definition.word-definition', wdId);
            }
          }

          // 3. Delete the flashcard
          deletedFlashcard = await strapi.entityService.delete('api::flashcard.flashcard', id);
        });

        strapi.log.info(`✅ Flashcard ${id} deleted by user ${user.id}.`);
        if (deletedWordDefinition) {
          strapi.log.info(`✅ Related word-definition ${deletedWordDefinition.id} also deleted.`);
        }

        return this.transformResponse({
          flashcardId: deletedFlashcard?.id,
          wordDefinitionId: deletedWordDefinition?.id,
          message: 'Flashcard deleted successfully.',
        });
      } catch (err) {
        strapi.log.error(`Flashcard deletion error: ${err.message}`, { stack: err.stack });
        return ctx.internalServerError('An error occurred while deleting the flashcard.');
      }
    },

    /**
     * GET /flashcards/statistics
     * Tier-driven stats (no hard-coded ranges; no per-card loop)
     */
    async _resolveFlashcardStatsLinkTables() {
      if (this._flashcardStatsLinkTables) {
        return this._flashcardStatsLinkTables;
      }

      const dbSchemaName = strapi.config.get('database.connection.connection.schema', 'public');
      const schema = strapi.db.connection.schema.withSchema(dbSchemaName);
      const [hasUserLinks, hasReviewTierLinks, hasWordDefinitionLinks] = await Promise.all([
        schema.hasTable('flashcards_user_links'),
        schema.hasTable('flashcards_review_tire_links'),
        schema.hasTable('flashcards_word_definition_links'),
      ]);

      this._flashcardStatsLinkTables = {
        hasUserLinks,
        hasReviewTierLinks,
        hasWordDefinitionLinks,
      };

      return this._flashcardStatsLinkTables;
    },

    async _getStatisticsFast(userId, tiers) {
      const {
        hasUserLinks,
        hasReviewTierLinks,
        hasWordDefinitionLinks,
      } = await this._resolveFlashcardStatsLinkTables();

      if (!hasUserLinks || !hasReviewTierLinks || !hasWordDefinitionLinks) {
        return null;
      }

      const dbSchemaName = strapi.config.get('database.connection.connection.schema', 'public');
      const rows = await strapi.db.connection.withSchema(dbSchemaName).from('flashcards as f')
        .join('flashcards_user_links as ful', 'ful.flashcard_id', 'f.id')
        .join('flashcards_word_definition_links as fwdl', 'fwdl.flashcard_id', 'f.id')
        .leftJoin('flashcards_review_tire_links as frtl', 'frtl.flashcard_id', 'f.id')
        .where('ful.user_id', userId)
        .whereNotNull('fwdl.word_definition_id')
        .groupBy(
          'f.id',
          'f.last_reviewed_at',
          'f.is_remembered',
          'f.correct_streak',
          'f.wrong_streak'
        )
        .select(
          'f.id',
          'f.last_reviewed_at',
          'f.is_remembered',
          'f.correct_streak',
          'f.wrong_streak'
        )
        .max({ review_tire_id: 'frtl.review_tire_id' });

      const now = new Date();
      const rememberedTier = tiers.find((tier) => tier.tier === 'remembered') || null;
      const tierById = new Map(tiers.map((tier) => [tier.id, tier]));
      const perTierMap = new Map(
        tiers.map((tier) => [tier.id, {
          id: tier.id,
          tier: tier.tier,
          display_name: tier.display_name || null,
          min_streak: tier.min_streak,
          max_streak: tier.max_streak,
          cooldown_hours: tier.cooldown_hours,
          count: 0,
          dueCount: 0,
          hardToRememberCount: 0,
        }])
      );

      let remembered = 0;

      rows.forEach((card) => {
        const tier = getTierMembership(card, tiers, tierById);

        if (!tier) {
          return;
        }

        const tierStats = perTierMap.get(tier.id);
        tierStats.count += 1;

        const effectiveCooldownHours = getEffectiveCooldown(tier.cooldown_hours);
        const due = !card.last_reviewed_at
          || now >= new Date(new Date(card.last_reviewed_at).getTime() + (effectiveCooldownHours * 3600 * 1000));

        if (due) {
          tierStats.dueCount += 1;
        }

        if ((card.wrong_streak ?? 0) >= (tier.demote_bar ?? 0)) {
          tierStats.hardToRememberCount += 1;
        }

        if (
          card.is_remembered === true
          || (rememberedTier && (
            card.review_tire_id === rememberedTier.id
            || (!card.review_tire_id && (card.correct_streak ?? 0) >= rememberedTier.min_streak)
          ))
        ) {
          remembered += 1;
        }
      });

      const byTier = tiers.map((tier) => perTierMap.get(tier.id));
      const totalCards = rows.length;
      const dueForReview = byTier.reduce((sum, tier) => sum + tier.dueCount, 0);
      const hardToRemember = byTier.reduce((sum, tier) => sum + tier.hardToRememberCount, 0);
      const reviewed = Math.max(0, totalCards - dueForReview - remembered);

      return {
        totalCards,
        remembered,
        dueForReview,
        reviewed,
        hardToRemember,
        byTier,
      };
    },

    async _getStatisticsLegacy(userId, tiers) {
      const baseFilter = { user: userId, word_definition: { $not: null } };
      const totalCards = await strapi.entityService.count('api::flashcard.flashcard', { filters: baseFilter });
      const now = new Date();

      const membershipForTier = (tier) => ({
        $or: [
          { review_tire: tier.id },
          {
            $and: [
              { review_tire: null },
              { correct_streak: { $gte: tier.min_streak } },
              { correct_streak: { $lte: tier.max_streak } },
            ],
          },
        ],
      });

      const perTier = await Promise.all(
        tiers.map(async (tier) => {
          const membership = membershipForTier(tier);
          const hours = getEffectiveCooldown(tier.cooldown_hours);
          const thresholdIso = new Date(now.getTime() - hours * 3600 * 1000).toISOString();

          const count = await strapi.entityService.count('api::flashcard.flashcard', {
            filters: { ...baseFilter, ...membership },
          });

          const dueCount = await strapi.entityService.count('api::flashcard.flashcard', {
            filters: {
              ...baseFilter,
              $and: [
                membership,
                {
                  $or: [
                    { last_reviewed_at: null },
                    { last_reviewed_at: { $lte: thresholdIso } },
                  ],
                },
              ],
            },
          });

          const hardToRememberCount = await strapi.entityService.count('api::flashcard.flashcard', {
            filters: {
              ...baseFilter,
              $and: [
                membership,
                { wrong_streak: { $gte: tier.demote_bar } },
              ],
            },
          });

          return {
            id: tier.id,
            tier: tier.tier,
            display_name: tier.display_name || null,
            min_streak: tier.min_streak,
            max_streak: tier.max_streak,
            cooldown_hours: tier.cooldown_hours,
            count,
            dueCount,
            hardToRememberCount,
          };
        })
      );

      const rememberedTier = tiers.find((tier) => tier.tier === 'remembered');
      let remembered = 0;

      if (rememberedTier) {
        remembered = await strapi.entityService.count('api::flashcard.flashcard', {
          filters: {
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
          },
        });
      } else {
        remembered = await strapi.entityService.count('api::flashcard.flashcard', {
          filters: { ...baseFilter, is_remembered: true },
        });
      }

      const dueForReview = perTier.reduce((sum, tier) => sum + tier.dueCount, 0);
      const hardToRemember = perTier.reduce((sum, tier) => sum + tier.hardToRememberCount, 0);
      const reviewed = Math.max(0, totalCards - dueForReview - remembered);

      return {
        totalCards,
        remembered,
        dueForReview,
        reviewed,
        hardToRemember,
        byTier: perTier,
      };
    },

    async getStatistics(ctx) {
      const { user } = ctx.state;
      if (!user) return ctx.unauthorized('You must be logged in to view statistics.');

      try {
        const statistics = await strapi
          .service('api::flashcard-stat.flashcard-stat')
          .getUserStatisticsSummary(user.id);

        return ctx.send({
          data: statistics,
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

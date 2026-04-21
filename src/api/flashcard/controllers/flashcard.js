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

const getReviewlogEventsTopic = () => process.env.REVIEWLOG_EVENTS_TOPIC || 'pointserver-reviewlogs';

const buildReviewlogEventPayload = ({ reviewlog, flashcardId, user }) => ({
  event: 'reviewlog.created',
  eventId: `reviewlog:${reviewlog.id}`,
  reviewlog: {
    id: reviewlog.id,
    flashcard_id: String(flashcardId),
    reviewed_at: reviewlog.reviewed_at,
    result: reviewlog.result,
    level: reviewlog.level,
    effective: reviewlog.effective,
    newlevel: reviewlog.newlevel,
    user: {
      id: String(user.id),
      username: user.username || user.email || `user-${user.id}`,
    },
  },
});

const publishReviewlogEvent = async (strapi, payload) => {
  const topicName = getReviewlogEventsTopic();

  if (!topicName) {
    return;
  }

  await strapi.service('pubsub').publishJson(
    topicName,
    payload,
    {
      eventType: 'reviewlog.created',
      source: 'langgo-strapi4',
    }
  );
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
        const reviewResult = await strapi.db.transaction(async () => {
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

          const reviewlog = await strapi.entityService.create('api::reviewlog.reviewlog', {
            data: {
              user: user.id,
              flashcard: id,
              reviewed_at: now.toISOString(),
              result,
              level: currentLevel,
              effective,
              newlevel: newLevel,
            },
          });
    
          if (Object.keys(updateData).length > 0) {
            await strapi.entityService.update(
              'api::flashcard.flashcard',
              id,
              { data: updateData }
            );
          }

          const finalCard = await strapi.entityService.findOne(
            'api::flashcard.flashcard',
            id,
            { populate: this._commonPopulate() }
          );

          return {
            finalCard,
            reviewlog,
          };
        });

        if (getReviewlogEventsTopic()) {
          try {
            await publishReviewlogEvent(
              strapi,
              buildReviewlogEventPayload({
                reviewlog: reviewResult.reviewlog,
                flashcardId: id,
                user,
              })
            );
          } catch (publishError) {
            strapi.log.error(`review event publish error: ${publishError.message}`, publishError.stack);
          }
        }
    
        return this.transformResponse(reviewResult.finalCard);
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

        // Membership for a tier: relation OR (no relation && streak in [min,max])
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
              filters: { ...baseFilter, ...membership }, // one $or only
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

            // hard to remember in this tier
            const hardToRememberCount = await strapi.entityService.count('api::flashcard.flashcard', {
              filters: {
                ...baseFilter,
                $and: [
                  membership,
                  { wrong_streak: { $gte: t.demote_bar } },
                ],
              },
            });

            return {
              id: t.id,
              tier: t.tier,
              display_name: t.display_name || null,
              min_streak: t.min_streak,
              max_streak: t.max_streak,
              cooldown_hours: t.cooldown_hours,
              count,
              dueCount,
              hardToRememberCount,
            };
          })
        );

        // Remembered: explicit flag OR in remembered tier (by relation or by streak)
        const rememberedTier = tiers.find((x) => x.tier === 'remembered');
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

        // Fold up the results
        const dueForReview   = perTier.reduce((s, x) => s + x.dueCount, 0);
        const hardToRemember = perTier.reduce((s, x) => s + x.hardToRememberCount, 0);
        const reviewed       = Math.max(0, totalCards - dueForReview - remembered);

        return ctx.send({
          data: {
            totalCards,
            remembered,
            dueForReview,
            reviewed,
            hardToRemember,
            byTier: perTier,
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

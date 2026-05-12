'use strict';

/**
 * flashcard service
 */

const { createCoreService } = require('@strapi/strapi').factories;
const { calculateReviewOutcome } = require('../controllers/review-logic');

// Helper: shorten cooldowns for testing in development environment
const getEffectiveCooldown = (hours) => {
  if (process.env.SHORT_TIME_FOR_REVIEW === 'true') {
    return (hours || 0) / 180;
  }
  return hours || 0;
};

const TIER_ORDER = ['new', 'warmup', 'daily', 'weekly', 'monthly', 'remembered'];
const tierRank = (level) => TIER_ORDER.indexOf((level || '').toLowerCase());

const buildReviewEvent = ({
  flashcardId,
  user,
  reviewedAt,
  result,
  tierBefore,
  tierAfter,
  effective,
}) => ({
  eventId: `flashcard.reviewed:${flashcardId}:${user.id}:${reviewedAt}`,
  flashcardId,
  userId: user.id,
  username: user.username || user.email || `user-${user.id}`,
  result,
  tierBefore,
  tierAfter,
  effective,
  occurredAt: reviewedAt,
});

module.exports = createCoreService('api::flashcard.flashcard', ({ strapi }) => ({
  async reviewFlashcard({ flashcardId, user, result }) {
    return strapi.db.transaction(async ({ trx }) => {
      const flashcard = await strapi.entityService.findOne(
        'api::flashcard.flashcard',
        flashcardId,
        {
          filters: { user: user.id },
          populate: { review_tire: true, word_definition: true },
          db: trx,
        }
      );

      if (!flashcard) {
        throw new Error('Flashcard not found.');
      }

      const tierService = strapi.service('tier-service');
      const reviewTiers = await tierService.getAllTiers();
      const currentTier =
        flashcard.review_tire ||
        tierService.findTierForStreakWithRules(flashcard.correct_streak, reviewTiers);

      const effectiveCooldown = getEffectiveCooldown(currentTier?.cooldown_hours || 0);
      const now = new Date();
      const reviewedAt = now.toISOString();
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
        getCooldownHoursForTier: (tier) => getEffectiveCooldown(tier?.cooldown_hours || 0),
        now,
      });

      const shouldUpdateFlashcardStat =
        effective &&
        flashcard.word_definition?.id &&
        currentTier?.id &&
        currentTier.id !== (updateData.review_tire || currentTier.id);

      if (Object.keys(updateData).length > 0) {
        await strapi.entityService.update(
          'api::flashcard.flashcard',
          flashcardId,
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

      const reviewEvent = buildReviewEvent({
        flashcardId: flashcard.id,
        user,
        reviewedAt,
        result,
        tierBefore: currentLevel,
        tierAfter: newLevel,
        effective,
      });

      await strapi.entityService.create('api::reviewlog.reviewlog', {
        data: {
          user: user.id,
          flashcard: flashcard.id,
          reviewed_at: reviewedAt,
          event_id: reviewEvent.eventId,
          result,
          level: currentLevel,
          effective,
          points_awarded: null,
          newlevel: newLevel,
        },
        db: trx,
      });

      return {
        effective,
        tierPromoted: tierRank(newLevel) > tierRank(currentLevel),
        becameRemembered: currentLevel !== 'remembered' && newLevel === 'remembered',
        reviewedAt,
        currentLevel,
        newLevel,
        flashcardId: flashcard.id,
        reviewEvent,
      };
    });
  },
}));

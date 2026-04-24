'use strict';

const {
  toFlashcardDbTimestamp,
  addHoursAsFlashcardDbTimestamp,
} = require('../../../utils/flashcard-datetime');

const getReviewLevel = (tier) => tier?.tier?.toLowerCase() || null;

const calculateReviewOutcome = ({
  flashcard,
  currentTier,
  reviewTiers,
  result,
  effectiveCooldownHours,
  getCooldownHoursForTier = (tier) => tier?.cooldown_hours || 0,
  now = new Date(),
}) => {
  const reviewIsOnCooldown = currentTier && flashcard.last_reviewed_at
    ? (now - new Date(flashcard.last_reviewed_at)) / 3600e3 <= effectiveCooldownHours
    : false;

  const effective = !reviewIsOnCooldown;
  const updateData = {};
  let nextTier = currentTier;

  if (effective) {
    updateData.last_reviewed_at = toFlashcardDbTimestamp(now);

    if (result === 'correct') {
      const newStreak = (flashcard.correct_streak ?? 0) + 1;
      updateData.correct_streak = newStreak;
      updateData.wrong_streak = 0;

      nextTier = reviewTiers.find(
        (tier) => newStreak >= tier.min_streak && newStreak <= tier.max_streak
      ) || reviewTiers[reviewTiers.length - 1] || null;

      if (nextTier) {
        updateData.review_tire = nextTier.id;
        if (nextTier.tier === 'remembered') {
          updateData.is_remembered = true;
        }
      }
    } else {
      const newWrong = (flashcard.wrong_streak ?? 0) + 1;
      updateData.wrong_streak = newWrong;

      if (currentTier && newWrong >= currentTier.demote_bar) {
        const idx = reviewTiers.findIndex((tier) => tier.id === currentTier.id);
        const prevTier = idx > 0 ? reviewTiers[idx - 1] : reviewTiers[0];
        nextTier = prevTier;
        updateData.correct_streak = prevTier.min_streak;
        updateData.wrong_streak = 0;
        updateData.review_tire = prevTier.id;
        updateData.is_remembered = false;
      }
    }

    updateData.next_review_at = addHoursAsFlashcardDbTimestamp(now, getCooldownHoursForTier(nextTier));
  }

  return {
    effective,
    currentLevel: getReviewLevel(currentTier),
    newLevel: getReviewLevel(nextTier),
    updateData,
  };
};

module.exports = {
  calculateReviewOutcome,
  getReviewLevel,
};

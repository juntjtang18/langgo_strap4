'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const { calculateReviewOutcome } = require('../src/api/flashcard/controllers/review-logic');

const reviewTiers = [
  { id: 1, tier: 'new', min_streak: 0, max_streak: 0, cooldown_hours: 0, demote_bar: 2 },
  { id: 2, tier: 'warmup', min_streak: 1, max_streak: 2, cooldown_hours: 24, demote_bar: 2 },
  { id: 3, tier: 'weekly', min_streak: 3, max_streak: 6, cooldown_hours: 168, demote_bar: 2 },
  { id: 4, tier: 'remembered', min_streak: 7, max_streak: 9999, cooldown_hours: 720, demote_bar: 2 },
];

test('effective correct review promotes tier and records new level', () => {
  const now = new Date(2026, 3, 16, 12, 0, 0, 0);
  const flashcard = {
    correct_streak: 0,
    wrong_streak: 0,
    last_reviewed_at: null,
  };

  const outcome = calculateReviewOutcome({
    flashcard,
    currentTier: reviewTiers[0],
    reviewTiers,
    result: 'correct',
    effectiveCooldownHours: 0,
    now,
  });

  assert.equal(outcome.effective, true);
  assert.equal(outcome.currentLevel, 'new');
  assert.equal(outcome.newLevel, 'warmup');
  assert.deepEqual(outcome.updateData, {
    last_reviewed_at: '2026-04-16 12:00:00.000',
    next_review_at: '2026-04-17 12:00:00.000',
    correct_streak: 1,
    wrong_streak: 0,
    review_tire: 2,
  });
});

test('review on cooldown is not effective and does not change level', () => {
  const now = new Date(2026, 3, 16, 12, 0, 0, 0);
  const flashcard = {
    correct_streak: 1,
    wrong_streak: 0,
    last_reviewed_at: '2026-04-16 11:00:00.000',
  };

  const outcome = calculateReviewOutcome({
    flashcard,
    currentTier: reviewTiers[1],
    reviewTiers,
    result: 'correct',
    effectiveCooldownHours: 24,
    now,
  });

  assert.equal(outcome.effective, false);
  assert.equal(outcome.currentLevel, 'warmup');
  assert.equal(outcome.newLevel, 'warmup');
  assert.deepEqual(outcome.updateData, {});
});

test('effective wrong review demotes when demote bar is reached', () => {
  const now = new Date(2026, 3, 16, 12, 0, 0, 0);
  const flashcard = {
    correct_streak: 3,
    wrong_streak: 1,
    last_reviewed_at: '2026-04-01 12:00:00.000',
  };

  const outcome = calculateReviewOutcome({
    flashcard,
    currentTier: reviewTiers[2],
    reviewTiers,
    result: 'wrong',
    effectiveCooldownHours: 168,
    now,
  });

  assert.equal(outcome.effective, true);
  assert.equal(outcome.currentLevel, 'weekly');
  assert.equal(outcome.newLevel, 'warmup');
  assert.deepEqual(outcome.updateData, {
    last_reviewed_at: '2026-04-16 12:00:00.000',
    next_review_at: '2026-04-17 12:00:00.000',
    wrong_streak: 0,
    correct_streak: 1,
    review_tire: 2,
    is_remembered: false,
  });
});

test('effective wrong review below demote bar keeps current level', () => {
  const now = new Date(2026, 3, 16, 12, 0, 0, 0);
  const flashcard = {
    correct_streak: 3,
    wrong_streak: 0,
    last_reviewed_at: '2026-04-01 12:00:00.000',
  };

  const outcome = calculateReviewOutcome({
    flashcard,
    currentTier: reviewTiers[2],
    reviewTiers,
    result: 'wrong',
    effectiveCooldownHours: 168,
    now,
  });

  assert.equal(outcome.effective, true);
  assert.equal(outcome.currentLevel, 'weekly');
  assert.equal(outcome.newLevel, 'weekly');
  assert.deepEqual(outcome.updateData, {
    last_reviewed_at: '2026-04-16 12:00:00.000',
    next_review_at: '2026-04-23 12:00:00.000',
    wrong_streak: 1,
  });
});

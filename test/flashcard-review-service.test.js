'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const createFlashcardService = require('../src/api/flashcard/services/flashcard');

test('reviewFlashcard marks becameRemembered when an effective correct review reaches remembered tier', async () => {
  const updates = [];
  const reviewlogs = [];

  const flashcard = {
    id: 2627,
    correct_streak: 6,
    wrong_streak: 0,
    next_review_at: null,
    review_tire: { id: 3, tier: 'monthly', cooldown_hours: 24, demote_bar: 2, min_streak: 6, max_streak: 6 },
    word_definition: { id: 90 },
  };

  const reviewTiers = [
    { id: 1, tier: 'new', min_streak: 0, max_streak: 0, cooldown_hours: 0, demote_bar: 2 },
    { id: 2, tier: 'weekly', min_streak: 1, max_streak: 5, cooldown_hours: 24, demote_bar: 2 },
    { id: 3, tier: 'monthly', min_streak: 6, max_streak: 6, cooldown_hours: 24, demote_bar: 2 },
    { id: 4, tier: 'remembered', min_streak: 7, max_streak: 9999, cooldown_hours: 720, demote_bar: 2 },
  ];

  const strapi = {
    contentType() {
      return {};
    },
    db: {
      async transaction(handler) {
        return handler({ trx: {} });
      },
    },
    entityService: {
      async findOne(uid, id) {
        assert.equal(uid, 'api::flashcard.flashcard');
        assert.equal(id, 2627);
        return flashcard;
      },
      async update(uid, id, payload) {
        assert.equal(uid, 'api::flashcard.flashcard');
        assert.equal(id, 2627);
        updates.push(payload.data);
        return { id, ...payload.data };
      },
      async create(uid, payload) {
        assert.equal(uid, 'api::reviewlog.reviewlog');
        reviewlogs.push(payload.data);
        return { id: 1, ...payload.data };
      },
    },
    service(name) {
      if (name === 'tier-service') {
        return {
          async getAllTiers() {
            return reviewTiers;
          },
          findTierForStreakWithRules(streak, tiers) {
            return tiers.find((tier) => streak >= tier.min_streak && streak <= tier.max_streak) || tiers[tiers.length - 1];
          },
        };
      }
      if (name === 'api::flashcard-stat.flashcard-stat') {
        return {
          async move() {
            return undefined;
          },
        };
      }
      throw new Error(`Unexpected service ${name}`);
    },
  };

  const service = createFlashcardService({ strapi });
  const result = await service.reviewFlashcard({
    flashcardId: 2627,
    user: { id: 8, username: 'vivian' },
    result: 'correct',
  });

  assert.equal(result.effective, true);
  assert.equal(result.tierPromoted, true);
  assert.equal(result.becameRemembered, true);
  assert.equal(result.reviewEvent.tierAfter, 'remembered');
  assert.equal(updates.length, 1);
  assert.equal(updates[0].is_remembered, true);
  assert.equal(reviewlogs.length, 1);
});

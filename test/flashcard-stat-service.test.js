'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const createFlashcardStatService = require('../src/api/flashcard-stat/services/flashcard-stat');

test('flashcard-stat summary uses live due counts even when persisted tier counts are stale', async () => {
  const tiers = [
    { id: 1, tier: 'new', display_name: 'New', min_streak: 0, max_streak: 2, cooldown_hours: 6 },
    { id: 2, tier: 'warmup', display_name: 'Warmup', min_streak: 3, max_streak: 6, cooldown_hours: 24 },
    { id: 3, tier: 'remembered', display_name: 'Remembered', min_streak: 7, max_streak: 9999, cooldown_hours: 1000000 },
  ];

  const strapi = {
    contentType() {
      return {};
    },
    entityService: {
      async findMany(uid, query) {
        assert.equal(uid, 'api::flashcard-stat.flashcard-stat');
        assert.deepEqual(query, {
          filters: { user: 60 },
          populate: { review_tire: true },
          limit: 500,
        });

        return [
          { id: 1, word_count: 5, review_tire: { id: 1 } },
          { id: 2, word_count: 2, review_tire: { id: 2 } },
        ];
      },
    },
    service(name) {
      if (name === 'tier-service') {
        return {
          async getAllTiers() {
            return tiers;
          },
        };
      }

      throw new Error(`Unexpected service ${name}`);
    },
  };

  const service = createFlashcardStatService({ strapi });
  service.getLiveDueSummary = async (userId, incomingTiers) => {
    assert.equal(userId, 60);
    assert.equal(incomingTiers.length, 3);

    return {
      dueForReview: 11,
      dueCountByTierId: new Map([
        [1, 8],
        [2, 3],
        [3, 0],
      ]),
    };
  };
  service.getNextFetchAt = async () => {
    throw new Error('getNextFetchAt should not be called when due cards exist');
  };

  const summary = await service.getUserStatisticsSummary(60);

  assert.equal(summary.totalCards, 7);
  assert.equal(summary.dueForReview, 11);
  assert.equal(summary.byTier[0].count, 5);
  assert.equal(summary.byTier[0].dueCount, 8);
  assert.equal(summary.byTier[1].count, 2);
  assert.equal(summary.byTier[1].dueCount, 3);
});

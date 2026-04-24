'use strict';

/**
 * flashcard-stat service
 *
 * Stores only stable, tier-based flashcard counts.
 * Time-driven values such as due-for-review should still be calculated live.
 */

const { createCoreService } = require('@strapi/strapi').factories;

const PAGE_SIZE = 500;

module.exports = createCoreService('api::flashcard-stat.flashcard-stat', ({ strapi }) => ({
  async findOrCreateStatRow(userId, reviewTireId) {
    const rows = await strapi.entityService.findMany('api::flashcard-stat.flashcard-stat', {
      filters: {
        user: userId,
        review_tire: reviewTireId,
      },
      limit: 2,
    });

    if (rows.length > 0) {
      return rows[0];
    }

    return strapi.entityService.create('api::flashcard-stat.flashcard-stat', {
      data: {
        user: userId,
        review_tire: reviewTireId,
        word_count: 0,
      },
    });
  },

  async increment(userId, reviewTireId, delta = 1) {
    if (!userId || !reviewTireId || !delta) return null;

    const row = await this.findOrCreateStatRow(userId, reviewTireId);
    const currentCount = row.word_count || 0;

    return strapi.entityService.update('api::flashcard-stat.flashcard-stat', row.id, {
      data: {
        word_count: Math.max(0, currentCount + delta),
      },
    });
  },

  async move(userId, fromReviewTireId, toReviewTireId) {
    if (!userId || fromReviewTireId === toReviewTireId) return;

    if (fromReviewTireId) {
      await this.increment(userId, fromReviewTireId, -1);
    }

    if (toReviewTireId) {
      await this.increment(userId, toReviewTireId, 1);
    }
  },

  getCardTier(card, tiers, tierService) {
    if (card.review_tire?.id) {
      return card.review_tire;
    }

    return tierService.findTierForStreakWithRules(card.correct_streak || 0, tiers);
  },

  async getUserFlashcards(userId) {
    const cards = [];
    let start = 0;

    while (true) {
      const page = await strapi.entityService.findMany('api::flashcard.flashcard', {
        filters: {
          user: userId,
          word_definition: { $not: null },
        },
        populate: {
          review_tire: true,
        },
        fields: ['id', 'correct_streak'],
        start,
        limit: PAGE_SIZE,
      });

      cards.push(...page);

      if (page.length < PAGE_SIZE) {
        break;
      }

      start += PAGE_SIZE;
    }

    return cards;
  },

  buildTierCounts(cards, tiers, tierService) {
    const countsByTierId = new Map(tiers.map((tier) => [String(tier.id), 0]));

    for (const card of cards) {
      const tier = this.getCardTier(card, tiers, tierService);
      if (!tier?.id) continue;

      const key = String(tier.id);
      countsByTierId.set(key, (countsByTierId.get(key) || 0) + 1);
    }

    return countsByTierId;
  },

  async rebuildUser(userId, tiers) {
    const tierService = strapi.service('tier-service');
    const cards = await this.getUserFlashcards(userId);
    const countsByTierId = this.buildTierCounts(cards, tiers, tierService);

    const existingRows = await strapi.entityService.findMany('api::flashcard-stat.flashcard-stat', {
      filters: { user: userId },
      populate: { review_tire: true },
      limit: -1,
    });

    const firstRowByTierId = new Map();
    const duplicateRowIds = [];

    for (const row of existingRows) {
      const tierId = row.review_tire?.id;
      if (!tierId) continue;

      const key = String(tierId);
      if (firstRowByTierId.has(key)) {
        duplicateRowIds.push(row.id);
      } else {
        firstRowByTierId.set(key, row);
      }
    }

    for (const duplicateId of duplicateRowIds) {
      await strapi.entityService.delete('api::flashcard-stat.flashcard-stat', duplicateId);
    }

    const tierResults = [];

    for (const tier of tiers) {
      const key = String(tier.id);
      const count = countsByTierId.get(key) || 0;
      const existing = firstRowByTierId.get(key);

      let row;
      if (existing) {
        row = await strapi.entityService.update('api::flashcard-stat.flashcard-stat', existing.id, {
          data: { word_count: count },
        });
      } else {
        row = await strapi.entityService.create('api::flashcard-stat.flashcard-stat', {
          data: {
            user: userId,
            review_tire: tier.id,
            word_count: count,
          },
        });
      }

      tierResults.push({
        review_tire_id: tier.id,
        tier: tier.tier,
        word_count: count,
        stat_id: row.id,
      });
    }

    return {
      userId,
      totalCards: cards.length,
      removedDuplicateRows: duplicateRowIds.length,
      tiers: tierResults,
    };
  },

  async getAllUsers() {
    const users = [];
    let start = 0;

    while (true) {
      const page = await strapi.entityService.findMany('plugin::users-permissions.user', {
        fields: ['id', 'username', 'email'],
        start,
        limit: PAGE_SIZE,
      });

      users.push(...page);

      if (page.length < PAGE_SIZE) {
        break;
      }

      start += PAGE_SIZE;
    }

    return users;
  },

  async rebuildAllUsers() {
    const tierService = strapi.service('tier-service');
    const tiers = await tierService.getAllTiers();
    const users = await this.getAllUsers();

    const results = [];

    for (const user of users) {
      const result = await this.rebuildUser(user.id, tiers);
      results.push({
        ...result,
        username: user.username || null,
        email: user.email || null,
      });
    }

    return {
      usersProcessed: users.length,
      tiersProcessed: tiers.length,
      results,
    };
  },
}));

'use strict';

/**
 * flashcard-stat service
 *
 * Stores only stable, tier-based flashcard counts.
 * Time-driven values such as due-for-review should still be calculated live.
 */

const { createCoreService } = require('@strapi/strapi').factories;
const { toFlashcardDbTimestamp } = require('../../../utils/flashcard-datetime');

const PAGE_SIZE = 500;
const BATCH_WINDOW_MINUTES = 20;

module.exports = createCoreService('api::flashcard-stat.flashcard-stat', ({ strapi }) => ({
  async getLiveDueSummary(userId, tiers) {
    if (!userId || !tiers.length) {
      return {
        dueForReview: 0,
        dueCountByTierId: new Map(),
      };
    }

    const tierService = strapi.service('tier-service');
    const now = new Date();
    const dueCountByTierId = new Map(tiers.map((tier) => [tier.id, 0]));
    const seenCardIds = new Set();
    let start = 0;

    while (true) {
      const page = await strapi.entityService.findMany('api::flashcard.flashcard', {
        filters: {
          user: userId,
          word_definition: { $not: null },
          $or: [
            { next_review_at: { $null: true } },
            { next_review_at: { $lte: now } },
          ],
        },
        populate: {
          review_tire: true,
        },
        fields: ['id', 'correct_streak', 'next_review_at'],
        start,
        limit: PAGE_SIZE,
      });

      for (const card of page) {
        if (!card?.id || seenCardIds.has(card.id)) {
          continue;
        }

        seenCardIds.add(card.id);

        const tier = this.getCardTier(card, tiers, tierService);
        if (!tier?.id || !dueCountByTierId.has(tier.id)) {
          continue;
        }

        // 🔥 FIX: exclude remembered tier from due
        if (tier.tier === 'remembered') {
          continue;
        }

        dueCountByTierId.set(tier.id, (dueCountByTierId.get(tier.id) || 0) + 1);
      }

      if (page.length < PAGE_SIZE) {
        break;
      }

      start += PAGE_SIZE;
    }

    const dueForReview = Array.from(dueCountByTierId.values())
      .reduce((sum, count) => sum + count, 0);

    return {
      dueForReview,
      dueCountByTierId,
    };
  },

  async getNextFetchAt(userId) {
    if (!userId) {
      return null;
    }

    const dbSchemaName = strapi.config.get('database.connection.connection.schema', 'public');
    const nowTimestamp = toFlashcardDbTimestamp(new Date());
    const row = await strapi.db.connection.withSchema(dbSchemaName).from('flashcards as f')
      .join('flashcards_user_links as ful', 'ful.flashcard_id', 'f.id')
      .join('flashcards_word_definition_links as fwdl', 'fwdl.flashcard_id', 'f.id')
      .where('ful.user_id', userId)
      .whereNotNull('fwdl.word_definition_id')
      .whereNotNull('f.next_review_at')
      .andWhereRaw('f.next_review_at > ?::timestamp', [nowTimestamp])
      .orderBy('f.next_review_at', 'asc')
      .first('f.next_review_at');

    if (!row?.next_review_at) {
      return null;
    }

    const firstDueAt = new Date(row.next_review_at);
    if (Number.isNaN(firstDueAt.getTime())) {
      return null;
    }

    return new Date(firstDueAt.getTime() + BATCH_WINDOW_MINUTES * 60 * 1000).toISOString();
  },

  async getUserStatisticsSummary(userId) {
    if (!userId) {
      return {
        totalCards: 0,
        remembered: 0,
        dueForReview: 0,
        reviewed: null,
        hardToRemember: null,
        byTier: [],
        nextFetchAt: null,
        batchWindowMinutes: BATCH_WINDOW_MINUTES,
      };
    }

    const tierService = strapi.service('tier-service');
    const tiers = await tierService.getAllTiers();

    if (!tiers.length) {
      return {
        totalCards: 0,
        remembered: 0,
        dueForReview: 0,
        reviewed: null,
        hardToRemember: null,
        byTier: [],
        nextFetchAt: null,
        batchWindowMinutes: BATCH_WINDOW_MINUTES,
      };
    }

    const rows = await strapi.entityService.findMany('api::flashcard-stat.flashcard-stat', {
      filters: { user: userId },
      populate: { review_tire: true },
      limit: 500,
    });

    const countByTierId = new Map();

    for (const row of rows) {
      const reviewTireId = typeof row.review_tire === 'number'
        ? row.review_tire
        : row.review_tire?.id;

      if (!reviewTireId) {
        continue;
      }

      countByTierId.set(
        reviewTireId,
        (countByTierId.get(reviewTireId) || 0) + (row.word_count || 0)
      );
    }

    const { dueCountByTierId } = await this.getLiveDueSummary(userId, tiers);

    const byTier = tiers.map((tier) => {
      const count = countByTierId.get(tier.id) || 0;
      const liveDueCount = dueCountByTierId.get(tier.id) || 0;

      return {
        id: tier.id,
        tier: tier.tier,
        display_name: tier.display_name || null,
        min_streak: tier.min_streak,
        max_streak: tier.max_streak,
        cooldown_hours: tier.cooldown_hours,
        count,
        dueCount: Math.min(count, liveDueCount),
        hardToRememberCount: null,
      };
    });

    const totalCards = byTier.reduce((sum, tier) => sum + tier.count, 0);
    const remembered = byTier.find((tier) => tier.tier === 'remembered')?.count || 0;
    const dueForReview = byTier.reduce((sum, tier) => sum + tier.dueCount, 0);

    const nextFetchAt = dueForReview > 0
      ? null
      : await this.getNextFetchAt(userId);

    return {
      totalCards,
      remembered,
      dueForReview,
      reviewed: null,
      hardToRemember: null,
      byTier,
      nextFetchAt,
      batchWindowMinutes: BATCH_WINDOW_MINUTES,
    };
  },

  async findOrCreateStatRow(userId, reviewTireId, trx) {
    const rows = await strapi.entityService.findMany('api::flashcard-stat.flashcard-stat', {
      filters: {
        user: userId,
        review_tire: reviewTireId,
      },
      limit: 2,
      db: trx,
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
      db: trx,
    });
  },

  async increment(userId, reviewTireId, delta = 1, trx) {
    if (!userId || !reviewTireId || !delta) return null;

    const row = await this.findOrCreateStatRow(userId, reviewTireId, trx);
    const currentCount = row.word_count || 0;

    return strapi.entityService.update('api::flashcard-stat.flashcard-stat', row.id, {
      data: {
        word_count: Math.max(0, currentCount + delta),
      },
      db: trx,
    });
  },

  async move(userId, fromReviewTireId, toReviewTireId, trx) {
    if (!userId || fromReviewTireId === toReviewTireId) return;

    if (fromReviewTireId) {
      await this.increment(userId, fromReviewTireId, -1, trx);
    }

    if (toReviewTireId) {
      await this.increment(userId, toReviewTireId, 1, trx);
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

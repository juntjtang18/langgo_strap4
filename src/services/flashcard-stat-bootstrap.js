'use strict';

module.exports = ({ strapi }) => ({
  async ensureForUser(userId, trx) {
    if (!userId) {
      return [];
    }

    const reviewTiers = await strapi.service('tier-service').getAllTiers();

    if (!reviewTiers.length) {
      return [];
    }

    const existingStats = await strapi.entityService.findMany('api::flashcard-stat.flashcard-stat', {
      filters: {
        user: userId,
      },
      populate: {
        review_tire: true,
      },
      limit: 200,
      db: trx,
    });

    const existingTierIds = new Set(
      existingStats
        .map((stat) => {
          if (!stat?.review_tire) {
            return null;
          }

          return typeof stat.review_tire === 'number'
            ? stat.review_tire
            : stat.review_tire.id;
        })
        .filter(Boolean)
    );

    const createdStats = [];

    for (const tier of reviewTiers) {
      if (existingTierIds.has(tier.id)) {
        continue;
      }

      const createdStat = await strapi.entityService.create('api::flashcard-stat.flashcard-stat', {
        data: {
          user: userId,
          review_tire: tier.id,
          word_count: 0,
        },
        db: trx,
      });

      createdStats.push(createdStat);
    }

    return createdStats;
  },
});

'use strict';

/**
 * A reusable service to find the correct review tier and cache tier data.
 */
module.exports = ({ strapi }) => {
  let _cachedTiers = null; // Private variable for caching

  return {
    /**
     * Fetches all review tiers, sorted by min_streak.
     * Caches the result in memory for subsequent calls.
     * @returns {Promise<Array<object>>} - A sorted array of review_tire objects.
     */
    async getAllTiers() {
      if (_cachedTiers) {
        //strapi.log.debug(`Returning cached review tiers: ${JSON.stringify(_cachedTiers)}`);
        return _cachedTiers;
      }

      strapi.log.info('Fetching and caching review tiers from database.');
      const tiers = await strapi.entityService.findMany('api::review-tire.review-tire', {
        locale: 'en',              // or locale: 'all'
        sort: { min_streak: 'asc' },
      });
      _cachedTiers = tiers;
      //strapi.log.debug(`Tiers cached: ${JSON.stringify(_cachedTiers)}`);
      return _cachedTiers;
    },

    /**
     * Finds the correct review tier for a given streak. This is the simplest
     * method to use as it handles fetching and caching of tier rules internally.
     * @param {number} streak - The user's current correct streak.
     * @returns {Promise<object|null>} - The matching tier object or null.
     */
    async findTierForStreak(streak) {
      const tiers = await this.getAllTiers();
      const tierFound =  this.findTierForStreakWithRules(streak, tiers);
      strapi.log.debug('Found tier for streak:', tierFound);
      return tierFound;
    },

    /**
     * A synchronous version of findTierForStreak that requires the tier rules
     * to be passed in. Useful for performance-critical loops where the rules
     * can be fetched once outside the loop.
     * @param {number} streak - The user's current correct streak.
     * @param {Array<object>} tiers - A sorted array of review_tire objects.
     * @returns {object|null} - The matching tier object or null.
     */
    findTierForStreakWithRules(streak, tiers) {
      //strapi.log.debug(`Finding tier for streak: ${streak}`);
      //strapi.log.debug(`Available tiers: ${JSON.stringify(tiers)}`);
      const currentStreak = streak ?? 0;
      if (!tiers || tiers.length === 0) return null;
      // Tiers should be sorted by min_streak ascending.
      return (
        tiers.find(
          (tier) => currentStreak >= tier.min_streak && currentStreak <= tier.max_streak
        ) || tiers[tiers.length - 1] || null
      );
    },
  };
};
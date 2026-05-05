'use strict';

const CACHE_TTL_MS = 5 * 60 * 1000;

module.exports = ({ strapi }) => {
  let cache = {
    loadedAt: 0,
    groupRule: null,
    levelRule: null,
    eventRules: new Map(),
    groupRanks: [],
    levelTitlesByLocale: new Map(),
    groupRankTitlesByLocale: new Map(),
  };

  const isFresh = () => Date.now() - cache.loadedAt < CACHE_TTL_MS;

  const loadTitles = async (uid, relationField) => {
    const rows = await strapi.entityService.findMany(uid, {
      fields: ['title', 'locale'],
      populate: {
        [relationField]: {
          fields: ['id'],
        },
      },
      limit: 1000,
    });

    const byLocale = new Map();
    for (const row of rows) {
      const locale = row.locale || 'en';
      if (!byLocale.has(locale)) {
        byLocale.set(locale, new Map());
      }
      byLocale.get(locale).set(row[relationField]?.id, row.title || null);
    }
    return byLocale;
  };

  const refresh = async () => {
    const [groupRules, levelRules, eventRules, groupRanks, levelTitlesByLocale, groupRankTitlesByLocale] = await Promise.all([
      strapi.entityService.findMany('plugin::rank-system.rs-group-rule', {
        limit: 1,
        sort: { id: 'asc' },
      }),
      strapi.entityService.findMany('plugin::rank-system.rs-level-rule', {
        limit: 1,
        sort: { id: 'asc' },
      }),
      strapi.entityService.findMany('plugin::rank-system.rs-event-list', {
        limit: 1000,
      }),
      strapi.entityService.findMany('plugin::rank-system.rs-group-rank', {
        sort: [{ rank_no: 'desc' }, { id: 'asc' }],
        populate: {
          rs_group_rule: {
            fields: ['id'],
          },
        },
        limit: 1000,
      }),
      loadTitles('plugin::rank-system.rs-level-title', 'rs_level'),
      loadTitles('plugin::rank-system.rs-group-rank-title', 'rs_group_rank'),
    ]);

    cache = {
      loadedAt: Date.now(),
      groupRule: groupRules[0] || null,
      levelRule: levelRules[0] || null,
      eventRules: new Map(eventRules.map((rule) => [rule.event_name, rule])),
      groupRanks,
      levelTitlesByLocale,
      groupRankTitlesByLocale,
    };
  };

  const ensureLoaded = async () => {
    if (!isFresh()) {
      await refresh();
    }
  };

  const findLocalizedTitle = (store, entityId, locale = 'en') => {
    const byRequested = store.get(locale);
    if (byRequested?.has(entityId)) return byRequested.get(entityId);
    const byEn = store.get('en');
    if (byEn?.has(entityId)) return byEn.get(entityId);
    for (const titles of store.values()) {
      if (titles.has(entityId)) return titles.get(entityId);
    }
    return null;
  };

  return {
    async invalidate() {
      cache.loadedAt = 0;
    },

    async loadGroupRule() {
      await ensureLoaded();
      return cache.groupRule;
    },

    async loadLevelRule() {
      await ensureLoaded();
      return cache.levelRule;
    },

    async loadPointRule(eventName) {
      await ensureLoaded();
      return cache.eventRules.get(eventName) || null;
    },

    async loadGroupRanks(groupRuleId) {
      await ensureLoaded();
      return cache.groupRanks.filter((rank) => rank.rs_group_rule?.id === groupRuleId);
    },

    async findOrCreateLevel(levelNo) {
      const levels = await strapi.entityService.findMany('plugin::rank-system.rs-level', {
        filters: { level_no: levelNo },
        limit: 1,
      });
      if (levels[0]) return levels[0];

      const created = await strapi.entityService.create('plugin::rank-system.rs-level', {
        data: { level_no: levelNo },
      });
      await this.invalidate();
      return created;
    },

    async findLevelTitle(levelId, locale = 'en') {
      await ensureLoaded();
      return findLocalizedTitle(cache.levelTitlesByLocale, levelId, locale);
    },

    async findGroupRankTitle(groupRankId, locale = 'en') {
      await ensureLoaded();
      return findLocalizedTitle(cache.groupRankTitlesByLocale, groupRankId, locale);
    },
  };
};

'use strict';

module.exports = ({ strapi }) => ({
  async loadGroupRule() {
    const rules = await strapi.entityService.findMany('api::rs-group-rule.rs-group-rule', {
      limit: 1,
      sort: { id: 'asc' },
    });
    return rules[0] || null;
  },

  async loadLevelRule() {
    const rules = await strapi.entityService.findMany('api::rs-level-rule.rs-level-rule', {
      limit: 1,
      sort: { id: 'asc' },
    });
    return rules[0] || null;
  },

  async loadPointRule(eventName) {
    const rules = await strapi.entityService.findMany('api::rs-event-list.rs-event-list', {
      filters: { event_name: eventName },
      limit: 1,
    });
    return rules[0] || null;
  },

  async loadGroupRanks(groupRuleId) {
    return strapi.entityService.findMany('api::rs-group-rank.rs-group-rank', {
      filters: { rs_group_rule: { id: groupRuleId } },
      sort: { rank_no: 'desc' },
    });
  },

  async findOrCreateLevel(levelNo) {
    const levels = await strapi.entityService.findMany('api::rs-level.rs-level', {
      filters: { level_no: levelNo },
      limit: 1,
    });
    if (levels[0]) return levels[0];
    return strapi.entityService.create('api::rs-level.rs-level', {
      data: { level_no: levelNo },
    });
  },
});

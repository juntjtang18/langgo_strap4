'use strict';

module.exports = ({ strapi }) => ({
  getGroupRankForPoints(periodPoints, groupRanks) {
    // groupRanks sorted by rank_no desc — return highest rank user qualifies for
    for (const rank of groupRanks) {
      if (periodPoints >= rank.min_period_points) {
        return rank;
      }
    }
    return groupRanks[groupRanks.length - 1];
  },

  async getNextGroupNo(groupRuleId) {
    const groups = await strapi.entityService.findMany('api::rs-group.rs-group', {
      filters: { rs_group_rule: { id: groupRuleId } },
      sort: { group_no: 'desc' },
      limit: 1,
    });
    return (groups[0]?.group_no || 0) + 1;
  },

  async createGroup(groupRuleId, groupRankId) {
    const groupNo = await this.getNextGroupNo(groupRuleId);
    return strapi.entityService.create('api::rs-group.rs-group', {
      data: { rs_group_rule: groupRuleId, rs_group_rank: groupRankId, group_no: groupNo },
    });
  },

  // Returns userids whose most-recent snapshot belongs to the given group (PostgreSQL).
  async getCurrentMembersOfGroup(groupId) {
    const result = await strapi.db.connection.raw(`
      SELECT userid FROM (
        SELECT DISTINCT ON (userid) userid, rs_group_id
        FROM rs_user_snapshots
        ORDER BY userid, record_date DESC
      ) latest
      WHERE rs_group_id = ?
    `, [groupId]);
    return result.rows.map(r => r.userid);
  },

  async countCurrentGroupMembers(groupId) {
    const members = await this.getCurrentMembersOfGroup(groupId);
    return members.length;
  },

  async splitGroup(groupId, groupRuleId, groupRankId) {
    const members = await this.getCurrentMembersOfGroup(groupId);
    const newGroup = await this.createGroup(groupRuleId, groupRankId);

    // Alternate assignment: odd-indexed members move to new group
    const toMove = members.filter((_, i) => i % 2 === 1);
    const snapshotSvc = strapi.service('rank-snapshot');
    for (const userid of toMove) {
      await snapshotSvc.moveUserToGroup(userid, newGroup.id);
    }

    return newGroup;
  },

  async assignUserToRankedGroup(userid, groupRuleId, groupRankId, groupSize) {
    const groups = await strapi.entityService.findMany('api::rs-group.rs-group', {
      filters: { rs_group_rank: { id: groupRankId } },
    });

    if (groups.length === 0) {
      return this.createGroup(groupRuleId, groupRankId);
    }

    for (const group of groups) {
      const memberCount = await this.countCurrentGroupMembers(group.id);
      if (memberCount < groupSize * 2) {
        return group;
      }
    }

    // All groups at capacity — split first group, assign to the smaller half
    const targetGroup = groups[0];
    const newGroup = await this.splitGroup(targetGroup.id, groupRuleId, groupRankId);
    const oldCount = await this.countCurrentGroupMembers(targetGroup.id);
    const newCount = await this.countCurrentGroupMembers(newGroup.id);
    return oldCount <= newCount ? targetGroup : newGroup;
  },
});

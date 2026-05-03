'use strict';

module.exports = ({ strapi }) => ({
  getGroupRankForPoints(periodPoints, groupRanks) {
    for (const rank of groupRanks) {
      if (periodPoints >= (rank.min_period_points || 0)) {
        return rank;
      }
    }
    return groupRanks[groupRanks.length - 1] || null;
  },

  async getNextGroupNo(groupRuleId) {
    const groups = await strapi.entityService.findMany('api::rs-group.rs-group', {
      filters: { rs_group_rule: { id: groupRuleId } },
      sort: [{ group_no: 'desc' }, { id: 'desc' }],
      limit: 1,
    });
    return (groups[0]?.group_no || 0) + 1;
  },

  async createGroup(groupRuleId, groupRankId) {
    const groupNo = await this.getNextGroupNo(groupRuleId);
    return strapi.entityService.create('api::rs-group.rs-group', {
      data: {
        rs_group_rule: groupRuleId,
        rs_group_rank: groupRankId,
        group_no: groupNo,
      },
    });
  },

  async getCurrentMembersOfGroup(groupId) {
    const rows = await strapi.service('rank-user-group').listByGroup(groupId);
    return rows.map((row) => row.userid);
  },

  async countCurrentGroupMembers(groupId) {
    return strapi.service('rank-user-group').countByGroup(groupId);
  },

  async splitGroup(groupId, groupRuleId, groupRankId, groupSize, groupRankTitle) {
    const rows = await strapi.service('rank-user-group').listByGroup(groupId);
    if (rows.length <= groupSize * 2) {
      return null;
    }

    const newGroup = await this.createGroup(groupRuleId, groupRankId);
    const toMove = rows.slice(Math.ceil(rows.length / 2));
    const userGroupSvc = strapi.service('rank-user-group');
    const snapshotSvc = strapi.service('rank-snapshot');

    for (const row of toMove) {
      await userGroupSvc.upsert(row.userid, row.username, newGroup.id, row.period_points || 0);
      await snapshotSvc.updateLatestGroup(row.userid, newGroup.id, groupRankId, groupRankTitle);
    }

    return newGroup;
  },

  async assignUserToRankedGroup(userid, username, groupRuleId, groupRankId, groupSize, periodPoints, groupRankTitle) {
    const userGroupSvc = strapi.service('rank-user-group');
    const existingMembership = await userGroupSvc.getByUserid(userid);

    let targetGroup = null;
    if (existingMembership?.rs_group?.id) {
      const currentGroup = await strapi.entityService.findOne('api::rs-group.rs-group', existingMembership.rs_group.id, {
        populate: {
          rs_group_rank: {
            fields: ['id'],
          },
        },
      });
      if (currentGroup?.rs_group_rank?.id === groupRankId) {
        targetGroup = currentGroup;
      }
    }

    if (!targetGroup) {
      const groups = await strapi.entityService.findMany('api::rs-group.rs-group', {
        filters: { rs_group_rank: { id: groupRankId } },
        sort: [{ group_no: 'asc' }, { id: 'asc' }],
        limit: 1000,
      });

      targetGroup = groups[0] || null;

      if (!targetGroup) {
        targetGroup = await this.createGroup(groupRuleId, groupRankId);
      }
    }

    await userGroupSvc.upsert(userid, username, targetGroup.id, periodPoints);
    await this.splitGroup(targetGroup.id, groupRuleId, groupRankId, groupSize, groupRankTitle);

    const finalMembership = await userGroupSvc.getByUserid(userid);
    const finalGroup = finalMembership?.rs_group?.id
      ? await strapi.entityService.findOne('api::rs-group.rs-group', finalMembership.rs_group.id)
      : targetGroup;

    return {
      membership: finalMembership,
      group: finalGroup,
    };
  },
});

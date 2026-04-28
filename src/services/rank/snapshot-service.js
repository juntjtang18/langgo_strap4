'use strict';

module.exports = ({ strapi }) => ({
  getTodayDate() {
    return new Date().toISOString().split('T')[0];
  },

  async userExists(userid) {
    const found = await strapi.entityService.findMany('api::rs-user-snapshot.rs-user-snapshot', {
      filters: { userid },
      limit: 1,
      fields: ['id'],
    });
    return found.length > 0;
  },

  async getTodaySnapshot(userid) {
    const today = this.getTodayDate();
    const records = await strapi.entityService.findMany('api::rs-user-snapshot.rs-user-snapshot', {
      filters: { userid, record_date: today },
      populate: ['rs_group', 'rs_group_rank', 'rs_level'],
      limit: 1,
    });
    return records[0] || null;
  },

  async getLatestSnapshot(userid) {
    const today = this.getTodayDate();
    const records = await strapi.entityService.findMany('api::rs-user-snapshot.rs-user-snapshot', {
      filters: { userid, record_date: { $lt: today } },
      sort: { record_date: 'desc' },
      populate: ['rs_group', 'rs_group_rank', 'rs_level'],
      limit: 1,
    });
    return records[0] || null;
  },

  // Returns today's snapshot, or the most recent one if today's doesn't exist yet.
  async getCurrentSnapshot(userid) {
    return (await this.getTodaySnapshot(userid)) || (await this.getLatestSnapshot(userid));
  },

  async createInitialSnapshot(userid, groupId, groupRankId, levelId) {
    return strapi.entityService.create('api::rs-user-snapshot.rs-user-snapshot', {
      data: {
        userid,
        record_date: this.getTodayDate(),
        rs_group: groupId || null,
        rs_group_rank: groupRankId || null,
        rs_level: levelId || null,
        total_points: 0,
        points_add: 0,
        word_count: 0,
        word_add: 0,
        article_count: 0,
        article_add: 0,
        level_change: 0,
        group_rank_change: 0,
      },
    });
  },

  async createFromPrevious(userid, previous) {
    return strapi.entityService.create('api::rs-user-snapshot.rs-user-snapshot', {
      data: {
        userid,
        record_date: this.getTodayDate(),
        rs_group: previous.rs_group?.id || null,
        rs_group_rank: previous.rs_group_rank?.id || null,
        rs_level: previous.rs_level?.id || null,
        total_points: previous.total_points,
        points_add: 0,
        word_count: previous.word_count,
        word_add: 0,
        article_count: previous.article_count,
        article_add: 0,
        level_change: 0,
        group_rank_change: 0,
      },
    });
  },

  // Used by group-service split: moves a user's today-snapshot (creating it if needed) to a new group.
  async moveUserToGroup(userid, newGroupId) {
    const today = this.getTodayDate();
    let snap = await this.getTodaySnapshot(userid);
    if (snap) {
      return this.updateSnapshot(snap.id, { rs_group: newGroupId });
    }
    const previous = await this.getLatestSnapshot(userid);
    if (!previous) return null;
    return strapi.entityService.create('api::rs-user-snapshot.rs-user-snapshot', {
      data: {
        userid,
        record_date: today,
        rs_group: newGroupId,
        rs_group_rank: previous.rs_group_rank?.id || null,
        rs_level: previous.rs_level?.id || null,
        total_points: previous.total_points,
        points_add: 0,
        word_count: previous.word_count,
        word_add: 0,
        article_count: previous.article_count,
        article_add: 0,
        level_change: 0,
        group_rank_change: 0,
      },
    });
  },

  async updateSnapshot(snapshotId, data) {
    return strapi.entityService.update('api::rs-user-snapshot.rs-user-snapshot', snapshotId, { data });
  },

  async getPeriodPoints(userid, periodDays) {
    const today = new Date();
    const startDate = new Date(today);
    startDate.setDate(startDate.getDate() - periodDays + 1);
    const startStr = startDate.toISOString().split('T')[0];
    const todayStr = today.toISOString().split('T')[0];

    const snaps = await strapi.entityService.findMany('api::rs-user-snapshot.rs-user-snapshot', {
      filters: { userid, record_date: { $gte: startStr, $lte: todayStr } },
      fields: ['points_add'],
    });
    return snaps.reduce((sum, s) => sum + (s.points_add || 0), 0);
  },
});

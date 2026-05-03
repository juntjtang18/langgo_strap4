'use strict';

module.exports = ({ strapi }) => ({
  getTodayDate(date = new Date()) {
    return date.toISOString().slice(0, 10);
  },

  async getTodaySnapshot(userid, date = new Date()) {
    const today = this.getTodayDate(date);
    const rows = await strapi.entityService.findMany('api::rs-user-snapshot.rs-user-snapshot', {
      filters: { userid: String(userid), record_date: today },
      populate: ['rs_group', 'rs_group_rank', 'rs_level'],
      limit: 1,
    });
    return rows[0] || null;
  },

  async getLatestSnapshot(userid) {
    const rows = await strapi.entityService.findMany('api::rs-user-snapshot.rs-user-snapshot', {
      filters: { userid: String(userid) },
      populate: ['rs_group', 'rs_group_rank', 'rs_level'],
      sort: [{ record_date: 'desc' }, { id: 'desc' }],
      limit: 1,
    });
    return rows[0] || null;
  },

  async getPreviousSnapshot(userid, date = new Date()) {
    const today = this.getTodayDate(date);
    const rows = await strapi.entityService.findMany('api::rs-user-snapshot.rs-user-snapshot', {
      filters: { userid: String(userid), record_date: { $lt: today } },
      populate: ['rs_group', 'rs_group_rank', 'rs_level'],
      sort: [{ record_date: 'desc' }, { id: 'desc' }],
      limit: 1,
    });
    return rows[0] || null;
  },

  async ensureTodaySnapshot(userid, username, date = new Date()) {
    const existing = await this.getTodaySnapshot(userid, date);
    if (existing) return existing;

    const previous = await this.getPreviousSnapshot(userid, date);
    const today = this.getTodayDate(date);

    return strapi.entityService.create('api::rs-user-snapshot.rs-user-snapshot', {
      data: {
        userid: String(userid),
        username: username || previous?.username || null,
        record_date: today,
        total_points: previous?.total_points || 0,
        points_add: 0,
        word_count: previous?.word_count || 0,
        word_add: 0,
        article_count: previous?.article_count || 0,
        article_add: 0,
        rs_level: previous?.rs_level?.id || null,
        level_title: previous?.level_title || null,
        level_change: 0,
        rs_group_rank: previous?.rs_group_rank?.id || null,
        rs_group: previous?.rs_group?.id || null,
        group_rank_title: previous?.group_rank_title || null,
        group_rank_change: 0,
      },
    });
  },

  async updateSnapshot(snapshotId, data) {
    return strapi.entityService.update('api::rs-user-snapshot.rs-user-snapshot', snapshotId, { data });
  },

  async getPeriodPoints(userid, periodDays, date = new Date()) {
    const end = new Date(date);
    end.setHours(0, 0, 0, 0);

    const start = new Date(end);
    const safeDays = Number.isInteger(periodDays) && periodDays > 0 ? periodDays : 7;
    start.setDate(start.getDate() - safeDays + 1);

    const rows = await strapi.entityService.findMany('api::rs-user-snapshot.rs-user-snapshot', {
      filters: {
        userid: String(userid),
        record_date: {
          $gte: this.getTodayDate(start),
          $lte: this.getTodayDate(end),
        },
      },
      fields: ['points_add'],
      limit: 1000,
    });

    return rows.reduce((sum, row) => sum + (row.points_add || 0), 0);
  },

  async updateLatestGroup(userid, groupId, groupRankId = null, groupRankTitle = null) {
    const latest = await this.getLatestSnapshot(userid);
    if (!latest) return null;

    return this.updateSnapshot(latest.id, {
      rs_group: groupId,
      ...(groupRankId ? { rs_group_rank: groupRankId } : {}),
      ...(groupRankTitle !== null ? { group_rank_title: groupRankTitle } : {}),
    });
  },
});

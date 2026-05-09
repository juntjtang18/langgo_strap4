'use strict';

module.exports = ({ strapi }) => ({
  async getByUserid(userid) {
    const rows = await strapi.entityService.findMany('plugin::rank-system.rs-user-group', {
      filters: { userid: String(userid) },
      populate: ['rs_group'],
      limit: 1,
    });
    return rows[0] || null;
  },

  async listByGroup(groupId) {
    return strapi.entityService.findMany('plugin::rank-system.rs-user-group', {
      filters: { rs_group: { id: groupId } },
      fields: ['id', 'userid', 'username', 'period_points', 'visible_on_ladder'],
      sort: [{ userid: 'asc' }, { id: 'asc' }],
      limit: 1000,
    });
  },

  async countByGroup(groupId) {
    const rows = await this.listByGroup(groupId);
    return rows.length;
  },

  async upsert(userid, username, groupId, periodPoints, visibleOnLadder = null) {
    const existing = await this.getByUserid(userid);
    const data = {
      userid: String(userid),
      username: username || existing?.username || null,
      rs_group: groupId || null,
      period_points: periodPoints || 0,
      visible_on_ladder: visibleOnLadder == null
        ? (existing?.visible_on_ladder ?? true)
        : visibleOnLadder !== false,
    };

    if (existing) {
      return strapi.entityService.update('plugin::rank-system.rs-user-group', existing.id, { data });
    }

    return strapi.entityService.create('plugin::rank-system.rs-user-group', { data });
  },
});

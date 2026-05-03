'use strict';

module.exports = ({ strapi }) => ({
  async getByUserid(userid) {
    const rows = await strapi.entityService.findMany('api::rs-user-group.rs-user-group', {
      filters: { userid: String(userid) },
      populate: ['rs_group'],
      limit: 1,
    });
    return rows[0] || null;
  },

  async listByGroup(groupId) {
    return strapi.entityService.findMany('api::rs-user-group.rs-user-group', {
      filters: { rs_group: { id: groupId } },
      fields: ['id', 'userid', 'username', 'period_points'],
      sort: [{ userid: 'asc' }, { id: 'asc' }],
      limit: 1000,
    });
  },

  async countByGroup(groupId) {
    const rows = await this.listByGroup(groupId);
    return rows.length;
  },

  async upsert(userid, username, groupId, periodPoints) {
    const existing = await this.getByUserid(userid);
    const data = {
      userid: String(userid),
      username: username || existing?.username || null,
      rs_group: groupId || null,
      period_points: periodPoints || 0,
    };

    if (existing) {
      return strapi.entityService.update('api::rs-user-group.rs-user-group', existing.id, { data });
    }

    return strapi.entityService.create('api::rs-user-group.rs-user-group', { data });
  },
});

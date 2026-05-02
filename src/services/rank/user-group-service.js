'use strict';

module.exports = ({ strapi }) => ({
  async upsertUserGroup(userid, groupId) {
    const existing = await strapi.entityService.findMany('api::rs-user-group.rs-user-group', {
      filters: { userid: String(userid) },
      fields: ['id', 'userid'],
      populate: {
        rs_group: {
          fields: ['id'],
        },
      },
      limit: 1,
    });

    if (existing.length > 0) {
      const current = existing[0];
      if (current.rs_group?.id === groupId) {
        return current;
      }

      return strapi.entityService.update('api::rs-user-group.rs-user-group', current.id, {
        data: {
          rs_group: groupId || null,
        },
      });
    }

    return strapi.entityService.create('api::rs-user-group.rs-user-group', {
      data: {
        userid: String(userid),
        rs_group: groupId || null,
      },
    });
  },
});

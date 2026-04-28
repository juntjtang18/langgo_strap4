'use strict';

module.exports = {
  async submitEvent(ctx) {
    const { event_id, event_name, userid, payload } = ctx.request.body || {};

    if (!event_name || !userid) {
      return ctx.badRequest('event_name and userid are required');
    }

    const result = await strapi.service('rank-event-processor').processEvent({
      event_id,
      event_name,
      userid,
      payload: payload || {},
    });

    ctx.body = { data: result };
  },

  async getUserStatus(ctx) {
    const { userid } = ctx.params;

    const [userLevel, userGroup, snapshot] = await Promise.all([
      strapi.entityService.findMany('api::rs-user-level.rs-user-level', {
        filters: { userid },
        limit: 1,
      }),
      strapi.entityService.findMany('api::rs-user-group.rs-user-group', {
        filters: { userid },
        populate: { rs_group: { populate: ['rs_group_rank'] } },
        limit: 1,
      }),
      strapi.entityService.findMany('api::rs-user-snapshot.rs-user-snapshot', {
        filters: { userid },
        sort: { record_date: 'desc' },
        populate: ['rs_group', 'rs_group_rank', 'rs_level'],
        limit: 1,
      }),
    ]);

    ctx.body = {
      data: {
        userid,
        level_no: userLevel[0]?.level_no || null,
        group: userGroup[0]?.rs_group || null,
        group_rank: userGroup[0]?.rs_group?.rs_group_rank || null,
        latest_snapshot: snapshot[0] || null,
      },
    };
  },
};

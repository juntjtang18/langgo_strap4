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
    const userId = String(userid);

    const snapshots = await strapi.entityService.findMany(
      'api::rs-user-snapshot.rs-user-snapshot',
      {
        filters: { userid: userId },
        sort: { record_date: 'desc' },
        fields: [
          'id',
          'userid',
          'record_date',
          'total_points',
          'points_add',
          'word_count',
          'word_add',
          'article_count',
          'article_add',
          'group_rank_change',
          'level_change',
        ],
        populate: {
          rs_group: {
            fields: ['id', 'group_no'],
            populate: {
              rs_group_rank: {
                fields: ['id', 'rank_no', 'min_period_points'],
              },
            },
          },
          rs_group_rank: {
            fields: ['id', 'rank_no', 'min_period_points'],
          },
          rs_level: {
            fields: ['id', 'level_no'],
          },
        },
        limit: 1,
      }
    );

    const snapshot = snapshots[0] || null;
    const groupRank = snapshot?.rs_group?.rs_group_rank || snapshot?.rs_group_rank || null;

    ctx.body = {
      data: {
        latest_snapshot: snapshot
          ? {
              id: snapshot.id,
              userid: snapshot.userid,
              record_date: snapshot.record_date,

              total_points: snapshot.total_points,
              points_add: snapshot.points_add,

              word_count: snapshot.word_count,
              word_add: snapshot.word_add,

              article_count: snapshot.article_count,
              article_add: snapshot.article_add,

              level_no: snapshot.rs_level?.level_no || null,
              level_change: snapshot.level_change,

              group: snapshot.rs_group?.id || null,
              group_no: snapshot.rs_group?.group_no || null,

              group_rank_change: snapshot.group_rank_change,
            }
          : null,
      },
    };
  },
};
'use strict';

async function findTitle(uid, relationField, relationId, locale) {
  if (!relationId) return null;

  const findByLocale = async (targetLocale) => {
    const rows = await strapi.entityService.findMany(uid, {
      filters: {
        [relationField]: {
          id: relationId,
        },
      },
      locale: targetLocale,
      fields: ['title', 'locale'],
      limit: 1,
    });

    return rows?.[0]?.title || null;
  };

  return (
    (await findByLocale(locale)) ||
    (locale !== 'en' ? await findByLocale('en') : null) ||
    null
  );
}

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
    const locale = ctx.query?.locale || 'en';

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
                fields: ['id', 'rank_no'],
              },
            },
          },
          rs_group_rank: {
            fields: ['id', 'rank_no'],
          },
          rs_level: {
            fields: ['id', 'level_no'],
          },
        },
        limit: 1,
      }
    );

    const snapshot = snapshots[0] || null;

    if (!snapshot) {
      return (ctx.body = { data: { latest_snapshot: null } });
    }

    const groupRank =
      snapshot?.rs_group?.rs_group_rank ||
      snapshot?.rs_group_rank ||
      null;

    const levelTitle = await findTitle(
      'api::rs-level-title.rs-level-title',
      'rs_level',
      snapshot?.rs_level?.id,
      locale
    );

    const groupRankTitle = await findTitle(
      'api::rs-group-rank-title.rs-group-rank-title',
      'rs_group_rank',
      groupRank?.id,
      locale
    );

    return (ctx.body = {
      data: {
        latest_snapshot: {
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
          level_title: levelTitle,

          group_id: snapshot.rs_group?.id || null,
          group_no: snapshot.rs_group?.group_no || null,

          group_rank: groupRank?.rank_no || null,
          group_rank_title: groupRankTitle,

          group_rank_change: snapshot.group_rank_change,
        },
      },
    });
  },

  async getMeStatus(ctx) {
    if (!ctx.state.user) {
      return ctx.unauthorized('You must be logged in to perform this action.');
    }

    const { id: userId } = ctx.state.user;

    const profiles = await strapi.entityService.findMany(
      'api::user-profile.user-profile',
      {
        filters: { user: userId },
        fields: ['id', 'baseLanguage'],
        limit: 1,
      }
    );

    if (profiles.length === 0) {
      return ctx.notFound('No user profile found for the current user.');
    }

    const profile = profiles[0];

    ctx.params = {
      ...ctx.params,
      userid: String(userId),
    };

    ctx.query = {
      ...ctx.query,
      locale: profile.baseLanguage || 'en',
    };

    return this.getUserStatus(ctx);
  },
};

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

async function getCurrentUserProfile(userId) {
  const profiles = await strapi.entityService.findMany(
    'api::user-profile.user-profile',
    {
      filters: { user: userId },
      fields: ['id', 'baseLanguage'],
      limit: 1,
    }
  );

  return profiles[0] || null;
}

function requireAuthenticatedUser(ctx) {
  if (!ctx.state.user) {
    ctx.unauthorized('You must be logged in to perform this action.');
    return null;
  }

  return ctx.state.user;
}

function toUtcDate(dateString) {
  return new Date(`${dateString}T00:00:00.000Z`);
}

async function resolvePeriodMetrics(userid, snapshot) {
  if (!snapshot) {
    return {
      periodPoints: 0,
      periodPointsChange: 0,
    };
  }

  if (snapshot.period_points != null && snapshot.period_points_change != null) {
    return {
      periodPoints: snapshot.period_points,
      periodPointsChange: snapshot.period_points_change,
    };
  }

  const groupRule = await strapi.service('rank-rule-loader').loadGroupRule();
  const periodDays = groupRule?.period_days || 7;
  const snapshotDate = snapshot.record_date ? toUtcDate(snapshot.record_date) : new Date();
  const snapshotService = strapi.service('rank-snapshot');

  const periodPoints = await snapshotService.getPeriodPoints(userid, periodDays, snapshotDate);
  const previousSnapshot = await snapshotService.getPreviousSnapshot(userid, snapshotDate);

  let previousPeriodPoints = 0;
  if (previousSnapshot) {
    if (previousSnapshot.period_points != null) {
      previousPeriodPoints = previousSnapshot.period_points;
    } else if (previousSnapshot.record_date) {
      previousPeriodPoints = await snapshotService.getPeriodPoints(
        userid,
        periodDays,
        toUtcDate(previousSnapshot.record_date)
      );
    }
  }

  return {
    periodPoints,
    periodPointsChange: periodPoints - previousPeriodPoints,
  };
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
          'level_title',
          'group_rank_title',
          'period_points',
          'period_points_change',
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
        sort: [{ record_date: 'desc' }, { id: 'desc' }],
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
    const { periodPoints, periodPointsChange } = await resolvePeriodMetrics(userId, snapshot);

    return (ctx.body = {
      data: {
        latest_snapshot: {
          id: snapshot.id,
          userid: snapshot.userid,
          record_date: snapshot.record_date || null,

          total_points: snapshot.total_points,
          points_add: snapshot.points_add,

          word_count: snapshot.word_count,
          word_add: snapshot.word_add,

          article_count: snapshot.article_count,
          article_add: snapshot.article_add,

          level_no: snapshot.rs_level?.level_no || null,
          level_change: snapshot.level_change,
          level_title: levelTitle || snapshot.level_title || null,

          group_id: snapshot.rs_group?.id || null,
          group_no: snapshot.rs_group?.group_no || null,

          group_rank: groupRank?.rank_no || null,
          group_rank_title: groupRankTitle || snapshot.group_rank_title || null,

          group_rank_change: snapshot.group_rank_change,
          period_points: periodPoints,
          period_points_change: periodPointsChange,
        },
      },
    });
  },

  async getMeStatus(ctx) {
    const user = requireAuthenticatedUser(ctx);
    if (!user) return;

    const { id: userId } = user;
    const profile = await getCurrentUserProfile(userId);

    if (!profile) {
      return ctx.notFound('No user profile found for the current user.');
    }

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

  async getMyLeaderboard(ctx) {
    const user = requireAuthenticatedUser(ctx);
    if (!user) return;

    const profile = await getCurrentUserProfile(user.id);
    if (!profile) {
      return ctx.notFound('No user profile found for the current user.');
    }

    const locale = ctx.query?.locale || profile.baseLanguage || 'en';
    const membership = await strapi.service('rank-user-group').getByUserid(user.id);

    if (!membership?.rs_group?.id) {
      ctx.body = {
        data: {
          group: null,
          members: [],
        },
      };
      return;
    }

    const group = await strapi.entityService.findOne('api::rs-group.rs-group', membership.rs_group.id, {
      fields: ['id', 'group_no'],
      populate: {
        rs_group_rank: {
          fields: ['id', 'rank_no'],
        },
      },
    });

    const members = await strapi.service('rank-user-group').listByGroup(membership.rs_group.id);
    const sortedMembers = members
      .slice()
      .sort((left, right) => {
        const pointDelta = (right.period_points || 0) - (left.period_points || 0);
        if (pointDelta !== 0) return pointDelta;
        const userCompare = String(left.userid).localeCompare(String(right.userid), 'en', { numeric: true });
        if (userCompare !== 0) return userCompare;
        return (left.id || 0) - (right.id || 0);
      })
      .map((row, index) => ({
        userid: String(row.userid),
        username: row.username || null,
        period_points: row.period_points || 0,
        order_in_group: index + 1,
      }));

    const groupRankTitle = await findTitle(
      'api::rs-group-rank-title.rs-group-rank-title',
      'rs_group_rank',
      group?.rs_group_rank?.id,
      locale
    );

    ctx.body = {
      data: {
        group: {
          group_id: group?.id || null,
          group_no: group?.group_no || null,
          group_rank: group?.rs_group_rank?.rank_no || null,
          group_rank_title: groupRankTitle || null,
          member_count: members.length,
        },
        members: sortedMembers,
      },
    };
  },
};

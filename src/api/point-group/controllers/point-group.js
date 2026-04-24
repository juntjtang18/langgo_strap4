'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

const buildEmptyPointGroupResponse = () => ({
  data: {
    point_group: null,
    my_membership: {
      user_point_group_id: null,
      period_points: 0,
      position_in_group: null,
      group_member_count: 0,
    },
    leaderboard: [],
  },
  meta: {},
});

const buildEmptyRequestedPointGroupResponse = () => ({
  data: {
    point_group: null,
    current_user_position: null,
    group_member_count: 0,
    leaderboard: [],
  },
  meta: {},
});

const resolveRequestedLocale = async (strapi, userId, explicitLocale) => {
  if (explicitLocale && explicitLocale !== 'all') {
    return explicitLocale;
  }

  if (!userId) {
    return null;
  }

  const profile = await strapi.db.query('api::user-profile.user-profile').findOne({
    where: { user: userId },
    select: ['baseLanguage'],
  });

  return profile?.baseLanguage || null;
};

const localizeGroupRank = async (strapi, groupRank, locale) => {
  if (!groupRank) {
    return null;
  }

  if (!locale || groupRank.locale === locale) {
    return groupRank;
  }

  const localizedRanks = await strapi.entityService.findMany('api::group-rank.group-rank', {
    filters: {
      localizations: {
        id: groupRank.id,
      },
      locale,
    },
    limit: 1,
  });

  return localizedRanks?.[0] || groupRank;
};

const buildPointGroupSummary = (pointGroup) => ({
  id: pointGroup.id,
  group_no: pointGroup.group_no ?? null,
  group_rank: pointGroup.group_rank
    ? {
        id: pointGroup.group_rank.id,
        title: pointGroup.group_rank.title,
        min_period_points: pointGroup.group_rank.min_period_points ?? 0,
      }
    : null,
});

const mapLeaderboardMember = (member, position, currentUserId) => ({
  position,
  period_points: member.period_points ?? 0,
  is_current_user: member.user?.id === currentUserId,
  user_point_group_id: member.id,
  user: {
    id: member.user?.id ?? null,
    username: member.user?.username ?? null,
    email: member.user?.email ?? null,
    honor_title: member.user?.honor_title
      ? {
          id: member.user.honor_title.id,
          title: member.user.honor_title.title,
        }
      : null,
    user_profile: member.user?.user_profile
      ? {
          id: member.user.user_profile.id,
          baseLanguage: member.user.user_profile.baseLanguage ?? null,
          avatar_img: member.user.user_profile.avatar_img
            ? {
                id: member.user.user_profile.avatar_img.id,
                url: member.user.user_profile.avatar_img.url ?? null,
              }
            : null,
        }
      : null,
  },
});

module.exports = createCoreController('api::point-group.point-group', ({ strapi }) => ({
  async _buildLeaderboardData(pointGroupId, currentUserId, locale = null) {
    const pointGroup = await strapi.entityService.findOne('api::point-group.point-group', pointGroupId, {
      populate: {
        group_rank: {
          populate: {
            localizations: true,
          },
        },
      },
    });

    if (!pointGroup) {
      return null;
    }

    const localizedGroupRank = await localizeGroupRank(strapi, pointGroup.group_rank, locale);
    if (localizedGroupRank) {
      pointGroup.group_rank = localizedGroupRank;
    }

    const members = await strapi.entityService.findMany('api::user-point-group.user-point-group', {
      filters: {
        point_group: pointGroup.id,
      },
      sort: ['id:asc'],
      limit: 1000,
      populate: {
        user: {
          populate: {
            honor_title: true,
            user_profile: {
              populate: {
                avatar_img: true,
              },
            },
          },
        },
      },
    });

    const sortedMembers = [...members].sort((left, right) => {
      const periodGap = (right.period_points ?? 0) - (left.period_points ?? 0);

      if (periodGap !== 0) {
        return periodGap;
      }

      return (left.id ?? 0) - (right.id ?? 0);
    });

    const leaderboard = sortedMembers.map((member, index) =>
      mapLeaderboardMember(member, index + 1, currentUserId)
    );

    return {
      pointGroup,
      leaderboard,
    };
  },

  async findMine(ctx) {
    const { user } = ctx.state;

    if (!user) {
      return ctx.unauthorized('Authentication required.');
    }

    const requestedLocale = await resolveRequestedLocale(strapi, user.id, ctx.query?.locale);

    const memberships = await strapi.entityService.findMany('api::user-point-group.user-point-group', {
      filters: {
        user: user.id,
      },
      sort: ['id:desc'],
      limit: 1,
      populate: {
        point_group: {
          populate: {
            group_rank: {
              populate: {
                localizations: true,
              },
            },
          },
        },
      },
    });

    const currentMembership = memberships[0];

    if (!currentMembership?.point_group?.id) {
      return buildEmptyPointGroupResponse();
    }

    const localizedGroupRank = await localizeGroupRank(
      strapi,
      currentMembership.point_group.group_rank,
      requestedLocale
    );
    if (localizedGroupRank) {
      currentMembership.point_group.group_rank = localizedGroupRank;
    }

    const leaderboardData = await this._buildLeaderboardData(currentMembership.point_group.id, user.id, requestedLocale);
    const leaderboard = leaderboardData?.leaderboard || [];

    const currentUserEntry = leaderboard.find((entry) => entry.user.id === user.id) || null;

    return {
      data: {
        point_group: buildPointGroupSummary(currentMembership.point_group),
        my_membership: {
          user_point_group_id: currentMembership.id,
          period_points: currentMembership.period_points ?? 0,
          position_in_group: currentUserEntry?.position ?? null,
          group_member_count: leaderboard.length,
        },
        leaderboard,
      },
      meta: {},
    };
  },

  async findLeaderboard(ctx) {
    const { user } = ctx.state;

    if (!user) {
      return ctx.unauthorized('Authentication required.');
    }

    const pointGroupId = Number(ctx.params.id);

    if (!Number.isInteger(pointGroupId) || pointGroupId <= 0) {
      return ctx.badRequest('point group id must be a positive integer.');
    }

    const requestedLocale = await resolveRequestedLocale(strapi, user.id, ctx.query?.locale);
    const leaderboardData = await this._buildLeaderboardData(pointGroupId, user.id, requestedLocale);

    if (!leaderboardData) {
      return buildEmptyRequestedPointGroupResponse();
    }

    const currentUserEntry = leaderboardData.leaderboard.find((entry) => entry.user.id === user.id) || null;

    return {
      data: {
        point_group: buildPointGroupSummary(leaderboardData.pointGroup),
        current_user_position: currentUserEntry?.position ?? null,
        group_member_count: leaderboardData.leaderboard.length,
        leaderboard: leaderboardData.leaderboard,
      },
      meta: {},
    };
  },
}));

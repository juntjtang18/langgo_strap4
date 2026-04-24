'use strict';

const { createCoreController } = require('@strapi/strapi').factories;
const { buildUserProfilePopulate } = require('../../../utils/user-profile');

const buildEmptyLatestUserPointResponse = (user) => ({
  data: {
    id: null,
    attributes: {
      record_date: null,
      points: 0,
      points_add: 0,
      word_count: 0,
      word_add: 0,
      article_count: 0,
      article_add: 0,
      group_rank_change: 0,
      rank: 0,
      rank_change: 0,
      rank_text: null,
      point_group: {
        data: null,
      },
      user: {
        data: {
          id: user.id,
          attributes: {
            username: user.username || null,
            email: user.email || null,
            honor_title: {
              data: null,
            },
          },
        },
      },
    },
  },
  meta: {},
});

const getLocaleCandidates = (locale) => {
  if (!locale || typeof locale !== 'string') {
    return [];
  }

  const trimmed = locale.trim();

  if (!trimmed) {
    return [];
  }

  const parts = trimmed.split('-').filter(Boolean);
  const candidates = [trimmed];

  if (parts.length > 1) {
    candidates.push(parts[0]);
  }

  return [...new Set(candidates)];
};

const pickLocalizedEntity = (entity, locale) => {
  if (!entity) return null;
  const localeCandidates = getLocaleCandidates(locale);

  if (!localeCandidates.length || localeCandidates.includes(entity.locale)) {
    return entity;
  }

  const localizedMatch = Array.isArray(entity.localizations)
    ? entity.localizations.find((item) => item && localeCandidates.includes(item.locale))
    : null;

  return localizedMatch || entity;
};

const getLocalizationFamilyKey = (entity) => {
  if (!entity) {
    return null;
  }

  const ids = [entity.id]
    .concat(Array.isArray(entity.localizations) ? entity.localizations.map((item) => item?.id) : [])
    .filter(Boolean);

  if (!ids.length) {
    return null;
  }

  return Math.min(...ids);
};

const resolveLocalizedHonorTitleByRank = async (strapi, rank, locale) => {
  if (!Number.isInteger(rank) || rank <= 0) {
    return null;
  }

  const titles = await strapi.entityService.findMany('api::honor-title.honor-title', {
    sort: ['id:asc'],
    limit: 200,
    locale: 'all',
    populate: {
      localizations: true,
    },
  });

  if (!titles.length) {
    return null;
  }

  const families = [];
  const seenFamilyKeys = new Set();

  titles.forEach((title) => {
    const familyKey = getLocalizationFamilyKey(title);

    if (!familyKey || seenFamilyKeys.has(familyKey)) {
      return;
    }

    seenFamilyKeys.add(familyKey);
    families.push(title);
  });

  const matchedFamily = families[rank - 1] || null;
  return pickLocalizedEntity(matchedFamily, locale);
};

const resolveRequestedLocale = async (strapi, ctx, userId) => {
  if (typeof ctx.query?.locale === 'string' && ctx.query.locale.trim()) {
    return ctx.query.locale.trim();
  }

  try {
    const userWithProfile = await strapi.entityService.findOne('plugin::users-permissions.user', userId, {
      populate: {
        user_profile: {
          fields: ['baseLanguage'],
          populate: buildUserProfilePopulate(strapi),
        },
      },
    });
    return userWithProfile?.user_profile?.baseLanguage || null;
  } catch (error) {
    strapi.log.warn(`Failed to resolve base language for user ${userId}: ${error.message}`);
    return null;
  }
};

module.exports = createCoreController('api::user-point.user-point', ({ strapi }) => ({
  async findLatest(ctx) {
    const { user } = ctx.state;

    if (!user) {
      return ctx.unauthorized('Authentication required.');
    }

    const requestedLocale = await resolveRequestedLocale(strapi, ctx, user.id);

    const userPoints = await strapi.entityService.findMany('api::user-point.user-point', {
      filters: {
        user: user.id,
      },
      sort: ['record_date:desc', 'id:desc'],
      limit: 1,
      populate: {
        user: {
          populate: {
            honor_title: {
              populate: {
                localizations: true,
              },
            },
          },
        },
        point_group: {
          populate: {
            group_rank: true,
          },
        },
      },
    });

    if (!userPoints[0]) {
      return buildEmptyLatestUserPointResponse(user);
    }

    const latestUserPoint = userPoints[0];
    const storedRank = Number.isInteger(latestUserPoint.rank) ? latestUserPoint.rank : 0;
    const displayRank = storedRank > 0 ? storedRank : 1;
    const localizedHonorTitleFromRelation = pickLocalizedEntity(
      latestUserPoint.user?.honor_title,
      requestedLocale
    );
    const localizedHonorTitle = localizedHonorTitleFromRelation
      || await resolveLocalizedHonorTitleByRank(strapi, displayRank, requestedLocale);
    const response = this.transformResponse(latestUserPoint);

    if (response?.data?.attributes) {
      response.data.attributes.rank = displayRank;
      response.data.attributes.rank_text = localizedHonorTitle?.title || null;

      const honorTitleData = response.data.attributes.user?.data?.attributes?.honor_title?.data;

      if (honorTitleData?.attributes && localizedHonorTitle) {
        honorTitleData.attributes.title = localizedHonorTitle.title;
      }
    }

    return response;
  },
}));

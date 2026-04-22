'use strict';

const getUserProfileModel = (strapi) => strapi.getModel('api::user-profile.user-profile');

const getUserProfileAttributes = (strapi) => getUserProfileModel(strapi)?.attributes || {};

const getProfileDataAttributeNames = (strapi) => {
  const attributes = getUserProfileAttributes(strapi);

  return Object.entries(attributes)
    .filter(([, attribute]) => !['relation', 'component', 'dynamiczone'].includes(attribute.type))
    .map(([name]) => name);
};

const buildUserProfilePopulate = (strapi) => {
  const attributes = getUserProfileAttributes(strapi);

  return Object.fromEntries(
    Object.entries(attributes)
      .filter(([, attribute]) => ['relation', 'media', 'component', 'dynamiczone'].includes(attribute.type))
      .map(([name]) => [name, true])
  );
};

const formatMediaRelation = (media) => {
  if (!media) {
    return null;
  }

  return {
    data: {
      id: media.id,
      attributes: {
        name: media.name,
        alternativeText: media.alternativeText,
        caption: media.caption,
        width: media.width,
        height: media.height,
        formats: media.formats,
        hash: media.hash,
        ext: media.ext,
        mime: media.mime,
        size: media.size,
        url: media.url,
        previewUrl: media.previewUrl,
        provider: media.provider,
        createdAt: media.createdAt,
        updatedAt: media.updatedAt,
      },
    },
  };
};

const formatUserProfile = (strapi, userProfile) => {
  if (!userProfile) {
    return null;
  }

  const attributes = getUserProfileAttributes(strapi);
  const formatted = { id: userProfile.id };

  for (const [name, attribute] of Object.entries(attributes)) {
    if (name === 'user') {
      continue;
    }

    if (attribute.type === 'media') {
      formatted[name] = formatMediaRelation(userProfile[name]);
      continue;
    }

    if (['relation', 'component', 'dynamiczone'].includes(attribute.type)) {
      formatted[name] = userProfile[name] ?? null;
      continue;
    }

    formatted[name] = userProfile[name];
  }

  return formatted;
};

const pickUserProfileData = (strapi, source = {}) => {
  const allowedNames = new Set(getProfileDataAttributeNames(strapi));
  const picked = {};

  for (const [key, value] of Object.entries(source)) {
    if (allowedNames.has(key)) {
      picked[key] = value;
    }
  }

  return picked;
};

module.exports = {
  buildUserProfilePopulate,
  formatUserProfile,
  pickUserProfileData,
};

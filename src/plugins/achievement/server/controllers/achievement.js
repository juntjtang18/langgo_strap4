'use strict';

async function getCurrentUserProfile(userId) {
  const profiles = await strapi.entityService.findMany('api::user-profile.user-profile', {
    filters: { user: userId },
    fields: ['id', 'baseLanguage'],
    limit: 1,
  });

  return profiles[0] || null;
}

function requireAuthenticatedUser(ctx) {
  if (!ctx.state.user) {
    ctx.unauthorized('You must be logged in to perform this action.');
    return null;
  }

  return ctx.state.user;
}

module.exports = {
  async listAchieved(ctx) {
    const user = requireAuthenticatedUser(ctx);
    if (!user) return;

    const profile = await getCurrentUserProfile(user.id);
    const locale = ctx.query?.locale || profile?.baseLanguage || 'en';
    await strapi.plugin('achievement').service('achievement').ensureUserAchievements(
      user.id,
      user.username || user.email || null
    );
    const rows = await strapi.plugin('achievement').service('achievement').listAchievedByUserid(user.id, locale);

    ctx.body = { data: rows };
  },

  async listNotAchieved(ctx) {
    const user = requireAuthenticatedUser(ctx);
    if (!user) return;

    const profile = await getCurrentUserProfile(user.id);
    const locale = ctx.query?.locale || profile?.baseLanguage || 'en';
    await strapi.plugin('achievement').service('achievement').ensureUserAchievements(
      user.id,
      user.username || user.email || null
    );
    const rows = await strapi.plugin('achievement').service('achievement').listNotAchievedByUserid(user.id, locale);

    ctx.body = { data: rows };
  },
};

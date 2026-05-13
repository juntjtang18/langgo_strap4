'use strict';

module.exports = ({ strapi }) => ({
  async applyEvent(event) {
    const userid = event.userid == null ? null : String(event.userid);
    const username = event.username || null;
    const eventName = event.event_name;

    if (!userid || !eventName) {
      return { updated: 0 };
    }

    await strapi.plugin('achievement').service('achievement').ensureUserAchievements(userid, username);

    const achievements = await strapi.entityService.findMany('plugin::achievement.as-achievement', {
      filters: { event_name: eventName },
      fields: ['id', 'code', 'event_name', 'points', 'goal'],
      limit: 1000,
      sort: [{ id: 'asc' }],
    });

    if (achievements.length === 0) {
      return { updated: 0 };
    }

    let updated = 0;

    for (const achievement of achievements) {
      const current = await strapi.plugin('achievement').service('achievement').getUserAchievement(userid, achievement.id);
      if (current?.achieved === true) {
        continue;
      }

      const nextProgress = (current?.progress || 0) + (achievement.points || 0);
      const achieved = nextProgress >= (achievement.goal || 0);

      await strapi.plugin('achievement').service('achievement').upsertUserAchievement(
        userid,
        username,
        achievement.id,
        {
          progress: nextProgress,
          achieved,
          achieved_at: achieved ? (current?.achieved_at || new Date().toISOString()) : null,
        }
      );

      updated += 1;
    }

    return { updated };
  },
});

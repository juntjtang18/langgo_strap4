'use strict';

const sortById = (rows) => rows.slice().sort((left, right) => (left.id || 0) - (right.id || 0));

module.exports = ({ strapi }) => {
  const findTranslation = (translations, locale) => {
    const exact = translations.find((row) => (row.locale || 'en') === locale);
    if (exact) return exact;
    const english = translations.find((row) => (row.locale || 'en') === 'en');
    return english || translations[0] || null;
  };

  const formatAchievement = (achievement, userAchievement, translation) => ({
    id: achievement.id,
    code: achievement.code,
    event_name: achievement.event_name,
    points: achievement.points || 0,
    goal: achievement.goal || 0,
    progress: userAchievement?.progress || 0,
    achieved: userAchievement?.achieved === true,
    achieved_at: userAchievement?.achieved_at || null,
    title: translation?.title || null,
    description: translation?.description || null,
  });

  return {
    async listAll(locale = 'en') {
      return strapi.entityService.findMany('plugin::achievement.as-achievement', {
        fields: ['id', 'code', 'event_name', 'points', 'goal'],
        populate: {
          translations: {
            fields: ['id', 'locale', 'title', 'description'],
          },
        },
        sort: [{ id: 'asc' }],
        limit: 1000,
      }).then((rows) => sortById(rows).map((row) => ({
        ...row,
        translation: findTranslation(row.translations || [], locale),
      })));
    },

    async listUserAchievements(userid) {
      return strapi.entityService.findMany('plugin::achievement.as-user-achievement', {
        filters: { userid: String(userid) },
        populate: {
          achievement: {
            fields: ['id', 'code', 'event_name', 'points', 'goal'],
          },
        },
        sort: [{ id: 'asc' }],
        limit: 1000,
      });
    },

    async ensureUserAchievements(userid, username = null) {
      const normalizedUserid = String(userid);
      const [achievements, userAchievements] = await Promise.all([
        this.listAll('en'),
        this.listUserAchievements(normalizedUserid),
      ]);

      if (achievements.length === 0) {
        return [];
      }

      const existingByAchievementId = new Map(
        userAchievements
          .filter((row) => row.achievement?.id)
          .map((row) => [row.achievement.id, row])
      );

      const createdRows = [];

      for (const achievement of achievements) {
        if (existingByAchievementId.has(achievement.id)) {
          continue;
        }

        const created = await strapi.entityService.create('plugin::achievement.as-user-achievement', {
          data: {
            userid: normalizedUserid,
            username: username || null,
            achievement: achievement.id,
            progress: 0,
            achieved: false,
            achieved_at: null,
          },
        });

        createdRows.push(created);
      }

      return createdRows;
    },

    async getUserAchievement(userid, achievementId) {
      const rows = await strapi.entityService.findMany('plugin::achievement.as-user-achievement', {
        filters: {
          userid: String(userid),
          achievement: { id: achievementId },
        },
        populate: {
          achievement: {
            fields: ['id', 'code', 'event_name', 'points', 'goal'],
          },
        },
        limit: 1,
      });

      return rows[0] || null;
    },

    async upsertUserAchievement(userid, username, achievementId, data) {
      const existing = await this.getUserAchievement(userid, achievementId);
      const payload = {
        userid: String(userid),
        username: username || existing?.username || null,
        achievement: achievementId,
        progress: data.progress || 0,
        achieved: data.achieved === true,
        achieved_at: data.achieved_at || null,
      };

      if (existing) {
        return strapi.entityService.update('plugin::achievement.as-user-achievement', existing.id, {
          data: payload,
        });
      }

      return strapi.entityService.create('plugin::achievement.as-user-achievement', {
        data: payload,
      });
    },

    async listAchievedByUserid(userid, locale = 'en') {
      const [achievements, userAchievements] = await Promise.all([
        this.listAll(locale),
        this.listUserAchievements(userid),
      ]);

      const userMap = new Map(
        userAchievements
          .filter((row) => row.achievement?.id)
          .map((row) => [row.achievement.id, row])
      );

      return achievements
        .map((achievement) => formatAchievement(
          achievement,
          userMap.get(achievement.id) || null,
          achievement.translation
        ))
        .filter((row) => row.achieved);
    },

    async listNotAchievedByUserid(userid, locale = 'en') {
      const [achievements, userAchievements] = await Promise.all([
        this.listAll(locale),
        this.listUserAchievements(userid),
      ]);

      const userMap = new Map(
        userAchievements
          .filter((row) => row.achievement?.id)
          .map((row) => [row.achievement.id, row])
      );

      return achievements
        .map((achievement) => formatAchievement(
          achievement,
          userMap.get(achievement.id) || null,
          achievement.translation
        ))
        .filter((row) => !row.achieved);
    },
  };
};

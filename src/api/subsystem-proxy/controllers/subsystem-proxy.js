'use strict';

const createSubsystemProxy = require('../../../services/subsystem-proxy');

const createProxy = () => createSubsystemProxy({ strapi });

module.exports = {
  async rankMe(ctx) {
    await createProxy().forward(ctx, 'rank', '/api/v1/rank/me');
  },

  async rankUser(ctx) {
    const userid = encodeURIComponent(ctx.params.userid);
    await createProxy().forward(ctx, 'rank', `/api/v1/rank/users/${userid}`);
  },

  async myLeaderboard(ctx) {
    await createProxy().forward(ctx, 'rank', '/api/v1/myleaderboard');
  },

  async achievementsAchieved(ctx) {
    await createProxy().forward(ctx, 'achievement', '/api/v1/achievements-achieved');
  },

  async achievementsNotAchieved(ctx) {
    await createProxy().forward(ctx, 'achievement', '/api/v1/achievements-not-achieved');
  },
};

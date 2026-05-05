'use strict';

module.exports = {
  type: 'content-api',
  routes: [
    {
      method: 'GET',
      path: '/achievements-achieved',
      handler: 'achievement.listAchieved',
      config: {
        prefix: '',
        policies: [],
        middlewares: [],
      },
    },
    {
      method: 'GET',
      path: '/achievements-not-achieved',
      handler: 'achievement.listNotAchieved',
      config: {
        prefix: '',
        policies: [],
        middlewares: [],
      },
    },
  ],
};

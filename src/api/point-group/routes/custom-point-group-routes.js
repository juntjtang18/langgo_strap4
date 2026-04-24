'use strict';

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/my-point-group',
      handler: 'point-group.findMine',
      config: {
        policies: [],
        middlewares: [],
      },
    },
    {
      method: 'GET',
      path: '/point-groups/:id/leaderboard',
      handler: 'point-group.findLeaderboard',
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};

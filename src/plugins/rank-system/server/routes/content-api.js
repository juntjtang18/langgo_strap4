'use strict';

module.exports = {
  type: 'content-api',
  routes: [
    {
      method: 'POST',
      path: '/rank/events',
      handler: 'rank.submitEvent',
      config: { auth: false, prefix: '' },
    },
    {
      method: 'GET',
      path: '/rank/me',
      handler: 'rank.getMeStatus',
      config: {
        prefix: '',
        policies: [],
        middlewares: [],
      },
    },
    {
      method: 'GET',
      path: '/myleaderboard',
      handler: 'rank.getMyLeaderboard',
      config: {
        prefix: '',
        policies: [],
        middlewares: [],
      },
    },
    {
      method: 'GET',
      path: '/rank/users/:userid',
      handler: 'rank.getUserStatus',
      config: { auth: false, prefix: '' },
    },
    {
      method: 'POST',
      path: '/rank-migration/run',
      handler: 'migration.run',
      config: { auth: false, prefix: '' },
    },
    {
      method: 'GET',
      path: '/rank-migration/status',
      handler: 'migration.status',
      config: { auth: false, prefix: '' },
    },
  ],
};

'use strict';

module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/rank/events',
      handler: 'rank.submitEvent',
      config: { auth: false },
    },
    {
      method: 'GET',
      path: '/rank/me',
      handler: 'rank.getMeStatus',
      config: {
        policies: [], // Add any policies if needed, e.g., ['global::is-authenticated']
        middlewares: [],
      },
    },
    {
      method: 'GET',
      path: '/myleaderboard',
      handler: 'rank.getMyLeaderboard',
      config: {
        policies: [],
        middlewares: [],
      },
    },
    {
      method: 'GET',
      path: '/rank/users/:userid',
      handler: 'rank.getUserStatus',
      config: { auth: false },
    },
  ],
};

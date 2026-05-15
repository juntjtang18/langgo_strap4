'use strict';

const authenticatedRouteConfig = {
  auth: {},
  policies: ['global::is-authenticated'],
  middlewares: [],
};

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/rank/me',
      handler: 'subsystem-proxy.rankMe',
      config: authenticatedRouteConfig,
    },
    {
      method: 'GET',
      path: '/rank/users/:userid',
      handler: 'subsystem-proxy.rankUser',
      config: authenticatedRouteConfig,
    },
    {
      method: 'GET',
      path: '/myleaderboard',
      handler: 'subsystem-proxy.myLeaderboard',
      config: authenticatedRouteConfig,
    },
    {
      method: 'GET',
      path: '/achievements-achieved',
      handler: 'subsystem-proxy.achievementsAchieved',
      config: authenticatedRouteConfig,
    },
    {
      method: 'GET',
      path: '/achievements-not-achieved',
      handler: 'subsystem-proxy.achievementsNotAchieved',
      config: authenticatedRouteConfig,
    },
  ],
};

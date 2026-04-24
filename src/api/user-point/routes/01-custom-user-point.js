'use strict';

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/my-user-points',
      handler: 'user-point.findLatest',
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};

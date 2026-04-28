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
      path: '/rank/users/:userid',
      handler: 'rank.getUserStatus',
      config: { auth: false },
    },
  ],
};

'use strict';

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/migratecount',
      handler: 'migratecount.index',
      config: {
        auth: false, // or true if you want to secure it
      },
    },
  ],
};

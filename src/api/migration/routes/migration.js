'use strict';
module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/migration/run', // This is the only endpoint you need to call
      handler: 'migration.run',
      config: { auth: false },
    },
  ],
};
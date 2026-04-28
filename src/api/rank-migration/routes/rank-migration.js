'use strict';

module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/rank-migration/run',
      handler: 'rank-migration.run',
      config: { auth: false },
    },
    {
      method: 'GET',
      path: '/rank-migration/status',
      handler: 'rank-migration.status',
      config: { auth: false },
    },
  ],
};

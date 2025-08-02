'use strict';

/**
 * ping router.
 */

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/ping',
      handler: 'ping.find',
      config: {
        auth: false, // Make this endpoint public
      },
    },
  ],
};
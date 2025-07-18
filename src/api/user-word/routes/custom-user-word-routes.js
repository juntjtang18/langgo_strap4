'use strict';

/**
 * user-word custom router.
 */

module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/user-word/copyToZh',
      handler: 'user-word.copyToZh',
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};
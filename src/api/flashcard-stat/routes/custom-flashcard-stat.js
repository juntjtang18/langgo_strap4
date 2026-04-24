'use strict';

module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/flashcard-stats/rebuild-all',
      handler: 'flashcard-stat.rebuildAll',
      config: {
        auth: false,
        policies: [],
        middlewares: [],
      },
    },
  ],
};

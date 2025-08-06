'use strict';

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/word-definitions/search',
      handler: 'word-definition.search',
      config: {
        // This route requires an authenticated user to check for their flashcards
        auth: {},
      },
    },
  ],
};
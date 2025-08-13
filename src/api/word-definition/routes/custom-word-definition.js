'use strict';

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/word-definitions/search',
      handler: 'word-definition.search',
      config: {
        auth: {},
      },
    },
    {
      // This is the new route for your performant search
      method: 'GET',
      path: '/word-definitions/search-by-target',
      handler: 'word-definition.searchByTarget',
      config: {
        auth: {},
      },
    },
  ],
};
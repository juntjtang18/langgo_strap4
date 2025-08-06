'use strict';

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/words/search',
      handler: 'word.search',
      config: {
        policies: [],
        auth: {}, // Make this public so it can be used in the "Add New Word" form
      },
    },
  ],
};
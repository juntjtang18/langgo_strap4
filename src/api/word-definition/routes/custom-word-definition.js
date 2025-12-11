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
    {
      // NEW: enqueue all word-definitions for exam_base/target regeneration
      method: 'POST',
      path: '/word-definitions/refine-exam-options',
      handler: 'word-definition.refineExamOptions',
      config: {
        auth: {}, // keep this protected; only authenticated users with proper permissions
      },
    },
  ],
};
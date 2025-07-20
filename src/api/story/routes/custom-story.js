'use strict';

/**
 * Custom story router.
 */

module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/stories/fetch-from-author',
      handler: 'story.getStories',
      config: {
        // You can add policies here to protect the endpoint if needed
        policies: [],
      },
    },
  ],
};
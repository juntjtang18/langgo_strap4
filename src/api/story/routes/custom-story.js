'use strict';

/**
 * Custom story router.
 */

module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/stories/fetch-from-openai-by-author',
      handler: 'story.fetchStoriesFromOpenAIByAuthor',
      config: {
        // You can add policies here to protect the endpoint if needed
        policies: [],
      },
    },
    {
        method: 'POST',
        path: '/stories/:id/generate-prompts',
        handler: 'story.generatePrompts',
        config: {
          // You might want to add policies here later to protect this endpoint
          policies: [],
        },
    },
    {
      method: 'POST',
      path: '/stories/:id/like',
      handler: 'story.like',
      config: {
        policies: ['global::is-authenticated'],
      },
    },
    {
      method: 'GET',
      path: '/stories/recommended',
      handler: 'story.findRecommended',
      config: {
        policies: [], // This can remain public
      },
    },    
  ],
};
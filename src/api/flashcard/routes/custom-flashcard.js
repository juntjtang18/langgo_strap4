'use strict';

/**
 * Custom flashcard router.
 */

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/review-flashcards', // The path for your custom endpoint
      handler: 'flashcard.findForReview', // Points to the custom controller action
      config: {
        policies: [], // You can add policies here, e.g., to ensure the user is authenticated
        middlewares: [],
      },
    },
  ],
};

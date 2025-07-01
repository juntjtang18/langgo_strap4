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
    {
      // --- NEW ROUTE ---
      method: 'POST',
      path: '/flashcards/:id/review', // Handles a review for a specific card
      handler: 'flashcard.review',     // Points to the new 'review' controller action
      config: {
        // IMPORTANT: Add policies to ensure only authenticated users can access this
        // e.g., policies: ['global::is-authenticated']
        policies: [],
      },
    },
  ],
};

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
    // --- ADD THIS NEW ROUTE DEFINITION ---
    {
      method: 'GET',
      path: '/flashcard-stat',                 // The new, non-conflicting path
      handler: 'flashcard.getStatistics',      // Points to the new controller action
      config: {
        policies: [], // Add authentication policies here
      },
    },
    {
      method: 'GET',
      path: '/flashcards/mine',
      handler: 'flashcard.findMine',
      config: {
        auth: {},      // must be an object to enforce JWT auth
        policies: [],  // you can add global::is-authenticated here if desired
        middlewares: [],
      },
    },
    {
      method: 'POST',
      path: '/flashcards/:id/validate',
      handler: 'flashcard.validate',
      config: {
        // It's highly recommended to protect this endpoint
        policies: ['global::is-authenticated'],
      },
    },
    {
      method: 'POST', // Use POST method for custom action
      path: '/flashcards/:id/remove', // Custom, descriptive path
      handler: 'flashcard.remove', // New controller action name
      config: {
        policies: [], // Add your authentication policy here
      },
    },

  ],
};

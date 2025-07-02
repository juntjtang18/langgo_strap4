
'use strict';

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/user-profiles/mine', // Endpoint to get the logged-in user's profile
      handler: 'user-profile.findMine',
      config: {
        policies: [], // Add any policies if needed, e.g., ['global::is-authenticated']
        middlewares: [],
      },
    },
    {
      method: 'PUT',
      path: '/user-profiles/mine', // Endpoint to update the logged-in user's profile
      handler: 'user-profile.updateMine',
      config: {
        policies: [],
        middlewares: [],
      },
    },
    {
        // This is the new route for our custom registration
        method: 'POST',
        path: '/user-profiles/register', // A cleaner, more consistent endpoint path
        handler: 'user-profile.registerWithProfile',
        config: {
          auth: false, // This makes the endpoint public so new users can access it
        },
      },
  
  ],
};

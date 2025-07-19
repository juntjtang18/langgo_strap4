'use strict';

/**
 * Custom router for the conversation feature.
 */

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/v1/conversation/start',
      handler: 'conversation.start',
      config: {
        auth: false,
      },
    },
    {
      method: 'POST',
      path: '/v1/conversation/nextprompt',
      handler: 'conversation.nextPrompt',
      config: {
        auth: false, // You might want to protect this with a policy later
      },
    },
  ],
};
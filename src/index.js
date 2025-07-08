// Path: src/index.js
'use strict';

module.exports = {
  register(/*{ strapi }*/) {},

  bootstrap({ strapi }) {
    const initWordProcessingQueueService = require('./services/word-processing-queue');

    // Initialize the service instance (it now returns an object with an addJob method)
    const wordProcessingQueueService = initWordProcessingQueueService({ strapi });

    // Explicitly add the service to Strapi's service container
    // This makes it accessible via strapi.service('word-processing-queue')
    strapi.container.get('services').set('word-processing-queue', wordProcessingQueueService);

    if (wordProcessingQueueService) {
      strapi.log.info('Word processing queue service initialized during bootstrap.');
      // No need to call .resume() for async.queue; it starts processing when jobs are pushed
      strapi.log.info('Word processing queue (in-process) is ready.');
    } else {
      strapi.log.error('Failed to initialize word-processing-queue service during bootstrap.');
    }
  },
};
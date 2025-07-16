// Path: src/index.js
'use strict';

module.exports = {
  register(/*{ strapi }*/) {},

  bootstrap({ strapi }) {
    // Initialize and register the word processing queue
    const initWordProcessingQueueService = require('./services/word-processing-queue');
    const wordProcessingQueueService = initWordProcessingQueueService({ strapi });
    strapi.container.get('services').set('word-processing-queue', wordProcessingQueueService);

    // Initialize and register the new OpenAI service
    const initOpenAIService = require('./services/openai');
    const openAIService = initOpenAIService({ strapi });
    strapi.container.get('services').set('openai', openAIService);

    // Initialize and register the new Tier service
    const initTierService = require('./services/tier-service');
    const tierService = initTierService({ strapi });
    strapi.container.get('services').set('tier-service', tierService);
    
    // Initialize and register the flashcard-validate service
    const initFlashcardValidateService = require('./services/flashcard-validate');
    const flashcardValidateService = initFlashcardValidateService({ strapi });
    strapi.container.get('services').set('flashcard-validate', flashcardValidateService);


    if (wordProcessingQueueService && openAIService && tierService && flashcardValidateService) {
      strapi.log.info('All custom services initialized successfully during bootstrap.');
      strapi.log.info('Word processing queue (in-process) is ready.');
    } else {
      strapi.log.error('Failed to initialize one or more custom services during bootstrap.');
    }
  },
};
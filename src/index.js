'use strict';
const { keepSubsysWarm } = require('./utils/cron-jobs');

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

    // Initialize and register the new Topic Generator service
    const initTopicGeneratorService = require('./services/topic-generator');
    const topicGeneratorService = initTopicGeneratorService({ strapi });
    strapi.container.get('services').set('topic-generator', topicGeneratorService);

    if (topicGeneratorService) {
      strapi.log.info('Custom topic-generator service initialized successfully.');
    } else {
      strapi.log.error('Failed to initialize topic-generator service.');
    }

    strapi.cron.add({
      '0 0 * * * *': async () => {
        try {
          strapi.log.info("🚀 Running topic generator job every 30 seconds...");
          //await strapi.service('topic-generator').generateProgressiveLesson();
          strapi.log.info("✅ Topic generation job completed successfully.");
        } catch (error) {
          strapi.log.error("❌ An error occurred during the topic generation job:", error);
        }
      },
    });
    // --- SUBSYS PING CRON JOB ---
    strapi.cron.add({
      '*/5 * * * *': async () => {
        await keepSubsysWarm(strapi);
      },
    });
  },
};
'use strict';
const { keepSubsysWarm } = require('./utils/cron-jobs');

module.exports = {
  register(/*{ strapi }*/) {},

  async bootstrap({ strapi }) {
    const disableBackgroundTasks =
      process.env.DISABLE_BACKGROUND_TASKS === 'true' ||
      process.env.NODE_ENV === 'test';

    // Crash safety logging
    process.on('unhandledRejection', (reason) => {
      strapi.log.error('🔴 Unhandled Promise Rejection:', reason);
    });
    process.on('uncaughtException', (error) => {
      strapi.log.error('🔴 Uncaught Exception:', error);
    });

    // Register word processing queue
    const initWordProcessingQueueService = require('./services/word-processing-queue');
    const wordProcessingQueueService = initWordProcessingQueueService({ strapi });
    strapi.container.get('services').set('word-processing-queue', wordProcessingQueueService);

    // Register OpenAI
    const initOpenAIService = require('./services/openai');
    const openAIService = initOpenAIService({ strapi });
    strapi.container.get('services').set('openai', openAIService);

    // Register tier service
    const initTierService = require('./services/tier-service');
    const tierService = initTierService({ strapi });
    strapi.container.get('services').set('tier-service', tierService);

    // Register Google Pub/Sub service
    const initPubSubService = require('./services/pubsub');
    const pubSubService = initPubSubService({ strapi });
    strapi.container.get('services').set('pubsub', pubSubService);

    // Register review event handler and queue facade
    const initReviewRewardService = require('./services/review-reward-service');
    const reviewRewardService = initReviewRewardService({ strapi });
    strapi.container.get('services').set('review-reward-service', reviewRewardService);

    const initPointService = require('./services/point-service');
    const pointService = initPointService({ strapi });
    strapi.container.get('services').set('point-service', pointService);

    const initReviewEventHandlerService = require('./services/review-event-handler');
    const reviewEventHandlerService = initReviewEventHandlerService({ strapi });
    strapi.container.get('services').set('review-event-handler', reviewEventHandlerService);

    const initEventHandlerService = require('./services/event-handler');
    const eventHandlerService = initEventHandlerService({ strapi });
    strapi.container.get('services').set('event-handler', eventHandlerService);

    const initReviewEventQueueService = require('./services/review-event-queue');
    const reviewEventQueueService = initReviewEventQueueService({ strapi });
    strapi.container.get('services').set('review-event-queue', reviewEventQueueService);

    const initEventApiService = require('./services/event-api');
    const eventApiService = initEventApiService({ strapi });
    strapi.container.get('services').set('event-api', eventApiService);

    // Register flashcard validation
    const initFlashcardValidateService = require('./services/flashcard-validate');
    const flashcardValidateService = initFlashcardValidateService({ strapi });
    strapi.container.get('services').set('flashcard-validate', flashcardValidateService);

    // Register account deletion service
    const initAccountDeletionService = require('./services/account-deletion');
    const accountDeletionService = initAccountDeletionService({ strapi });
    strapi.container.get('services').set('account-deletion', accountDeletionService);

    const initFlashcardStatBootstrapService = require('./services/flashcard-stat-bootstrap');
    const flashcardStatBootstrapService = initFlashcardStatBootstrapService({ strapi });
    strapi.container.get('services').set('flashcard-stat-bootstrap', flashcardStatBootstrapService);

    const initDbIndexEnsureService = require('./services/db-index-ensure');
    const dbIndexEnsureService = initDbIndexEnsureService({ strapi });
    strapi.container.get('services').set('db-index-ensure', dbIndexEnsureService);

    // Log service setup success
    if (
      wordProcessingQueueService &&
      openAIService &&
      tierService &&
      pubSubService &&
      reviewRewardService &&
      pointService &&
      reviewEventHandlerService &&
      eventHandlerService &&
      reviewEventQueueService &&
      eventApiService &&
      flashcardValidateService &&
      accountDeletionService &&
      flashcardStatBootstrapService &&
      dbIndexEnsureService
    ) {
      strapi.log.info('All custom services initialized successfully during bootstrap.');
      strapi.log.info('Word processing queue (in-process) is ready.');
    } else {
      strapi.log.error('Failed to initialize one or more custom services during bootstrap.');
    }

    if (pubSubService.isConfigured()) {
      strapi.log.info(`Google Pub/Sub service initialized for project ${pubSubService.getProjectId() || '(ADC inferred)'}.`);
    } else {
      strapi.log.warn('Google Pub/Sub service initialized without explicit project configuration.');
    }

    // Register topic generator
    const initTopicGeneratorService = require('./services/topic-generator');
    const topicGeneratorService = initTopicGeneratorService({ strapi });
    strapi.container.get('services').set('topic-generator', topicGeneratorService);

    if (topicGeneratorService) {
      strapi.log.info('Custom topic-generator service initialized successfully.');
    } else {
      strapi.log.error('Failed to initialize topic-generator service.');
    }

    try {
      await strapi.service('db-index-ensure').ensureIndexes();
    } catch (error) {
      strapi.log.error('Failed to ensure database indexes.', error);
    }

    strapi.server.routes([
      {
        method: 'DELETE',
        path: '/api/users/me',
        handler: async (ctx) => {
          await strapi.service('account-deletion').deleteMyAccount(ctx);
        },
        config: { auth: false },
      },
    ]);

    if (!disableBackgroundTasks) {
      // Cron: Generate topic every hour
      strapi.cron.add({
        '0 0 * * * *': async () => {
          try {
            strapi.log.info("🚀 Running topic generator job every 30 seconds...");
            // await strapi.service('topic-generator').generateProgressiveLesson();
            strapi.log.info("✅ Topic generation job completed successfully.");
          } catch (error) {
            strapi.log.error("❌ An error occurred during the topic generation job:", error);
          }
        },
      });

      // Cron: Keep subsystem warm every minute
      strapi.cron.add({
        '*/8 * * * *': async () => {
          try {
            await keepSubsysWarm(strapi);
          } catch (err) {
            strapi.log.error('❌ keepSubsysWarm cron job crashed unexpectedly:', err);
          }
        },
      });
    }
  },
  
};

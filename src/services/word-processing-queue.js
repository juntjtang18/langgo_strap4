// path: src/services/word-processing-queue.js
'use strict';
const async = require('async');

module.exports = ({ strapi }) => {
  // Define the worker function that will process jobs from the queue
  const processUserWordJob = async (job) => {
    const openAIService = strapi.service('openai');
    const { userWordId, incomingData, flashcardId, userId } = job;

    try {
      // Fetch user's base language from their profile
      const profiles = await strapi.entityService.findMany('api::user-profile.user-profile', {
        filters: { user: userId },
        fields: ['baseLanguage'],
      });
      const baseLocale = profiles[0]?.baseLanguage;
      const targetLocale = process.env.TARGET_LOCALE;

      if (!baseLocale || !targetLocale) {
        throw new Error(`Cannot process job for user_word ${userWordId}: baseLocale or targetLocale is missing.`);
      }

      const { target_text, base_text } = incomingData;

      // 1. Generate exam options
      const examBaseOptions = await openAIService.generateExamOptions(base_text, baseLocale, userWordId);
      const examTargetOptions = await openAIService.generateExamOptions(target_text, targetLocale, userWordId);
      strapi.log.info(`Background Job: Generated exam data for user_word ${userWordId}`);

      // 2. Update the user_word with exam data
      await strapi.entityService.update('api::user-word.user-word', userWordId, {
        data: {
          exam_base: examBaseOptions,
          exam_target: examTargetOptions,
        },
      });
      strapi.log.info(`Background Job: Updated user_word ${userWordId} with exam data.`);

      // 3. Fetch the flashcard
      const createdFlashcard = await strapi.entityService.findOne('api::flashcard.flashcard', flashcardId);
      if (!createdFlashcard) {
        throw new Error(`Flashcard with ID ${flashcardId} not found for job for user_word ${userWordId}.`);
      }
      strapi.log.info(`Background Job: Fetched flashcard ID ${createdFlashcard.id}`);

      // Job complete
      strapi.log.info(`Background Job: Job for user_word ${userWordId} completed successfully.`);
      return { status: 'success', userWordId };
    } catch (error) {
      strapi.log.error(`Background Job Error for user_word ID ${userWordId}:`, error);
      throw error;
    }
  };

  const backgroundQueue = async.queue(processUserWordJob, 2);

  backgroundQueue.error((err, job) => {
    strapi.log.error(
      `Error from background queue (job for user_word ${job.userWordId}):`,
      err.message
    );
  });

  return {
    addJob: (jobData) => {
      backgroundQueue.push(jobData, (err, result) => {
        if (err) {
          strapi.log.error(
            `Job for user_word ${jobData.userWordId} failed in queue (push callback):`,
            err.message
          );
        } else if (result) {
          strapi.log.info(
            `Job for user_word ${jobData.userWordId} completed in queue (push callback):`,
            result
          );
        }
      });
    },
  };
};
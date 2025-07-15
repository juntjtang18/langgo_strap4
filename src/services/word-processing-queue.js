// path: src/services/word-processing-queue.js
'use strict';
const async = require('async');

module.exports = ({ strapi }) => {
  // Define the worker function that will process jobs from the queue
  const processUserWordJob = async (job) => {
    // ✅ CORRECTION: Get the service inside the function, not at the top level.
    const openAIService = strapi.service('openai');
    const { userWordId, incomingData, flashcardId } = job;

    try {
      const { target_text, base_text, base_locale, target_locale } = incomingData;

      // 1. Generate exam options
      const examBaseOptions = await openAIService.generateExamOptions(base_text, base_locale, userWordId);
      const examTargetOptions = await openAIService.generateExamOptions(target_text, target_locale, userWordId);
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
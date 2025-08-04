// path: src/services/word-processing-queue.js
'use strict';
const async = require('async');

module.exports = ({ strapi }) => {
  /**
   * Defines the worker function that processes a job from the queue.
   * It fetches a word_definition, generates exam options and an example sentence,
   * and then updates the record.
   * @param {object} job - The job object from the queue.
   * @param {number} job.wordDefinitionId - The ID of the word_definition to process.
   * @param {number} job.flashcardId - The ID of the related flashcard to get user context.
   */
  const processWordDefinitionJob = async (job) => {
    const { wordDefinitionId, flashcardId } = job;
    const openAIService = strapi.service('openai');

    try {
      // 1. Fetch the flashcard to get the user context
      const flashcard = await strapi.entityService.findOne('api::flashcard.flashcard', flashcardId, {
        populate: { user: { populate: ['user_profile'] } },
      });

      if (!flashcard || !flashcard.user || !flashcard.user.user_profile) {
        throw new Error(`Cannot find user profile via flashcard ${flashcardId}.`);
      }
      const baseLocale = flashcard.user.user_profile.baseLanguage;
      const targetLocale = process.env.TARGET_LOCALE;

      if (!baseLocale || !targetLocale) {
        throw new Error(`Cannot process job for word_definition ${wordDefinitionId}: baseLocale or targetLocale is missing.`);
      }

      // 2. Fetch the word_definition and its related word
      const wordDefinition = await strapi.entityService.findOne('api::word-definition.word-definition', wordDefinitionId, {
        populate: ['word'],
      });

      if (!wordDefinition || !wordDefinition.word) {
        throw new Error(`Word Definition or its associated word not found for ID ${wordDefinitionId}.`);
      }

      const { base_text, example_sentence, exam_base, exam_target } = wordDefinition;
      const { target_text } = wordDefinition.word;
      const updateData = {};

      // 3. Generate exam options if they don't exist
      if (!exam_base && base_text) {
        updateData.exam_base = await openAIService.generateExamOptions(base_text, baseLocale, wordDefinitionId);
      }
      if (!exam_target && target_text) {
        updateData.exam_target = await openAIService.generateExamOptions(target_text, targetLocale, wordDefinitionId);
      }

      // 4. Generate an example sentence if it doesn't exist
      if (!example_sentence && target_text) {
        updateData.example_sentence = await openAIService.generateExampleSentence(target_text, targetLocale, wordDefinitionId, base_text);
      }

      // 5. Update the word_definition if there's new data
      if (Object.keys(updateData).length > 0) {
        await strapi.entityService.update('api::word-definition.word-definition', wordDefinitionId, {
          data: updateData,
        });
        strapi.log.info(`Background Job: Updated word_definition ${wordDefinitionId} with generated content.`);
      } else {
        strapi.log.info(`Background Job: No new content needed for word_definition ${wordDefinitionId}.`);
      }

      strapi.log.info(`Background Job: Job for word_definition ${wordDefinitionId} completed successfully.`);
      return { status: 'success', wordDefinitionId };
    } catch (error) {
      strapi.log.error(`Background Job Error for word_definition ID ${wordDefinitionId}:`, error);
      throw error; // Re-throw to let the queue handle the error
    }
  };

  // Initialize the async queue with the worker function
  const wordProcessingQueue = async.queue(processWordDefinitionJob, 2); // Process 2 jobs concurrently

  wordProcessingQueue.error((err, job) => {
    strapi.log.error(
      `Fatal error in queue for word_definition ${job.wordDefinitionId}:`,
      err.message
    );
  });

  return {
    /**
     * Adds a new job to the word processing queue.
     * @param {object} jobData - The data for the job.
     * @param {number} jobData.wordDefinitionId - The ID of the word_definition.
     * @param {number} jobData.flashcardId - The ID of the flashcard.
     */
    addJob: (jobData) => {
      strapi.log.info(`Adding job to word processing queue for word_definition: ${jobData.wordDefinitionId}`);
      wordProcessingQueue.push(jobData);
    },
  };
};
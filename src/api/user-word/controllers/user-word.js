// Path: src/api/user-word/controllers/user-word.js
'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::user-word.user-word', ({ strapi }) => ({
  async create(ctx) {
    const userId = ctx.state.user?.id;
    if (!userId) { return ctx.badRequest('Authenticated user not found.'); }

    const incomingData = ctx.request.body?.data || {};
    const { target_text, base_text, base_locale, target_locale } = incomingData;

    if (!base_text || !target_text || !base_locale || !target_locale) {
      return ctx.badRequest('Missing base_text, target_text, base_locale, or target_locale in request data.');
    }

    let createdUserWord;
    let createdFlashcard;

    try {
      createdUserWord = await strapi.entityService.create('api::user-word.user-word', {
        data: {
          ...incomingData,
          user: userId,
          exam_base: null,
          exam_target: null,
        },
        // populate: ['user'], // This line is removed
      });
      strapi.log.info(`User word created: ${createdUserWord.id}`);

      const flashcardData = {
        user: userId,
        content: [
          {
            __component: 'a.user-word-ref',
            user_word: createdUserWord.id,
          },
        ],
        last_reviewed_at: null,
        correct_streak: 0,
        wrong_streak: 0,
        is_remembered: false,
      };
      createdFlashcard = await strapi.entityService.create('api::flashcard.flashcard', {
        data: flashcardData,
      });
      strapi.log.info(`Flashcard created for new user_word ID: ${createdUserWord.id}, Flashcard ID: ${createdFlashcard.id}`);

    } catch (initialCreationError) {
      strapi.log.error(`Failed initial creation of user_word or flashcard:`, initialCreationError);
      return ctx.internalServerError('Failed initial word creation.', { details: initialCreationError.message });
    }

    if (createdUserWord && createdUserWord.id && createdFlashcard && createdFlashcard.id) {
        const wordProcessingQueueService = strapi.service('word-processing-queue'); // Access the service instance

        if (!wordProcessingQueueService || typeof wordProcessingQueueService.addJob !== 'function') {
            strapi.log.error('word-processing-queue service is not correctly loaded or does not have addJob method.');
            return ctx.internalServerError('Background processing service is unavailable or misconfigured.');
        }

        // --- KEY CHANGE HERE ---
        wordProcessingQueueService.addJob({ // Call the addJob method on the service
            userWordId: createdUserWord.id,
            flashcardId: createdFlashcard.id,
            userId: userId,
            incomingData: { base_text, target_text, base_locale, target_locale }
        });
        // --- END KEY CHANGE ---
        
        strapi.log.info(`Job enqueued for user_word ID ${createdUserWord.id}.`);
    } else {
        strapi.log.error('Failed to enqueue background job: Missing created user_word or flashcard ID.');
    }

    return {
      data: {
        id: createdUserWord.id,
        attributes: {
          target_text: createdUserWord.target_text,
          base_text: createdUserWord.base_text,
          part_of_speech: createdUserWord.part_of_speech,
          exam_base: null,
          exam_target: null,
          createdAt: createdUserWord.createdAt,
          updatedAt: createdUserWord.updatedAt,
          locale: createdUserWord.locale,
        }
      }
    };
  },
}));
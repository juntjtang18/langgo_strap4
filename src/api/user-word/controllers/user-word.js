// Path: src/api/user-word/controllers/user-word.js
'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::user-word.user-word', ({ strapi }) => ({
  async create(ctx) {
    const userId = ctx.state.user?.id;

    if (!userId) {
      return ctx.badRequest('Authenticated user not found.');
    }

    const incomingData = ctx.request.body?.data || {};

    let createdUserWord;
    try {
      // 1. Manually create the user_word entry with the user ID
      createdUserWord = await strapi.entityService.create('api::user-word.user-word', {
        data: {
          ...incomingData,
          user: userId, // Link to the authenticated user
        },
        populate: ['user'], // Populate if you need the user data in the response
      });
      strapi.log.info(`User word created: ${createdUserWord.id}`);

    } catch (userWordError) {
      strapi.log.error(`Failed to create user_word:`, userWordError);
      return ctx.internalServerError('Failed to create user word.', { details: userWordError.message });
    }

    // Ensure the user_word was successfully created before attempting flashcard creation
    if (createdUserWord && createdUserWord.id) {
      const userWordId = createdUserWord.id;

      // 2. Prepare data for the new flashcard
      const flashcardData = {
        user: userId, // Associate the flashcard with the same user
        content: [
          {
            __component: 'a.user-word-ref', // This must match your component identifier
            user_word: userWordId, // Link to the newly created user_word
          },
        ],
        last_reviewed_at: null,
        correct_streak: 0,
        wrong_streak: 0,
        is_remembered: false,
        // lesson: <optional: if you want to link to a lesson>
      };

      try {
        // 3. Create the flashcard entry
        await strapi.entityService.create('api::flashcard.flashcard', {
          data: flashcardData,
        });
        strapi.log.info(`Flashcard created for new user_word ID: ${userWordId}`);
        
        // Instead of returning the raw 'createdUserWord', format it to match the standard Strapi API response for a single entry
        return {
          data: {
            id: createdUserWord.id,
            attributes: {
              target_text: createdUserWord.target_text,
              base_text: createdUserWord.base_text,
              part_of_speech: createdUserWord.part_of_speech,
              createdAt: createdUserWord.createdAt,
              updatedAt: createdUserWord.updatedAt,
              locale: createdUserWord.locale,
              // Do NOT include 'user' here if you want to match the existing Swift struct
            }
          }
        };

      } catch (flashcardError) {
        strapi.log.error(`Failed to create flashcard for user_word ID ${userWordId}:`, flashcardError);

        // 4. Rollback: Attempt to delete the user_word if flashcard creation failed
        try {
          await strapi.entityService.delete('api::user-word.user-word', userWordId);
          strapi.log.info(`Successfully rolled back user_word ID: ${userWordId} due to flashcard creation failure.`);
        } catch (rollbackError) {
          strapi.log.error(`Failed to rollback user_word ID: ${userWordId} after flashcard creation failed:`, rollbackError);
          // This is a critical error: user_word exists but flashcard doesn't, AND rollback failed.
          // You might need an external monitoring/alerting system here.
        }

        // Return an error to the client, indicating the overall operation failed
        return ctx.internalServerError('Failed to create flashcard, user word rolled back.', { details: flashcardError.message });
      }
    }

    // This line should ideally not be reached if createdUserWord is null/undefined,
    // as the initial try-catch for user_word creation handles it.
    // However, as a fallback, we return an error if somehow we get here without a createdUserWord.
    return ctx.internalServerError('Unexpected error: User word not created or ID missing.');
  },
}));
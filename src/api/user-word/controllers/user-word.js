// Path: src/api/user-word/controllers/user-word.js
'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::user-word.user-word', ({ strapi }) => ({
  /**
   * Creates a new user_word entry, automatically assigning the correct
   * locale based on the authenticated user's profile.
   */
  async create(ctx) {
    const { user } = ctx.state;
    if (!user) {
      return ctx.unauthorized('Authenticated user not found.');
    }

    // 1. Get the user's baseLanguage from their profile using entityService
    // Note: We expect one profile per user.
    const profiles = await strapi.entityService.findMany('api::user-profile.user-profile', {
      filters: { user: user.id },
      fields: ['baseLanguage'],
    });

    if (!profiles || profiles.length === 0 || !profiles[0].baseLanguage) {
      return ctx.badRequest("User profile with a baseLanguage is required to create a word.");
    }
    const baseLocale = profiles[0].baseLanguage;

    // 2. Prepare the data for the new user_word
    const incomingData = ctx.request.body?.data || {};
    const { target_text, base_text } = incomingData; // a simplified example of required fields

    if (!base_text || !target_text) {
      return ctx.badRequest('Missing base_text or target_text in request data.');
    }

    let createdUserWord;
    let createdFlashcard;

    // 3. Create user_word and its flashcard
    try {
      // Create the user_word with the automatically determined locale
      createdUserWord = await strapi.entityService.create('api::user-word.user-word', {
        data: {
          ...incomingData,
          user: user.id,
          locale: baseLocale, // Set the locale from the user's profile
          exam_base: null,
          exam_target: null,
        },
      });
      strapi.log.info(`User word created: ${createdUserWord.id} with locale: ${baseLocale}`);

      // Create the associated flashcard
      const flashcardData = {
        user: user.id,
        content: [{
          __component: 'a.user-word-ref',
          user_word: createdUserWord.id,
        }, ],
        last_reviewed_at: null,
        correct_streak: 0,
        wrong_streak: 0,
        is_remembered: false,
        // The locale for the flashcard will also be set from the user's context
        locale: baseLocale,
      };
      createdFlashcard = await strapi.entityService.create('api::flashcard.flashcard', {
        data: flashcardData,
      });
      strapi.log.info(`Flashcard created for new user_word ID: ${createdUserWord.id}, Flashcard ID: ${createdFlashcard.id}`);

    } catch (initialCreationError) {
      strapi.log.error(`Failed initial creation of user_word or flashcard:`, initialCreationError);
      return ctx.internalServerError('Failed initial word creation.', {
        details: initialCreationError.message
      });
    }

    // 4. Enqueue background job for exam generation
    if (createdUserWord && createdUserWord.id && createdFlashcard && createdFlashcard.id) {
      const wordProcessingQueueService = strapi.service('word-processing-queue');
      const {
        target_locale
      } = incomingData; // Still needed for the background job

      wordProcessingQueueService.addJob({
        userWordId: createdUserWord.id,
        flashcardId: createdFlashcard.id,
        userId: user.id,
        incomingData: {
          base_text,
          target_text,
          base_locale: baseLocale, // Pass the correct base locale to the job
          target_locale
        }
      });
      strapi.log.info(`Job enqueued for user_word ID ${createdUserWord.id}.`);
    } else {
      strapi.log.error('Failed to enqueue background job: Missing created user_word or flashcard ID.');
    }

    // 5. Return the sanitized response
    // Using entityService.findOne to ensure all populated fields are correct
    const finalUserWord = await strapi.entityService.findOne('api::user-word.user-word', createdUserWord.id, {
        fields: ['target_text', 'base_text', 'part_of_speech', 'locale', 'createdAt', 'updatedAt'],
    });

    return this.transformResponse(finalUserWord);
  },

  /**
   * The copyToZh function remains unchanged as it has a very specific
   * batch-processing purpose that is separate from individual user actions.
   */
  async copyToZh(ctx) {
    // ... existing copyToZh code ...
    strapi.log.info('The /api/user-word/copyToZh endpoint was called.');

    try {
        const sourceWords = await strapi.entityService.findMany('api::user-word.user-word', {
            locale: 'all',
            filters: {
                $or: [
                    { locale: 'en' },
                    { locale: { $null: true } }
                ]
            },
            populate: { localizations: true },
        });

        strapi.log.info(`Found a total of ${sourceWords.length} source user_word entries to process.`);

        if (sourceWords.length === 0) {
            ctx.send({ message: "No 'en' or 'null' locale entries found to process." });
            return;
        }

        let createdCount = 0;
        let skippedCount = 0;

        for (const word of sourceWords) {
            const allRelatedWords = [word, ...word.localizations];
            const hasZhLocalization = allRelatedWords.some(w => w.locale === 'zh');

            if (hasZhLocalization) {
                skippedCount++;
            } else {
                // THE FIX: Explicitly include all required fields
                const newLocalizationData = {
                    // Localized fields
                    base_text: word.base_text,
                    part_of_speech: word.part_of_speech,
                    locale: 'zh',
                    
                    // Non-localized but REQUIRED fields
                    target_text: word.target_text,
                    target_locale: word.target_locale,

                    // Relational data
                    localizations: [word.id, ...word.localizations.map(l => l.id)],
                    user: word.user, // Important for ownership
                };

                await strapi.entityService.create('api::user-word.user-word', {
                    data: newLocalizationData,
                });
                createdCount++;
            }
        }

        ctx.send({
            message: `Processing complete. Created ${createdCount} new Chinese localizations. Skipped ${skippedCount} entries that already had a 'zh' version.`,
        });

    } catch (error) {
        // BETTER LOGGING: Print the detailed error message
        strapi.log.error('Error in copyToZh function:', error.details || error);
        ctx.internalServerError('An error occurred during the copy process.', error.details);
    }
  },
}));
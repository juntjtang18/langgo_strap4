// Path: src/api/user-word/controllers/user-word.js
'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::user-word.user-word', ({ strapi }) => ({
  /**
   * Creates a new user_word entry. The user's base language is automatically
   * fetched from their profile for use in background processing.
   */
  async create(ctx) {
    const { user } = ctx.state;
    if (!user) {
      return ctx.unauthorized('Authenticated user not found.');
    }

    // 1. Prepare the data for the new user_word
    const incomingData = ctx.request.body?.data || {};
    const { target_text, base_text } = incomingData;

    if (!base_text || !target_text) {
      return ctx.badRequest('Missing base_text or target_text in request data.');
    }

    let createdUserWord;
    let createdFlashcard;

    // 2. Create user_word and its flashcard
    try {
      createdUserWord = await strapi.entityService.create('api::user-word.user-word', {
        data: {
          ...incomingData,
          user: user.id,
          exam_base: null,
          exam_target: null,
        },
      });
      strapi.log.info(`User word created: ${createdUserWord.id}`);

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

    // 3. Enqueue background job for exam generation
    if (createdUserWord && createdUserWord.id && createdFlashcard && createdFlashcard.id) {
      const wordProcessingQueueService = strapi.service('word-processing-queue');
      wordProcessingQueueService.addJob({
        userWordId: createdUserWord.id,
        flashcardId: createdFlashcard.id,
        userId: user.id,
        incomingData: {
          base_text,
          target_text,
        }
      });
      strapi.log.info(`Job enqueued for user_word ID ${createdUserWord.id}.`);
    } else {
      strapi.log.error('Failed to enqueue background job: Missing created user_word or flashcard ID.');
    }

    // 4. Return the sanitized response
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
                const newLocalizationData = {
                    base_text: word.base_text,
                    part_of_speech: word.part_of_speech,
                    locale: 'zh',
                    target_text: word.target_text,
                    target_locale: word.target_locale,
                    localizations: [word.id, ...word.localizations.map(l => l.id)],
                    user: word.user,
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
        strapi.log.error('Error in copyToZh function:', error.details || error);
        ctx.internalServerError('An error occurred during the copy process.', error.details);
    }
  },
}));
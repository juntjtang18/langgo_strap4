// File: src/api/word-definition/controllers/word-definition.js
'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::word-definition.word-definition', ({ strapi }) => ({
  /**
   * Custom search action to find word definitions by base_text.
   * This allows searching for a word in one language (e.g., Chinese) and seeing all its
   * potential translations (e.g., in English).
   * @param {object} ctx - The Koa context object.
   */
  async search(ctx) {
    const { term } = ctx.query;
    const user = ctx.state.user;

    if (!user) {
      return ctx.unauthorized('Authentication is required to perform a search.');
    }

    if (!term) {
      return ctx.badRequest('A "term" query parameter is required.');
    }
    
    // 1. Get the user's base language from their profile
    const userWithProfile = await strapi.entityService.findOne(
        'plugin::users-permissions.user',
        user.id,
        { populate: { user_profile: true } }
    );
    const userLocale = userWithProfile?.user_profile?.baseLanguage;

    if (!userLocale) {
        return ctx.badRequest("User's base language is not set.");
    }

    try {
      const definitions = await strapi.entityService.findMany('api::word-definition.word-definition', {
        filters: {
          base_text: {
            $containsi: term, // Case-insensitive search on the base text
          },
          locale: userLocale,
        },
        limit: 10,
        populate: {
          word: true, // Populate the parent 'word' to get the target_text
          part_of_speech: true,
          flashcards: {
            filters: {
              user: user.id,
            },
            populate: {
              user: true,
            },
          },
        },
      });

      return this.transformResponse(definitions);
    } catch (error) {
      strapi.log.error('Error in custom word-definition search controller:', error);
      return ctx.internalServerError('An error occurred during the search.');
    }
  },
    /**
   * Creates or finds a word/definition and an associated flashcard for the user,
   * then enqueues a background job to populate the entry with AI-generated content.
   * Accepts an optional `example_sentence`.
   */
  async create(ctx) {
    const { user } = ctx.state;
    if (!user) {
      return ctx.unauthorized('Authenticated user not found.');
    }
    
    // 1. Get the user's base language
    const userWithProfile = await strapi.entityService.findOne(
        'plugin::users-permissions.user',
        user.id,
        { populate: { user_profile: true } }
    );
    const userLocale = userWithProfile?.user_profile?.baseLanguage;

    if (!userLocale) {
        return ctx.badRequest("User's base language is not set.");
    }

    const { target_text, base_text, part_of_speech, example_sentence } = ctx.request.body?.data || {};

    if (!target_text || !base_text) {
      return ctx.badRequest('Missing required fields: target_text and base_text.');
    }
    
    const trimmedTarget = target_text.trim();
    const trimmedBase = base_text.trim();

    try {
      let word = (await strapi.entityService.findMany('api::word.word', {
        filters: { target_text: trimmedTarget },
      }))[0];

      if (!word) {
        word = await strapi.entityService.create('api::word.word', {
          data: { target_text: trimmedTarget },
        });
      }

      const getPosId = async (posName) => {
        if (!posName) return null;
        const trimmedPosName = posName.trim().toLowerCase();
        let posEntry = (await strapi.entityService.findMany('api::part-of-speech.part-of-speech', {
          filters: { name: trimmedPosName },
        }))[0];
        if (!posEntry) {
          posEntry = await strapi.entityService.create('api::part-of-speech.part-of-speech', {
            data: { name: trimmedPosName, slug: trimmedPosName },
          });
        }
        return posEntry.id;
      };
      const posId = await getPosId(part_of_speech);

      let wordDefinition = (await strapi.entityService.findMany('api::word-definition.word-definition', {
        filters: {
          word: word.id,
          base_text: trimmedBase,
          part_of_speech: posId || null,
          locale: userLocale,
        },
        populate: { word: true, part_of_speech: true },
      }))[0];

      let flashcard;

      if (!wordDefinition) {
        await strapi.db.transaction(async ({ trx }) => {
          wordDefinition = await strapi.entityService.create('api::word-definition.word-definition', {
            data: {
              word: word.id,
              base_text: trimmedBase,
              part_of_speech: posId,
              example_sentence: example_sentence || null, // Save the example sentence
              locale: userLocale,
            },
            db: trx,
          });

          flashcard = await strapi.entityService.create('api::flashcard.flashcard', {
            data: { user: user.id, word_definition: wordDefinition.id },
            db: trx,
          });
        });
        
        wordDefinition = await strapi.entityService.findOne('api::word-definition.word-definition', wordDefinition.id, {
            populate: { word: true, part_of_speech: true },
        });

      } else {
        flashcard = (await strapi.entityService.findMany('api::flashcard.flashcard', {
          filters: { user: user.id, word_definition: wordDefinition.id },
        }))[0];

        if (!flashcard) {
          flashcard = await strapi.entityService.create('api::flashcard.flashcard', {
            data: { user: user.id, word_definition: wordDefinition.id },
          });
        }
      }
      
      const queueService = strapi.service('word-processing-queue');
      if (queueService) {
          queueService.addJob({
              wordDefinitionId: wordDefinition.id,
              flashcardId: flashcard.id,
          });
      } else {
          strapi.log.error("Could not find 'word-processing-queue' service.");
      }
      
      return this.transformResponse(wordDefinition);

    } catch (error) {
      strapi.log.error('Error in custom word-definition create controller:', error);
      return ctx.internalServerError('An error occurred while creating the word entry.');
    }
  },
}));
// File: src/api/word-definition/controllers/word-definition.js
'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::word-definition.word-definition', ({ strapi }) => ({
  /**
   * [Existing Function - Unchanged]
   * Custom search action to find word definitions by base_text.
   */
  async search(ctx) {
    const { term } = ctx.query;
    const { user } = ctx.state;

    if (!user) {
      return ctx.unauthorized('Authentication is required to perform a search.');
    }
    if (!term) {
      return ctx.badRequest('A "term" query parameter is required.');
    }
    
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
        locale: userLocale,
        filters: {
          base_text: {
            $containsi: term,
          },
        },
        limit: 10,
        populate: {
          word: true,
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
   * [Corrected Function]
   * Searches for word definitions by the word's target_text, filtered by the user's baseLanguage (i18n locale).
   */
  async searchByTarget(ctx) {
    const { term } = ctx.query;
    const { user } = ctx.state;

    if (!user) {
      return ctx.unauthorized('Authentication is required.');
    }
    if (!term) {
      return ctx.badRequest('A "term" query parameter is required.');
    }

    // Load user profile to get locale (baseLanguage)
    const userWithProfile = await strapi.entityService.findOne(
      'plugin::users-permissions.user',
      user.id,
      { populate: { user_profile: true } }
    );
    const userLocale = userWithProfile?.user_profile?.baseLanguage;

    if (!userLocale) {
      return ctx.badRequest("User's base language is not set.");
    }

    strapi.log.info(
      `searchByTarget: term="${term}", locale="${userLocale}", userId=${user.id}`
    );

    try {
      // IMPORTANT: put locale at the top level so Strapi i18n filters the entry itself
      const definitions = await strapi.entityService.findMany(
        'api::word-definition.word-definition',
        {
          locale: userLocale,
          filters: {
            word: {
              target_text: { $containsi: term },
            },
          },
          limit: 10,
          populate: {
            word: true,
            part_of_speech: true,
            flashcards: {
              filters: { user: user.id },
              populate: { user: true },
            },
          },
        }
      );

      return this.transformResponse(definitions);
    } catch (error) {
      strapi.log.error('Error in searchByTarget controller:', error);
      return ctx.internalServerError('An error occurred during the search.');
    }
  },


  async create(ctx) {
    const { user } = ctx.state;
    // Destructure the locale sent from the client
    const { 
        target_text, 
        base_text, 
        part_of_speech, 
        example_sentence,
        locale: clientLocale 
    } = ctx.request.body?.data || {};

    // 1. Validate User and Input
    if (!user) {
      return ctx.unauthorized('Authenticated user not found.');
    }
    if (!target_text || !base_text) {
      return ctx.badRequest('Missing required fields: target_text and base_text.');
    }

    try {
      // 2. Determine the Correct Locale to Use
      let finalLocale;
      if (clientLocale) {
        // Prioritize the locale sent directly from the client
        finalLocale = clientLocale;
        strapi.log.info(`Using locale from client payload: "${finalLocale}"`);
      } else {
        // As a fallback, fetch the user's profile to get their base language
        const userWithProfile = await strapi.entityService.findOne(
          'plugin::users-permissions.user',
          user.id,
          { populate: { user_profile: true } }
        );
        finalLocale = userWithProfile?.user_profile?.baseLanguage || 'en'; // Default to 'en' if all else fails
        strapi.log.info(`Using locale from user profile: "${finalLocale}"`);
      }

      // 3. Continue with your existing logic, but use 'finalLocale'
      const trimmedTarget = target_text.trim();
      const trimmedBase = base_text.trim();

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
          locale: finalLocale, // Use the corrected locale here
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
              example_sentence: example_sentence || null,
              locale: finalLocale, // Use the corrected locale here
              publishedAt: new Date(), // Publish immediately
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
// File: src/api/word-definition/controllers/word-definition.js
'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::word-definition.word-definition', ({ strapi }) => ({
  /**
   * Corrected Custom search action to find word definitions by base_text.
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
          $and: [
            {
              base_text: {
                $containsi: term,
              },
            },
            {
              $or: [
                { owner: user.id },
                { owner: { id: { $null: true } } } // Corrected syntax
              ],
            },
          ],
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
   * Corrected function to search for word definitions by the word's target_text.
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
      const definitions = await strapi.entityService.findMany(
        'api::word-definition.word-definition',
        {
          locale: userLocale,
          filters: {
            $and: [
              {
                word: {
                  target_text: { $containsi: term },
                },
              },
              {
                $or: [
                  { owner: user.id },
                  { owner: { id: { $null: true } } }, // Corrected syntax
                ],
              },
            ],
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

      // This is the section with the fix
      let wordDefinition = (await strapi.entityService.findMany('api::word-definition.word-definition', {
        filters: {
          word: word.id,
          base_text: trimmedBase,
          part_of_speech: posId || null,
          locale: finalLocale,
          $or: [
            { owner: user.id },
            { owner: { id: { $null: true } } }, // Corrected syntax
          ],
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
              owner: user.id, // Set the owner
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

    /**
   * Maintenance endpoint:
   * Enqueue ALL relevant word-definitions into the background queue
   * to regenerate exam_base and exam_target.
   *
   * POST /api/word-definitions/refine-exam-options
   *
   * Optional query params:
   *   - locales=en,zh-CN (comma-separated) to restrict which locales to include.
   */
  async refineExamOptions(ctx) {
    const { user } = ctx.state;
    if (!user) {
      return ctx.unauthorized('Authentication is required.');
    }

    const locale = ctx.query.locale;
    if (!locale) {
      return ctx.badRequest('Missing required query parameter: locale');
    }

    const batchSize = Number(ctx.query.batchSize) > 0
      ? Number(ctx.query.batchSize)
      : 200;

    const queueService = strapi.service('word-processing-queue');
    const openAIService = strapi.service('openai');

    if (!queueService) {
      strapi.log.error("RefineExamOptions: 'word-processing-queue' service not found.");
      return ctx.internalServerError('Queue service not available.');
    }
    if (!openAIService) {
      strapi.log.error("RefineExamOptions: 'openai' service not found.");
      return ctx.internalServerError('OpenAI service not available.');
    }

    let start = 0;
    let totalQueued = 0;
    let totalSkipped = 0;

    strapi.log.info(
      `RefineExamOptions: scanning word_definitions for locale "${locale}". batchSize=${batchSize}`
    );

    while (true) {
      const wordDefinitions = await strapi.entityService.findMany(
        'api::word-definition.word-definition',
        {
          limit: batchSize,
          start,
          locale, // i18n locale filter (top-level)
          populate: {
            word: true,
            flashcards: true,
          },
        }
      );

      if (!wordDefinitions || wordDefinitions.length === 0) {
        break;
      }

      for (const wd of wordDefinitions) {
        const wordDefinitionId = wd.id;
        const flashcards = wd.flashcards || [];
        const flashcard = flashcards[0];

        if (!flashcard) {
          totalSkipped += 1;
          strapi.log.warn(
            `RefineExamOptions: word_definition ${wordDefinitionId} has no flashcards. Skipping.`
          );
          continue;
        }

        const base_text = wd.base_text;
        const exam_base = wd.exam_base;
        const target_text = wd.word?.target_text;
        const exam_target = wd.exam_target;

        let needsRefine = false;

        if (base_text) {
          const baseOk = openAIService.isExamOptionsValid(base_text, exam_base, {
            field: 'exam_base',
            wordDefinitionId,
            locale,
          });
          if (!baseOk) needsRefine = true;
        }

        if (target_text) {
          const targetOk = openAIService.isExamOptionsValid(target_text, exam_target, {
            field: 'exam_target',
            wordDefinitionId,
            locale,
          });
          if (!targetOk) needsRefine = true;
        }

        if (!needsRefine) {
          totalSkipped += 1;
          continue;
        }

        // Only enqueue those that failed validation
        queueService.addJob({
          wordDefinitionId,
          flashcardId: flashcard.id,
        });

        totalQueued += 1;
      }

      start += wordDefinitions.length;
      if (wordDefinitions.length < batchSize) {
        break;
      }
    }

    strapi.log.info(
      `RefineExamOptions: finished scan for locale "${locale}". queued=${totalQueued}, skipped=${totalSkipped}.`
    );

    ctx.body = {
      message:
        'Scanned word_definitions and enqueued invalid exam options for background refinement.',
      queued: totalQueued,
      skipped: totalSkipped,
      locale,
    };
  },

}));

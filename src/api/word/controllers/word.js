'use strict';

/**
 * word controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::word.word', ({ strapi }) => ({
  /**
   * Custom search action to find words by target_text, and populate their definitions and flashcards.
   * This version uses a more robust two-step fetch to avoid deep filtering issues.
   * @param {object} ctx - The Koa context object.
   */
  async search(ctx) {
    const { term } = ctx.query;
    const user = ctx.state.user; // Get the authenticated user

    if (user) {
      strapi.log.info(`Searching for words for user ID: ${user.id}`);
    } else {
      strapi.log.warn('Word search executed by an unauthenticated user.');
    }

    if (!term) {
      return ctx.badRequest('A "term" query parameter is required.');
    }

    try {
      // Step 1: Find the words and their definitions
      const words = await strapi.entityService.findMany('api::word.word', {
        filters: {
          target_text: {
            $containsi: term,
          },
        },
        limit: 10,
        populate: {
          word_definitions: {
            populate: {
              part_of_speech: true,
            },
          },
        },
      });

      if (!user) {
        words.forEach(word => {
          if (word.word_definitions) {
            word.word_definitions.forEach(def => {
              def.flashcards = []; // Ensure consistent response structure
            });
          }
        });
        return this.transformResponse(words);
      }
      
      const definitionIds = words.flatMap(word => (word.word_definitions || []).map(def => def.id));

      let flashcardMap = new Map();

      if (definitionIds.length > 0) {
        const userFlashcards = await strapi.entityService.findMany('api::flashcard.flashcard', {
          filters: {
            user: user.id,
            word_definition: { id: { $in: definitionIds } },
          },
          populate: { user: true, word_definition: true },
        });

        userFlashcards.forEach(fc => {
          const defId = fc.word_definition.id;
          if (!flashcardMap.has(defId)) {
            flashcardMap.set(defId, []);
          }
          flashcardMap.get(defId).push(fc);
        });
      }

      // Step 4: Attach the flashcards to the correct definitions (THE FIX IS HERE)
      words.forEach(word => {
        if (word.word_definitions) {
          word.word_definitions.forEach(def => {
            // Assign the raw array. The sanitizer will create the { data: [...] } wrapper.
            def.flashcards = flashcardMap.get(def.id) || [];
          });
        }
      });

      return this.transformResponse(words);
    } catch (error) {
      strapi.log.error('Error in custom word search controller:', error);
      return ctx.internalServerError('An error occurred during the search.');
    }
  },
}));
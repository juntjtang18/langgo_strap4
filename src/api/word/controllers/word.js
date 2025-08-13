'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::word.word', ({ strapi }) => ({
  /**
   * Searches for words by their target_text.
   * This definitive implementation uses a robust two-step query to ensure
   * that all word definitions are correctly filtered by the authenticated user's
   * specific locale, which is fetched from their user profile.
   */
  async search(ctx) {
    const { term } = ctx.query;
    const { user } = ctx.state;

    // 1. Validate the incoming request
    if (!user) {
      return ctx.unauthorized('Authentication is required for this action.');
    }
    if (!term) {
      return ctx.badRequest('A "term" query parameter is required.');
    }

    try {
      // 2. Reliably get the user's true language preference from their profile.
      // This step is critical and addresses the core issue we identified.
      const userWithProfile = await strapi.entityService.findOne(
        'plugin::users-permissions.user',
        user.id,
        { populate: { user_profile: true } }
      );

      const userLocale = userWithProfile?.user_profile?.baseLanguage;

      if (!userLocale) {
        strapi.log.warn(`User ${user.id} has no baseLanguage set in their profile.`);
        return ctx.badRequest("User profile is missing the 'baseLanguage' setting.");
      }

      strapi.log.info(`Executing word search for term: "${term}", with user's actual locale: "${userLocale}"`);

      // 3. Step One of the Query: Find all parent words that match the search term.
      // We do not populate any relations here to keep the query clean and fast.
      const words = await strapi.entityService.findMany('api::word.word', {
        filters: {
          target_text: {
            $containsi: term,
          },
        },
      });

      if (!words.length) {
        strapi.log.info('No words found matching the term. Returning empty response.');
        return this.transformResponse([]);
      }

      const wordIds = words.map(w => w.id);

      // 4. Step Two of the Query: Fetch only the word definitions that match BOTH the word IDs AND the user's specific locale.
      // This is the most important filtering step.
      const definitions = await strapi.entityService.findMany('api::word-definition.word-definition', {
        locale: userLocale, // The key to correct filtering
        filters: {
          word: {
            id: { $in: wordIds },
          },
        },
        populate: {
          word: true,
          part_of_speech: true,
          flashcards: { // Pre-filter flashcards for the current user at the database level
            filters: { user: user.id }
          },
        },
      });
      
      strapi.log.info(`Found ${definitions.length} definitions with locale "${userLocale}" for the matched words.`);

      // 5. Manually assemble the final, correctly-structured response.
      // This prevents any potential issues with Strapi's automatic data handling.
      const definitionsByWordId = definitions.reduce((acc, def) => {
        const parentWordId = def.word.id;
        if (!acc[parentWordId]) {
          acc[parentWordId] = [];
        }
        acc[parentWordId].push(def);
        return acc;
      }, {});
      
      // Attach the correctly-filtered definitions to each word.
      words.forEach(word => {
        word.word_definitions = definitionsByWordId[word.id] || [];
      });

      // 6. Filter out any words that have no definitions in the user's locale.
      const finalWords = words.filter(word => word.word_definitions.length > 0);

      return this.transformResponse(finalWords);

    } catch (error) {
      strapi.log.error('A critical error occurred in the custom word search controller:', error);
      return ctx.internalServerError('An error occurred during the search. Please try again later.');
    }
  },
}));
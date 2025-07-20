'use strict';

/**
 * story controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::story.story', ({ strapi }) => ({
  /**
   * Fetches stories from OpenAI for a given author and saves them.
   * If a 'limit' is provided, it will fetch and create that number of *new* stories,
   * skipping any that already exist in the database.
   *
   * @param {object} ctx - The Koa context object.
   */
  async getStories(ctx) {
    const { author, limit } = ctx.request.body;

    if (!author) {
      return ctx.badRequest('The "author" field is required in the request body.');
    }

    try {
      const openaiService = strapi.service('openai');

      strapi.log.info(`Fetching all story titles for author: ${author}`);
      const allTitles = await openaiService.getStoryTitles(author);

      if (!allTitles || allTitles.length === 0) {
        return ctx.notFound(`No story titles were found for the author: ${author}`);
      }

      strapi.log.info(`Found ${allTitles.length} total titles. Now processing...`);

      let createdCount = 0;
      let skippedCount = 0;
      let titlesChecked = 0;

      // Iterate through the full list of titles.
      for (const title of allTitles) {
        // If a limit is set and we have successfully created the required number of stories, stop.
        if (limit && createdCount >= parseInt(limit, 10)) {
          strapi.log.info(`Limit of ${limit} new stories reached. Stopping process.`);
          break;
        }
        
        titlesChecked++;

        // Check if the story already exists in the database.
        const existingStory = await strapi.db.query('api::story.story').findOne({
          where: { title, author },
        });

        if (existingStory) {
          skippedCount++;
          strapi.log.info(`Skipping duplicate story: "${title}"`);
          continue; // Skip to the next title without fetching text.
        }

        // If the story is new, fetch its text.
        strapi.log.info(`Fetching text for new story #${createdCount + 1}: "${title}"`);
        const storyText = await openaiService.getStoryText(title, author);

        if (storyText) {
          const wordCount = storyText.split(/\s+/).length;

          await strapi.entityService.create('api::story.story', {
            data: {
              title,
              author,
              text: storyText,
              word_count: wordCount,
              publishedAt: new Date(),
            },
          });
          // IMPORTANT: Only increment the created count after a successful creation.
          createdCount++;
          strapi.log.info(`Successfully created story #${createdCount}: "${title}"`);
        } else {
          strapi.log.warn(`Could not retrieve text for "${title}". It will be skipped.`);
        }
      }

      return ctx.send({
        message: `Processing complete for ${author}.`,
        new_stories_created: createdCount,
        duplicates_skipped: skippedCount,
        titles_checked: titlesChecked,
      });

    } catch (error) {
      strapi.log.error('An error occurred in the getStories controller:', error);
      return ctx.internalServerError('An unexpected error occurred while fetching stories.');
    }
  },
}));
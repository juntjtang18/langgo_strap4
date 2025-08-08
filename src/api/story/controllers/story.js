'use strict';

/**
 * story controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::story.story', ({ strapi }) => ({
  /**********************************************************************
   * Intelligently generates all missing AI prompts for a given story.
   *
   * @param {object} ctx - The Koa context object.
   **********************************************************************/
  async generatePrompts(ctx) {
    const { id } = ctx.params;

    let story = await strapi.entityService.findOne('api::story.story', id, {
      populate: { generation_prompts: { populate: 'illustration_prompts' } },
    });

    if (!story) {
      return ctx.notFound(`Story with ID ${id} not found.`);
    }

    const openaiService = strapi.service('openai');

    if (!story.brief) {
      if (!story.text) {
        return ctx.badRequest('The story must have text to generate a brief and prompts.');
      }
      const newBrief = await openaiService.generateStoryBrief(story.text);
      if (newBrief) {
        story = await strapi.entityService.update('api::story.story', id, {
          data: { brief: newBrief },
          populate: { generation_prompts: { populate: 'illustration_prompts' } },
        });
      }
    }
    
    const existingPrompts = story.generation_prompts || {};
    const generationPromises = {};

    // Check for Cover Image Prompt
    if (!existingPrompts.cover_image_prompt) {
      generationPromises.cover_image_prompt = openaiService.generateCoverImagePrompt(story.title, story.author, story.brief);
    }

    // Check for Brief Video Prompt
    if (!existingPrompts.brief_video_prompt) {
      generationPromises.brief_video_prompt = openaiService.generateBriefVideoPrompt(story.title, story.brief);
    }
    
    // Final Check: Generate illustration prompts only if there are fewer than 3.
    const hasEnoughIllustrations = existingPrompts.illustration_prompts && existingPrompts.illustration_prompts.length >= 3;
    if (!hasEnoughIllustrations) {
      if (!story.text) {
        return ctx.badRequest('The story must have text to generate illustration prompts.');
      }
      generationPromises.illustration_prompts = openaiService.generateIllustrationPrompts(story.title, story.text);
    } else {
        strapi.log.info('Sufficient illustration prompts already exist. Skipping.');
    }

    const promiseKeys = Object.keys(generationPromises);
    if (promiseKeys.length === 0) {
      strapi.log.info(`All prompts already exist for story ID ${id}. No action taken.`);
      return ctx.send({ message: "All prompts already exist or are sufficient. No action taken.", data: story });
    }
    
    const results = await Promise.all(Object.values(generationPromises));
    
    const newPrompts = {};
    promiseKeys.forEach((key, index) => {
      newPrompts[key] = results[index];
    });

    // Format the array of illustration prompt strings into the required component structure
    let illustrationPromptsForUpdate = existingPrompts.illustration_prompts || [];
    if (newPrompts.illustration_prompts) {
      // This ensures we replace the old (insufficient) prompts with the new full set
      illustrationPromptsForUpdate = newPrompts.illustration_prompts.map(p => ({ prompt: p }));
    }

    const finalPromptData = {
      ...existingPrompts,
      cover_image_prompt: newPrompts.cover_image_prompt || existingPrompts.cover_image_prompt,
      brief_video_prompt: newPrompts.brief_video_prompt || existingPrompts.brief_video_prompt,
      illustration_prompts: illustrationPromptsForUpdate,
    };

    const updatedStory = await strapi.entityService.update('api::story.story', story.id, {
      data: {
        generation_prompts: finalPromptData,
      },
      populate: { generation_prompts: { populate: 'illustration_prompts' } }
    });
    
    strapi.log.info(`Successfully generated ${promiseKeys.length} new prompt set(s) for story ID ${id}.`);
    return this.transformResponse(updatedStory);
  },
  /**********************************************************************
   * Regenerates all AI prompts for a given story, optionally using a specified style.
   * @param {object} ctx - The Koa context object.
   **********************************************************************/
  async regeneratePromptsWithStyle(ctx) {
    const { id } = ctx.params;
    const { style = 'bright' } = ctx.request.body;
  
    let story = await strapi.entityService.findOne('api::story.story', id, {
      populate: { generation_prompts: { populate: 'illustration_prompts' } },
    });
  
    if (!story) {
      return ctx.notFound(`Story with ID ${id} not found.`);
    }
  
    if (!story.text) {
      return ctx.badRequest('The story must have text to regenerate prompts.');
    }
  
    const openaiService = strapi.service('openai');
  
    // Ensure the brief exists or generate it
    let updatedBrief = story.brief;
    if (!updatedBrief) {
      updatedBrief = await openaiService.generateStoryBrief(story.text);
      if (updatedBrief) {
        story = await strapi.entityService.update('api::story.story', id, {
          data: { brief: updatedBrief },
          populate: { generation_prompts: { populate: 'illustration_prompts' } },
        });
      }
    }
  
    // Regenerate everything (unconditionally)
    const [coverPrompt, videoPrompt, illustrationPrompts] = await Promise.all([
      openaiService.generateCoverImagePrompt(story.title, story.author, updatedBrief || story.brief, style),
      openaiService.generateBriefVideoPrompt(story.title, updatedBrief || story.brief),
      openaiService.generateIllustrationPrompts(story.title, story.text),
    ]);
  
    const finalPromptData = {
      cover_image_prompt: coverPrompt,
      brief_video_prompt: videoPrompt,
      illustration_prompts: (illustrationPrompts || []).map(p => ({ prompt: p })),
    };
  
    const updatedStory = await strapi.entityService.update('api::story.story', story.id, {
      data: {
        generation_prompts: finalPromptData,
      },
      populate: { generation_prompts: { populate: 'illustration_prompts' } }
    });
  
    strapi.log.info(`Regenerated prompts for story ID ${id} with style "${style}"`);
    return this.transformResponse(updatedStory);
  },
  
    /*******************************************************************************
   * Fetches stories, generates a brief, analyzes difficulty, and saves them.
   *
   * @param {object} ctx - The Koa context object.
   *********************************************************************************/
  async fetchStoriesFromOpenAIByAuthor(ctx) {
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

      for (const title of allTitles) {
        if (limit && createdCount >= parseInt(limit, 10)) {
          strapi.log.info(`Limit of ${limit} new stories reached. Stopping process.`);
          break;
        }
        
        titlesChecked++;

        const existingStory = await strapi.db.query('api::story.story').findOne({
          where: { title, author },
        });

        if (existingStory) {
          skippedCount++;
          strapi.log.info(`Skipping duplicate story: "${title}"`);
          continue;
        }

        strapi.log.info(`Fetching text for new story #${createdCount + 1}: "${title}"`);
        const storyText = await openaiService.getStoryText(title, author);

        if (storyText) {
          // New Steps: Analyze text for brief and difficulty
          const [brief, difficultyCode] = await Promise.all([
            openaiService.generateStoryBrief(storyText),
            openaiService.getStoryDifficulty(storyText),
          ]);

          let difficultyLevelEntity = null;
          if (difficultyCode) {
            strapi.log.info(`Story "${title}" analyzed with difficulty: ${difficultyCode}`);
            difficultyLevelEntity = await strapi.db.query('api::difficulty-level.difficulty-level').findOne({
              where: { code: difficultyCode },
            });
             if (!difficultyLevelEntity) {
               strapi.log.warn(`Could not find a difficulty_level with code "${difficultyCode}".`);
             }
          } else {
            strapi.log.warn(`Could not determine difficulty for "${title}".`);
          }

          const wordCount = storyText.split(/\s+/).length;

          await strapi.entityService.create('api::story.story', {
            data: {
              title,
              author,
              text: storyText,
              brief: brief || '', // Add the generated brief
              word_count: wordCount,
              difficulty_level: difficultyLevelEntity ? difficultyLevelEntity.id : null,
              publishedAt: new Date(),
            },
          });

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

  /********************************************************************************************************
   * Handles "liking" or "unliking" a story.
   * Ensures a user can only like a story once and returns a concise response.
   *********************************************************************************************************/
  async like(ctx) {
    const { user } = ctx.state;
    const { id } = ctx.params;

    // 1. Fetch only the fields you need from the story
    const story = await strapi.entityService.findOne('api::story.story', id, {
      fields: ['id', 'like_count'],
    });

    if (!story) {
      return ctx.notFound('Story not found.');
    }

    const existingLike = await strapi.db.query('api::story-like.story-like').findOne({
      where: {
        user: user.id,
        story: id,
      },
    });

    let newLikeCount;
    let message;

    if (existingLike) {
      // --- UNLIKE LOGIC ---
      await strapi.entityService.delete('api::story-like.story-like', existingLike.id);
      newLikeCount = Math.max(0, (story.like_count || 1) - 1);
      message = 'Story unliked successfully.';
    } else {
      // --- LIKE LOGIC ---
      await strapi.entityService.create('api::story-like.story-like', {
        data: { user: user.id, story: id },
      });
      newLikeCount = (story.like_count || 0) + 1;
      message = 'Story liked successfully.';
    }

    // Update the story's like count
    await strapi.entityService.update('api::story.story', id, {
      data: { like_count: newLikeCount },
    });

    // 2. Return a custom, minimal response instead of the full story object
    return ctx.send({
      message,
      data: {
        id: story.id,
        like_count: newLikeCount,
      },
    });
  },

  /**
   * Fetches stories sorted by popularity, including the full text and populated relations.
   */
  async findRecommended(ctx) {
    // Parse query parameters for pagination
    const page = parseInt(ctx.query.pagination?.page || '1', 10);
    const pageSize = parseInt(ctx.query.pagination?.pageSize || '10', 10);
  
    // Use findPage for proper pagination
    const { results, pagination } = await strapi.entityService.findPage('api::story.story', {
      populate: {
        difficulty_level: true,
        illustrations: {
          populate: '*',
        },
      },
      sort: { like_count: 'desc' },
      page,
      pageSize,
    });
  
    // Return the full story objects with pagination metadata
    return this.transformResponse(results, { pagination });
  },
  async backfillMissingFields(ctx) {
    const { id } = ctx.params;
  
    let story = await strapi.entityService.findOne('api::story.story', id, {
      populate: { generation_prompts: { populate: 'illustration_prompts' } },
    });
  
    if (!story) {
      return ctx.notFound(`Story with ID ${id} not found.`);
    }
  
    if (!story.text) {
      return ctx.badRequest('Story must have text to backfill fields.');
    }
  
    const openaiService = strapi.service('openai');
  
    const updates = {};
  
    // Brief
    if (!story.brief) {
      updates.brief = await openaiService.generateStoryBrief(story.text);
    }
  
    // Word Count
    if (!story.word_count) {
      updates.word_count = story.text.split(/\s+/).length;
    }
  
    // Difficulty Level
    if (!story.difficulty_level) {
      const difficultyCode = await openaiService.getStoryDifficulty(story.text);
      if (difficultyCode) {
        const levelEntity = await strapi.db.query('api::difficulty-level.difficulty-level').findOne({
          where: { code: difficultyCode },
        });
        if (levelEntity) {
          updates.difficulty_level = levelEntity.id;
        } else {
          strapi.log.warn(`Difficulty code "${difficultyCode}" not found in DB.`);
        }
      }
    }
  
    // Generation Prompts
    const existingPrompts = story.generation_prompts || {};
    const promptUpdates = {};
  
    if (!existingPrompts.cover_image_prompt) {
      promptUpdates.cover_image_prompt = await openaiService.generateCoverImagePrompt(story.title, story.author, updates.brief || story.brief);
    }
  
    if (!existingPrompts.brief_video_prompt) {
      promptUpdates.brief_video_prompt = await openaiService.generateBriefVideoPrompt(story.title, updates.brief || story.brief);
    }
  
    const needsIllustrations = !existingPrompts.illustration_prompts || existingPrompts.illustration_prompts.length < 3;
    if (needsIllustrations) {
      const illustrations = await openaiService.generateIllustrationPrompts(story.title, story.text);
      if (illustrations) {
        promptUpdates.illustration_prompts = illustrations.map(prompt => ({ prompt }));
      }
    }
  
    if (Object.keys(promptUpdates).length > 0) {
      updates.generation_prompts = {
        ...existingPrompts,
        ...promptUpdates,
        illustration_prompts: promptUpdates.illustration_prompts || existingPrompts.illustration_prompts || [],
      };
    }
  
    if (Object.keys(updates).length === 0) {
      return ctx.send({ message: 'No fields needed to be backfilled. Story already complete.', data: story });
    }
  
    const updatedStory = await strapi.entityService.update('api::story.story', id, {
      data: updates,
      populate: { generation_prompts: { populate: 'illustration_prompts' }, difficulty_level: true },
    });
  
    strapi.log.info(`Backfilled fields for story ID ${id}: ${Object.keys(updates).join(', ')}`);
    return this.transformResponse(updatedStory);
  },
    
  
}));
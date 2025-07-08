// src/api/vocapage/controllers/vocapage.js
'use strict';

/**
 * vocapage controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::vocapage.vocapage', ({ strapi }) => ({
  /**
   * Fetches a single vocapage with its deeply nested flashcards
   * and component data, ensuring it belongs to the authenticated user.
   * @param {object} ctx The Koa context object.
   * @returns {object} The user's vocapage with its nested data.
   */
  async findMyVocapage(ctx) {
    const { id: userId } = ctx.state.user; // Authenticated user's ID
    const { id: vocapageId } = ctx.params; // Vocapage ID from the URL

    // This is the deep population query object.
    const populateQuery = {
      flashcards: {
        populate: {
          content: {
            populate: {
              // Populate the relation within the 'wordRef' component
              word: true,
              // Populate the relation within the 'UserWordRef' component
              user_word: true,
              // Populate the relation within the 'sentRef' component
              sentence: true,
              // Assuming you have a 'userSentRef' component
              user_sentence: true,
            },
          },
        },
      },
    };

    // Find the vocapage, but only if its parent vocabook belongs to the current user.
    // This is a critical security check.
    const entity = await strapi.db.query('api::vocapage.vocapage').findOne({
      where: {
        id: vocapageId,
        vocabook: {
          user: {
            id: userId,
          },
        },
      },
      populate: populateQuery,
    });

    if (!entity) {
      return ctx.notFound('Vocapage not found or you do not have permission to access it.');
    }

    const sanitizedEntity = await this.sanitizeOutput(entity, ctx);
    return this.transformResponse(sanitizedEntity);
  },
}));
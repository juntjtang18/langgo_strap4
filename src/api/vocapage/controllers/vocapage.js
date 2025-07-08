// src/api/vocapage/controllers/vocapage.js
'use strict';

/**
 * vocapage controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::vocapage.vocapage', ({ strapi }) => ({
  /**
   * Fetches a single vocapage, ensuring it belongs to the authenticated user,
   * and deeply populates its nested data.
   */
  async findMyVocapage(ctx) {
    const { id: userId } = ctx.state.user;
    const { id: vocapageId } = ctx.params;

    // Here we use findOne because we have the vocapage's primary key (ID).
    // The filter is used as a security check to ensure ownership.
    const entity = await strapi.entityService.findOne('api::vocapage.vocapage', vocapageId, {
      filters: {
        vocabook: {
          user: {
            id: userId,
          },
        },
      },
      populate: {
        flashcards: {
          populate: {
            content: {
              // Populates relations within the dynamic zone's components
              populate: ['word', 'user_word', 'sentence'],
            },
          },
        },
      },
    });

    if (!entity) {
      return ctx.notFound('Vocapage not found or you do not have permission to access it.');
    }

    const sanitizedEntity = await this.sanitizeOutput(entity, ctx);
    return this.transformResponse(sanitizedEntity);
  },
}));
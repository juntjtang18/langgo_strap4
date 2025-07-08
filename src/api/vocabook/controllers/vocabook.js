// src/api/vocabook/controllers/vocabook.js
'use strict';

/**
 * vocabook controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::vocabook.vocabook', ({ strapi }) => ({
  /**
   * Fetches the vocabook and its pages for the authenticated user.
   */
  async findMyVocabook(ctx) {
    const { id: userId } = ctx.state.user;

    // We use findMany with a limit of 1 since we're filtering by a relation, not the ID.
    const entities = await strapi.entityService.findMany('api::vocabook.vocabook', {
      filters: { user: { id: userId } },
      populate: { vocapages: true },
      limit: 1,
    });

    if (!entities || entities.length === 0) {
      return ctx.notFound('No vocabook found for the current user.');
    }

    const sanitizedEntity = await this.sanitizeOutput(entities[0], ctx);
    return this.transformResponse(sanitizedEntity);
  },
}));
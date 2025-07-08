// src/api/vocabook/controllers/vocabook.js
'use strict';

/**
 * vocabook controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::vocabook.vocabook', ({ strapi }) => ({
  /**
   * Fetches the vocabook and its pages for the authenticated user.
   * @param {object} ctx The Koa context object.
   * @returns {object} The user's vocabook with its vocapages.
   */
  async findMyVocabook(ctx) {
    const { id } = ctx.state.user; // Get the authenticated user's ID

    // Find the vocabook that belongs to the current user and populate its vocapages
    const entity = await strapi.db.query('api::vocabook.vocabook').findOne({
      where: { user: id },
      populate: { vocapages: true },
    });

    if (!entity) {
      return ctx.notFound('No vocabook found for the current user.');
    }

    const sanitizedEntity = await this.sanitizeOutput(entity, ctx);
    return this.transformResponse(sanitizedEntity);
  }
}));
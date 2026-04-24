'use strict';

/**
 * flashcard-stat controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::flashcard-stat.flashcard-stat', ({ strapi }) => ({
  async rebuildAll(ctx) {
    const expectedToken = process.env.FLASHCARD_STAT_REBUILD_TOKEN;

    if (expectedToken) {
      const providedToken = ctx.request.headers['x-maintenance-token'];
      if (providedToken !== expectedToken) {
        return ctx.unauthorized('Invalid maintenance token.');
      }
    } else if (process.env.NODE_ENV === 'production') {
      return ctx.forbidden('Set FLASHCARD_STAT_REBUILD_TOKEN before enabling this endpoint in production.');
    }

    try {
      const result = await strapi
        .service('api::flashcard-stat.flashcard-stat')
        .rebuildAllUsers();

      return ctx.send({ data: result });
    } catch (err) {
      strapi.log.error(`flashcard-stat rebuildAll error: ${err.message}`, { stack: err.stack });
      return ctx.internalServerError('Failed to rebuild flashcard stats.');
    }
  },
}));

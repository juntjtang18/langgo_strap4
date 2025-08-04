'use strict';
module.exports = {
  async run(ctx) { // We only need this one now
    try {
      const result = await strapi.service('api::migration.migration').run();
      return ctx.send(result);
    } catch (error) {
      strapi.log.error('Migration controller error:', error);
      return ctx.internalServerError('Migration failed.');
    }
  },
};
'use strict';

module.exports = {
  async run(ctx) {
    try {
      const result = await strapi.plugin('rank-system').service('migration').run();
      ctx.body = result;
    } catch (error) {
      strapi.log.error('[RankMigration] Controller error:', error);
      ctx.internalServerError(`Migration failed: ${error.message}`);
    }
  },

  async status(ctx) {
    try {
      const result = await strapi.plugin('rank-system').service('migration').status();
      ctx.body = result;
    } catch (error) {
      ctx.internalServerError(`Status check failed: ${error.message}`);
    }
  },
};

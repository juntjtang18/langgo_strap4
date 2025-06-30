// ./src/api/reviewlog/controllers/reviewlog.js

'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::reviewlog.reviewlog', ({ strapi }) => ({
  /**
   * Override the default create controller to add the logged-in user
   */
  async create(ctx) {
    // The error "strapi.log.default is not a function" indicates an incorrect call
    // to the logger. Below is the correct usage with methods like .info() and .error().
    strapi.log.info('Custom reviewlog controller: "create" action started.');

    const user = ctx.state.user;

    if (!user) {
      strapi.log.warn('Attempted to create review log without authentication.');
      return ctx.unauthorized('You must be logged in to create a review log.');
    }

    const { data } = ctx.request.body;

    if (!data) {
        strapi.log.error('Request to create review log failed: Missing "data" in request body.');
        return ctx.badRequest('Missing "data" in request body');
    }

    // Forcefully assign the logged-in user's ID to the data.
    // This is the secure way to associate the log with the correct user.
    data.user = user.id;

    try {
      strapi.log.info(`Creating review log for user: ${user.id} with data: ${JSON.stringify(data)}`);
      
      const entity = await strapi.service('api::reviewlog.reviewlog').create({ data });
      const sanitizedEntity = await this.sanitizeOutput(entity, ctx);
      
      strapi.log.info(`Successfully created review log ${entity.id} for user ${user.id}.`);
      return this.transformResponse(sanitizedEntity);

    } catch (error) {
      strapi.log.error(`An error occurred while creating review log for user ${user.id}: ${error.message}`);
      // Use Strapi's built-in error handling to return a generic 500 error
      return ctx.internalServerError('An error occurred. Please try again later.');
    }
  }
}));
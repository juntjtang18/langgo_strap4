'use strict';

/**
 * ping controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::ping.ping', ({ strapi }) => ({
  /**
   * @param {import('koa').Context} ctx
   */
  async find(ctx) {
    // Return a simple success response
    return { status: 'ok' };
  }
}));
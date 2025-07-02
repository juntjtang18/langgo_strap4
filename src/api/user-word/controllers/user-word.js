'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::user-word.user-word', ({ strapi }) => ({
  async create(ctx) {
    const userId = ctx.state.user?.id;

    if (!userId) {
      return ctx.badRequest('Authenticated user not found.');
    }

    const incomingData = ctx.request.body?.data || {};

    // Manually create the entry with the user ID
    const createdEntry = await strapi.entityService.create('api::user-word.user-word', {
      data: {
        ...incomingData,
        user: userId,
      },
      populate: ['user'],
    });

    return { data: createdEntry };
  },
}));

'use strict';
const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::vbsetting.vbsetting', ({ strapi }) => ({

  /**
   * GET /vbsettings/mine
   */
  async findMine(ctx) {
    if (!ctx.state.user) return ctx.unauthorized();

    const settings = await strapi.entityService.findMany('api::vbsetting.vbsetting', {
      filters: { user: ctx.state.user.id },
    });

    if (settings.length === 0) return ctx.notFound('No VBSetting found for this user.');
    return this.transformResponse(settings[0]);
  },

  /**
   * PUT /vbsettings/mine
   */
  async updateMine(ctx) {
    if (!ctx.state.user) return ctx.unauthorized();

    const { data } = ctx.request.body;
    const existing = await strapi.entityService.findMany('api::vbsetting.vbsetting', {
      filters: { user: ctx.state.user.id },
    });
    if (existing.length === 0) return ctx.notFound('No VBSetting to update.');

    const updated = await strapi.entityService.update(
      'api::vbsetting.vbsetting',
      existing[0].id,
      { data }
    );
    return this.transformResponse(updated);
  },

}));

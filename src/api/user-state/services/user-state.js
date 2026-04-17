'use strict';

/**
 * user-state service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::user-state.user-state');

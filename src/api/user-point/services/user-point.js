'use strict';

/**
 * user-point service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::user-point.user-point');

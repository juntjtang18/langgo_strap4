'use strict';

/**
 * difficulty-level service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::difficulty-level.difficulty-level');

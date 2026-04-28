'use strict';

/**
 * rs-level service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::rs-level.rs-level');

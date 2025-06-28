'use strict';

/**
 * user-word service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::user-word.user-word');

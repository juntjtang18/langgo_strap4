'use strict';

/**
 * user-sentence service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::user-sentence.user-sentence');

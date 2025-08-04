'use strict';

/**
 * word-definition service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::word-definition.word-definition');

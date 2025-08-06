'use strict';

/**
 * word router
 */

const { createCoreRouter } = require('@strapi/strapi').factories;

module.exports = createCoreRouter('api::word-definition.word-definition');

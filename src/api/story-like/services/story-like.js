'use strict';

/**
 * story-like service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::story-like.story-like');

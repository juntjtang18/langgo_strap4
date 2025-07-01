'use strict';

/**
 * review-tire service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::review-tire.review-tire');

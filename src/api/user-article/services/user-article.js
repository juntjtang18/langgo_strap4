'use strict';

/**
 * user-article service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::user-article.user-article');

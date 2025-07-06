'use strict';

/**
 * vocapage service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::vocapage.vocapage');

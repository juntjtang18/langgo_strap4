'use strict';

/**
 * clesson service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::clesson.clesson');

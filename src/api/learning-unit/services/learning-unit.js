'use strict';

/**
 * learning-unit service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::learning-unit.learning-unit');

'use strict';

/**
 * reviewlog service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::reviewlog.reviewlog');

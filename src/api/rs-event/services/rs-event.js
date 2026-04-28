'use strict';

/**
 * rs-event service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::rs-event.rs-event');

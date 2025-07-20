'use strict';

/**
 * conversation-log service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::conversation-log.conversation-log');

'use strict';

/**
 * part-of-speech service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::part-of-speech.part-of-speech');

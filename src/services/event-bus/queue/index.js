'use strict';

// Driver factory — reads EVENT_BUS_DRIVER env var (default: "internal").
// Supported values: "internal", "pubsub".
module.exports = ({ onEvent, strapi }) => {
  const driver = (process.env.EVENT_BUS_DRIVER || 'internal').toLowerCase();

  strapi.log.info(`[EventBus] Using queue driver: ${driver}`);

  if (driver === 'pubsub') {
    const createPubSubDriver = require('./drivers/pubsub');
    return createPubSubDriver({ strapi });
  }

  const createInternalDriver = require('./drivers/internal');
  return createInternalDriver({ onEvent, strapi });
};

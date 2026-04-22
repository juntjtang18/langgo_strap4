'use strict';

const createInternalDriver = require('./review-event-queue-drivers/internal');
const createPubsubDriver = require('./review-event-queue-drivers/pubsub');

module.exports = ({ strapi }) => {
  const driverFactories = {
    internal: createInternalDriver,
    pubsub: createPubsubDriver,
  };

  let driverInstance = null;

  const getConfiguredDriverName = () => (process.env.REVIEW_EVENT_QUEUE_DRIVER || 'internal').toLowerCase();

  const getDriver = () => {
    if (driverInstance) {
      return driverInstance;
    }

    const driverName = getConfiguredDriverName();
    const createDriver = driverFactories[driverName];

    if (!createDriver) {
      throw new Error(`Unsupported review event queue driver: ${driverName}`);
    }

    driverInstance = createDriver({ strapi });
    return driverInstance;
  };

  return {
    getConfiguredDriverName,

    async dispatchReviewCompleted(event) {
      try {
        return await getDriver().enqueue(event);
      } catch (error) {
        strapi.log.error(`Review event queue dispatch failed: ${error.message}`);
        strapi.log.warn('Falling back to inline review event handling.');
        await strapi.service('review-event-handler').handleReviewCompleted(event);
        return {
          queued: false,
          driver: 'inline-fallback',
        };
      }
    },

    async waitForIdle(timeoutMs) {
      const driver = getDriver();

      if (typeof driver.waitForIdle === 'function') {
        return driver.waitForIdle(timeoutMs);
      }
    },
  };
};

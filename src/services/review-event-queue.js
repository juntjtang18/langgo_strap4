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

    async dispatch(event) {
      try {
        return await getDriver().enqueue(event);
      } catch (error) {
        strapi.log.error(`Event queue dispatch failed for ${event?.event || 'unknown'}: ${error.message}`);
        strapi.log.warn('Falling back to inline event handling.');
        await strapi.service('event-handler').handle(event);
        return {
          queued: false,
          driver: 'inline-fallback',
        };
      }
    },

    async dispatchReviewCompleted(event) {
      return this.dispatch(event);
    },

    async dispatchWordDefinitionCreated(event) {
      return this.dispatch(event);
    },

    async waitForIdle(timeoutMs) {
      const driver = getDriver();

      if (typeof driver.waitForIdle === 'function') {
        return driver.waitForIdle(timeoutMs);
      }
    },
  };
};

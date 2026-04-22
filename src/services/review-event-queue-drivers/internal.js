'use strict';

const async = require('async');

module.exports = ({ strapi }) => {
  const worker = async (job) => {
    await strapi.service('event-handler').handle(job);
  };

  const queue = async.queue(worker, 1);

  queue.error((err, job) => {
    strapi.log.error(
      `Event queue job failed for ${job?.event || 'unknown'}: ${err.message}`
    );
  });

  const waitForIdle = async (timeoutMs = 5000, pollMs = 25) => {
    const startedAt = Date.now();

    while (true) {
      if (queue.length() === 0 && queue.running() === 0) {
        return;
      }

      if (Date.now() - startedAt > timeoutMs) {
        throw new Error('Timed out waiting for the internal review event queue to drain.');
      }

      await new Promise((resolve) => setTimeout(resolve, pollMs));
    }
  };

  return {
    name: 'internal',

    async enqueue(event) {
      queue.push(event);
      return { queued: true, driver: 'internal' };
    },

    waitForIdle,
  };
};

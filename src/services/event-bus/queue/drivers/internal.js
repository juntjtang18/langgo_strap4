'use strict';

const async = require('async');

module.exports = ({ onEvent, strapi }) => {
  const queue = async.queue(async (task) => {
    try {
      await onEvent(task);
    } catch (err) {
      strapi.log.error(`[EventBus/internal] Handler error for "${task.event_name}": ${err.message}`);
    }
  }, 1);

  return {
    enqueue(eventObj) {
      queue.push(eventObj);
    },

    waitForIdle(timeoutMs = 5000) {
      if (queue.idle()) return Promise.resolve();
      return new Promise((resolve, reject) => {
        const timer = setTimeout(() => {
          reject(new Error('EventBus waitForIdle timed out'));
        }, timeoutMs);
        queue.drain(() => {
          clearTimeout(timer);
          resolve();
        });
      });
    },
  };
};

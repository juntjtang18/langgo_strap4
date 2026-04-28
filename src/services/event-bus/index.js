'use strict';

const createQueue = require('./queue/index');
const createDispatcher = require('./dispatcher');
const onEvent = require('./handlers/index');

module.exports = ({ strapi }) => {
  const queue = createQueue({
    onEvent: (event) => onEvent({ strapi, event }),
    strapi,
  });

  const dispatcher = createDispatcher({ queue });

  strapi.container.get('services').set('event-bus-queue', queue);
  strapi.container.get('services').set('event-dispatcher', dispatcher);

  strapi.log.info('[EventBus] Initialized.');
};

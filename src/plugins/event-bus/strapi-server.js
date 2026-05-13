'use strict';

module.exports = {
  register: require('./server/register'),
  bootstrap: require('./server/bootstrap'),
  services: {
    'event-bus': require('./server/services/event-bus'),
  },
  contentTypes: {
    'eb-event': {
      schema: require('./server/content-types/eb-event/schema.json'),
    },
  },
};

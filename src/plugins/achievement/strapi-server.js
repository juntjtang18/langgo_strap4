'use strict';

const fs = require('node:fs');
const path = require('node:path');

const contentTypesDir = path.join(__dirname, 'server', 'content-types');
const contentTypes = Object.fromEntries(
  fs
    .readdirSync(contentTypesDir, { withFileTypes: true })
    .filter((entry) => entry.isDirectory())
    .map((entry) => [
      entry.name,
      {
        schema: require(path.join(contentTypesDir, entry.name, 'schema.json')),
      },
    ])
);

module.exports = {
  register: require('./server/register'),
  bootstrap: require('./server/bootstrap'),
  contentTypes,
  controllers: require('./server/controllers'),
  routes: require('./server/routes'),
  services: {
    achievement: require('./server/services/achievement'),
    progress: require('./server/services/progress'),
    'handle-event': require('./server/services/handle-event'),
    'register-event-subscribers': require('./server/services/register-event-subscribers'),
  },
};

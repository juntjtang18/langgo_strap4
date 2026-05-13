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
    'rule-loader': require('./server/services/rule-loader'),
    'snapshot': require('./server/services/snapshot-service'),
    'level': require('./server/services/level-service'),
    'user-group': require('./server/services/user-group-service'),
    'group': require('./server/services/group-service'),
    'event-processor': require('./server/services/event-processor'),
    'dispatcher': require('./server/services/dispatcher'),
    'handle-event': require('./server/services/handle-event'),
    'register-event-subscribers': require('./server/services/register-event-subscribers'),
    migration: require('./server/services/migration'),
  },
};

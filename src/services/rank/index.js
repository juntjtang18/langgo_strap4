'use strict';

const createRuleLoader = require('./rule-loader');
const createSnapshotService = require('./snapshot-service');
const createLevelService = require('./level-service');
const createGroupService = require('./group-service');
const createEventProcessor = require('./event-processor');
const createDispatcher = require('./dispatcher');

module.exports = ({ strapi }) => {
  // Register sub-services first — event-processor resolves them lazily via strapi.service()
  strapi.container.get('services').set('rank-rule-loader', createRuleLoader({ strapi }));
  strapi.container.get('services').set('rank-snapshot', createSnapshotService({ strapi }));
  strapi.container.get('services').set('rank-level', createLevelService({ strapi }));
  strapi.container.get('services').set('rank-group', createGroupService({ strapi }));
  strapi.container.get('services').set('rank-event-processor', createEventProcessor({ strapi }));
  strapi.container.get('services').set('rank-dispatcher', createDispatcher({ strapi }));

  strapi.log.info('[Rank] Subsystem services registered.');
};

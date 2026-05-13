'use strict';

module.exports = async ({ strapi }) => {
  strapi.plugin('event-bus').service('event-bus').initializeRegistry();
  strapi.log.info('[EventBus] plugin bootstrapped');
};

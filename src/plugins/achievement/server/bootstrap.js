'use strict';

module.exports = async ({ strapi }) => {
  await strapi
    .plugin('achievement')
    .service('register-event-subscribers')
    .register();

  strapi.log.info('[Achievement] plugin bootstrapped');
};

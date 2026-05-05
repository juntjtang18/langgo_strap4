'use strict';

module.exports = async ({ strapi }) => {
  await strapi
    .plugin('rank-system')
    .service('register-event-subscribers')
    .register();

  strapi.log.info('[RankSystem] plugin bootstrapped');
};

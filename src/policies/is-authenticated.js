// File: src/policies/is-authenticated.js
'use strict';

module.exports = (policyContext, config, { strapi }) => {
  if (policyContext.state.user) {
    return true; // User is authenticated
  }
  return false; // User is not authenticated
};
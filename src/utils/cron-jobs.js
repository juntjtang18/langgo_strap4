'use strict';

// Add the axios import at the top
const axios = require('axios');

module.exports = {
  async keepSubsysWarm(strapi) {
    try {
      strapi.log.info('🐧 Pinging subsystem to keep it warm...');
      const subscriptionUrl = process.env.SUBSYS_BASE_URL;

      if (!subscriptionUrl) {
        strapi.log.error("SUBSYS_BASE_URL environment variable is not set. Cannot ping subsystem.");
        return;
      }
      
      // Moved this log to be before the request
      strapi.log.info(`Pinging subsystem at ${subscriptionUrl}/api/pings`);

      const response = await axios.get(`${subscriptionUrl}/api/pings`);

      if (response.status === 200) {
        strapi.log.info('✅ Subsystem pinged successfully.');
      } else {
        strapi.log.warn(`⚠️ Subsystem ping returned status: ${response.status}`);
      }
    } catch (error) {
      // Log the full error for better debugging
      strapi.log.error('❌ Error pinging subsystem:', error);
    }
  }
};
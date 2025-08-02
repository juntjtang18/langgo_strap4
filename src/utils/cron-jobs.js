'use strict';
const axios = require('axios');

module.exports = {
  async keepSubsysWarm(strapi) {
    try {
      strapi.log.info('🐧 Pinging subsystem to keep it warm...');

      const subscriptionUrl = process.env.SUBSYS_BASE_URL;
      const serviceSecret = process.env.SUBSCRIPTION_SERVICE_SECRET;

      if (!subscriptionUrl || !serviceSecret) {
        strapi.log.error("❌ Missing SUBSYS_BASE_URL or SUBSCRIPTION_SERVICE_SECRET");
        return;
      }

      const headers = {
        Authorization: `Bearer ${serviceSecret}`,
      };

      strapi.log.info(`➡️ Pinging subsystem at ${subscriptionUrl}/api/pings with bearer token`);

      const response = await axios.get(`${subscriptionUrl}/api/pings`, {
        headers,
        timeout: 10000, // 10s timeout for safety
      });

      if (response.status === 200) {
        strapi.log.info('✅ Subsystem pinged successfully.');
      } else {
        strapi.log.warn(`⚠️ Subsystem ping returned status: ${response.status}`);
      }

    } catch (error) {
      const reason = error.response?.status
        ? `Status ${error.response.status}`
        : error.code || error.message;
      strapi.log.error('❌ Error pinging subsystem:', reason);
    }
  },
};

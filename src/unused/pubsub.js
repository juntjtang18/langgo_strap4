'use strict';

const { PubSub } = require('@google-cloud/pubsub');

module.exports = ({ strapi, PubSubClient = PubSub }) => {
  let client = null;

  const getProjectId = () =>
    process.env.GOOGLE_PUBSUB_PROJECT_ID ||
    process.env.GOOGLE_PROJECT_ID ||
    process.env.GCLOUD_PROJECT ||
    process.env.GOOGLE_CLOUD_PROJECT ||
    null;

  const getCredentials = () => {
    const raw =
      process.env.GOOGLE_PUBSUB_CREDENTIALS_JSON ||
      process.env.GOOGLE_CREDENTIALS_JSON ||
      null;

    if (!raw) {
      return null;
    }

    try {
      return JSON.parse(raw);
    } catch (error) {
      throw new Error(`Invalid Google credentials JSON: ${error.message}`);
    }
  };

  const buildClientOptions = () => {
    const projectId = getProjectId();
    const credentials = getCredentials();

    const options = {};

    if (projectId) {
      options.projectId = projectId;
    }

    if (credentials) {
      options.credentials = credentials;
    }

    return options;
  };

  const getClient = () => {
    if (!client) {
      client = new PubSubClient(buildClientOptions());
    }

    return client;
  };

  const normalizeDataBuffer = (data) => {
    if (Buffer.isBuffer(data)) {
      return data;
    }

    if (typeof data === 'string') {
      return Buffer.from(data, 'utf8');
    }

    return Buffer.from(JSON.stringify(data ?? {}), 'utf8');
  };

  return {
    isConfigured() {
      return Boolean(getProjectId() || process.env.GOOGLE_APPLICATION_CREDENTIALS || process.env.K_SERVICE);
    },

    getProjectId,

    getClient,

    topic(topicName, options = {}) {
      if (!topicName) {
        throw new Error('topicName is required');
      }

      return getClient().topic(topicName, options);
    },

    subscription(subscriptionName, options = {}) {
      if (!subscriptionName) {
        throw new Error('subscriptionName is required');
      }

      return getClient().subscription(subscriptionName, options);
    },

    async publish(topicName, data, attributes = {}, options = {}) {
      const message = {
        data: normalizeDataBuffer(data),
        attributes,
      };

      if (options.orderingKey) {
        message.orderingKey = options.orderingKey;
      }

      const messageId = await this.topic(topicName, options.topicOptions).publishMessage(message);
      strapi.log.info(`Published Pub/Sub message ${messageId} to topic "${topicName}"`);
      return messageId;
    },

    async publishJson(topicName, payload, attributes = {}, options = {}) {
      return this.publish(
        topicName,
        payload,
        {
          contentType: 'application/json',
          ...attributes,
        },
        options
      );
    },
  };
};

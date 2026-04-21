'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const initPubSubService = require('../src/services/pubsub');

test('pubsub service builds client from project id and publishes json payloads', async () => {
  const originalProject = process.env.GOOGLE_PUBSUB_PROJECT_ID;
  const originalCreds = process.env.GOOGLE_PUBSUB_CREDENTIALS_JSON;

  process.env.GOOGLE_PUBSUB_PROJECT_ID = 'langgo-test-project';
  delete process.env.GOOGLE_PUBSUB_CREDENTIALS_JSON;

  const published = [];

  class FakePubSub {
    constructor(options) {
      this.options = options;
    }

    topic(name) {
      return {
        publishMessage: async (message) => {
          published.push({ name, message, options: this.options });
          return 'msg-123';
        },
      };
    }

    subscription(name, options) {
      return { name, options };
    }
  }

  const service = initPubSubService({
    strapi: {
      log: {
        info() {},
      },
    },
    PubSubClient: FakePubSub,
  });

  const messageId = await service.publishJson('review-events', { flashcardId: 99 }, { source: 'test' });

  assert.equal(messageId, 'msg-123');
  assert.equal(service.getProjectId(), 'langgo-test-project');
  assert.equal(published.length, 1);
  assert.equal(published[0].name, 'review-events');
  assert.equal(published[0].options.projectId, 'langgo-test-project');
  assert.deepEqual(published[0].message.attributes, {
    contentType: 'application/json',
    source: 'test',
  });
  assert.deepEqual(JSON.parse(published[0].message.data.toString('utf8')), {
    flashcardId: 99,
  });

  if (originalProject === undefined) {
    delete process.env.GOOGLE_PUBSUB_PROJECT_ID;
  } else {
    process.env.GOOGLE_PUBSUB_PROJECT_ID = originalProject;
  }

  if (originalCreds === undefined) {
    delete process.env.GOOGLE_PUBSUB_CREDENTIALS_JSON;
  } else {
    process.env.GOOGLE_PUBSUB_CREDENTIALS_JSON = originalCreds;
  }
});

test('pubsub service parses inline credentials json when provided', () => {
  const originalProject = process.env.GOOGLE_PUBSUB_PROJECT_ID;
  const originalCreds = process.env.GOOGLE_PUBSUB_CREDENTIALS_JSON;

  process.env.GOOGLE_PUBSUB_PROJECT_ID = 'langgo-test-project';
  process.env.GOOGLE_PUBSUB_CREDENTIALS_JSON = JSON.stringify({
    client_email: 'svc@example.com',
    private_key: 'fake-key',
  });

  let constructedOptions = null;

  class FakePubSub {
    constructor(options) {
      constructedOptions = options;
    }

    topic() {
      return { publishMessage: async () => 'msg-123' };
    }

    subscription(name, options) {
      return { name, options };
    }
  }

  const service = initPubSubService({
    strapi: { log: { info() {} } },
    PubSubClient: FakePubSub,
  });

  service.getClient();

  assert.deepEqual(constructedOptions, {
    projectId: 'langgo-test-project',
    credentials: {
      client_email: 'svc@example.com',
      private_key: 'fake-key',
    },
  });

  if (originalProject === undefined) {
    delete process.env.GOOGLE_PUBSUB_PROJECT_ID;
  } else {
    process.env.GOOGLE_PUBSUB_PROJECT_ID = originalProject;
  }

  if (originalCreds === undefined) {
    delete process.env.GOOGLE_PUBSUB_CREDENTIALS_JSON;
  } else {
    process.env.GOOGLE_PUBSUB_CREDENTIALS_JSON = originalCreds;
  }
});

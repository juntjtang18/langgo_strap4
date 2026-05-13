'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const createEventBusService = require('../src/services/event-bus');

const flushImmediates = async (times = 2) => {
  for (let index = 0; index < times; index += 1) {
    await new Promise((resolve) => setImmediate(resolve));
  }
};

const createFakeEventBusClient = () => {
  const handlersByTopic = new Map();

  return {
    async publish(topic, payload) {
      const handlers = Array.from(handlersByTopic.get(topic) || []);
      const message = {
        topic,
        payload,
        id: payload?.eventId || null,
        publishedAt: payload?.occurredAt || new Date().toISOString(),
        raw: { topic, payload },
        async ack() {},
        async nack() {},
      };

      await Promise.all(handlers.map(async (handler) => handler(message)));
      return {
        driver: 'postgres',
        topic,
        publishedAt: message.publishedAt,
      };
    },

    async subscribe(topic, handler) {
      const handlers = handlersByTopic.get(topic) || new Set();
      handlers.add(handler);
      handlersByTopic.set(topic, handlers);

      return {
        driver: 'postgres',
        topic,
        async unsubscribe() {
          const current = handlersByTopic.get(topic);
          if (!current) return;
          current.delete(handler);
          if (current.size === 0) {
            handlersByTopic.delete(topic);
          }
        },
      };
    },

    async close() {
      handlersByTopic.clear();
    },
  };
};

const createStrapi = () => ({
  log: {
    info() {},
    warn() {},
    error() {},
  },
});

test('event-bus service publishes to the client and notifies subscribers', async () => {
  const service = createEventBusService({
    strapi: createStrapi(),
    eventBusClient: createFakeEventBusClient(),
  });

  const seen = [];

  await service.subscribe('demo.event', 'alpha', async (event) => {
    seen.push(['alpha', event]);
  });
  await service.subscribe('demo.event', 'beta', async (event) => {
    seen.push(['beta', event]);
  });

  assert.deepEqual(service.listSubscribers('demo.event'), ['alpha', 'beta']);

  const result = service.publish('demo.event', { eventId: 'evt-1', value: 42 }, {
    source: 'test-suite',
    metadata: { trace: 't-1' },
  });

  assert.equal(result.accepted, true);
  assert.equal(result.event.event_name, 'demo.event');
  assert.equal(result.event.event_id, 'evt-1');
  assert.deepEqual(result.event.payload, { eventId: 'evt-1', value: 42 });
  assert.equal(result.event.source, 'test-suite');

  await flushImmediates();

  assert.deepEqual(seen.map(([name]) => name), ['alpha', 'beta']);
  assert.equal(await service.unsubscribe('demo.event', 'beta'), true);
  assert.deepEqual(service.listSubscribers('demo.event'), ['alpha']);
  assert.equal(await service.clearSubscribers('demo.event'), 1);
  assert.deepEqual(service.listSubscribers('demo.event'), []);
});

test('event-bus service works with no subscribers', async () => {
  const service = createEventBusService({
    strapi: createStrapi(),
    eventBusClient: createFakeEventBusClient(),
  });

  const result = service.publish('empty.event', { noop: true });
  assert.equal(result.accepted, true);

  await flushImmediates();
});

test('event-bus service initializeRegistry clears all subscribers', async () => {
  const service = createEventBusService({
    strapi: createStrapi(),
    eventBusClient: createFakeEventBusClient(),
  });

  await service.subscribe('alpha.event', 'alpha', async () => {});
  await service.subscribe('beta.event', 'beta', async () => {});

  assert.deepEqual(service.listSubscribers('alpha.event'), ['alpha']);
  assert.deepEqual(service.listSubscribers('beta.event'), ['beta']);

  await service.initializeRegistry();

  assert.deepEqual(service.listSubscribers('alpha.event'), []);
  assert.deepEqual(service.listSubscribers('beta.event'), []);
});

test('event-bus service validates subscribe and publish inputs', async () => {
  const service = createEventBusService({
    strapi: createStrapi(),
    eventBusClient: createFakeEventBusClient(),
  });

  await assert.rejects(() => service.subscribe('', 'alpha', async () => {}), /eventName is required/);
  await assert.rejects(() => service.subscribe('demo.event', '', async () => {}), /subscriberName is required/);
  await assert.rejects(() => service.subscribe('demo.event', 'alpha', null), /handler must be a function/);
  assert.throws(() => service.publish('', {}), /eventName is required/);
});

test('event-bus service normalizes payload and metadata defaults', async () => {
  const service = createEventBusService({
    strapi: createStrapi(),
    eventBusClient: createFakeEventBusClient(),
  });

  const result = service.publish('normalize.event', null, {
    source: 'normalize-test',
    metadata: 'not-an-object',
  });

  await flushImmediates();

  assert.deepEqual(result.event.payload, {});
  assert.deepEqual(result.event.metadata, {});
  assert.equal(result.event.source, 'normalize-test');
});

test('event-bus service publish is fire-and-forget while subscribers run asynchronously', async () => {
  let releaseSubscriber;
  let markProcessed;

  const subscriberGate = new Promise((resolve) => {
    releaseSubscriber = resolve;
  });
  const processed = new Promise((resolve) => {
    markProcessed = resolve;
  });

  const service = createEventBusService({
    strapi: createStrapi(),
    eventBusClient: createFakeEventBusClient(),
  });

  await service.subscribe('async.event', 'slow-subscriber', async () => {
    await subscriberGate;
    markProcessed();
  });

  const result = service.publish('async.event', { value: 7 }, {
    source: 'async-test',
  });

  assert.equal(result.accepted, true);

  releaseSubscriber();
  await processed;
});

test('event-bus service close clears subscriptions', async () => {
  const service = createEventBusService({
    strapi: createStrapi(),
    eventBusClient: createFakeEventBusClient(),
  });

  await service.subscribe('later.event', 'alpha', async () => {});
  assert.deepEqual(service.listSubscribers('later.event'), ['alpha']);

  await service.close();

  assert.deepEqual(service.listSubscribers('later.event'), []);
});

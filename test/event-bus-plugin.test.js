'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const createEventBusService = require('../src/plugins/event-bus/server/services/event-bus');

const flushImmediates = async (times = 2) => {
  for (let index = 0; index < times; index += 1) {
    await new Promise((resolve) => setImmediate(resolve));
  }
};

test('event-bus plugin service persists events and notifies subscribers without tracking outcomes', async () => {
  const creates = [];
  let nextId = 1;

  const strapi = {
    entityService: {
      async create(uid, payload) {
        const row = { id: nextId++, ...payload.data };
        creates.push([uid, payload.data]);
        return row;
      },
    },
    log: {
      info() {},
      error() {},
    },
  };

  const service = createEventBusService({ strapi });
  const seen = [];

  service.subscribe('demo.event', 'alpha', async (event) => {
    seen.push(['alpha', event]);
    return { ok: true };
  });
  service.subscribe('demo.event', 'beta', async (event) => {
    seen.push(['beta', event]);
    throw new Error(`boom:${event.event_name}`);
  });

  assert.deepEqual(service.listSubscribers('demo.event'), ['alpha', 'beta']);

  const result = service.publish('demo.event', { value: 42 }, {
    source: 'test-suite',
    metadata: { trace: 't-1' },
  });

  assert.equal(result.accepted, true);
  assert.equal(result.event.event_name, 'demo.event');
  assert.equal(typeof result.event.event_id, 'string');
  assert.deepEqual(result.event.payload, { value: 42 });
  assert.equal(result.event.source, 'test-suite');

  await flushImmediates();

  assert.deepEqual(seen.map(([name]) => name), ['alpha', 'beta']);

  assert.deepEqual(creates.map(([uid]) => uid), [
    'plugin::event-bus.eb-event',
  ]);

  assert.deepEqual(creates[0][1], {
    event_id: result.event.event_id,
    event_name: 'demo.event',
    payload: { value: 42 },
    source: 'test-suite',
    occurred_at: result.event.occurred_at,
    metadata: { trace: 't-1' },
  });

  assert.equal(service.unsubscribe('demo.event', 'beta'), true);
  assert.deepEqual(service.listSubscribers('demo.event'), ['alpha']);
  assert.equal(service.clearSubscribers('demo.event'), 1);
  assert.deepEqual(service.listSubscribers('demo.event'), []);
});

test('event-bus plugin persists events even when there are no subscribers', async () => {
  const creates = [];

  const strapi = {
    entityService: {
      async create(uid, payload) {
        creates.push([uid, payload.data]);
        return { id: 99, ...payload.data };
      },
    },
    log: {
      info() {},
      error() {},
    },
  };

  const service = createEventBusService({ strapi });
  const result = service.publish('empty.event', { noop: true });

  assert.equal(result.accepted, true);
  await flushImmediates();
  assert.equal(creates.length, 1);
  assert.equal(creates[0][0], 'plugin::event-bus.eb-event');
});

test('event-bus plugin initializeRegistry clears all subscribers', () => {
  const service = createEventBusService({
    strapi: {
      entityService: {},
      log: {
        info() {},
        error() {},
      },
    },
  });

  service.subscribe('alpha.event', 'alpha', async () => {});
  service.subscribe('beta.event', 'beta', async () => {});

  assert.deepEqual(service.listSubscribers('alpha.event'), ['alpha']);
  assert.deepEqual(service.listSubscribers('beta.event'), ['beta']);

  service.initializeRegistry();

  assert.deepEqual(service.listSubscribers('alpha.event'), []);
  assert.deepEqual(service.listSubscribers('beta.event'), []);
});

test('event-bus plugin validates subscribe and publish inputs', async () => {
  const service = createEventBusService({
    strapi: {
      entityService: {
        async create() {
          throw new Error('create should not be called in validation test');
        },
      },
      log: {
        info() {},
        error() {},
      },
    },
  });

  assert.throws(() => service.subscribe('', 'alpha', async () => {}), /eventName is required/);
  assert.throws(() => service.subscribe('demo.event', '', async () => {}), /subscriberName is required/);
  assert.throws(() => service.subscribe('demo.event', 'alpha', null), /handler must be a function/);
  assert.throws(() => service.publish('', {}), /eventName is required/);
});

test('event-bus plugin normalizes payload and metadata defaults', async () => {
  const creates = [];

  const service = createEventBusService({
    strapi: {
      entityService: {
        async create(uid, payload) {
          creates.push([uid, payload.data]);
          return { id: 7, ...payload.data };
        },
      },
      log: {
        info() {},
        error() {},
      },
    },
  });

  const result = service.publish('normalize.event', null, {
    source: 'normalize-test',
    metadata: 'not-an-object',
  });

  await flushImmediates();

  assert.deepEqual(result.event.payload, {});
  assert.deepEqual(result.event.metadata, {});
  assert.equal(result.event.source, 'normalize-test');
  assert.deepEqual(creates[0][1].payload, {});
  assert.deepEqual(creates[0][1].metadata, {});
});

test('event-bus plugin publish is fire-and-forget while subscribers run asynchronously', async () => {
  const creates = [];
  let nextId = 1;
  let releaseSubscriber;
  let markProcessed;

  const subscriberGate = new Promise((resolve) => {
    releaseSubscriber = resolve;
  });
  const processed = new Promise((resolve) => {
    markProcessed = resolve;
  });

  const service = createEventBusService({
    strapi: {
      entityService: {
        async create(uid, payload) {
          const row = { id: nextId++, ...payload.data };
          creates.push([uid, payload.data]);
          return row;
        },
      },
      log: {
        info() {},
        error() {},
      },
    },
  });

  service.subscribe('async.event', 'slow-subscriber', async () => {
    await subscriberGate;
    markProcessed();
  });

  const result = service.publish('async.event', { value: 7 }, {
    source: 'async-test',
  });

  assert.equal(result.accepted, true);
  assert.equal(result.event.event_name, 'async.event');
  assert.equal(creates.length, 0);

  await flushImmediates(1);

  assert.equal(creates.length, 1);

  releaseSubscriber();
  await processed;
});

test('event-bus plugin publish returns before background persistence starts', async () => {
  const creates = [];
  let nextId = 1;
  let handlerRuns = 0;

  const strapi = {
    entityService: {
      async create(uid, payload) {
        creates.push([uid, payload.data]);
        return { id: nextId++, ...payload.data };
      },
      async update() {
        return {};
      },
    },
    log: {
      info() {},
      error() {},
    },
  };

  const service = createEventBusService({ strapi });

  service.subscribe('later.event', 'alpha', async () => {
    handlerRuns += 1;
  });

  const result = service.publish('later.event', { value: 9 }, {
    source: 'publish-later-test',
  });

  assert.equal(result.accepted, true);
  assert.equal(creates.length, 0);
  assert.equal(handlerRuns, 0);

  await flushImmediates();

  assert.equal(creates[0][0], 'plugin::event-bus.eb-event');
  assert.equal(handlerRuns, 1);
});

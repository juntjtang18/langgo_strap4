'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const createEventBusService = require('../src/plugins/event-bus/server/services/event-bus');

test('event-bus plugin service subscribes, persists events, and records delivery outcomes', async () => {
  const creates = [];
  const updates = [];
  let nextId = 1;

  const strapi = {
    entityService: {
      async create(uid, payload) {
        const row = { id: nextId++, ...payload.data };
        creates.push([uid, payload.data]);
        return row;
      },
      async update(uid, id, payload) {
        updates.push([uid, id, payload.data]);
        return { id, ...payload.data };
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

  const result = await service.publish('demo.event', { value: 42 }, {
    source: 'test-suite',
    metadata: { trace: 't-1' },
  });

  assert.equal(result.event.event_name, 'demo.event');
  assert.deepEqual(result.event.payload, { value: 42 });
  assert.equal(result.event.source, 'test-suite');
  assert.deepEqual(seen.map(([name]) => name), ['alpha', 'beta']);

  assert.deepEqual(creates.map(([uid]) => uid), [
    'plugin::event-bus.eb-event',
    'plugin::event-bus.eb-event-delivery',
    'plugin::event-bus.eb-event-delivery',
  ]);

  assert.deepEqual(creates[0][1], {
    id: result.event.id,
    event_name: 'demo.event',
    payload: { value: 42 },
    source: 'test-suite',
    occurred_at: result.event.occurred_at,
    metadata: { trace: 't-1' },
  });

  assert.deepEqual(creates[1][1], {
    event: result.event.id,
    subscriber_name: 'alpha',
    status: 'pending',
    error_message: null,
    processed_at: null,
  });
  assert.deepEqual(creates[2][1], {
    event: result.event.id,
    subscriber_name: 'beta',
    status: 'pending',
    error_message: null,
    processed_at: null,
  });

  assert.equal(result.results.length, 2);
  assert.deepEqual(result.results[0], {
    subscriberName: 'alpha',
    deliveryId: 2,
    status: 'success',
    value: { ok: true },
  });
  assert.deepEqual(result.results[1], {
    subscriberName: 'beta',
    deliveryId: 3,
    status: 'failed',
    error: 'boom:demo.event',
  });

  assert.deepEqual(updates, [
    ['plugin::event-bus.eb-event-delivery', 2, {
      status: 'success',
      error_message: null,
      processed_at: updates[0][2].processed_at,
    }],
    ['plugin::event-bus.eb-event-delivery', 3, {
      status: 'failed',
      error_message: 'boom:demo.event',
      processed_at: updates[1][2].processed_at,
    }],
  ]);

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
  const result = await service.publish('empty.event', { noop: true });

  assert.equal(creates.length, 1);
  assert.equal(creates[0][0], 'plugin::event-bus.eb-event');
  assert.deepEqual(result.results, []);
});

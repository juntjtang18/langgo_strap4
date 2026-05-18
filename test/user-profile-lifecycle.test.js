'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const lifecycles = require('../src/api/user-profile/content-types/user-profile/lifecycles');

test('user-profile lifecycle publishes user_profile.visibility_updated when visible_on_ladder changes', async () => {
  const published = [];
  const RealDate = Date;
  const profiles = new Map([
    [25, { id: 25, visible_on_ladder: false, user: { id: 60, username: 'chinese2', email: 'chinese2@langgo.ca' } }],
  ]);

  global.Date = class extends RealDate {
    constructor(...args) {
      if (args.length > 0) return new RealDate(...args);
      return new RealDate('2026-05-11T00:00:00.000Z');
    }
    static now() {
      return new RealDate('2026-05-11T00:00:00.000Z').valueOf();
    }
    static parse(value) {
      return RealDate.parse(value);
    }
    static UTC(...args) {
      return RealDate.UTC(...args);
    }
  };

  try {
  global.strapi = {
    entityService: {
      async findOne(uid, id) {
        assert.equal(uid, 'api::user-profile.user-profile');
        return profiles.get(id) || null;
      },
    },
    eventBusClient: {
      publish(eventName, payload) {
        published.push({ eventName, payload });
        return Promise.resolve({ driver: 'test', topic: eventName });
      },
    },
  };

  const event = {
    params: { where: { id: 25 } },
    state: {},
    result: { id: 25 },
  };

  profiles.set(25, { id: 25, visible_on_ladder: true, user: { id: 60, username: 'chinese2', email: 'chinese2@langgo.ca' } });
  event.state.before = { id: 25, visible_on_ladder: false, user: { id: 60, username: 'chinese2', email: 'chinese2@langgo.ca' } };

  await lifecycles.afterUpdate(event);
  await new Promise((resolve) => setImmediate(resolve));

  assert.match(published[0].payload.eventId, /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i);
  delete published[0].payload.eventId;

  assert.deepEqual(published, [
    {
      eventName: 'user_profile.visibility_updated',
      payload: {
        eventType: 'user_profile.visibility_updated',
        occurredAt: '2026-05-11T00:00:00.000Z',
        userId: 60,
        username: 'chinese2',
        visibleOnLadder: true,
      },
    },
  ]);
  } finally {
    global.Date = RealDate;
  }
});

test('user-profile lifecycle skips publish when visible_on_ladder is unchanged', async () => {
  const published = [];

  global.strapi = {
    entityService: {
      async findOne(uid, id) {
        assert.equal(uid, 'api::user-profile.user-profile');
        assert.equal(id, 25);
        return { id: 25, visible_on_ladder: true, user: { id: 60, username: 'chinese2', email: 'chinese2@langgo.ca' } };
      },
    },
    eventBusClient: {
      publish(...args) {
        published.push(args);
        return Promise.resolve({ driver: 'test' });
      },
    },
  };

  await lifecycles.afterUpdate({
    state: {
      before: { id: 25, visible_on_ladder: true, user: { id: 60, username: 'chinese2', email: 'chinese2@langgo.ca' } },
    },
    result: { id: 25 },
  });

  assert.deepEqual(published, []);
});

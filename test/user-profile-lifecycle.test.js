'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const lifecycles = require('../src/api/user-profile/content-types/user-profile/lifecycles');

test('user-profile lifecycle publishes user.profile.update when visible_on_ladder changes', async () => {
  const published = [];
  const profiles = new Map([
    [25, { id: 25, visible_on_ladder: false, user: { id: 60, username: 'chinese2', email: 'chinese2@langgo.ca' } }],
  ]);

  global.strapi = {
    entityService: {
      async findOne(uid, id) {
        assert.equal(uid, 'api::user-profile.user-profile');
        return profiles.get(id) || null;
      },
    },
    plugin(name) {
      assert.equal(name, 'event-bus');
      return {
        service(serviceName) {
          assert.equal(serviceName, 'event-bus');
          return {
            publish(eventName, payload, options) {
              published.push({ eventName, payload, options });
            },
          };
        },
      };
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

  assert.deepEqual(published, [
    {
      eventName: 'user.profile.update',
      payload: {
        userId: 60,
        username: 'chinese2',
        visible_on_ladder: true,
      },
      options: {
        source: 'user-profile.lifecycle',
        metadata: {
          publisher: 'api::user-profile.user-profile.afterUpdate',
          profileId: 25,
        },
      },
    },
  ]);
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
    plugin() {
      return {
        service() {
          return {
            publish(...args) {
              published.push(args);
            },
          };
        },
      };
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

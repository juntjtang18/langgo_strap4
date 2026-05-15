'use strict';

const assert = require('node:assert/strict');
const test = require('node:test');
const createSubsystemProxy = require('../src/services/subsystem-proxy');
const proxyController = require('../src/api/subsystem-proxy/controllers/subsystem-proxy');
const proxyRoutes = require('../src/api/subsystem-proxy/routes/subsystem-proxy');

const withEnv = async (values, fn) => {
  const previous = {};
  for (const key of Object.keys(values)) {
    previous[key] = process.env[key];
    process.env[key] = values[key];
  }

  try {
    await fn();
  } finally {
    for (const key of Object.keys(values)) {
      if (previous[key] === undefined) {
        delete process.env[key];
      } else {
        process.env[key] = previous[key];
      }
    }
  }
};

const createStrapiMock = () => ({
  log: {
    info() {},
    error() {},
  },
});

test('subsystem proxy forwards authenticated user context and internal key', async () => {
  const originalFetch = global.fetch;
  const calls = [];

  await withEnv(
    {
      RANK_SERVER_BASE_URL: 'http://rank.local',
      RANK_SERVER_INTERNAL_KEY: 'rank-secret',
      SUBSYSTEM_PROXY_TIMEOUT_MS: '1000',
    },
    async () => {
      global.fetch = async (url, options) => {
        calls.push({ url, options });
        return new Response(JSON.stringify({ data: { latest_snapshot: { userid: '60' } } }), {
          status: 200,
          headers: { 'content-type': 'application/json' },
        });
      };

      const ctx = {
        method: 'GET',
        path: '/api/rank/me',
        querystring: 'locale=zh-Hans',
        state: { user: { id: 60, baseLanguage: 'zh-Hans' } },
        unauthorized() {
          throw new Error('should not be unauthorized');
        },
      };

      await createSubsystemProxy({ strapi: createStrapiMock() }).forward(ctx, 'rank', '/api/v1/rank/me');

      assert.equal(calls.length, 1);
      assert.equal(calls[0].url, 'http://rank.local/api/v1/rank/me?locale=zh-Hans');
      assert.equal(calls[0].options.headers['x-internal-key'], 'rank-secret');
      assert.equal(calls[0].options.headers['x-user-id'], '60');
      assert.equal(calls[0].options.headers['x-user-locale'], 'zh-Hans');
      assert.equal(ctx.status, 200);
      assert.deepEqual(ctx.body, { data: { latest_snapshot: { userid: '60' } } });
    }
  );

  global.fetch = originalFetch;
});

test('subsystem proxy rejects unauthenticated requests before backend call', async () => {
  const originalFetch = global.fetch;
  let fetchCalled = false;
  global.fetch = async () => {
    fetchCalled = true;
    throw new Error('unexpected fetch');
  };

  const ctx = {
    state: {},
    unauthorized(message) {
      this.status = 401;
      this.body = { error: message };
    },
  };

  await createSubsystemProxy({ strapi: createStrapiMock() }).forward(ctx, 'achievement', '/api/v1/achievements-achieved');

  assert.equal(fetchCalled, false);
  assert.equal(ctx.status, 401);
  assert.deepEqual(ctx.body, { error: 'Authentication required.' });

  global.fetch = originalFetch;
});

test('subsystem proxy returns 503 when backend configuration is missing', async () => {
  await withEnv(
    {
      RANK_SERVER_BASE_URL: '',
      RANK_SERVER_INTERNAL_KEY: '',
    },
    async () => {
      const ctx = {
        state: { user: { id: 60 } },
        unauthorized() {
          throw new Error('should not be unauthorized');
        },
      };

      await createSubsystemProxy({ strapi: createStrapiMock() }).forward(ctx, 'rank', '/api/v1/rank/me');

      assert.equal(ctx.status, 503);
      assert.equal(ctx.body.error.name, 'ServiceUnavailableError');
    }
  );
});

test('subsystem proxy exposes the expected authenticated public Strapi routes', () => {
  const routeMap = new Map(proxyRoutes.routes.map((route) => [`${route.method} ${route.path}`, route]));

  const expectedRoutes = [
    ['GET /rank/me', 'subsystem-proxy.rankMe'],
    ['GET /rank/users/:userid', 'subsystem-proxy.rankUser'],
    ['GET /myleaderboard', 'subsystem-proxy.myLeaderboard'],
    ['GET /achievements-achieved', 'subsystem-proxy.achievementsAchieved'],
    ['GET /achievements-not-achieved', 'subsystem-proxy.achievementsNotAchieved'],
  ];

  for (const [key, handler] of expectedRoutes) {
    const route = routeMap.get(key);
    assert.ok(route, `missing route ${key}`);
    assert.equal(route.handler, handler);
    assert.deepEqual(route.config.auth, {});
    assert.deepEqual(route.config.policies, ['global::is-authenticated']);
  }
});

test('subsystem proxy controller endpoints forward to versioned rank and achievement backend APIs', async () => {
  const originalFetch = global.fetch;
  const originalStrapi = global.strapi;
  const calls = [];

  await withEnv(
    {
      RANK_SERVER_BASE_URL: 'http://rank.local',
      RANK_SERVER_INTERNAL_KEY: 'rank-secret',
      ACHIEVEMENT_SERVER_BASE_URL: 'http://achievement.local',
      ACHIEVEMENT_SERVER_INTERNAL_KEY: 'achievement-secret',
      SUBSYSTEM_PROXY_TIMEOUT_MS: '1000',
    },
    async () => {
      global.strapi = createStrapiMock();
      global.fetch = async (url, options) => {
        calls.push({ url, options });
        return new Response(JSON.stringify({ data: { ok: true } }), {
          status: 200,
          headers: { 'content-type': 'application/json' },
        });
      };

      const createCtx = (path, params = {}) => ({
        method: 'GET',
        path,
        params,
        querystring: 'locale=en',
        state: { user: { id: 60, baseLanguage: 'en' } },
        unauthorized(message) {
          this.status = 401;
          this.body = { error: message };
        },
      });

      await proxyController.rankMe(createCtx('/api/rank/me'));
      await proxyController.rankUser(createCtx('/api/rank/users/60', { userid: '60' }));
      await proxyController.myLeaderboard(createCtx('/api/myleaderboard'));
      await proxyController.achievementsAchieved(createCtx('/api/achievements-achieved'));
      await proxyController.achievementsNotAchieved(createCtx('/api/achievements-not-achieved'));

      assert.deepEqual(
        calls.map((call) => call.url),
        [
          'http://rank.local/api/v1/rank/me?locale=en',
          'http://rank.local/api/v1/rank/users/60?locale=en',
          'http://rank.local/api/v1/myleaderboard?locale=en',
          'http://achievement.local/api/v1/achievements-achieved?locale=en',
          'http://achievement.local/api/v1/achievements-not-achieved?locale=en',
        ]
      );

      assert.equal(calls[0].options.headers['x-internal-key'], 'rank-secret');
      assert.equal(calls[3].options.headers['x-internal-key'], 'achievement-secret');
      for (const call of calls) {
        assert.equal(call.options.headers['x-user-id'], '60');
        assert.equal(call.options.headers['x-user-locale'], 'en');
      }
    }
  );

  global.fetch = originalFetch;
  global.strapi = originalStrapi;
});

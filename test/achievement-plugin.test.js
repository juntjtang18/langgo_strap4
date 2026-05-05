'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const createEventBusService = require('../src/plugins/event-bus/server/services/event-bus');
const createAchievementService = require('../src/plugins/achievement/server/services/achievement');
const createProgressService = require('../src/plugins/achievement/server/services/progress');
const createHandleEventService = require('../src/plugins/achievement/server/services/handle-event');
const createRegisterSubscribersService = require('../src/plugins/achievement/server/services/register-event-subscribers');
const achievementController = require('../src/plugins/achievement/server/controllers/achievement');

const flushImmediates = async (times = 3) => {
  for (let index = 0; index < times; index += 1) {
    await new Promise((resolve) => setImmediate(resolve));
  }
};

const createHarness = () => {
  const logs = [];
  const store = {
    users: [{ id: 8, username: 'vivian' }],
    profiles: [{ id: 1, user: 8, baseLanguage: 'en' }],
    ebEvents: [],
    achievements: [
      { id: 10, code: 'review-novice', event_name: 'flashcard.review', points: 2, goal: 5 },
      { id: 11, code: 'writer', event_name: 'article.create', points: 1, goal: 1 },
    ],
    translations: [
      { id: 20, achievement: { id: 10 }, locale: 'en', title: 'Review Novice', description: 'Do reviews' },
      { id: 21, achievement: { id: 10 }, locale: 'zh', title: '复习新手', description: '去复习' },
      { id: 22, achievement: { id: 11 }, locale: 'en', title: 'Writer', description: 'Write an article' },
    ],
    userAchievements: [],
  };
  let idCursor = 100;

  const strapi = {
    log: {
      info(message) {
        logs.push(['info', message]);
      },
      warn(message) {
        logs.push(['warn', message]);
      },
      error(message) {
        logs.push(['error', message]);
      },
    },
    entityService: {
      async findMany(uid, query = {}) {
        const filters = query.filters || {};

        if (uid === 'api::user-profile.user-profile') {
          return store.profiles.filter((row) => row.user === filters.user);
        }

        if (uid === 'plugin::achievement.as-achievement') {
          let rows = store.achievements.slice();
          if (filters.event_name) {
            rows = rows.filter((row) => row.event_name === filters.event_name);
          }
          return rows.map((row) => ({
            ...row,
            translations: store.translations.filter((translation) => translation.achievement?.id === row.id),
          }));
        }

        if (uid === 'plugin::achievement.as-user-achievement') {
          let rows = store.userAchievements.slice();
          if (filters.userid) rows = rows.filter((row) => row.userid === String(filters.userid));
          if (filters.achievement?.id) rows = rows.filter((row) => row.achievement?.id === filters.achievement.id);
          return rows.map((row) => ({
            ...row,
            achievement: store.achievements.find((achievement) => achievement.id === row.achievement.id) || row.achievement,
          }));
        }

        if (uid === 'plugin::event-bus.eb-event') {
          return store.ebEvents.slice();
        }

        throw new Error(`Unexpected findMany uid ${uid}`);
      },

      async create(uid, payload) {
        const data = { ...payload.data };

        if (uid === 'plugin::event-bus.eb-event') {
          const row = { id: idCursor++, ...data };
          store.ebEvents.push(row);
          return row;
        }

        if (uid === 'plugin::achievement.as-user-achievement') {
          const row = {
            id: idCursor++,
            ...data,
            achievement: { id: data.achievement },
          };
          store.userAchievements.push(row);
          return row;
        }

        throw new Error(`Unexpected create uid ${uid}`);
      },

      async update(uid, id, payload) {
        const data = { ...payload.data };

        if (uid === 'plugin::achievement.as-user-achievement') {
          const row = store.userAchievements.find((entry) => entry.id === id);
          Object.assign(row, data, {
            achievement: { id: data.achievement },
          });
          return row;
        }

        throw new Error(`Unexpected update uid ${uid}`);
      },
    },
  };

  const plugins = {};
  strapi.plugin = (name) => ({
    service(serviceName) {
      return plugins[name][serviceName];
    },
  });

  plugins['event-bus'] = {
    'event-bus': createEventBusService({ strapi }),
  };
  plugins.achievement = {
    achievement: createAchievementService({ strapi }),
    progress: createProgressService({ strapi }),
    'handle-event': createHandleEventService({ strapi }),
    'register-event-subscribers': createRegisterSubscribersService({ strapi }),
  };

  return {
    logs,
    store,
    strapi,
    eventBus: plugins['event-bus']['event-bus'],
  };
};

function createCtx(userId = 8, locale = undefined) {
  return {
    state: {
      user: userId ? { id: userId } : null,
    },
    query: locale ? { locale } : {},
    body: null,
    unauthorizedMessage: null,
    unauthorized(message) {
      this.unauthorizedMessage = message;
      return message;
    },
  };
}

test('achievement plugin subscribes to event bus and increments progress until achieved', async () => {
  const harness = createHarness();
  const { strapi, eventBus, store, logs } = harness;

  eventBus.initializeRegistry();
  await strapi.plugin('achievement').service('register-event-subscribers').register();

  assert.deepEqual(eventBus.listSubscribers('flashcard.review'), ['achievement']);
  assert.ok(logs.some(([, message]) => message === '[Achievement] registered event-bus subscribers'));

  eventBus.publish('flashcard.review', {
    review: {
      userId: 8,
      userName: 'vivian',
      flashcardId: 2627,
    },
  }, {
    source: 'test.flashcard',
  });

  await flushImmediates(4);

  assert.equal(store.ebEvents.length, 1);
  assert.equal(store.userAchievements.length, 2);

  const reviewAchievement = store.userAchievements.find((row) => row.achievement.id === 10);
  const writerAchievement = store.userAchievements.find((row) => row.achievement.id === 11);

  assert.ok(reviewAchievement);
  assert.ok(writerAchievement);
  assert.equal(reviewAchievement.userid, '8');
  assert.equal(reviewAchievement.username, 'vivian');
  assert.equal(reviewAchievement.progress, 2);
  assert.equal(reviewAchievement.achieved, false);
  assert.equal(writerAchievement.userid, '8');
  assert.equal(writerAchievement.username, 'vivian');
  assert.equal(writerAchievement.progress, 0);
  assert.equal(writerAchievement.achieved, false);

  eventBus.publish('flashcard.review', {
    review: {
      userId: 8,
      userName: 'vivian',
      flashcardId: 2627,
    },
  }, {
    source: 'test.flashcard',
  });

  await flushImmediates(4);

  assert.equal(reviewAchievement.progress, 4);
  assert.equal(reviewAchievement.achieved, false);

  eventBus.publish('flashcard.review', {
    review: {
      userId: 8,
      userName: 'vivian',
      flashcardId: 2627,
    },
  }, {
    source: 'test.flashcard',
  });

  await flushImmediates(4);

  assert.equal(reviewAchievement.progress, 6);
  assert.equal(reviewAchievement.achieved, true);
  assert.ok(reviewAchievement.achieved_at);
});

test('achievement plugin initializes missing user achievement rows on first matching event', async () => {
  const harness = createHarness();
  const { strapi, eventBus, store } = harness;

  eventBus.initializeRegistry();
  await strapi.plugin('achievement').service('register-event-subscribers').register();

  eventBus.publish('article.create', {
    article: {
      userId: 8,
      userName: 'vivian',
      articleId: 900,
    },
  }, {
    source: 'test.article',
  });

  await flushImmediates(4);

  assert.equal(store.userAchievements.length, 2);

  const reviewAchievement = store.userAchievements.find((row) => row.achievement.id === 10);
  const writerAchievement = store.userAchievements.find((row) => row.achievement.id === 11);

  assert.ok(reviewAchievement);
  assert.ok(writerAchievement);
  assert.equal(reviewAchievement.progress, 0);
  assert.equal(reviewAchievement.achieved, false);
  assert.equal(writerAchievement.progress, 1);
  assert.equal(writerAchievement.achieved, true);
  assert.ok(writerAchievement.achieved_at);
});

test('achievement controller separates achieved and not achieved lists with locale translations', async () => {
  const harness = createHarness();
  const { strapi, store } = harness;

  store.userAchievements.push({
    id: 90,
    userid: '8',
    username: 'vivian',
    achievement: { id: 10 },
    progress: 6,
    achieved: true,
    achieved_at: '2026-05-04T21:00:00.000Z',
  });
  store.userAchievements.push({
    id: 91,
    userid: '8',
    username: 'vivian',
    achievement: { id: 11 },
    progress: 0,
    achieved: false,
    achieved_at: null,
  });

  global.strapi = strapi;

  const achievedCtx = createCtx(8, 'zh');
  await achievementController.listAchieved(achievedCtx);

  assert.deepEqual(achievedCtx.body, {
    data: [
      {
        id: 10,
        code: 'review-novice',
        event_name: 'flashcard.review',
        points: 2,
        goal: 5,
        progress: 6,
        achieved: true,
        achieved_at: '2026-05-04T21:00:00.000Z',
        title: '复习新手',
        description: '去复习',
      },
    ],
  });

  const notAchievedCtx = createCtx(8, 'en');
  await achievementController.listNotAchieved(notAchievedCtx);

  assert.deepEqual(notAchievedCtx.body, {
    data: [
      {
        id: 11,
        code: 'writer',
        event_name: 'article.create',
        points: 1,
        goal: 1,
        progress: 0,
        achieved: false,
        achieved_at: null,
        title: 'Writer',
        description: 'Write an article',
      },
    ],
  });
});

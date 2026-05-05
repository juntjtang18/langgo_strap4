'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const createSnapshotService = require('../src/plugins/rank-system/server/services/snapshot-service');
const createGroupService = require('../src/plugins/rank-system/server/services/group-service');
const createUserGroupService = require('../src/plugins/rank-system/server/services/user-group-service');
const createEventProcessor = require('../src/plugins/rank-system/server/services/event-processor');
const createRuleLoader = require('../src/plugins/rank-system/server/services/rule-loader');
const createLevelService = require('../src/plugins/rank-system/server/services/level-service');
const createRankDispatcher = require('../src/plugins/rank-system/server/services/dispatcher');
const createRankHandleEvent = require('../src/plugins/rank-system/server/services/handle-event');
const createRankRegisterSubscribers = require('../src/plugins/rank-system/server/services/register-event-subscribers');
const createEventBusService = require('../src/plugins/event-bus/server/services/event-bus');

const getToday = () => new Date().toISOString().slice(0, 10);
const flushImmediates = async (times = 3) => {
  for (let index = 0; index < times; index += 1) {
    await new Promise((resolve) => setImmediate(resolve));
  }
};

const sortSnapshots = (rows) =>
  rows.sort((a, b) => {
    if (a.record_date === b.record_date) return b.id - a.id;
    return a.record_date < b.record_date ? 1 : -1;
  });

const createHarness = () => {
  const logs = [];
  const store = {
    users: [{ id: 8, username: 'vivian', email: 'vivian@example.com' }],
    ebEvents: [],
    rsEvents: [],
    rsSnapshots: [],
    rsUserGroups: [],
    rsGroups: [],
    rsLevels: [
      { id: 1, level_no: 1 },
      { id: 2, level_no: 2 },
      { id: 3, level_no: 3 },
    ],
    rsGroupRule: { id: 5, period_days: 7, group_size: 2 },
    rsLevelRule: { id: 6, base_points: 10, increase_points: 10 },
    rsEventList: [
      { id: 1, event_name: 'flashcard.create', points: 2 },
      { id: 2, event_name: 'flashcard.review', points: 5 },
      { id: 3, event_name: 'article.create', points: 3 },
      { id: 4, event_name: 'flashcard.review_tier_promote', points: 7 },
      { id: 5, event_name: 'user.register', points: 0 },
    ],
    rsGroupRanks: [
      { id: 21, rank_no: 2, min_period_points: 10, rs_group_rule: { id: 5 } },
      { id: 20, rank_no: 1, min_period_points: 0, rs_group_rule: { id: 5 } },
    ],
    rsLevelTitles: [
      { id: 31, locale: 'en', title: 'Level 1', rs_level: { id: 1 } },
      { id: 32, locale: 'en', title: 'Level 2', rs_level: { id: 2 } },
      { id: 33, locale: 'en', title: 'Level 3', rs_level: { id: 3 } },
    ],
    rsGroupRankTitles: [
      { id: 41, locale: 'en', title: 'Starter', rs_group_rank: { id: 20 } },
      { id: 42, locale: 'en', title: 'Active', rs_group_rank: { id: 21 } },
    ],
  };

  let idCursor = 100;

  const hydrateSnapshot = (row) => ({
    ...row,
    rs_level: row.rs_level ? store.rsLevels.find((level) => level.id === row.rs_level) || { id: row.rs_level } : null,
    rs_group_rank: row.rs_group_rank ? store.rsGroupRanks.find((rank) => rank.id === row.rs_group_rank) || { id: row.rs_group_rank } : null,
    rs_group: row.rs_group ? store.rsGroups.find((group) => group.id === row.rs_group) || { id: row.rs_group } : null,
  });

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
      async findOne(uid, id) {
        if (uid === 'plugin::users-permissions.user') {
          return store.users.find((user) => user.id === id) || null;
        }
        if (uid === 'plugin::rank-system.rs-group') {
          const row = store.rsGroups.find((group) => group.id === id);
          return row ? { ...row, rs_group_rank: row.rs_group_rank ? { id: row.rs_group_rank } : null } : null;
        }
        throw new Error(`Unexpected findOne uid: ${uid}`);
      },

      async findMany(uid, query = {}) {
        const filters = query.filters || {};

        if (uid === 'plugin::rank-system.rs-group-rule') return [store.rsGroupRule];
        if (uid === 'plugin::rank-system.rs-level-rule') return [store.rsLevelRule];
        if (uid === 'plugin::rank-system.rs-event-list') {
          return filters.event_name
            ? store.rsEventList.filter((row) => row.event_name === filters.event_name)
            : store.rsEventList.slice();
        }
        if (uid === 'plugin::rank-system.rs-group-rank') {
          const rows = store.rsGroupRanks.filter((row) => !filters.rs_group_rule?.id || row.rs_group_rule?.id === filters.rs_group_rule.id);
          return rows.slice().sort((a, b) => (b.rank_no - a.rank_no) || (a.id - b.id));
        }
        if (uid === 'plugin::rank-system.rs-level-title') {
          const rows = filters.rs_level?.id
            ? store.rsLevelTitles.filter((row) => row.rs_level?.id === filters.rs_level.id)
            : store.rsLevelTitles.slice();
          return rows.filter((row) => !query.locale || row.locale === query.locale);
        }
        if (uid === 'plugin::rank-system.rs-group-rank-title') {
          const rows = filters.rs_group_rank?.id
            ? store.rsGroupRankTitles.filter((row) => row.rs_group_rank?.id === filters.rs_group_rank.id)
            : store.rsGroupRankTitles.slice();
          return rows.filter((row) => !query.locale || row.locale === query.locale);
        }
        if (uid === 'plugin::rank-system.rs-level') {
          return filters.level_no
            ? store.rsLevels.filter((row) => row.level_no === filters.level_no)
            : store.rsLevels.slice();
        }
        if (uid === 'plugin::rank-system.rs-event') {
          return filters.event_id
            ? store.rsEvents.filter((row) => row.event_id === filters.event_id)
            : store.rsEvents.slice();
        }
        if (uid === 'plugin::rank-system.rs-user-snapshot') {
          let rows = store.rsSnapshots.slice();
          if (filters.userid) rows = rows.filter((row) => row.userid === String(filters.userid));
          if (typeof filters.record_date === 'string') {
            rows = rows.filter((row) => row.record_date === filters.record_date);
          }
          if (filters.record_date?.$lt) {
            rows = rows.filter((row) => row.record_date < filters.record_date.$lt);
          }
          if (filters.record_date?.$gte || filters.record_date?.$lte) {
            rows = rows.filter((row) => {
              if (filters.record_date.$gte && row.record_date < filters.record_date.$gte) return false;
              if (filters.record_date.$lte && row.record_date > filters.record_date.$lte) return false;
              return true;
            });
          }
          rows = sortSnapshots(rows).map(hydrateSnapshot);
          return rows.slice(0, query.limit || rows.length);
        }
        if (uid === 'plugin::rank-system.rs-user-group') {
          let rows = store.rsUserGroups.slice();
          if (filters.userid) rows = rows.filter((row) => row.userid === String(filters.userid));
          if (filters.rs_group?.id) rows = rows.filter((row) => row.rs_group === filters.rs_group.id);
          rows.sort((a, b) => (a.userid < b.userid ? -1 : a.userid > b.userid ? 1 : a.id - b.id));
          return rows.slice(0, query.limit || rows.length).map((row) => ({
            ...row,
            rs_group: row.rs_group ? { id: row.rs_group } : null,
          }));
        }
        if (uid === 'plugin::rank-system.rs-group') {
          let rows = store.rsGroups.slice();
          if (filters.rs_group_rank?.id) rows = rows.filter((row) => row.rs_group_rank === filters.rs_group_rank.id);
          if (filters.rs_group_rule?.id) rows = rows.filter((row) => row.rs_group_rule === filters.rs_group_rule.id);
          rows.sort((a, b) => (a.group_no - b.group_no) || (a.id - b.id));
          return rows.slice(0, query.limit || rows.length).map((row) => ({ ...row }));
        }

        throw new Error(`Unexpected findMany uid: ${uid}`);
      },

      async create(uid, payload) {
        const data = { ...payload.data };

        if (uid === 'plugin::event-bus.eb-event') {
          const row = { ...data };
          store.ebEvents.push(row);
          return row;
        }
        if (uid === 'plugin::rank-system.rs-event') {
          const row = { id: idCursor++, ...data };
          store.rsEvents.push(row);
          return row;
        }
        if (uid === 'plugin::rank-system.rs-level') {
          const row = { id: idCursor++, ...data };
          store.rsLevels.push(row);
          return row;
        }
        if (uid === 'plugin::rank-system.rs-user-snapshot') {
          const row = { id: idCursor++, ...data };
          store.rsSnapshots.push(row);
          return hydrateSnapshot(row);
        }
        if (uid === 'plugin::rank-system.rs-user-group') {
          const row = { id: idCursor++, ...data };
          store.rsUserGroups.push(row);
          return { ...row, rs_group: row.rs_group ? { id: row.rs_group } : null };
        }
        if (uid === 'plugin::rank-system.rs-group') {
          const row = { id: idCursor++, ...data };
          store.rsGroups.push(row);
          return row;
        }

        throw new Error(`Unexpected create uid: ${uid}`);
      },

      async update(uid, id, payload) {
        const data = payload.data;
        if (uid === 'plugin::rank-system.rs-event') {
          const row = store.rsEvents.find((item) => item.id === id);
          Object.assign(row, data);
          return row;
        }
        if (uid === 'plugin::rank-system.rs-user-snapshot') {
          const row = store.rsSnapshots.find((item) => item.id === id);
          Object.assign(row, data);
          return hydrateSnapshot(row);
        }
        if (uid === 'plugin::rank-system.rs-user-group') {
          const row = store.rsUserGroups.find((item) => item.id === id);
          Object.assign(row, data);
          return { ...row, rs_group: row.rs_group ? { id: row.rs_group } : null };
        }

        throw new Error(`Unexpected update uid: ${uid}`);
      },
    },
  };

  const plugins = {};

  strapi.service = () => {
    throw new Error('Unexpected global service lookup in rank-system plugin harness');
  };
  strapi.plugin = (name) => ({
    service(serviceName) {
      return plugins[name][serviceName];
    },
  });

  plugins['event-bus'] = {
    'event-bus': createEventBusService({ strapi }),
  };
  plugins['rank-system'] = {
    'rule-loader': createRuleLoader({ strapi }),
    snapshot: createSnapshotService({ strapi }),
    level: createLevelService({ strapi }),
    'user-group': createUserGroupService({ strapi }),
    group: createGroupService({ strapi }),
    'event-processor': createEventProcessor({ strapi }),
    dispatcher: createRankDispatcher({ strapi }),
    'handle-event': createRankHandleEvent({ strapi }),
    'register-event-subscribers': createRankRegisterSubscribers({ strapi }),
  };

  return {
    logs,
    store,
    strapi,
    eventBus: plugins['event-bus']['event-bus'],
  };
};

test('event-bus plugin publishes all active LangGo events to the rank subscriber and persists results', async () => {
  const harness = createHarness();
  const { eventBus, strapi, store, logs } = harness;

  eventBus.initializeRegistry();
  await strapi.plugin('rank-system').service('register-event-subscribers').register();

  assert.deepEqual(eventBus.listSubscribers('flashcard.review'), ['rank']);
  assert.ok(logs.some(([, message]) => message === '[Rank] registered event-bus subscribers'));

  const events = [
    {
      eventName: 'user.register',
      payload: {
        userId: 8,
        username: 'vivian',
        email: 'vivian@example.com',
      },
      options: {
        source: 'test.user-profile',
        metadata: { publisher: 'test.user-profile.registerWithProfile' },
      },
    },
    {
      eventName: 'flashcard.create',
      payload: {
        event: 'flashcard.created',
        eventId: 'flashcard-created:2627',
        occurredAt: `${getToday()}T12:00:00.000Z`,
        flashcard: {
          flashcardId: 2627,
          userId: 8,
          username: 'vivian',
          locale: 'en',
          baseText: 'hello',
          targetText: 'hola',
        },
      },
      options: {
        source: 'test.word-definition',
        metadata: { publisher: 'test.word-definition.create' },
      },
    },
    {
      eventName: 'flashcard.review',
      payload: {
        review: {
          flashcardId: 2627,
          userId: 8,
          userName: 'vivian',
          level: 'monthly',
          result: 'correct',
          newlevel: 'monthly',
          effective: true,
          reviewedAt: `${getToday()}T12:01:00.000Z`,
        },
        flashcardId: 2627,
      },
      options: {
        source: 'test.flashcard',
        metadata: { publisher: 'test.flashcard.review' },
      },
    },
    {
      eventName: 'flashcard.review_tier_promote',
      payload: {
        review: {
          flashcardId: 2627,
          userId: 8,
          userName: 'vivian',
          level: 'daily',
          result: 'correct',
          newlevel: 'weekly',
          effective: true,
          reviewedAt: `${getToday()}T12:02:00.000Z`,
        },
        flashcardId: 2627,
      },
      options: {
        source: 'test.flashcard',
        metadata: { publisher: 'test.flashcard.review' },
      },
    },
    {
      eventName: 'article.create',
      payload: {
        event: 'user_article.created',
        eventId: 'user-article-created:9001',
        occurredAt: `${getToday()}T12:03:00.000Z`,
        article: {
          userArticleId: 9001,
          userId: 8,
          username: 'vivian',
          title: 'My article',
          wordCount: 120,
        },
      },
      options: {
        source: 'test.user-article',
        metadata: { publisher: 'test.user-article.create' },
      },
    },
  ];

  for (const event of events) {
    const result = eventBus.publish(event.eventName, event.payload, event.options);
    assert.equal(result.accepted, true);
    assert.equal(result.event.event_name, event.eventName);
  }

  await flushImmediates(6);

  assert.equal(store.ebEvents.length, 5);
  assert.equal(store.rsEvents.length, 5);

  assert.deepEqual(
    store.rsEvents.map((row) => row.event_name),
    [
      'user.register',
      'flashcard.create',
      'flashcard.review',
      'flashcard.review_tier_promote',
      'article.create',
    ]
  );
  assert.ok(store.rsEvents.every((row) => row.status === 'handled'));
  assert.deepEqual(
    logs.filter(([, message]) => message.startsWith('[Rank] handling event: ')).map(([, message]) => message),
    [
      '[Rank] handling event: user.register',
      '[Rank] handling event: flashcard.create',
      '[Rank] handling event: flashcard.review',
      '[Rank] handling event: flashcard.review_tier_promote',
      '[Rank] handling event: article.create',
    ]
  );

  const latestSnapshot = sortSnapshots(store.rsSnapshots.slice())[0];
  assert.equal(latestSnapshot.userid, '8');
  assert.equal(latestSnapshot.record_date, getToday());
  assert.equal(latestSnapshot.total_points, 17);
  assert.equal(latestSnapshot.points_add, 17);
  assert.equal(latestSnapshot.word_count, 1);
  assert.equal(latestSnapshot.word_add, 1);
  assert.equal(latestSnapshot.article_count, 1);
  assert.equal(latestSnapshot.article_add, 1);
  assert.equal(latestSnapshot.level_title, 'Level 2');
  assert.equal(latestSnapshot.group_rank_title, 'Active');
  assert.equal(latestSnapshot.period_points, 17);
  assert.equal(latestSnapshot.period_points_change, 17);

  assert.equal(store.rsUserGroups.length, 1);
  assert.equal(store.rsUserGroups[0].userid, '8');
  assert.equal(store.rsUserGroups[0].period_points, 17);
  assert.equal(store.rsUserGroups[0].rs_group, latestSnapshot.rs_group);

  assert.equal(store.rsGroups.length, 2);
  assert.deepEqual(
    store.rsGroups.map((row) => row.rs_group_rank),
    [20, 21]
  );

  const flashcardCreateEvent = store.rsEvents.find((row) => row.event_name === 'flashcard.create');
  assert.equal(flashcardCreateEvent.payload.flashcard.flashcardId, 2627);
  const articleCreateEvent = store.rsEvents.find((row) => row.event_name === 'article.create');
  assert.equal(articleCreateEvent.payload.article.userArticleId, 9001);
});

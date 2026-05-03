'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const snapshotSchema = require('../src/api/rs-user-snapshot/content-types/rs-user-snapshot/schema.json');

const createSnapshotService = require('../src/services/rank/snapshot-service');
const createGroupService = require('../src/services/rank/group-service');
const createUserGroupService = require('../src/services/rank/user-group-service');
const createEventProcessor = require('../src/services/rank/event-processor');
const createRuleLoader = require('../src/services/rank/rule-loader');
const createLevelService = require('../src/services/rank/level-service');
const createRankDispatcher = require('../src/services/rank/dispatcher');
const createInternalQueue = require('../src/services/event-bus/queue/drivers/internal');
const createEventDispatcher = require('../src/services/event-bus/dispatcher');
const handleEvent = require('../src/services/event-bus/handlers/index');

const getToday = () => new Date().toISOString().slice(0, 10);

const shiftDate = (dateString, days) => {
  const date = new Date(`${dateString}T00:00:00.000Z`);
  date.setUTCDate(date.getUTCDate() + days);
  return date.toISOString().slice(0, 10);
};

const createRankHarness = ({
  users = [{ id: 8, username: 'vivian' }],
  rsSnapshots = [],
  rsUserGroups = [],
  rsGroups = [],
  rsLevels = [
    { id: 1, level_no: 1 },
    { id: 2, level_no: 2 },
    { id: 3, level_no: 3 },
  ],
  rsGroupRule = { id: 5, period_days: 7, group_size: 2 },
  rsLevelRule = { id: 6, base_points: 10, increase_points: 10 },
  rsEventList = [
    { id: 1, event_name: 'flashcard.create', points: 2 },
    { id: 2, event_name: 'flashcard.review', points: 5 },
    { id: 3, event_name: 'article.create', points: 3 },
    { id: 4, event_name: 'flashcard.review_tier_promote', points: 7 },
    { id: 5, event_name: 'user.register', points: 0 },
  ],
  rsGroupRanks = [
    { id: 21, rank_no: 2, min_period_points: 10, rs_group_rule: { id: 5 } },
    { id: 20, rank_no: 1, min_period_points: 0, rs_group_rule: { id: 5 } },
  ],
  rsLevelTitles = [
    { id: 1, locale: 'en', title: 'Level 1', rs_level: { id: 1 } },
    { id: 2, locale: 'en', title: 'Level 2', rs_level: { id: 2 } },
    { id: 3, locale: 'en', title: 'Level 3', rs_level: { id: 3 } },
  ],
  rsGroupRankTitles = [
    { id: 1, locale: 'en', title: 'Starter', rs_group_rank: { id: 20 } },
    { id: 2, locale: 'en', title: 'Active', rs_group_rank: { id: 21 } },
  ],
  nextId = 100,
} = {}) => {
  const store = {
    users: users.map((row) => ({ ...row })),
    rsEvents: [],
    rsSnapshots: rsSnapshots.map((row) => ({ ...row })),
    rsUserGroups: rsUserGroups.map((row) => ({ ...row })),
    rsGroups: rsGroups.map((row) => ({ ...row })),
    rsLevels: rsLevels.map((row) => ({ ...row })),
    rsGroupRule: { ...rsGroupRule },
    rsLevelRule: { ...rsLevelRule },
    rsEventList: rsEventList.map((row) => ({ ...row })),
    rsGroupRanks: rsGroupRanks.map((row) => ({ ...row })),
    rsLevelTitles: rsLevelTitles.map((row) => ({ ...row })),
    rsGroupRankTitles: rsGroupRankTitles.map((row) => ({ ...row })),
  };

  let idCursor = nextId;

  const hydrateSnapshot = (row) => ({
    ...row,
    rs_level: row.rs_level ? store.rsLevels.find((level) => level.id === row.rs_level) || { id: row.rs_level } : null,
    rs_group_rank: row.rs_group_rank ? store.rsGroupRanks.find((rank) => rank.id === row.rs_group_rank) || { id: row.rs_group_rank } : null,
    rs_group: row.rs_group ? store.rsGroups.find((group) => group.id === row.rs_group) || { id: row.rs_group } : null,
  });

  const strapi = {
    log: {
      info() {},
      warn() {},
      error() {},
    },
    entityService: {
      async findOne(uid, id) {
        if (uid === 'plugin::users-permissions.user') {
          return store.users.find((user) => user.id === id) || null;
        }
        if (uid === 'api::rs-group.rs-group') {
          const row = store.rsGroups.find((group) => group.id === id);
          if (!row) return null;
          return {
            ...row,
            rs_group_rank: row.rs_group_rank ? { id: row.rs_group_rank } : null,
          };
        }
        throw new Error(`Unexpected findOne uid: ${uid}`);
      },

      async findMany(uid, query = {}) {
        const filters = query.filters || {};

        if (uid === 'api::rs-group-rule.rs-group-rule') return [store.rsGroupRule];
        if (uid === 'api::rs-level-rule.rs-level-rule') return [store.rsLevelRule];
        if (uid === 'api::rs-event-list.rs-event-list') {
          if (filters.event_name) return store.rsEventList.filter((row) => row.event_name === filters.event_name);
          return store.rsEventList.slice();
        }
        if (uid === 'api::rs-group-rank.rs-group-rank') {
          return store.rsGroupRanks.filter((row) => !filters.rs_group_rule?.id || row.rs_group_rule?.id === filters.rs_group_rule.id);
        }
        if (uid === 'api::rs-level-title.rs-level-title') {
          if (filters.rs_level?.id) {
            return store.rsLevelTitles.filter((row) => row.rs_level?.id === filters.rs_level.id && (!query.locale || row.locale === query.locale));
          }
          return store.rsLevelTitles.slice();
        }
        if (uid === 'api::rs-group-rank-title.rs-group-rank-title') {
          if (filters.rs_group_rank?.id) {
            return store.rsGroupRankTitles.filter((row) => row.rs_group_rank?.id === filters.rs_group_rank.id && (!query.locale || row.locale === query.locale));
          }
          return store.rsGroupRankTitles.slice();
        }
        if (uid === 'api::rs-level.rs-level') {
          if (filters.level_no) return store.rsLevels.filter((row) => row.level_no === filters.level_no);
          return store.rsLevels.slice();
        }
        if (uid === 'api::rs-event.rs-event') {
          if (filters.event_id) return store.rsEvents.filter((row) => row.event_id === filters.event_id);
          return store.rsEvents.slice();
        }
        if (uid === 'api::rs-user-snapshot.rs-user-snapshot') {
          let rows = store.rsSnapshots.slice();
          if (filters.userid) rows = rows.filter((row) => row.userid === String(filters.userid));
          if (filters.record_date && typeof filters.record_date === 'string') {
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
          rows.sort((a, b) => {
            if (a.record_date === b.record_date) return b.id - a.id;
            return a.record_date < b.record_date ? 1 : -1;
          });
          return rows.slice(0, query.limit || rows.length).map(hydrateSnapshot);
        }
        if (uid === 'api::rs-user-group.rs-user-group') {
          let rows = store.rsUserGroups.slice();
          if (filters.userid) rows = rows.filter((row) => row.userid === String(filters.userid));
          if (filters.rs_group?.id) rows = rows.filter((row) => row.rs_group === filters.rs_group.id);
          rows.sort((a, b) => a.id - b.id);
          return rows.slice(0, query.limit || rows.length).map((row) => ({
            ...row,
            rs_group: row.rs_group ? { id: row.rs_group } : null,
          }));
        }
        if (uid === 'api::rs-group.rs-group') {
          let rows = store.rsGroups.slice();
          if (filters.rs_group_rank?.id) rows = rows.filter((row) => row.rs_group_rank === filters.rs_group_rank.id);
          if (filters.rs_group_rule?.id) rows = rows.filter((row) => row.rs_group_rule === filters.rs_group_rule.id);
          rows.sort((a, b) => (a.group_no - b.group_no) || (a.id - b.id));
          return rows.slice(0, query.limit || rows.length).map((row) => ({ ...row }));
        }

        throw new Error(`Unexpected findMany uid: ${uid}`);
      },

      async create(uid, payload) {
        const data = payload.data;
        if (uid === 'api::rs-event.rs-event') {
          const row = { id: idCursor++, ...data };
          store.rsEvents.push(row);
          return row;
        }
        if (uid === 'api::rs-level.rs-level') {
          const row = { id: idCursor++, ...data };
          store.rsLevels.push(row);
          return row;
        }
        if (uid === 'api::rs-user-snapshot.rs-user-snapshot') {
          const row = { id: idCursor++, ...data };
          store.rsSnapshots.push(row);
          return hydrateSnapshot(row);
        }
        if (uid === 'api::rs-user-group.rs-user-group') {
          const row = { id: idCursor++, ...data };
          store.rsUserGroups.push(row);
          return { ...row, rs_group: row.rs_group ? { id: row.rs_group } : null };
        }
        if (uid === 'api::rs-group.rs-group') {
          const row = { id: idCursor++, ...data };
          store.rsGroups.push(row);
          return row;
        }
        throw new Error(`Unexpected create uid: ${uid}`);
      },

      async update(uid, id, payload) {
        const data = payload.data;
        if (uid === 'api::rs-event.rs-event') {
          const row = store.rsEvents.find((item) => item.id === id);
          Object.assign(row, data);
          return row;
        }
        if (uid === 'api::rs-user-snapshot.rs-user-snapshot') {
          const row = store.rsSnapshots.find((item) => item.id === id);
          Object.assign(row, data);
          return hydrateSnapshot(row);
        }
        if (uid === 'api::rs-user-group.rs-user-group') {
          const row = store.rsUserGroups.find((item) => item.id === id);
          Object.assign(row, data);
          return { ...row, rs_group: row.rs_group ? { id: row.rs_group } : null };
        }
        throw new Error(`Unexpected update uid: ${uid}`);
      },
    },
  };

  const services = {};
  strapi.service = (name) => services[name];

  services['rank-rule-loader'] = createRuleLoader({ strapi });
  services['rank-snapshot'] = createSnapshotService({ strapi });
  services['rank-level'] = createLevelService({ strapi });
  services['rank-user-group'] = createUserGroupService({ strapi });
  services['rank-group'] = createGroupService({ strapi });
  services['rank-event-processor'] = createEventProcessor({ strapi });
  services['rank-dispatcher'] = createRankDispatcher({ strapi });

  const queue = createInternalQueue({
    strapi,
    onEvent: (event) => handleEvent({ strapi, event }),
  });
  const dispatcher = createEventDispatcher({ queue, strapi });

  return {
    store,
    strapi,
    queue,
    dispatcher,
    async publishEvent({
      eventName,
      eventId,
      userId = 8,
      flashcardId = 2627,
      articleId = 9001,
      review = {},
      flashcard = {},
      article = {},
    }) {
      if (eventName === 'flashcard.review') {
        await dispatcher.dispatchFlashcardReviewCompleted({
          eventId,
          review: {
            flashcardId,
            userId,
            level: 'monthly',
            result: 'correct',
            newlevel: 'monthly',
            effective: false,
            reviewedAt: `${getToday()}T10:00:00.000Z`,
            ...review,
          },
        });
        await queue.waitForIdle(5000);
        return;
      }

      if (eventName === 'flashcard.create') {
        await dispatcher.dispatchFlashcardCreate({
          eventId,
          flashcard: {
            flashcardId,
            userId,
            ...flashcard,
          },
        });
        await queue.waitForIdle(5000);
        return;
      }

      if (eventName === 'article.create') {
        await dispatcher.dispatchArticleCreate({
          eventId,
          article: {
            userArticleId: articleId,
            userId,
            ...article,
          },
        });
        await queue.waitForIdle(5000);
        return;
      }

      if (eventName === 'flashcard.review_tier_promote') {
        queue.enqueue({
          event_name: 'flashcard.review_tier_promote',
          event_id: eventId,
          userid: String(userId),
          username: store.users.find((user) => user.id === userId)?.username || null,
          flashcard_id: flashcardId,
          review: {
            flashcardId,
            userId,
            userName: store.users.find((user) => user.id === userId)?.username || null,
            level: 'daily',
            result: 'correct',
            newlevel: 'weekly',
            effective: true,
            reviewedAt: `${getToday()}T10:00:00.000Z`,
            ...review,
          },
        });
        await queue.waitForIdle(5000);
        return;
      }

      throw new Error(`Unsupported test event ${eventName}`);
    },
  };
};

test('rs_user_snapshot schema does not require userid uniqueness because snapshots are daily', () => {
  assert.equal(snapshotSchema.attributes.userid.required, true);
  assert.equal(Object.hasOwn(snapshotSchema.attributes.userid, 'unique'), false);
});

test('rank snapshot service creates today snapshot from previous day values', async () => {
  const calls = [];
  const previous = {
    id: 7,
    username: 'vivian',
    total_points: 100,
    word_count: 4,
    article_count: 2,
    rs_level: { id: 21 },
    level_title: 'Level 2',
    rs_group_rank: { id: 31 },
    rs_group: { id: 41 },
    group_rank_title: 'Starter',
  };

  const strapi = {
    entityService: {
      async findMany(uid, query) {
        calls.push(['findMany', uid, query]);
        if (query.filters.record_date === '2026-05-02') return [];
        return [previous];
      },
      async create(uid, payload) {
        calls.push(['create', uid, payload]);
        return { id: 8, ...payload.data };
      },
    },
  };

  const service = createSnapshotService({ strapi });
  const result = await service.ensureTodaySnapshot('8', 'vivian', new Date('2026-05-02T12:00:00.000Z'));

  assert.equal(result.id, 8);
  assert.deepEqual(calls[2][2].data, {
    userid: '8',
    username: 'vivian',
    record_date: '2026-05-02',
    total_points: 100,
    points_add: 0,
    word_count: 4,
    word_add: 0,
    article_count: 2,
    article_add: 0,
    rs_level: 21,
    level_title: 'Level 2',
    level_change: 0,
    rs_group_rank: 31,
    rs_group: 41,
    group_rank_title: 'Starter',
    group_rank_change: 0,
  });
});

test('rank user-group service upserts current membership and period points', async () => {
  const calls = [];
  const strapi = {
    entityService: {
      async findMany(uid, query) {
        calls.push(['findMany', uid, query]);
        return [{ id: 15, username: 'vivian', rs_group: { id: 3 } }];
      },
      async update(uid, id, payload) {
        calls.push(['update', uid, id, payload]);
        return { id, ...payload.data };
      },
    },
  };

  const service = createUserGroupService({ strapi });
  const result = await service.upsert('8', 'vivian', 9, 22);

  assert.equal(result.id, 15);
  assert.deepEqual(calls[1], ['update', 'api::rs-user-group.rs-user-group', 15, {
    data: {
      userid: '8',
      username: 'vivian',
      rs_group: 9,
      period_points: 22,
    },
  }]);
});

test('rank group split moves overflow members through rs_user_group and latest snapshots', async () => {
  const movedMemberships = [];
  const movedSnapshots = [];

  const strapi = {
    service(name) {
      if (name === 'rank-user-group') {
        return {
          async listByGroup() {
            return [
              { userid: 'u1', username: 'a', period_points: 10 },
              { userid: 'u2', username: 'b', period_points: 9 },
              { userid: 'u3', username: 'c', period_points: 8 },
              { userid: 'u4', username: 'd', period_points: 7 },
              { userid: 'u5', username: 'e', period_points: 6 },
            ];
          },
          async upsert(userid, username, groupId, periodPoints) {
            movedMemberships.push([userid, username, groupId, periodPoints]);
          },
        };
      }
      if (name === 'rank-snapshot') {
        return {
          async updateLatestGroup(userid, groupId, groupRankId, groupRankTitle) {
            movedSnapshots.push([userid, groupId, groupRankId, groupRankTitle]);
          },
        };
      }
      throw new Error(`Unexpected service ${name}`);
    },
    entityService: {
      async findMany() {
        throw new Error('findMany should not be called');
      },
      async create(uid, payload) {
        assert.equal(uid, 'api::rs-group.rs-group');
        return { id: 99, ...payload.data };
      },
    },
  };

  const service = createGroupService({ strapi });
  service.getNextGroupNo = async () => 5;
  const result = await service.splitGroup(4, 1, 2, 2, 'Active');

  assert.equal(result.id, 99);
  assert.deepEqual(movedMemberships, [
    ['u4', 'd', 99, 7],
    ['u5', 'e', 99, 6],
  ]);
  assert.deepEqual(movedSnapshots, [
    ['u4', 99, 2, 'Active'],
    ['u5', 99, 2, 'Active'],
  ]);
});

test('rank group assignment reuses existing target-rank group before splitting', async () => {
  const upserts = [];
  const memberships = new Map([
    ['8', { id: 1, userid: '8', username: 'vivian', rs_group: { id: 10 }, period_points: 6 }],
  ]);
  const strapi = {
    service(name) {
      if (name === 'rank-user-group') {
        return {
          async getByUserid(userid) {
            return memberships.get(String(userid)) || null;
          },
          async countByGroup() {
            throw new Error('countByGroup should not be used when an existing target-rank group exists');
          },
          async upsert(userid, username, groupId, periodPoints) {
            upserts.push([userid, username, groupId, periodPoints]);
            const row = { id: userid === '8' ? 20 : Number(userid), userid, username, rs_group: { id: groupId }, period_points: periodPoints };
            memberships.set(String(userid), row);
            return row;
          },
          async listByGroup(groupId) {
            if (groupId === 20) {
              return [
                { userid: '18', username: 'u18', period_points: 20 },
                { userid: '28', username: 'u28', period_points: 19 },
                { userid: '38', username: 'u38', period_points: 18 },
                { userid: '48', username: 'u48', period_points: 17 },
                { userid: '8', username: 'vivian', period_points: 11 },
              ];
            }
            return [];
          },
        };
      }
      if (name === 'rank-snapshot') {
        return {
          async updateLatestGroup() {},
        };
      }
      throw new Error(`Unexpected service ${name}`);
    },
    entityService: {
      async findOne(uid, id) {
        assert.equal(uid, 'api::rs-group.rs-group');
        if (id === 10) return { id: 10, rs_group_rank: { id: 20 } };
        if (id === 20) return { id: 20, group_no: 2, rs_group_rule: 5, rs_group_rank: { id: 21 } };
        if (id === 99) return { id: 99, group_no: 3, rs_group_rule: 5, rs_group_rank: { id: 21 } };
        return null;
      },
      async findMany(uid, query) {
        assert.equal(uid, 'api::rs-group.rs-group');
        assert.deepEqual(query.filters, { rs_group_rank: { id: 21 } });
        return [{ id: 20, group_no: 2, rs_group_rule: 5, rs_group_rank: 21 }];
      },
      async create(uid, payload) {
        assert.equal(uid, 'api::rs-group.rs-group');
        assert.deepEqual(payload.data, {
          rs_group_rule: 5,
          rs_group_rank: 21,
          group_no: 3,
        });
        return { id: 99, ...payload.data };
      },
    },
  };

  const service = createGroupService({ strapi });
  service.getNextGroupNo = async () => 3;

  const result = await service.assignUserToRankedGroup('8', 'vivian', 5, 21, 2, 11, 'Active');

  assert.deepEqual(upserts[0], ['8', 'vivian', 20, 11]);
  assert.equal(result.membership.rs_group.id, 99);
  assert.equal(result.group.id, 99);
});

test('rank event processor logs event and updates today snapshot, level, rank, and user group', async () => {
  const snapshotUpdates = [];
  const eventUpdates = [];
  const serviceCalls = [];

  const todaySnapshot = {
    id: 44,
    userid: '8',
    username: 'vivian',
    record_date: '2026-05-02',
    total_points: 100,
    points_add: 4,
    word_count: 3,
    word_add: 1,
    article_count: 2,
    article_add: 0,
    rs_level: { id: 11, level_no: 2 },
    rs_group_rank: { id: 21, rank_no: 1 },
    rs_group: { id: 31 },
  };
  const groupRanks = [
    { id: 22, rank_no: 2, min_period_points: 10, rs_group_rule: { id: 5 } },
    { id: 21, rank_no: 1, min_period_points: 0, rs_group_rule: { id: 5 } },
  ];

  const services = {
    'rank-rule-loader': {
      async loadGroupRule() {
        return { id: 5, group_size: 2, period_days: 7 };
      },
      async loadLevelRule() {
        return { id: 6, base_points: 10, increase_points: 10 };
      },
      async loadPointRule(name) {
        assert.equal(name, 'flashcard.create');
        return { points: 5 };
      },
      async loadGroupRanks(id) {
        assert.equal(id, 5);
        return groupRanks;
      },
      async findOrCreateLevel(levelNo) {
        serviceCalls.push(['findOrCreateLevel', levelNo]);
        return { id: 12, level_no: levelNo };
      },
      async findLevelTitle(levelId, locale) {
        serviceCalls.push(['findLevelTitle', levelId, locale]);
        return 'Level 3';
      },
      async findGroupRankTitle(groupRankId, locale) {
        serviceCalls.push(['findGroupRankTitle', groupRankId, locale]);
        return groupRankId === 22 ? 'Active' : 'Starter';
      },
    },
    'rank-snapshot': {
      getTodayDate() {
        return '2026-05-02';
      },
      async ensureTodaySnapshot(userid, username) {
        serviceCalls.push(['ensureTodaySnapshot', userid, username]);
        return todaySnapshot;
      },
      async getPeriodPoints(userid, periodDays) {
        serviceCalls.push(['getPeriodPoints', userid, periodDays]);
        return 7;
      },
      async updateSnapshot(snapshotId, data) {
        snapshotUpdates.push([snapshotId, data]);
        return { id: snapshotId };
      },
    },
    'rank-level': {
      calculateLevel(totalPoints, currentLevel, levelRule) {
        serviceCalls.push(['calculateLevel', totalPoints, currentLevel, levelRule.id]);
        return 3;
      },
    },
    'rank-group': {
      getGroupRankForPoints(points, ranks) {
        serviceCalls.push(['getGroupRankForPoints', points, ranks.length]);
        return ranks[0];
      },
      async assignUserToRankedGroup(userid, username, groupRuleId, groupRankId, groupSize, periodPoints, title) {
        serviceCalls.push(['assignUserToRankedGroup', userid, username, groupRuleId, groupRankId, groupSize, periodPoints, title]);
        return {
          membership: { id: 66 },
          group: { id: 32 },
        };
      },
    },
    'rank-user-group': {
      async getByUserid(userid) {
        serviceCalls.push(['getByUserid', userid]);
        return { id: 77, period_points: 4 };
      },
    },
  };

  const strapi = {
    service(name) {
      return services[name];
    },
    entityService: {
      async findOne(uid, id) {
        assert.equal(uid, 'plugin::users-permissions.user');
        assert.equal(id, 8);
        return { id: 8, username: 'vivian' };
      },
      async create(uid, payload) {
        if (uid === 'api::rs-event.rs-event') {
          return { id: 88, ...payload.data };
        }
        throw new Error(`Unexpected create uid ${uid}`);
      },
      async update(uid, id, payload) {
        if (uid === 'api::rs-event.rs-event') {
          eventUpdates.push([id, payload.data]);
          return { id, ...payload.data };
        }
        throw new Error(`Unexpected update uid ${uid}`);
      },
    },
    log: {
      error() {},
      warn() {},
    },
  };

  const processor = createEventProcessor({ strapi });
  const result = await processor.processEvent({
    event_id: 'evt-1',
    event_name: 'flashcard.create',
    userid: '8',
    payload: { flashcardId: 123 },
  });

  assert.equal(result.totalPoints, 105);
  assert.equal(result.pointsAdd, 9);
  assert.equal(result.wordCount, 4);
  assert.equal(result.level, 3);
  assert.equal(result.groupRankNo, 2);
  assert.equal(result.periodPoints, 12);
  assert.deepEqual(snapshotUpdates, [[44, {
    username: 'vivian',
    total_points: 105,
    points_add: 9,
    word_count: 4,
    word_add: 2,
    article_count: 2,
    article_add: 0,
    rs_level: 12,
    level_title: 'Level 3',
    level_change: 1,
    rs_group_rank: 22,
    rs_group: 32,
    group_rank_title: 'Active',
    group_rank_change: 1,
  }]]);
  assert.equal(eventUpdates[0][1].status, 'handled');
  assert.ok(eventUpdates[0][1].handled_at);
  assert.equal(
    eventUpdates[0][1].handle_result,
    JSON.stringify({
      userid: '8',
      username: 'vivian',
      totalPoints: 105,
      pointsAdd: 9,
      wordCount: 4,
      articleCount: 2,
      level: 3,
      levelChange: 1,
      groupRankNo: 2,
      groupRankChange: 1,
      periodPoints: 12,
    })
  );
  assert.deepEqual(serviceCalls, [
    ['ensureTodaySnapshot', '8', 'vivian'],
    ['calculateLevel', 105, 2, 6],
    ['findOrCreateLevel', 3],
    ['findLevelTitle', 12, 'en'],
    ['getByUserid', '8'],
    ['getPeriodPoints', '8', 7],
    ['getGroupRankForPoints', 12, 2],
    ['findGroupRankTitle', 22, 'en'],
    ['assignUserToRankedGroup', '8', 'vivian', 5, 22, 2, 12, 'Active'],
  ]);
});

test('event bus publishes and rank handler persists flashcard.create/review/article.create/review_tier_promote', async () => {
  const store = {
    users: [
      { id: 8, username: 'vivian' },
    ],
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
      { id: 21, rank_no: 2, min_period_points: 15, rs_group_rule: { id: 5 } },
      { id: 20, rank_no: 1, min_period_points: 0, rs_group_rule: { id: 5 } },
    ],
    rsLevelTitles: [
      { id: 1, locale: 'en', title: 'Level 1', rs_level: { id: 1 } },
      { id: 2, locale: 'en', title: 'Level 2', rs_level: { id: 2 } },
      { id: 3, locale: 'en', title: 'Level 3', rs_level: { id: 3 } },
    ],
    rsGroupRankTitles: [
      { id: 1, locale: 'en', title: 'Starter', rs_group_rank: { id: 20 } },
      { id: 2, locale: 'en', title: 'Active', rs_group_rank: { id: 21 } },
    ],
  };

  let nextId = 100;
  const today = new Date().toISOString().slice(0, 10);

  const hydrateSnapshot = (row) => ({
    ...row,
    rs_level: row.rs_level ? store.rsLevels.find((level) => level.id === row.rs_level) || { id: row.rs_level } : null,
    rs_group_rank: row.rs_group_rank ? store.rsGroupRanks.find((rank) => rank.id === row.rs_group_rank) || { id: row.rs_group_rank } : null,
    rs_group: row.rs_group ? store.rsGroups.find((group) => group.id === row.rs_group) || { id: row.rs_group } : null,
  });

  const strapi = {
    log: {
      info() {},
      warn() {},
      error() {},
    },
    entityService: {
      async findOne(uid, id) {
        if (uid === 'plugin::users-permissions.user') {
          return store.users.find((user) => user.id === id) || null;
        }
        if (uid === 'api::rs-group.rs-group') {
          const row = store.rsGroups.find((group) => group.id === id);
          if (!row) return null;
          return {
            ...row,
            rs_group_rank: row.rs_group_rank ? { id: row.rs_group_rank } : null,
          };
        }
        throw new Error(`Unexpected findOne uid: ${uid}`);
      },

      async findMany(uid, query = {}) {
        const filters = query.filters || {};

        if (uid === 'api::rs-group-rule.rs-group-rule') {
          return [store.rsGroupRule];
        }
        if (uid === 'api::rs-level-rule.rs-level-rule') {
          return [store.rsLevelRule];
        }
        if (uid === 'api::rs-event-list.rs-event-list') {
          if (filters.event_name) {
            return store.rsEventList.filter((row) => row.event_name === filters.event_name);
          }
          return store.rsEventList.slice();
        }
        if (uid === 'api::rs-group-rank.rs-group-rank') {
          return store.rsGroupRanks.filter((row) => {
            return !filters.rs_group_rule?.id || row.rs_group_rule?.id === filters.rs_group_rule.id;
          });
        }
        if (uid === 'api::rs-level-title.rs-level-title') {
          if (filters.rs_level?.id) {
            return store.rsLevelTitles.filter((row) => row.rs_level?.id === filters.rs_level.id && (!query.locale || row.locale === query.locale));
          }
          return store.rsLevelTitles.slice();
        }
        if (uid === 'api::rs-group-rank-title.rs-group-rank-title') {
          if (filters.rs_group_rank?.id) {
            return store.rsGroupRankTitles.filter((row) => row.rs_group_rank?.id === filters.rs_group_rank.id && (!query.locale || row.locale === query.locale));
          }
          return store.rsGroupRankTitles.slice();
        }
        if (uid === 'api::rs-level.rs-level') {
          if (filters.level_no) {
            return store.rsLevels.filter((row) => row.level_no === filters.level_no);
          }
          return store.rsLevels.slice();
        }
        if (uid === 'api::rs-event.rs-event') {
          if (filters.event_id) {
            return store.rsEvents.filter((row) => row.event_id === filters.event_id);
          }
          return store.rsEvents.slice();
        }
        if (uid === 'api::rs-user-snapshot.rs-user-snapshot') {
          let rows = store.rsSnapshots.slice();
          if (filters.userid) {
            rows = rows.filter((row) => row.userid === String(filters.userid));
          }
          if (filters.record_date && typeof filters.record_date === 'string') {
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
          rows.sort((a, b) => {
            if (a.record_date === b.record_date) return b.id - a.id;
            return a.record_date < b.record_date ? 1 : -1;
          });
          return rows.slice(0, query.limit || rows.length).map(hydrateSnapshot);
        }
        if (uid === 'api::rs-user-group.rs-user-group') {
          let rows = store.rsUserGroups.slice();
          if (filters.userid) {
            rows = rows.filter((row) => row.userid === String(filters.userid));
          }
          if (filters.rs_group?.id) {
            rows = rows.filter((row) => row.rs_group === filters.rs_group.id);
          }
          rows.sort((a, b) => a.id - b.id);
          return rows.slice(0, query.limit || rows.length).map((row) => ({
            ...row,
            rs_group: row.rs_group ? { id: row.rs_group } : null,
          }));
        }
        if (uid === 'api::rs-group.rs-group') {
          let rows = store.rsGroups.slice();
          if (filters.rs_group_rank?.id) {
            rows = rows.filter((row) => row.rs_group_rank === filters.rs_group_rank.id);
          }
          if (filters.rs_group_rule?.id) {
            rows = rows.filter((row) => row.rs_group_rule === filters.rs_group_rule.id);
          }
          rows.sort((a, b) => (a.group_no - b.group_no) || (a.id - b.id));
          return rows.slice(0, query.limit || rows.length).map((row) => ({ ...row }));
        }

        throw new Error(`Unexpected findMany uid: ${uid}`);
      },

      async create(uid, payload) {
        const data = payload.data;
        if (uid === 'api::rs-event.rs-event') {
          const row = { id: nextId++, ...data };
          store.rsEvents.push(row);
          return row;
        }
        if (uid === 'api::rs-level.rs-level') {
          const row = { id: nextId++, ...data };
          store.rsLevels.push(row);
          return row;
        }
        if (uid === 'api::rs-user-snapshot.rs-user-snapshot') {
          const row = { id: nextId++, ...data };
          store.rsSnapshots.push(row);
          return hydrateSnapshot(row);
        }
        if (uid === 'api::rs-user-group.rs-user-group') {
          const row = { id: nextId++, ...data };
          store.rsUserGroups.push(row);
          return { ...row, rs_group: row.rs_group ? { id: row.rs_group } : null };
        }
        if (uid === 'api::rs-group.rs-group') {
          const row = { id: nextId++, ...data };
          store.rsGroups.push(row);
          return row;
        }
        throw new Error(`Unexpected create uid: ${uid}`);
      },

      async update(uid, id, payload) {
        const data = payload.data;
        if (uid === 'api::rs-event.rs-event') {
          const row = store.rsEvents.find((item) => item.id === id);
          Object.assign(row, data);
          return row;
        }
        if (uid === 'api::rs-user-snapshot.rs-user-snapshot') {
          const row = store.rsSnapshots.find((item) => item.id === id);
          Object.assign(row, data);
          return hydrateSnapshot(row);
        }
        if (uid === 'api::rs-user-group.rs-user-group') {
          const row = store.rsUserGroups.find((item) => item.id === id);
          Object.assign(row, data);
          return { ...row, rs_group: row.rs_group ? { id: row.rs_group } : null };
        }
        throw new Error(`Unexpected update uid: ${uid}`);
      },
    },
  };

  const services = {};
  strapi.service = (name) => services[name];

  services['rank-rule-loader'] = createRuleLoader({ strapi });
  services['rank-snapshot'] = createSnapshotService({ strapi });
  services['rank-level'] = createLevelService({ strapi });
  services['rank-user-group'] = createUserGroupService({ strapi });
  services['rank-group'] = createGroupService({ strapi });
  services['rank-event-processor'] = createEventProcessor({ strapi });
  services['rank-dispatcher'] = createRankDispatcher({ strapi });

  const queue = createInternalQueue({
    strapi,
    onEvent: (event) => handleEvent({ strapi, event }),
  });
  const dispatcher = createEventDispatcher({ queue, strapi });

  await dispatcher.dispatchFlashcardCreate({
    eventId: 'evt-create',
    flashcard: {
      flashcardId: 2627,
      userId: 8,
    },
  });

  await dispatcher.dispatchArticleCreate({
    eventId: 'evt-article',
    article: {
      userArticleId: 9001,
      userId: 8,
    },
  });

  await dispatcher.dispatchFlashcardReviewCompleted({
    eventId: 'evt-review',
    review: {
      flashcardId: 2627,
      userId: 8,
      level: 'monthly',
      result: 'correct',
      newlevel: 'monthly',
      effective: false,
      reviewedAt: `${today}T10:00:00.000Z`,
    },
  });

  queue.enqueue({
    event_name: 'flashcard.review_tier_promote',
    event_id: 'evt-tier-promote',
    userid: '8',
    username: 'vivian',
    flashcard_id: 2627,
    review: {
      flashcardId: 2627,
      userId: 8,
      userName: 'vivian',
      level: 'daily',
      result: 'correct',
      newlevel: 'weekly',
      effective: true,
      reviewedAt: `${today}T10:05:00.000Z`,
    },
  });

  await queue.waitForIdle(5000);

  assert.deepEqual(
    store.rsEvents.map((event) => event.event_name),
    ['flashcard.create', 'article.create', 'flashcard.review', 'flashcard.review_tier_promote']
  );
  assert.ok(store.rsEvents.every((event) => event.status === 'handled'));
  assert.ok(store.rsEvents.every((event) => event.userid === '8'));
  assert.ok(store.rsEvents.every((event) => event.username === 'vivian'));
  assert.deepEqual(store.rsEvents[0].payload, {
    event_id: 'evt-create',
    event_name: 'flashcard.create',
    userid: '8',
    username: 'vivian',
    flashcardId: 2627,
    flashcard: {
      flashcardId: 2627,
      userId: 8,
      username: 'vivian',
    },
  });
  assert.deepEqual(store.rsEvents[1].payload, {
    event_id: 'evt-article',
    event_name: 'article.create',
    userid: '8',
    username: 'vivian',
    articleId: 9001,
    article: {
      userArticleId: 9001,
      userId: 8,
      username: 'vivian',
    },
  });
  assert.equal(store.rsEvents[2].payload.review.userName, 'vivian');
  assert.equal(store.rsEvents[3].payload.review.userName, 'vivian');
  assert.ok(store.rsEvents.every((event) => typeof event.handle_result === 'string' && event.handle_result.length > 0));

  assert.equal(store.rsSnapshots.length, 1);
  const snapshot = store.rsSnapshots[0];
  assert.equal(snapshot.userid, '8');
  assert.equal(snapshot.username, 'vivian');
  assert.equal(snapshot.record_date, today);
  assert.equal(snapshot.total_points, 17);
  assert.equal(snapshot.points_add, 17);
  assert.equal(snapshot.word_count, 1);
  assert.equal(snapshot.word_add, 1);
  assert.equal(snapshot.article_count, 1);
  assert.equal(snapshot.article_add, 1);
  assert.equal(snapshot.level_title, 'Level 2');
  assert.equal(snapshot.group_rank_title, 'Active');
  assert.equal(snapshot.group_rank_change, 1);

  assert.equal(store.rsUserGroups.length, 1);
  assert.equal(store.rsUserGroups[0].userid, '8');
  assert.equal(store.rsUserGroups[0].username, 'vivian');
  assert.equal(store.rsUserGroups[0].period_points, 17);
  assert.equal(store.rsUserGroups[0].rs_group, snapshot.rs_group);
});

test('rank event processor keeps original payload and writes error to handle_result on failure', async () => {
  const store = {
    rsEvents: [],
  };
  let nextId = 1;

  const strapi = {
    log: {
      error() {},
      warn() {},
    },
    entityService: {
      async findOne() {
        return { id: 8, username: 'vivian' };
      },
      async create(uid, payload) {
        if (uid === 'api::rs-event.rs-event') {
          const row = { id: nextId++, ...payload.data };
          store.rsEvents.push(row);
          return row;
        }
        throw new Error(`Unexpected create uid: ${uid}`);
      },
      async update(uid, id, payload) {
        if (uid === 'api::rs-event.rs-event') {
          const row = store.rsEvents.find((event) => event.id === id);
          Object.assign(row, payload.data);
          return row;
        }
        throw new Error(`Unexpected update uid: ${uid}`);
      },
    },
  };

  const services = {
    'rank-rule-loader': {
      async loadGroupRule() {
        throw new Error('No rs_group_rule configured');
      },
      async loadLevelRule() {
        throw new Error('should not be called');
      },
      async loadPointRule() {
        throw new Error('should not be called');
      },
    },
    'rank-snapshot': {},
    'rank-level': {},
    'rank-group': {},
    'rank-user-group': {},
  };
  strapi.service = (name) => services[name];

  const processor = createEventProcessor({ strapi });

  await assert.rejects(
    processor.processEvent({
      event_id: 'evt-fail',
      event_name: 'flashcard.review',
      userid: '8',
      username: 'vivian',
      flashcard_id: 2627,
      review: {
        flashcardId: 2627,
        userId: 8,
        userName: 'vivian',
      },
      payload: {
        review: {
          flashcardId: 2627,
        },
      },
    }),
    /No rs_group_rule configured/
  );

  assert.equal(store.rsEvents.length, 1);
  assert.deepEqual(store.rsEvents[0].payload, {
    event_id: 'evt-fail',
    event_name: 'flashcard.review',
    userid: '8',
    username: 'vivian',
    flashcard_id: 2627,
    review: {
      flashcardId: 2627,
    },
  });
  assert.equal(store.rsEvents[0].status, 'failed');
  assert.equal(store.rsEvents[0].handle_result, 'No rs_group_rule configured');
});

test('rank event scenarios cover carry-forward, promotion, reassignment, and splitting', async (t) => {
  const today = getToday();
  const previousDay = shiftDate(today, -1);

  const scenarios = [
    {
      name: 'flashcard.review with no previous day record',
      eventName: 'flashcard.review',
      expected: {
        total_points: 5,
        points_add: 5,
        word_count: 0,
        word_add: 0,
        article_count: 0,
        article_add: 0,
        level_title: 'Level 1',
        group_rank_title: 'Starter',
        eventCount: 1,
      },
    },
    {
      name: 'flashcard.review with previous day record',
      eventName: 'flashcard.review',
      rsSnapshots: [
        {
          id: 1,
          userid: '8',
          username: 'vivian',
          record_date: previousDay,
          total_points: 10,
          points_add: 4,
          word_count: 2,
          word_add: 1,
          article_count: 1,
          article_add: 1,
          rs_level: 1,
          level_title: 'Level 1',
          level_change: 0,
          rs_group_rank: 20,
          rs_group: 1,
          group_rank_title: 'Starter',
          group_rank_change: 0,
        },
      ],
      rsGroups: [{ id: 1, group_no: 1, rs_group_rule: 5, rs_group_rank: 20 }],
      rsUserGroups: [{ id: 1, userid: '8', username: 'vivian', rs_group: 1, period_points: 4 }],
      expected: {
        total_points: 15,
        points_add: 5,
        word_count: 2,
        word_add: 0,
        article_count: 1,
        article_add: 0,
        level_title: 'Level 2',
        group_rank_title: 'Starter',
        rs_group: 1,
        eventCount: 1,
      },
    },
    {
      name: 'flashcard.create with no previous day record',
      eventName: 'flashcard.create',
      expected: {
        total_points: 2,
        points_add: 2,
        word_count: 1,
        word_add: 1,
        article_count: 0,
        article_add: 0,
        level_title: 'Level 1',
        group_rank_title: 'Starter',
        eventCount: 1,
      },
    },
    {
      name: 'flashcard.create with previous day record',
      eventName: 'flashcard.create',
      rsSnapshots: [
        {
          id: 1,
          userid: '8',
          username: 'vivian',
          record_date: previousDay,
          total_points: 9,
          points_add: 3,
          word_count: 4,
          word_add: 2,
          article_count: 1,
          article_add: 1,
          rs_level: 1,
          level_title: 'Level 1',
          level_change: 0,
          rs_group_rank: 20,
          rs_group: 1,
          group_rank_title: 'Starter',
          group_rank_change: 0,
        },
      ],
      rsGroups: [{ id: 1, group_no: 1, rs_group_rule: 5, rs_group_rank: 20 }],
      rsUserGroups: [{ id: 1, userid: '8', username: 'vivian', rs_group: 1, period_points: 3 }],
      expected: {
        total_points: 11,
        points_add: 2,
        word_count: 5,
        word_add: 1,
        article_count: 1,
        article_add: 0,
        level_title: 'Level 2',
        group_rank_title: 'Starter',
        rs_group: 1,
        eventCount: 1,
      },
    },
    {
      name: 'flashcard.tier promote with no previous day record',
      eventName: 'flashcard.review_tier_promote',
      expected: {
        total_points: 7,
        points_add: 7,
        word_count: 0,
        word_add: 0,
        article_count: 0,
        article_add: 0,
        level_title: 'Level 1',
        group_rank_title: 'Starter',
        eventCount: 1,
      },
    },
    {
      name: 'flashcard.tier promote with previous day record',
      eventName: 'flashcard.review_tier_promote',
      rsSnapshots: [
        {
          id: 1,
          userid: '8',
          username: 'vivian',
          record_date: previousDay,
          total_points: 6,
          points_add: 3,
          word_count: 1,
          word_add: 1,
          article_count: 0,
          article_add: 0,
          rs_level: 1,
          level_title: 'Level 1',
          level_change: 0,
          rs_group_rank: 20,
          rs_group: 1,
          group_rank_title: 'Starter',
          group_rank_change: 0,
        },
      ],
      rsGroups: [{ id: 1, group_no: 1, rs_group_rule: 5, rs_group_rank: 20 }],
      rsUserGroups: [{ id: 1, userid: '8', username: 'vivian', rs_group: 1, period_points: 3 }],
      expected: {
        total_points: 13,
        points_add: 7,
        word_count: 1,
        word_add: 0,
        article_count: 0,
        article_add: 0,
        level_title: 'Level 2',
        group_rank_title: 'Active',
        rs_group_rank: 21,
        eventCount: 1,
      },
    },
    {
      name: 'article.create with no previous day record',
      eventName: 'article.create',
      expected: {
        total_points: 3,
        points_add: 3,
        word_count: 0,
        word_add: 0,
        article_count: 1,
        article_add: 1,
        level_title: 'Level 1',
        group_rank_title: 'Starter',
        eventCount: 1,
      },
    },
    {
      name: 'article.create with previous day record',
      eventName: 'article.create',
      rsSnapshots: [
        {
          id: 1,
          userid: '8',
          username: 'vivian',
          record_date: previousDay,
          total_points: 8,
          points_add: 2,
          word_count: 1,
          word_add: 1,
          article_count: 2,
          article_add: 1,
          rs_level: 1,
          level_title: 'Level 1',
          level_change: 0,
          rs_group_rank: 20,
          rs_group: 1,
          group_rank_title: 'Starter',
          group_rank_change: 0,
        },
      ],
      rsGroups: [{ id: 1, group_no: 1, rs_group_rule: 5, rs_group_rank: 20 }],
      rsUserGroups: [{ id: 1, userid: '8', username: 'vivian', rs_group: 1, period_points: 2 }],
      expected: {
        total_points: 11,
        points_add: 3,
        word_count: 1,
        word_add: 0,
        article_count: 3,
        article_add: 1,
        level_title: 'Level 2',
        group_rank_title: 'Starter',
        rs_group: 1,
        eventCount: 1,
      },
    },
    {
      name: 'flashcard.review with previous day record increases group rank and reassigns group',
      eventName: 'flashcard.review',
      rsSnapshots: [
        {
          id: 1,
          userid: '8',
          username: 'vivian',
          record_date: previousDay,
          total_points: 8,
          points_add: 6,
          word_count: 2,
          word_add: 1,
          article_count: 0,
          article_add: 0,
          rs_level: 1,
          level_title: 'Level 1',
          level_change: 0,
          rs_group_rank: 20,
          rs_group: 1,
          group_rank_title: 'Starter',
          group_rank_change: 0,
        },
      ],
      rsGroups: [
        { id: 1, group_no: 1, rs_group_rule: 5, rs_group_rank: 20 },
        { id: 2, group_no: 2, rs_group_rule: 5, rs_group_rank: 21 },
      ],
      rsUserGroups: [{ id: 1, userid: '8', username: 'vivian', rs_group: 1, period_points: 6 }],
      expected: {
        total_points: 13,
        points_add: 5,
        word_count: 2,
        word_add: 0,
        article_count: 0,
        article_add: 0,
        level_title: 'Level 2',
        group_rank_title: 'Active',
        rs_group: 2,
        rs_group_rank: 21,
        group_rank_change: 1,
        eventCount: 1,
        userGroupPeriodPoints: 11,
      },
    },
    {
      name: 'flashcard.review with previous day record increases group rank, assigns a new group, and splits it',
      eventName: 'flashcard.review',
      rsSnapshots: [
        {
          id: 1,
          userid: '8',
          username: 'vivian',
          record_date: previousDay,
          total_points: 8,
          points_add: 6,
          word_count: 2,
          word_add: 1,
          article_count: 0,
          article_add: 0,
          rs_level: 1,
          level_title: 'Level 1',
          level_change: 0,
          rs_group_rank: 20,
          rs_group: 1,
          group_rank_title: 'Starter',
          group_rank_change: 0,
        },
      ],
      rsGroups: [
        { id: 1, group_no: 1, rs_group_rule: 5, rs_group_rank: 20 },
        { id: 2, group_no: 2, rs_group_rule: 5, rs_group_rank: 21 },
      ],
      rsUserGroups: [
        { id: 1, userid: '8', username: 'vivian', rs_group: 1, period_points: 6 },
        { id: 2, userid: '18', username: 'u18', rs_group: 2, period_points: 20 },
        { id: 3, userid: '28', username: 'u28', rs_group: 2, period_points: 19 },
        { id: 4, userid: '38', username: 'u38', rs_group: 2, period_points: 18 },
        { id: 5, userid: '48', username: 'u48', rs_group: 2, period_points: 17 },
      ],
      expected: {
        total_points: 13,
        points_add: 5,
        word_count: 2,
        word_add: 0,
        article_count: 0,
        article_add: 0,
        level_title: 'Level 2',
        group_rank_title: 'Active',
        rs_group: 2,
        rs_group_rank: 21,
        group_rank_change: 1,
        eventCount: 1,
        userGroupPeriodPoints: 11,
        groupCount: 3,
        splitGroupRank: 21,
      },
    },
  ];

  for (const [index, scenario] of scenarios.entries()) {
    await t.test(scenario.name, async () => {
      const harness = createRankHarness({
        rsSnapshots: scenario.rsSnapshots || [],
        rsUserGroups: scenario.rsUserGroups || [],
        rsGroups: scenario.rsGroups || [],
        nextId: 100 + index * 20,
      });

      await harness.publishEvent({
        eventName: scenario.eventName,
        eventId: `scenario-${index + 1}`,
      });

      assert.equal(harness.store.rsEvents.length, scenario.expected.eventCount);
      assert.ok(harness.store.rsEvents.every((event) => event.status === 'handled'));
      assert.ok(harness.store.rsEvents.every((event) => event.userid === '8'));
      assert.ok(harness.store.rsEvents.every((event) => event.username === 'vivian'));
      assert.equal(harness.store.rsSnapshots.length, (scenario.rsSnapshots?.length || 0) + 1);

      const todaySnapshot = harness.store.rsSnapshots.find((row) => row.record_date === today && row.userid === '8');
      assert.ok(todaySnapshot);
      assert.equal(todaySnapshot.total_points, scenario.expected.total_points);
      assert.equal(todaySnapshot.points_add, scenario.expected.points_add);
      assert.equal(todaySnapshot.word_count, scenario.expected.word_count);
      assert.equal(todaySnapshot.word_add, scenario.expected.word_add);
      assert.equal(todaySnapshot.article_count, scenario.expected.article_count);
      assert.equal(todaySnapshot.article_add, scenario.expected.article_add);
      assert.equal(todaySnapshot.level_title, scenario.expected.level_title);
      assert.equal(todaySnapshot.group_rank_title, scenario.expected.group_rank_title);

      if (scenario.expected.rs_group !== undefined) {
        assert.equal(todaySnapshot.rs_group, scenario.expected.rs_group);
      }
      if (scenario.expected.rs_group_rank !== undefined) {
        assert.equal(todaySnapshot.rs_group_rank, scenario.expected.rs_group_rank);
      }
      if (scenario.expected.group_rank_change !== undefined) {
        assert.equal(todaySnapshot.group_rank_change, scenario.expected.group_rank_change);
      }

      const userGroup = harness.store.rsUserGroups.find((row) => row.userid === '8');
      assert.ok(userGroup);
      assert.equal(userGroup.username, 'vivian');
      assert.equal(userGroup.rs_group, scenario.expected.rs_group || todaySnapshot.rs_group);
      if (scenario.expected.userGroupPeriodPoints !== undefined) {
        assert.equal(userGroup.period_points, scenario.expected.userGroupPeriodPoints);
      }

      if (scenario.expected.groupCount !== undefined) {
        assert.equal(harness.store.rsGroups.length, scenario.expected.groupCount);
        const splitGroups = harness.store.rsGroups.filter((row) => row.rs_group_rank === scenario.expected.splitGroupRank);
        assert.equal(splitGroups.length, 2);
        assert.ok(splitGroups.some((row) => row.id !== scenario.expected.rs_group));
      }
    });
  }
});

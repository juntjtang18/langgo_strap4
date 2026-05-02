'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const createEventProcessor = require('../src/services/rank/event-processor');
const createGroupService = require('../src/services/rank/group-service');
const createUserGroupService = require('../src/services/rank/user-group-service');

test('rank-user-group upsert creates a row when none exists', async () => {
  const calls = [];
  const strapi = {
    entityService: {
      async findMany(uid, query) {
        calls.push({ op: 'findMany', uid, query });
        return [];
      },
      async create(uid, payload) {
        calls.push({ op: 'create', uid, payload });
        return { id: 11, ...payload.data };
      },
      async update() {
        throw new Error('update should not be called');
      },
    },
  };

  const service = createUserGroupService({ strapi });
  const result = await service.upsertUserGroup(8, 3);

  assert.equal(result.id, 11);
  assert.equal(calls.length, 2);
  assert.equal(calls[1].op, 'create');
  assert.equal(calls[1].uid, 'api::rs-user-group.rs-user-group');
  assert.deepEqual(calls[1].payload.data, {
    userid: '8',
    rs_group: 3,
  });
});

test('rank-user-group upsert skips update when the stored group is already current', async () => {
  const calls = [];
  const existing = { id: 21, userid: '8', rs_group: { id: 3 } };
  const strapi = {
    entityService: {
      async findMany(uid, query) {
        calls.push({ op: 'findMany', uid, query });
        return [existing];
      },
      async create() {
        throw new Error('create should not be called');
      },
      async update() {
        throw new Error('update should not be called');
      },
    },
  };

  const service = createUserGroupService({ strapi });
  const result = await service.upsertUserGroup(8, 3);

  assert.equal(result, existing);
  assert.equal(calls.length, 1);
});

test('rank event processor upserts rs_user_group during user.register', async () => {
  const serviceCalls = [];
  const entityCalls = [];

  const mockServices = {
    'rank-rule-loader': {
      async loadGroupRule() {
        return { id: 5, group_size: 10 };
      },
      async loadGroupRanks() {
        return [{ id: 91, rank_no: 1 }];
      },
      async findOrCreateLevel(levelNo) {
        return { id: 101, level_no: levelNo };
      },
    },
    'rank-snapshot': {
      async userExists(userid) {
        serviceCalls.push(['userExists', userid]);
        return false;
      },
      async createInitialSnapshot(userid, groupId, groupRankId, levelId) {
        serviceCalls.push(['createInitialSnapshot', userid, groupId, groupRankId, levelId]);
        return { id: 301 };
      },
    },
    'rank-level': {},
    'rank-group': {
      async assignUserToRankedGroup(userid, groupRuleId, groupRankId, groupSize) {
        serviceCalls.push(['assignUserToRankedGroup', userid, groupRuleId, groupRankId, groupSize]);
        return { id: 77 };
      },
    },
    'rank-user-group': {
      async upsertUserGroup(userid, groupId) {
        serviceCalls.push(['upsertUserGroup', userid, groupId]);
        return { id: 401 };
      },
    },
  };

  const strapi = {
    service(name) {
      return mockServices[name];
    },
    entityService: {
      async findMany(uid, query) {
        entityCalls.push(['findMany', uid, query]);
        if (uid === 'api::rs-event.rs-event') {
          return [];
        }
        throw new Error(`Unexpected findMany uid: ${uid}`);
      },
      async create(uid, payload) {
        entityCalls.push(['create', uid, payload]);
        if (uid === 'api::rs-event.rs-event') {
          return { id: 501 };
        }
        throw new Error(`Unexpected create uid: ${uid}`);
      },
      async update(uid, id, payload) {
        entityCalls.push(['update', uid, id, payload]);
        if (uid === 'api::rs-event.rs-event') {
          return { id };
        }
        throw new Error(`Unexpected update uid: ${uid}`);
      },
    },
    log: {
      info() {},
      error() {},
    },
  };

  const processor = createEventProcessor({ strapi });
  const result = await processor.processEvent({
    event_id: 'evt-register-1',
    event_name: 'user.register',
    userid: '8',
    payload: {},
  });

  assert.deepEqual(result, { registered: true });
  assert.deepEqual(serviceCalls, [
    ['userExists', '8'],
    ['assignUserToRankedGroup', '8', 5, 91, 10],
    ['upsertUserGroup', '8', 77],
    ['createInitialSnapshot', '8', 77, 91, 101],
  ]);

  const handledUpdate = entityCalls.find((call) => call[0] === 'update' && call[1] === 'api::rs-event.rs-event');
  assert.ok(handledUpdate);
  assert.equal(handledUpdate[3].data.status, 'handled');
});

test('rank event processor upserts rs_user_group for the current group on normal events', async () => {
  const serviceCalls = [];
  const updateCalls = [];

  const snapshot = {
    id: 601,
    total_points: 100,
    points_add: 2,
    word_count: 7,
    word_add: 1,
    article_count: 3,
    article_add: 1,
    rs_level: { id: 33, level_no: 3 },
    rs_group: { id: 44 },
    rs_group_rank: { id: 55, rank_no: 2 },
  };
  const sameRank = { id: 55, rank_no: 2, min_period_points: 50 };

  const mockServices = {
    'rank-rule-loader': {
      async loadGroupRule() {
        return { id: 5, group_size: 10, period_days: 7 };
      },
      async loadGroupRanks() {
        return [sameRank];
      },
      async loadLevelRule() {
        return { id: 6 };
      },
      async loadPointRule(eventName) {
        assert.equal(eventName, 'flashcard.create');
        return { points: 5 };
      },
      async findOrCreateLevel(levelNo) {
        return { id: 701, level_no: levelNo };
      },
    },
    'rank-snapshot': {
      async userExists(userid) {
        serviceCalls.push(['userExists', userid]);
        return true;
      },
      async getTodaySnapshot(userid) {
        serviceCalls.push(['getTodaySnapshot', userid]);
        return snapshot;
      },
      async getPeriodPoints(userid, periodDays) {
        serviceCalls.push(['getPeriodPoints', userid, periodDays]);
        return 50;
      },
      async updateSnapshot(snapshotId, data) {
        updateCalls.push(['updateSnapshot', snapshotId, data]);
        return { id: snapshotId };
      },
    },
    'rank-level': {
      calculateLevel(totalPoints, currentLevelNo) {
        serviceCalls.push(['calculateLevel', totalPoints, currentLevelNo]);
        return 4;
      },
    },
    'rank-group': {
      getGroupRankForPoints(periodPoints, groupRanks) {
        serviceCalls.push(['getGroupRankForPoints', periodPoints, groupRanks]);
        return sameRank;
      },
      async assignUserToRankedGroup() {
        throw new Error('assignUserToRankedGroup should not be called when rank is unchanged');
      },
    },
    'rank-user-group': {
      async upsertUserGroup(userid, groupId) {
        serviceCalls.push(['upsertUserGroup', userid, groupId]);
        return { id: 801 };
      },
    },
  };

  const strapi = {
    service(name) {
      return mockServices[name];
    },
    entityService: {
      async findMany(uid) {
        if (uid === 'api::rs-event.rs-event') {
          return [];
        }
        throw new Error(`Unexpected findMany uid: ${uid}`);
      },
      async create(uid) {
        if (uid === 'api::rs-event.rs-event') {
          return { id: 901 };
        }
        throw new Error(`Unexpected create uid: ${uid}`);
      },
      async update(uid, id, payload) {
        if (uid === 'api::rs-event.rs-event') {
          return { id, ...payload.data };
        }
        throw new Error(`Unexpected update uid: ${uid}`);
      },
    },
    log: {
      info() {},
      error() {},
    },
  };

  const processor = createEventProcessor({ strapi });
  const result = await processor.processEvent({
    event_id: 'evt-normal-1',
    event_name: 'flashcard.create',
    userid: '8',
    payload: { flashcardId: 99 },
  });

  assert.equal(result.userid, '8');
  assert.equal(result.totalPoints, 105);
  assert.equal(result.level, 4);
  assert.equal(result.groupRankNo, 2);
  assert.deepEqual(serviceCalls, [
    ['userExists', '8'],
    ['getTodaySnapshot', '8'],
    ['calculateLevel', 105, 3],
    ['getPeriodPoints', '8', 7],
    ['getGroupRankForPoints', 55, [sameRank]],
    ['upsertUserGroup', '8', 44],
  ]);
  assert.equal(updateCalls.length, 1);
  assert.deepEqual(updateCalls[0][2], {
    points_add: 7,
    word_count: 8,
    word_add: 2,
    article_count: 3,
    article_add: 1,
    total_points: 105,
    level_change: 1,
    group_rank_change: 0,
    rs_level: 701,
    rs_group: 44,
    rs_group_rank: 55,
  });
});

test('rank group split updates rs_user_group for every moved user', async () => {
  const movedSnapshots = [];
  const movedUserGroups = [];

  const strapi = {
    service(name) {
      if (name === 'rank-snapshot') {
        return {
          async moveUserToGroup(userid, groupId) {
            movedSnapshots.push([userid, groupId]);
          },
        };
      }
      if (name === 'rank-user-group') {
        return {
          async upsertUserGroup(userid, groupId) {
            movedUserGroups.push([userid, groupId]);
          },
        };
      }
      throw new Error(`Unexpected service: ${name}`);
    },
    entityService: {
      async findMany() {
        throw new Error('findMany should not be called in this test');
      },
      async create() {
        throw new Error('create should not be called in this test');
      },
    },
    db: {
      connection: {
        async raw() {
          throw new Error('raw should not be called in this test');
        },
      },
    },
  };

  const service = createGroupService({ strapi });
  service.getCurrentMembersOfGroup = async () => ['u1', 'u2', 'u3', 'u4', 'u5'];
  service.createGroup = async () => ({ id: 321 });

  const newGroup = await service.splitGroup(10, 20, 30);

  assert.deepEqual(newGroup, { id: 321 });
  assert.deepEqual(movedSnapshots, [
    ['u2', 321],
    ['u4', 321],
  ]);
  assert.deepEqual(movedUserGroups, [
    ['u2', 321],
    ['u4', 321],
  ]);
});

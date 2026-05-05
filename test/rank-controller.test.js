'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const rankController = require('../src/plugins/rank-system/server/controllers/rank');

function createCtx(userId = 60) {
  return {
    state: {
      user: userId ? { id: userId } : null,
    },
    query: {},
    body: null,
    unauthorizedMessage: null,
    notFoundMessage: null,
    unauthorized(message) {
      this.unauthorizedMessage = message;
      return message;
    },
    notFound(message) {
      this.notFoundMessage = message;
      return message;
    },
  };
}

test('rank controller getMyLeaderboard returns current group summary and ordered members', async () => {
  global.strapi = {
    plugin(name) {
      assert.equal(name, 'rank-system');
      return {
        service(serviceName) {
          if (serviceName === 'user-group') {
            return {
              async getByUserid(userid) {
                assert.equal(userid, 60);
                return {
                  id: 1,
                  userid: '60',
                  username: 'James',
                  period_points: 146,
                  rs_group: { id: 1 },
                };
              },
              async listByGroup(groupId) {
                assert.equal(groupId, 1);
                return [
                  { id: 2, userid: '72', username: 'Vivian', period_points: 120 },
                  { id: 1, userid: '60', username: 'James', period_points: 146 },
                  { id: 3, userid: '80', username: 'Aaron', period_points: 120 },
                ];
              },
            };
          }

          throw new Error(`Unexpected plugin service ${serviceName}`);
        },
      };
    },
    entityService: {
      async findMany(uid, query) {
        if (uid === 'api::user-profile.user-profile') {
          assert.deepEqual(query, {
            filters: { user: 60 },
            fields: ['id', 'baseLanguage'],
            limit: 1,
          });
          return [{ id: 10, baseLanguage: 'en' }];
        }

        if (uid === 'plugin::rank-system.rs-group-rank-title') {
          assert.deepEqual(query, {
            filters: { rs_group_rank: { id: 20 } },
            locale: 'en',
            fields: ['title', 'locale'],
            limit: 1,
          });
          return [{ title: 'Starter', locale: 'en' }];
        }

        throw new Error(`Unexpected findMany uid ${uid}`);
      },

      async findOne(uid, id, query) {
        assert.equal(uid, 'plugin::rank-system.rs-group');
        assert.equal(id, 1);
        assert.deepEqual(query, {
          fields: ['id', 'group_no'],
          populate: {
            rs_group_rank: {
              fields: ['id', 'rank_no'],
            },
          },
        });
        return {
          id: 1,
          group_no: 1,
          rs_group_rank: { id: 20, rank_no: 1 },
        };
      },
    },
  };

  const ctx = createCtx(60);
  await rankController.getMyLeaderboard(ctx);

  assert.deepEqual(ctx.body, {
    data: {
      group: {
        group_id: 1,
        group_no: 1,
        group_rank: 1,
        group_rank_title: 'Starter',
        member_count: 3,
      },
      members: [
        {
          userid: '60',
          username: 'James',
          period_points: 146,
          order_in_group: 1,
        },
        {
          userid: '72',
          username: 'Vivian',
          period_points: 120,
          order_in_group: 2,
        },
        {
          userid: '80',
          username: 'Aaron',
          period_points: 120,
          order_in_group: 3,
        },
      ],
    },
  });
});

test('rank controller getMyLeaderboard returns empty payload when the user has no group', async () => {
  global.strapi = {
    plugin(name) {
      assert.equal(name, 'rank-system');
      return {
        service(serviceName) {
          if (serviceName === 'user-group') {
            return {
              async getByUserid(userid) {
                assert.equal(userid, 60);
                return null;
              },
            };
          }

          throw new Error(`Unexpected plugin service ${serviceName}`);
        },
      };
    },
    entityService: {
      async findMany(uid) {
        assert.equal(uid, 'api::user-profile.user-profile');
        return [{ id: 10, baseLanguage: 'en' }];
      },
    },
  };

  const ctx = createCtx(60);
  await rankController.getMyLeaderboard(ctx);

  assert.deepEqual(ctx.body, {
    data: {
      group: null,
      members: [],
    },
  });
});

test('rank controller getMeStatus returns period points from the latest snapshot', async () => {
  global.strapi = {
    plugin(name) {
      assert.equal(name, 'rank-system');
      return {
        service(serviceName) {
          if (serviceName === 'rule-loader') {
            return {
              async loadGroupRule() {
                return { id: 5, period_days: 14 };
              },
            };
          }
          if (serviceName === 'snapshot') {
            return {
              async getPeriodPoints(userid, periodDays, date) {
                assert.equal(userid, '60');
                assert.equal(periodDays, 14);
                const dateString = date.toISOString().slice(0, 10);
                if (dateString === '2026-05-02') return 13;
                if (dateString === '2026-05-01') return 9;
                throw new Error(`Unexpected getPeriodPoints date ${dateString}`);
              },
              async getPreviousSnapshot(userid, date) {
                assert.equal(userid, '60');
                assert.equal(date.toISOString().slice(0, 10), '2026-05-02');
                return {
                  id: 16,
                  userid: '60',
                  record_date: '2026-05-01',
                  period_points: null,
                };
              },
            };
          }

          throw new Error(`Unexpected plugin service ${serviceName}`);
        },
      };
    },
    entityService: {
      async findMany(uid, query) {
        if (uid === 'api::user-profile.user-profile') {
          assert.deepEqual(query, {
            filters: { user: 60 },
            fields: ['id', 'baseLanguage'],
            limit: 1,
          });
          return [{ id: 10, baseLanguage: 'en' }];
        }

        if (uid === 'plugin::rank-system.rs-user-snapshot') {
          assert.deepEqual(query, {
            filters: { userid: '60' },
            fields: [
              'id',
              'userid',
              'record_date',
              'total_points',
              'points_add',
              'word_count',
              'word_add',
              'article_count',
              'article_add',
              'group_rank_change',
              'level_change',
              'level_title',
              'group_rank_title',
              'period_points',
              'period_points_change',
            ],
            populate: {
              rs_group: {
                fields: ['id', 'group_no'],
                populate: {
                  rs_group_rank: {
                    fields: ['id', 'rank_no'],
                  },
                },
              },
              rs_group_rank: {
                fields: ['id', 'rank_no'],
              },
              rs_level: {
                fields: ['id', 'level_no'],
              },
            },
            sort: [{ record_date: 'desc' }, { id: 'desc' }],
            limit: 1,
          });
          return [{
            id: 15,
            userid: '60',
            record_date: '2026-05-02',
            total_points: 320,
            points_add: 12,
            word_count: 30,
            word_add: 2,
            article_count: 8,
            article_add: 1,
            level_change: 1,
            level_title: 'Level 3',
            group_rank_change: 1,
            group_rank_title: 'Starter',
            period_points: null,
            period_points_change: null,
            rs_group: {
              id: 1,
              group_no: 1,
              rs_group_rank: { id: 20, rank_no: 1 },
            },
            rs_group_rank: { id: 20, rank_no: 1 },
            rs_level: { id: 3, level_no: 3 },
          }];
        }

        if (uid === 'plugin::rank-system.rs-level-title') {
          return [{ title: 'Level 3', locale: 'en' }];
        }

        if (uid === 'plugin::rank-system.rs-group-rank-title') {
          return [{ title: 'Starter', locale: 'en' }];
        }

        if (uid === 'plugin::rank-system.rs-user-snapshot' && query.fields?.length === 1 && query.fields[0] === 'points_add') {
          throw new Error('Expected rank-snapshot service to be stubbed instead of direct points_add lookup');
        }

        throw new Error(`Unexpected findMany uid ${uid}`);
      },
    },
  };

  const ctx = createCtx(60);
  await rankController.getMeStatus(ctx);

  assert.equal(ctx.body.data.latest_snapshot.id, 15);
  assert.equal(ctx.body.data.latest_snapshot.record_date, '2026-05-02');
  assert.equal(ctx.body.data.latest_snapshot.period_points, 13);
  assert.equal(ctx.body.data.latest_snapshot.period_points_change, 4);
  assert.equal(ctx.body.data.latest_snapshot.group_rank, 1);
  assert.equal(ctx.body.data.latest_snapshot.level_no, 3);
});

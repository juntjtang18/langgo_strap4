'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const rankController = require('../src/api/rank/controllers/rank');

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
    service(name) {
      if (name === 'rank-user-group') {
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

      throw new Error(`Unexpected service ${name}`);
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

        if (uid === 'api::rs-group-rank-title.rs-group-rank-title') {
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
        assert.equal(uid, 'api::rs-group.rs-group');
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
    service(name) {
      if (name === 'rank-user-group') {
        return {
          async getByUserid(userid) {
            assert.equal(userid, 60);
            return null;
          },
        };
      }

      throw new Error(`Unexpected service ${name}`);
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

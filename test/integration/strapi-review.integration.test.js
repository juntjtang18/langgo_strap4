'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const { createStrapi, destroyStrapi } = require('../helpers/strapi');

let app;
let reviewTiers;

const createTier = async (data) => {
  return app.entityService.create('api::review-tire.review-tire', {
    data: {
      locale: 'en',
      ...data,
    },
  });
};

const createAuthenticatedUser = async () => {
  const role = await app.query('plugin::users-permissions.role').findOne({
    where: { type: 'authenticated' },
  });

  return app.plugin('users-permissions').service('user').add({
    username: `ci-user-${Date.now()}-${Math.floor(Math.random() * 10000)}`,
    email: `ci-user-${Date.now()}-${Math.floor(Math.random() * 10000)}@example.com`,
    password: 'Passw0rd!',
    provider: 'local',
    confirmed: true,
    blocked: false,
    role: role.id,
  });
};

const cleanupTestData = async () => {
  await app.db.query('api::reviewlog.reviewlog').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::flashcard.flashcard').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::user-profile.user-profile').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('plugin::users-permissions.user').deleteMany({
    where: {
      email: { $contains: 'ci-user-' },
    },
  });
};

const makeCtx = (user, flashcardId, result) => ({
  state: { user },
  params: { id: String(flashcardId) },
  request: { body: { result } },
  unauthorized(message) {
    throw new Error(`unauthorized: ${message}`);
  },
  badRequest(message) {
    throw new Error(`badRequest: ${message}`);
  },
  internalServerError(message) {
    throw new Error(`internalServerError: ${message}`);
  },
});

test.before(async () => {
  app = await createStrapi();

  reviewTiers = {
    new: await createTier({
      tier: 'new',
      min_streak: 0,
      max_streak: 0,
      cooldown_hours: 0,
      demote_bar: 2,
    }),
    warmup: await createTier({
      tier: 'warmup',
      min_streak: 1,
      max_streak: 2,
      cooldown_hours: 24,
      demote_bar: 2,
    }),
    weekly: await createTier({
      tier: 'weekly',
      min_streak: 3,
      max_streak: 6,
      cooldown_hours: 168,
      demote_bar: 2,
    }),
  };
});

test.after(async () => {
  await cleanupTestData();
  await app.db.query('api::review-tire.review-tire').deleteMany({ where: { id: { $gt: 0 } } });
  await destroyStrapi(app);
});

test.afterEach(async () => {
  await cleanupTestData();
});

test('boots Strapi and exposes the flashcard review controller', async () => {
  const controller = app.controller('api::flashcard.flashcard');

  assert.ok(controller);
  assert.equal(typeof controller.review, 'function');
  assert.equal(app.contentType('api::reviewlog.reviewlog').attributes.effective.type, 'boolean');
  assert.equal(app.contentType('api::reviewlog.reviewlog').attributes.newlevel.type, 'enumeration');
});

test('review action publishes a reviewlog event when configured', async () => {
  const originalTopic = process.env.REVIEWLOG_EVENTS_TOPIC;
  process.env.REVIEWLOG_EVENTS_TOPIC = 'pointserver-reviewlogs';

  const user = await createAuthenticatedUser();
  const flashcard = await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      correct_streak: 0,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.new.id,
    },
  });

  const pubsubService = app.service('pubsub');
  const originalPublishJson = pubsubService.publishJson;
  const published = [];
  pubsubService.publishJson = async (...args) => {
    published.push(args);
    return 'message-1';
  };

  try {
    const controller = app.controller('api::flashcard.flashcard');
    await controller.review(makeCtx(user, flashcard.id, 'correct'));

    assert.equal(published.length, 1);
    assert.equal(published[0][0], 'pointserver-reviewlogs');
    assert.equal(published[0][1].event, 'reviewlog.created');
    assert.equal(published[0][1].reviewlog.result, 'correct');
    assert.equal(published[0][1].reviewlog.flashcard_id, String(flashcard.id));
    assert.equal(published[0][1].reviewlog.user.id, String(user.id));
    assert.equal(published[0][1].reviewlog.user.username, user.username);
    assert.equal(published[0][2].eventType, 'reviewlog.created');
    assert.equal(published[0][2].source, 'langgo-strapi4');
  } finally {
    pubsubService.publishJson = originalPublishJson;
    if (originalTopic === undefined) {
      delete process.env.REVIEWLOG_EVENTS_TOPIC;
    } else {
      process.env.REVIEWLOG_EVENTS_TOPIC = originalTopic;
    }
  }
});

test('review action writes reviewlog effective and newlevel from real Strapi flow', async () => {
  const user = await createAuthenticatedUser();

  const flashcard = await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      correct_streak: 0,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.new.id,
    },
  });

  const controller = app.controller('api::flashcard.flashcard');
  await controller.review(makeCtx(user, flashcard.id, 'correct'));

  const updatedFlashcard = await app.entityService.findOne('api::flashcard.flashcard', flashcard.id, {
    populate: { review_tire: true },
  });

  const reviewlogs = await app.entityService.findMany('api::reviewlog.reviewlog', {
    filters: { flashcard: flashcard.id },
    sort: { reviewed_at: 'desc' },
  });

  assert.equal(updatedFlashcard.correct_streak, 1);
  assert.equal(updatedFlashcard.wrong_streak, 0);
  assert.equal(updatedFlashcard.review_tire.tier, 'warmup');

  assert.equal(reviewlogs.length, 1);
  assert.equal(reviewlogs[0].result, 'correct');
  assert.equal(reviewlogs[0].level, 'new');
  assert.equal(reviewlogs[0].effective, true);
  assert.equal(reviewlogs[0].newlevel, 'warmup');
});

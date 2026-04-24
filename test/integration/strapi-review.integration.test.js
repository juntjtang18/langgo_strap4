'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const { createStrapi, destroyStrapi } = require('../helpers/strapi');

let app;
let reviewTiers;
let pointRule;
let honorTitleRule;
let honorTitles;
let groupRanks;
let pointGroupRule;
let seededPointGroups;

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

  const user = await app.plugin('users-permissions').service('user').add({
    username: `ci-user-${Date.now()}-${Math.floor(Math.random() * 10000)}`,
    email: `ci-user-${Date.now()}-${Math.floor(Math.random() * 10000)}@example.com`,
    password: 'Passw0rd!',
    provider: 'local',
    confirmed: true,
    blocked: false,
    role: role.id,
  });

  await app.entityService.create('api::user-profile.user-profile', {
    data: {
      user: user.id,
      baseLanguage: 'en',
      visible_on_ladder: true,
    },
  });

  return user;
};

const cleanupTestData = async () => {
  await app.db.query('api::reviewlog.reviewlog').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::flashcard-stat.flashcard-stat').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::user-point.user-point').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::user-point-group.user-point-group').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::flashcard.flashcard').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::vbsetting.vbsetting').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::user-article.user-article').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::article-tag.article-tag').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::word-definition.word-definition').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::part-of-speech.part-of-speech').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::word.word').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::user-profile.user-profile').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('plugin::users-permissions.user').deleteMany({
    where: {
      $or: [
        { email: { $contains: 'ci-user-' } },
        { email: { $contains: 'register-flashcard-stat-' } },
      ],
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

const makeStatsCtx = (user) => ({
  state: { user },
  body: null,
  send(payload) {
    this.body = payload;
    return payload;
  },
  unauthorized(message) {
    throw new Error(`unauthorized: ${message}`);
  },
  internalServerError(message) {
    throw new Error(`internalServerError: ${message}`);
  },
});

const makeRegisterWithProfileCtx = (body) => ({
  request: { body },
  state: {},
  body: null,
  send(payload) {
    this.body = payload;
    return payload;
  },
});

const makeWordDefinitionCreateCtx = (user, data) => ({
  state: { user },
  request: { body: { data } },
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

const makeUserArticleCreateCtx = (user, data) => ({
  state: { user },
  request: { body: { data } },
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

const makeUserPointLatestCtx = (user, query = {}) => ({
  state: { user },
  query,
  unauthorized(message) {
    throw new Error(`unauthorized: ${message}`);
  },
  badRequest(message) {
    throw new Error(`badRequest: ${message}`);
  },
  forbidden(message) {
    throw new Error(`forbidden: ${message}`);
  },
});

const makeFindForReviewCtx = (user, query = {}) => ({
  state: { user },
  query,
  unauthorized(message) {
    throw new Error(`unauthorized: ${message}`);
  },
  internalServerError(message) {
    throw new Error(`internalServerError: ${message}`);
  },
});

const makePointGroupMineCtx = (user) => ({
  state: { user },
  unauthorized(message) {
    throw new Error(`unauthorized: ${message}`);
  },
});

const makePointGroupLeaderboardCtx = (user, groupId) => ({
  state: { user },
  params: { id: String(groupId) },
  unauthorized(message) {
    throw new Error(`unauthorized: ${message}`);
  },
  badRequest(message) {
    throw new Error(`badRequest: ${message}`);
  },
  notFound(message) {
    throw new Error(`notFound: ${message}`);
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

  pointRule = await app.entityService.create('api::point-rule.point-rule', {
    data: {
      review_point: 1,
      review_tier_up_point: 2,
      new_word_point: 1,
      article_point: 1,
    },
  });

  honorTitleRule = await app.entityService.create('api::honer-title-rule.honer-title-rule', {
    data: {
      base_points: 1,
      increase_points: 2,
    },
  });

  honorTitles = {
    bronze: await app.entityService.create('api::honor-title.honor-title', {
      data: {
        locale: 'en',
        title: 'Bronze',
      },
    }),
    silver: await app.entityService.create('api::honor-title.honor-title', {
      data: {
        locale: 'en',
        title: 'Silver',
      },
    }),
  };

  groupRanks = {
    starter: await app.entityService.create('api::group-rank.group-rank', {
      data: {
        locale: 'en',
        title: 'Starter',
        min_period_points: 0,
      },
    }),
    active: await app.entityService.create('api::group-rank.group-rank', {
      data: {
        locale: 'en',
        title: 'Active',
        min_period_points: 3,
      },
    }),
    learner: await app.entityService.create('api::group-rank.group-rank', {
      data: {
        locale: 'en',
        title: 'Learner',
        min_period_points: 280,
      },
    }),
  };

  pointGroupRule = await app.entityService.create('api::point-group-rule.point-group-rule', {
    data: {
      period_days: 7,
      group_size: 1,
    },
  });

  seededPointGroups = {
    starter: await app.entityService.create('api::point-group.point-group', {
      data: {
        group_rank: groupRanks.starter.id,
        group_no: 1,
      },
    }),
    active: await app.entityService.create('api::point-group.point-group', {
      data: {
        group_rank: groupRanks.active.id,
        group_no: 1,
      },
    }),
  };
});

test.after(async () => {
  await cleanupTestData();
  await app.db.query('api::point-group.point-group').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::point-group-rule.point-group-rule').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::group-rank.group-rank').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::honer-title-rule.honer-title-rule').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::honor-title.honor-title').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::point-rule.point-rule').deleteMany({ where: { id: { $gt: 0 } } });
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
  assert.ok(app.service('review-event-queue'));
  assert.equal(typeof app.service('review-event-queue').dispatchReviewCompleted, 'function');
  assert.equal(typeof app.service('review-event-queue').dispatchWordDefinitionCreated, 'function');
  assert.equal(typeof app.service('review-event-queue').dispatchArticleCreated, 'function');
  assert.ok(app.service('event-api'));
  assert.equal(typeof app.service('event-api').dispatchEvent, 'function');
  assert.ok(app.service('point-service'));
  assert.equal(typeof app.service('point-service').applyWordDefinitionCreatedEvent, 'function');
  assert.equal(typeof app.service('point-service').applyArticleCreatedEvent, 'function');
  assert.ok(app.service('flashcard-stat-bootstrap'));
  assert.equal(typeof app.service('flashcard-stat-bootstrap').ensureForUser, 'function');
  assert.equal(app.contentType('api::reviewlog.reviewlog').attributes.event_id.type, 'string');
  assert.equal(app.contentType('api::reviewlog.reviewlog').attributes.effective.type, 'boolean');
  assert.equal(app.contentType('api::reviewlog.reviewlog').attributes.points_awarded.type, 'integer');
  assert.equal(app.contentType('api::reviewlog.reviewlog').attributes.newlevel.type, 'enumeration');
  assert.equal(app.contentType('api::user-point.user-point').attributes.record_date.type, 'date');
  assert.equal(app.contentType('api::user-point.user-point').attributes.points_add.type, 'integer');
  assert.equal(app.getModel('plugin::users-permissions.user').attributes.honor_title.relation, 'manyToOne');
});

test('review action updates the flashcard and delegates side effects to the queue facade', async () => {
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

  const queueService = app.service('review-event-queue');
  const originalDispatch = queueService.dispatchReviewCompleted;
  const dispatchedEvents = [];
  queueService.dispatchReviewCompleted = async (event) => {
    dispatchedEvents.push(event);
    return { queued: true, driver: 'stub' };
  };

  try {
    const controller = app.controller('api::flashcard.flashcard');
    await controller.review(makeCtx(user, flashcard.id, 'correct'));

    const updatedFlashcard = await app.entityService.findOne('api::flashcard.flashcard', flashcard.id, {
      populate: { review_tire: true },
    });
    const reviewlogs = await app.entityService.findMany('api::reviewlog.reviewlog', {
      filters: { flashcard: flashcard.id },
    });

    assert.equal(updatedFlashcard.correct_streak, 1);
    assert.equal(updatedFlashcard.wrong_streak, 0);
    assert.equal(updatedFlashcard.review_tire.tier, 'warmup');
    assert.ok(updatedFlashcard.next_review_at);
    assert.ok(new Date(updatedFlashcard.next_review_at) > new Date(updatedFlashcard.last_reviewed_at));

    assert.equal(dispatchedEvents.length, 1);
    assert.equal(dispatchedEvents[0].event, 'flashcard.review.completed');
    assert.equal(dispatchedEvents[0].review.flashcardId, flashcard.id);
    assert.equal(dispatchedEvents[0].review.userId, user.id);
    assert.equal(dispatchedEvents[0].review.result, 'correct');
    assert.equal(dispatchedEvents[0].review.level, 'new');
    assert.equal(dispatchedEvents[0].review.newlevel, 'warmup');
    assert.equal(reviewlogs.length, 0);
  } finally {
    queueService.dispatchReviewCompleted = originalDispatch;
  }
});

test('review action updates flashcard-stat synchronously and creates missing rows on demand', async () => {
  const user = await createAuthenticatedUser();
  const word = await app.entityService.create('api::word.word', {
    data: {
      target_text: `review-stat-word-${Date.now()}`,
    },
  });
  const wordDefinition = await app.entityService.create('api::word-definition.word-definition', {
    data: {
      locale: 'en',
      owner: user.id,
      word: word.id,
      base_text: 'review stat word',
    },
  });
  const flashcard = await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      word_definition: wordDefinition.id,
      correct_streak: 0,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.new.id,
    },
  });
  const controller = app.controller('api::flashcard.flashcard');

  const beforeStats = await app.entityService.findMany('api::flashcard-stat.flashcard-stat', {
    filters: { user: user.id },
  });

  assert.equal(beforeStats.length, 0);

  await controller.review(makeCtx(user, flashcard.id, 'correct'));

  const flashcardStats = await app.entityService.findMany('api::flashcard-stat.flashcard-stat', {
    filters: { user: user.id },
    populate: { review_tire: true },
    sort: ['review_tire.id:asc'],
  });

  const newTierStat = flashcardStats.find((row) => row.review_tire?.id === reviewTiers.new.id);
  const warmupTierStat = flashcardStats.find((row) => row.review_tire?.id === reviewTiers.warmup.id);

  assert.ok(newTierStat);
  assert.ok(warmupTierStat);
  assert.equal(newTierStat.word_count, 0);
  assert.equal(warmupTierStat.word_count, 1);

  await app.service('review-event-queue').waitForIdle(15000);
});

test('findForReview uses next_review_at to return only due flashcards', async () => {
  const user = await createAuthenticatedUser();
  const controller = app.controller('api::flashcard.flashcard');
  const word = await app.entityService.create('api::word.word', {
    data: {
      target_text: `review-list-word-${Date.now()}`,
    },
  });
  const wordDefinition = await app.entityService.create('api::word-definition.word-definition', {
    data: {
      locale: 'en',
      owner: user.id,
      word: word.id,
      base_text: 'review list word',
    },
  });
  const dueFlashcard = await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      word_definition: wordDefinition.id,
      correct_streak: 1,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.warmup.id,
      last_reviewed_at: '2026-04-20T12:00:00.000Z',
      next_review_at: '2026-04-21T12:00:00.000Z',
    },
  });
  await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      word_definition: wordDefinition.id,
      correct_streak: 1,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.warmup.id,
      last_reviewed_at: '2026-04-24T12:00:00.000Z',
      next_review_at: '2099-04-24T12:00:00.000Z',
    },
  });
  const nullNextReviewFlashcard = await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      word_definition: wordDefinition.id,
      correct_streak: 0,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.new.id,
      last_reviewed_at: null,
      next_review_at: null,
    },
  });

  const response = await controller.findForReview(
    makeFindForReviewCtx(user, { pagination: { page: 1, pageSize: 10 } })
  );

  const returnedIds = response.data.map((item) => item.id).sort((a, b) => a - b);

  assert.deepEqual(returnedIds, [dueFlashcard.id, nullNextReviewFlashcard.id].sort((a, b) => a - b));
  assert.equal(response.meta.pagination.total, 2);
});

test('registerWithProfile creates one flashcard-stat row per review tier for the new user', async () => {
  const controller = app.controller('api::user-profile.user-profile');
  const unique = Date.now();
  const ctx = makeRegisterWithProfileCtx({
    email: `register-flashcard-stat-${unique}@example.com`,
    username: `register-flashcard-stat-${unique}`,
    password: 'Passw0rd!',
    baseLanguage: 'en',
    visible_on_ladder: true,
  });

  await controller.registerWithProfile(ctx);

  assert.ok(ctx.body?.user?.id);

  const flashcardStats = await app.entityService.findMany('api::flashcard-stat.flashcard-stat', {
    filters: {
      user: ctx.body.user.id,
    },
    populate: {
      review_tire: true,
    },
  });

  const reviewTiersFromService = await app.service('tier-service').getAllTiers();

  assert.equal(flashcardStats.length, reviewTiersFromService.length);
  assert.deepEqual(
    flashcardStats.map((stat) => stat.review_tire.id).sort((a, b) => a - b),
    reviewTiersFromService.map((tier) => tier.id).sort((a, b) => a - b)
  );
  assert.ok(flashcardStats.every((stat) => stat.word_count === 0));
});

test('flashcard statistics endpoint returns the materialized flashcard-stat summary with due counts from next_review_at', async () => {
  const user = await createAuthenticatedUser();
  const otherUser = await createAuthenticatedUser();
  const controller = app.controller('api::flashcard.flashcard');
  const ctx = makeStatsCtx(user);
  const word = await app.entityService.create('api::word.word', {
    data: {
      target_text: `materialized-stats-word-${Date.now()}`,
    },
  });
  const wordDefinition = await app.entityService.create('api::word-definition.word-definition', {
    data: {
      locale: 'en',
      owner: user.id,
      word: word.id,
      base_text: 'materialized stats word',
    },
  });

  await app.entityService.create('api::flashcard-stat.flashcard-stat', {
    data: {
      user: user.id,
      review_tire: reviewTiers.new.id,
      word_count: 2,
    },
  });
  await app.entityService.create('api::flashcard-stat.flashcard-stat', {
    data: {
      user: user.id,
      review_tire: reviewTiers.warmup.id,
      word_count: 3,
    },
  });
  await app.entityService.create('api::flashcard-stat.flashcard-stat', {
    data: {
      user: otherUser.id,
      review_tire: reviewTiers.new.id,
      word_count: 99,
    },
  });

  await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      word_definition: wordDefinition.id,
      correct_streak: 0,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.new.id,
      next_review_at: null,
    },
  });
  await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      word_definition: wordDefinition.id,
      correct_streak: 1,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.warmup.id,
      next_review_at: '2099-04-22T12:00:00.000Z',
    },
  });
  await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: otherUser.id,
      word_definition: wordDefinition.id,
      correct_streak: 0,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.new.id,
      next_review_at: null,
    },
  });

  await controller.getStatistics(ctx);

  assert.equal(ctx.body.data.totalCards, 5);
  assert.equal(ctx.body.data.remembered, 0);
  assert.equal(ctx.body.data.dueForReview, 1);
  assert.equal(ctx.body.data.reviewed, null);
  assert.equal(ctx.body.data.hardToRemember, null);
  assert.equal(ctx.body.data.byTier.length, 3);
  assert.equal(ctx.body.data.byTier[0].tier, 'new');
  assert.equal(ctx.body.data.byTier[0].count, 2);
  assert.equal(ctx.body.data.byTier[0].dueCount, 1);
  assert.equal(ctx.body.data.byTier[1].tier, 'warmup');
  assert.equal(ctx.body.data.byTier[1].count, 3);
  assert.equal(ctx.body.data.byTier[1].dueCount, 0);
  assert.equal(ctx.body.data.byTier[1].hardToRememberCount, null);
  assert.equal(ctx.body.data.byTier[2].tier, 'weekly');
  assert.equal(ctx.body.data.byTier[2].count, 0);
  assert.equal(ctx.body.data.byTier[2].dueCount, 0);
});

test('review action writes reviewlog and daily user points from the local event handler', async () => {
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
  await app.service('review-event-queue').waitForIdle(15000);

  const updatedFlashcard = await app.entityService.findOne('api::flashcard.flashcard', flashcard.id, {
    populate: { review_tire: true },
  });

  const reviewlogs = await app.entityService.findMany('api::reviewlog.reviewlog', {
    filters: { flashcard: flashcard.id },
    sort: { reviewed_at: 'desc' },
  });
  const userPoints = await app.entityService.findMany('api::user-point.user-point', {
    filters: { user: user.id },
    sort: { record_date: 'asc' },
    populate: {
      point_group: {
        populate: {
          group_rank: true,
        },
      },
    },
  });
  const userPointGroups = await app.entityService.findMany('api::user-point-group.user-point-group', {
    filters: { user: user.id },
    populate: {
      point_group: {
        populate: {
          group_rank: true,
        },
      },
    },
  });
  const userWithHonor = await app.entityService.findOne('plugin::users-permissions.user', user.id, {
    populate: {
      honor_title: true,
    },
  });

  assert.equal(updatedFlashcard.correct_streak, 1);
  assert.equal(updatedFlashcard.wrong_streak, 0);
  assert.equal(updatedFlashcard.review_tire.tier, 'warmup');
  assert.ok(updatedFlashcard.next_review_at);
  assert.ok(new Date(updatedFlashcard.next_review_at) > new Date(updatedFlashcard.last_reviewed_at));

  assert.equal(reviewlogs.length, 1);
  assert.equal(typeof reviewlogs[0].event_id, 'string');
  assert.equal(reviewlogs[0].result, 'correct');
  assert.equal(reviewlogs[0].level, 'new');
  assert.equal(reviewlogs[0].effective, true);
  assert.equal(reviewlogs[0].points_awarded, pointRule.review_tier_up_point + pointRule.review_point);
  assert.equal(reviewlogs[0].newlevel, 'warmup');

  assert.equal(userPoints.length, 2);
  assert.equal(userPoints[0].points, 0);
  assert.equal(userPoints[0].points_add, 0);
  assert.equal(userPoints[1].points, pointRule.review_tier_up_point + pointRule.review_point);
  assert.equal(userPoints[1].points_add, pointRule.review_tier_up_point + pointRule.review_point);
  assert.equal(userWithHonor.honor_title?.id, honorTitles.silver.id);
  assert.equal(userPointGroups.length, 1);
  assert.equal(userPointGroups[0].period_points, pointRule.review_tier_up_point + pointRule.review_point);
  assert.equal(userPointGroups[0].point_group.group_rank.id, groupRanks.active.id);
  assert.equal(userPointGroups[0].point_group.group_no, 1);
  assert.equal(userPoints[1].point_group.id, seededPointGroups.active.id);
  assert.equal(userPointGroups[0].point_group.id, seededPointGroups.active.id);
});

test('word-definition create dispatches a queued event and updates user points through the handler', async () => {
  const user = await createAuthenticatedUser();
  const controller = app.controller('api::word-definition.word-definition');
  const wordProcessingQueue = app.service('word-processing-queue');
  const originalAddJob = wordProcessingQueue.addJob;
  const queuedWordJobs = [];

  wordProcessingQueue.addJob = (job) => {
    queuedWordJobs.push(job);
  };

  try {
    const response = await controller.create(
      makeWordDefinitionCreateCtx(user, {
        target_text: 'lernen',
        base_text: 'learn',
        part_of_speech: 'verb',
        locale: 'en',
      })
    );

    await app.service('event-api').waitForIdle();

    const createdWordDefinitionId = response?.data?.id;
    const createdWordDefinition = await app.entityService.findOne(
      'api::word-definition.word-definition',
      createdWordDefinitionId,
      {
        populate: {
          word: true,
          part_of_speech: true,
        },
      }
    );
    const flashcards = await app.entityService.findMany('api::flashcard.flashcard', {
      filters: {
        user: user.id,
        word_definition: createdWordDefinitionId,
      },
    });
    const userPoints = await app.entityService.findMany('api::user-point.user-point', {
      filters: { user: user.id },
      sort: { record_date: 'asc' },
      populate: {
        point_group: {
          populate: {
            group_rank: true,
          },
        },
      },
    });
    const userPointGroups = await app.entityService.findMany('api::user-point-group.user-point-group', {
      filters: { user: user.id },
      populate: {
        point_group: {
          populate: {
            group_rank: true,
          },
        },
      },
    });
    const userWithHonor = await app.entityService.findOne('plugin::users-permissions.user', user.id, {
      populate: {
        honor_title: true,
      },
    });

    assert.equal(createdWordDefinition.word.target_text, 'lernen');
    assert.equal(createdWordDefinition.base_text, 'learn');
    assert.equal(createdWordDefinition.part_of_speech.name, 'verb');
    assert.equal(flashcards.length, 1);
    assert.equal(queuedWordJobs.length, 1);
    assert.equal(queuedWordJobs[0].wordDefinitionId, createdWordDefinitionId);
    assert.equal(queuedWordJobs[0].flashcardId, flashcards[0].id);
    assert.equal(userPoints.length, 2);
    assert.equal(userPoints[0].points, 0);
    assert.equal(userPoints[1].points, pointRule.new_word_point);
    assert.equal(userPoints[1].points_add, pointRule.new_word_point);
    assert.equal(userPoints[1].word_count, 1);
    assert.equal(userPoints[1].word_add, 1);
    assert.equal(userPoints[1].point_group.group_rank.id, groupRanks.starter.id);
    assert.equal(userPoints[1].rank, 1);
    assert.equal(userPoints[1].rank_change, 1);
    assert.equal(userPointGroups.length, 1);
    assert.equal(userPointGroups[0].period_points, pointRule.new_word_point);
    assert.equal(userPointGroups[0].point_group.group_rank.id, groupRanks.starter.id);
    assert.equal(userWithHonor.honor_title?.id, honorTitles.bronze.id);
  } finally {
    wordProcessingQueue.addJob = originalAddJob;
  }
});

test('user-article create dispatches a queued event and updates user points through the handler', async () => {
  const user = await createAuthenticatedUser();
  const controller = app.controller('api::user-article.user-article');

  const response = await controller.create(
    makeUserArticleCreateCtx(user, {
      title: 'Learning German',
      content: 'One short article for reading practice.',
      language_code: 'en',
    })
  );

  await app.service('event-api').waitForIdle();

  const createdArticleId = response?.data?.id;
  const createdArticle = await app.entityService.findOne('api::user-article.user-article', createdArticleId, {
    populate: {
      user: true,
    },
  });
  const userPoints = await app.entityService.findMany('api::user-point.user-point', {
    filters: { user: user.id },
    sort: { record_date: 'asc' },
    populate: {
      point_group: {
        populate: {
          group_rank: true,
        },
      },
    },
  });
  const userPointGroups = await app.entityService.findMany('api::user-point-group.user-point-group', {
    filters: { user: user.id },
    populate: {
      point_group: {
        populate: {
          group_rank: true,
        },
      },
    },
  });
  const userWithHonor = await app.entityService.findOne('plugin::users-permissions.user', user.id, {
    populate: {
      honor_title: true,
    },
  });

  assert.equal(createdArticle.user.id, user.id);
  assert.equal(createdArticle.title, 'Learning German');
  assert.equal(createdArticle.language_code, 'en');
  assert.equal(createdArticle.word_count, 6);
  assert.equal(userPoints.length, 2);
  assert.equal(userPoints[0].points, 0);
  assert.equal(userPoints[1].points, pointRule.article_point);
  assert.equal(userPoints[1].points_add, pointRule.article_point);
  assert.equal(userPoints[1].article_count, 1);
  assert.equal(userPoints[1].article_add, 1);
  assert.equal(userPoints[1].point_group.group_rank.id, groupRanks.starter.id);
  assert.equal(userPoints[1].rank, 1);
  assert.equal(userPoints[1].rank_change, 1);
  assert.equal(userPointGroups.length, 1);
  assert.equal(userPointGroups[0].period_points, pointRule.article_point);
  assert.equal(userPointGroups[0].point_group.group_rank.id, groupRanks.starter.id);
  assert.equal(userWithHonor.honor_title?.id, honorTitles.bronze.id);
});

test('user-point latest endpoint returns the current latest snapshot for the authenticated user', async () => {
  const user = await createAuthenticatedUser();
  const controller = app.controller('api::user-point.user-point');

  await app.entityService.update('plugin::users-permissions.user', user.id, {
    data: {
      honor_title: honorTitles.bronze.id,
    },
  });

  await app.entityService.create('api::user-point.user-point', {
    data: {
      user: user.id,
      record_date: '2026-04-19',
      point_group: seededPointGroups.starter.id,
      points: 1,
      points_add: 1,
      word_count: 0,
      word_add: 0,
      article_count: 0,
      article_add: 0,
      group_rank_change: 0,
      rank: 1,
      rank_change: 1,
    },
  });

  await app.entityService.create('api::user-point.user-point', {
    data: {
      user: user.id,
      record_date: '2026-04-20',
      point_group: seededPointGroups.starter.id,
      points: 2,
      points_add: 1,
      word_count: 1,
      word_add: 1,
      article_count: 0,
      article_add: 0,
      group_rank_change: 0,
      rank: 1,
      rank_change: 0,
    },
  });

  await app.entityService.create('api::user-point.user-point', {
    data: {
      user: user.id,
      record_date: '2026-04-21',
      point_group: seededPointGroups.active.id,
      points: 5,
      points_add: 3,
      word_count: 1,
      word_add: 0,
      article_count: 1,
      article_add: 1,
      group_rank_change: 1,
      rank: 2,
      rank_change: 1,
    },
  });

  const response = await controller.findLatest(makeUserPointLatestCtx(user));

  assert.equal(response.data.attributes.record_date, '2026-04-21');
  assert.equal(response.data.attributes.points, 5);
  assert.equal(response.data.attributes.point_group.data.attributes.group_rank.data.attributes.title, 'Active');
  assert.equal(response.data.attributes.user.data.attributes.honor_title.data.attributes.title, 'Bronze');
});

test('user-point latest endpoint returns a zero-state payload when no user-point exists yet', async () => {
  const user = await createAuthenticatedUser();
  const controller = app.controller('api::user-point.user-point');

  const response = await controller.findLatest(makeUserPointLatestCtx(user));

  assert.equal(response.data.id, null);
  assert.equal(response.data.attributes.record_date, null);
  assert.equal(response.data.attributes.points, 0);
  assert.equal(response.data.attributes.points_add, 0);
  assert.equal(response.data.attributes.word_count, 0);
  assert.equal(response.data.attributes.word_add, 0);
  assert.equal(response.data.attributes.article_count, 0);
  assert.equal(response.data.attributes.article_add, 0);
  assert.equal(response.data.attributes.rank, 0);
  assert.equal(response.data.attributes.rank_change, 0);
  assert.equal(response.data.attributes.point_group.data, null);
  assert.equal(response.data.attributes.user.data.id, user.id);
});

test('user-point latest endpoint returns rank text and display rank when stored rank is zero', async () => {
  const user = await createAuthenticatedUser();
  const controller = app.controller('api::user-point.user-point');
  const profiles = await app.entityService.findMany('api::user-profile.user-profile', {
    filters: { user: user.id },
    limit: 1,
  });

  assert.ok(profiles[0]);

  await app.entityService.update('api::user-profile.user-profile', profiles[0].id, {
    data: {
      baseLanguage: 'en',
    },
  });

  await app.entityService.create('api::user-point.user-point', {
    data: {
      user: user.id,
      record_date: '2026-04-23',
      point_group: seededPointGroups.starter.id,
      points: 28,
      points_add: 28,
      word_count: 0,
      word_add: 0,
      article_count: 0,
      article_add: 0,
      group_rank_change: 0,
      rank: 0,
      rank_change: 0,
    },
  });

  const response = await controller.findLatest(makeUserPointLatestCtx(user, { locale: 'en' }));

  assert.equal(response.data.attributes.rank, 1);
  assert.equal(response.data.attributes.rank_text, 'Bronze');
});

test('my-point-group endpoint returns current group summary and leaderboard position', async () => {
  const firstUser = await createAuthenticatedUser();
  const secondUser = await createAuthenticatedUser();
  const thirdUser = await createAuthenticatedUser();
  const controller = app.controller('api::point-group.point-group');
  const customGroup = await app.entityService.create('api::point-group.point-group', {
    data: {
      group_rank: groupRanks.active.id,
      group_no: 3,
    },
  });

  await app.entityService.create('api::user-point-group.user-point-group', {
    data: {
      user: firstUser.id,
      point_group: customGroup.id,
      period_points: 8,
    },
  });
  await app.entityService.create('api::user-point-group.user-point-group', {
    data: {
      user: secondUser.id,
      point_group: customGroup.id,
      period_points: 12,
    },
  });
  await app.entityService.create('api::user-point-group.user-point-group', {
    data: {
      user: thirdUser.id,
      point_group: customGroup.id,
      period_points: 3,
    },
  });

  const response = await controller.findMine(makePointGroupMineCtx(firstUser));

  assert.equal(response.data.point_group.id, customGroup.id);
  assert.equal(response.data.point_group.group_no, 3);
  assert.equal(response.data.point_group.group_rank.title, 'Active');
  assert.equal(response.data.my_membership.period_points, 8);
  assert.equal(response.data.my_membership.position_in_group, 2);
  assert.equal(response.data.my_membership.group_member_count, 3);
  assert.equal(response.data.leaderboard.length, 3);
  assert.equal(response.data.leaderboard[0].user.id, secondUser.id);
  assert.equal(response.data.leaderboard[0].position, 1);
  assert.equal(response.data.leaderboard[0].period_points, 12);
  assert.equal(response.data.leaderboard[1].user.id, firstUser.id);
  assert.equal(response.data.leaderboard[1].position, 2);
  assert.equal(response.data.leaderboard[1].is_current_user, true);
  assert.equal(response.data.leaderboard[2].user.id, thirdUser.id);
  assert.equal(response.data.leaderboard[2].position, 3);
});

test('point-group leaderboard endpoint returns all members and period points for a given group', async () => {
  const firstUser = await createAuthenticatedUser();
  const secondUser = await createAuthenticatedUser();
  const thirdUser = await createAuthenticatedUser();
  const controller = app.controller('api::point-group.point-group');
  const customGroup = await app.entityService.create('api::point-group.point-group', {
    data: {
      group_rank: groupRanks.active.id,
      group_no: 5,
    },
  });

  const firstMembership = await app.entityService.create('api::user-point-group.user-point-group', {
    data: {
      user: firstUser.id,
      point_group: customGroup.id,
      period_points: 8,
    },
  });
  const secondMembership = await app.entityService.create('api::user-point-group.user-point-group', {
    data: {
      user: secondUser.id,
      point_group: customGroup.id,
      period_points: 12,
    },
  });
  const thirdMembership = await app.entityService.create('api::user-point-group.user-point-group', {
    data: {
      user: thirdUser.id,
      point_group: customGroup.id,
      period_points: 8,
    },
  });

  const response = await controller.findLeaderboard(makePointGroupLeaderboardCtx(firstUser, customGroup.id));

  assert.equal(response.data.point_group.id, customGroup.id);
  assert.equal(response.data.point_group.group_no, 5);
  assert.equal(response.data.point_group.group_rank.title, 'Active');
  assert.equal(response.data.current_user_position, 2);
  assert.equal(response.data.group_member_count, 3);
  assert.equal(response.data.leaderboard.length, 3);
  assert.equal(response.data.leaderboard[0].user_point_group_id, secondMembership.id);
  assert.equal(response.data.leaderboard[0].period_points, 12);
  assert.equal(response.data.leaderboard[0].position, 1);
  assert.equal(response.data.leaderboard[1].user_point_group_id, firstMembership.id);
  assert.equal(response.data.leaderboard[1].period_points, 8);
  assert.equal(response.data.leaderboard[1].position, 2);
  assert.equal(response.data.leaderboard[1].is_current_user, true);
  assert.equal(response.data.leaderboard[2].user_point_group_id, thirdMembership.id);
  assert.equal(response.data.leaderboard[2].period_points, 8);
  assert.equal(response.data.leaderboard[2].position, 3);
});

test('point-group leaderboard endpoint returns an empty payload when the group does not exist', async () => {
  const user = await createAuthenticatedUser();
  const controller = app.controller('api::point-group.point-group');

  const response = await controller.findLeaderboard(makePointGroupLeaderboardCtx(user, 999999));

  assert.equal(response.data.point_group, null);
  assert.equal(response.data.current_user_position, null);
  assert.equal(response.data.group_member_count, 0);
  assert.deepEqual(response.data.leaderboard, []);
});

test('review event handler is idempotent for the same event id', async () => {
  const user = await createAuthenticatedUser();

  const event = {
    event: 'flashcard.review.completed',
    eventId: `flashcard-review:test:${user.id}`,
    occurredAt: '2026-04-21T12:00:00.000Z',
    review: {
      flashcardId: null,
      userId: user.id,
      username: user.username,
      email: user.email,
      reviewedAt: '2026-04-21T12:00:00.000Z',
      result: 'correct',
      level: 'new',
      effective: true,
      newlevel: 'warmup',
    },
  };

  const flashcard = await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      correct_streak: 1,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.warmup.id,
    },
  });

  event.review.flashcardId = flashcard.id;
  const handler = app.service('review-event-handler');
  const first = await handler.handleReviewCompleted(event);
  const second = await handler.handleReviewCompleted(event);

  const reviewlogs = await app.entityService.findMany('api::reviewlog.reviewlog', {
    filters: { event_id: event.eventId },
  });
  const userPoints = await app.entityService.findMany('api::user-point.user-point', {
    filters: { user: user.id },
    sort: { record_date: 'asc' },
  });
  const userWithHonor = await app.entityService.findOne('plugin::users-permissions.user', user.id, {
    populate: {
      honor_title: true,
    },
  });

  assert.equal(first.duplicate, false);
  assert.equal(second.duplicate, true);
  assert.equal(reviewlogs.length, 1);
  assert.equal(reviewlogs[0].points_awarded, pointRule.review_tier_up_point + pointRule.review_point);
  assert.equal(userPoints.length, 2);
  assert.equal(userPoints[1].points, pointRule.review_tier_up_point + pointRule.review_point);
  assert.equal(userPoints[1].points_add, pointRule.review_tier_up_point + pointRule.review_point);
  assert.equal(userWithHonor.honor_title?.id, honorTitles.silver.id);
});

test('same-day user-point update does not recalculate honor title or group assignment', async () => {
  const user = await createAuthenticatedUser();
  const reviewedAt = '2026-04-21T12:00:00.000Z';
  const recordDate = app.service('review-reward-service').getRecordDate(reviewedAt);
  const activePointGroup = await app.entityService.create('api::point-group.point-group', {
    data: {
      group_rank: groupRanks.active.id,
      group_no: 1,
    },
  });

  await app.entityService.update('plugin::users-permissions.user', user.id, {
    data: {
      honor_title: honorTitles.bronze.id,
    },
  });

  await app.entityService.create('api::user-point-group.user-point-group', {
    data: {
      user: user.id,
      point_group: activePointGroup.id,
      period_points: 279,
    },
  });

  await app.entityService.create('api::user-point.user-point', {
    data: {
      user: user.id,
      record_date: recordDate,
      point_group: activePointGroup.id,
      points: 279,
      points_add: 279,
      word_count: 0,
      word_add: 0,
      article_count: 0,
      article_add: 0,
      group_rank_change: 0,
      rank: 0,
      rank_change: 0,
    },
  });

  const flashcard = await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      correct_streak: 1,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.warmup.id,
    },
  });

  const event = {
    event: 'flashcard.review.completed',
    eventId: `flashcard-review:same-day:${user.id}`,
    occurredAt: reviewedAt,
    review: {
      flashcardId: flashcard.id,
      userId: user.id,
      username: user.username,
      email: user.email,
      reviewedAt,
      result: 'correct',
      level: 'new',
      effective: true,
      newlevel: 'warmup',
    },
  };

  await app.service('review-event-handler').handleReviewCompleted(event);

  const userWithHonor = await app.entityService.findOne('plugin::users-permissions.user', user.id, {
    populate: {
      honor_title: true,
    },
  });
  const userPoints = await app.entityService.findMany('api::user-point.user-point', {
    filters: {
      user: user.id,
      record_date: recordDate,
    },
    populate: {
      point_group: {
        populate: {
          group_rank: true,
        },
      },
    },
  });
  const userPointGroups = await app.entityService.findMany('api::user-point-group.user-point-group', {
    filters: {
      user: user.id,
    },
    populate: {
      point_group: {
        populate: {
          group_rank: true,
        },
      },
    },
  });

  assert.equal(userWithHonor.honor_title?.id, honorTitles.bronze.id);
  assert.equal(userPoints.length, 1);
  assert.equal(userPoints[0].points, 282);
  assert.equal(userPoints[0].points_add, 282);
  assert.equal(userPoints[0].point_group.group_rank.id, groupRanks.active.id);
  assert.equal(userPointGroups.length, 1);
  assert.equal(userPointGroups[0].period_points, 279);
  assert.equal(userPointGroups[0].point_group.group_rank.id, groupRanks.active.id);
});

test('same-day second review does not reassign group rank after crossing the threshold', async () => {
  const user = await createAuthenticatedUser();
  const reviewedAt = '2026-04-21T12:00:00.000Z';
  const secondReviewedAt = '2026-04-21T13:00:00.000Z';
  const previousDate = '2026-04-20';
  const recordDate = app.service('review-reward-service').getRecordDate(reviewedAt);
  const activePointGroup = await app.entityService.create('api::point-group.point-group', {
    data: {
      group_rank: groupRanks.active.id,
      group_no: 1,
    },
  });

  try {
    await app.entityService.create('api::user-point-group.user-point-group', {
      data: {
        user: user.id,
        point_group: activePointGroup.id,
        period_points: 278,
      },
    });

    await app.entityService.create('api::user-point.user-point', {
      data: {
        user: user.id,
        record_date: previousDate,
        points: 278,
        points_add: 0,
        point_group: activePointGroup.id,
        word_count: 0,
        word_add: 0,
        article_count: 0,
        article_add: 0,
        group_rank_change: 0,
        rank: 0,
        rank_change: 0,
      },
    });

    await app.entityService.create('api::user-point.user-point', {
      data: {
        user: user.id,
        record_date: recordDate,
        points: 278,
        points_add: 0,
        point_group: activePointGroup.id,
        word_count: 0,
        word_add: 0,
        article_count: 0,
        article_add: 0,
        group_rank_change: 0,
        rank: 0,
        rank_change: 0,
      },
    });

    const firstFlashcard = await app.entityService.create('api::flashcard.flashcard', {
      data: {
        user: user.id,
        correct_streak: 1,
        wrong_streak: 0,
        is_remembered: false,
        review_tire: reviewTiers.warmup.id,
      },
    });
    const secondFlashcard = await app.entityService.create('api::flashcard.flashcard', {
      data: {
        user: user.id,
        correct_streak: 1,
        wrong_streak: 0,
        is_remembered: false,
        review_tire: reviewTiers.warmup.id,
      },
    });

    const handler = app.service('review-event-handler');

    await handler.handleReviewCompleted({
      event: 'flashcard.review.completed',
      eventId: `flashcard-review:same-day-threshold:first:${user.id}`,
      occurredAt: reviewedAt,
      review: {
        flashcardId: firstFlashcard.id,
        userId: user.id,
        username: user.username,
        email: user.email,
        reviewedAt,
        result: 'correct',
        level: 'warmup',
        effective: true,
        newlevel: 'warmup',
      },
    });

    await handler.handleReviewCompleted({
      event: 'flashcard.review.completed',
      eventId: `flashcard-review:same-day-threshold:second:${user.id}`,
      occurredAt: secondReviewedAt,
      review: {
        flashcardId: secondFlashcard.id,
        userId: user.id,
        username: user.username,
        email: user.email,
        reviewedAt: secondReviewedAt,
        result: 'correct',
        level: 'warmup',
        effective: true,
        newlevel: 'warmup',
      },
    });

    const userPoints = await app.entityService.findMany('api::user-point.user-point', {
      filters: {
        user: user.id,
        record_date: recordDate,
      },
      populate: {
        point_group: {
          populate: {
            group_rank: true,
          },
        },
      },
    });
    const userPointGroups = await app.entityService.findMany('api::user-point-group.user-point-group', {
      filters: {
        user: user.id,
      },
      populate: {
        point_group: {
          populate: {
            group_rank: true,
          },
        },
      },
    });
    const learnerGroups = await app.entityService.findMany('api::point-group.point-group', {
      filters: {
        group_rank: groupRanks.learner.id,
      },
    });

    assert.equal(userPoints.length, 1);
    assert.equal(userPoints[0].points, 280);
    assert.equal(userPoints[0].points_add, 2);
    assert.equal(userPoints[0].point_group.group_rank.id, groupRanks.active.id);
    assert.equal(userPointGroups.length, 1);
    assert.equal(userPointGroups[0].period_points, 278);
    assert.equal(userPointGroups[0].point_group.group_rank.id, groupRanks.active.id);
    assert.equal(learnerGroups.length, 0);
  } finally {
    await app.db.query('api::point-group.point-group').deleteMany({ where: { id: { $gt: 0 } } });
    await app.entityService.create('api::point-group.point-group', {
      data: {
        group_rank: groupRanks.starter.id,
        group_no: 1,
      },
    });
    await app.entityService.create('api::point-group.point-group', {
      data: {
        group_rank: groupRanks.active.id,
        group_no: 1,
      },
    });
  }
});

test('same-day reviews do not recalculate honor title after crossing the next-level threshold', async () => {
  const user = await createAuthenticatedUser();
  const reviewedAt = '2026-04-21T12:00:00.000Z';
  const secondReviewedAt = '2026-04-21T13:00:00.000Z';
  const previousDate = '2026-04-20';
  const recordDate = app.service('review-reward-service').getRecordDate(reviewedAt);
  const nextLevelThreshold =
    (honorTitleRule.base_points ?? 0) + (honorTitleRule.increase_points ?? 0) * 2;
  const startingPoints = nextLevelThreshold - 1;
  const goldTitle = await app.entityService.create('api::honor-title.honor-title', {
    data: {
      locale: 'en',
      title: 'Gold',
    },
  });

  try {
    await app.entityService.update('plugin::users-permissions.user', user.id, {
      data: {
        honor_title: honorTitles.silver.id,
      },
    });

    await app.entityService.create('api::user-point.user-point', {
      data: {
        user: user.id,
        record_date: previousDate,
        points: startingPoints,
        points_add: 0,
        word_count: 0,
        word_add: 0,
        article_count: 0,
        article_add: 0,
        group_rank_change: 0,
        rank: 0,
        rank_change: 0,
      },
    });

    await app.entityService.create('api::user-point.user-point', {
      data: {
        user: user.id,
        record_date: recordDate,
        points: startingPoints,
        points_add: 0,
        word_count: 0,
        word_add: 0,
        article_count: 0,
        article_add: 0,
        group_rank_change: 0,
        rank: 0,
        rank_change: 0,
      },
    });

    const firstFlashcard = await app.entityService.create('api::flashcard.flashcard', {
      data: {
        user: user.id,
        correct_streak: 1,
        wrong_streak: 0,
        is_remembered: false,
        review_tire: reviewTiers.warmup.id,
      },
    });
    const secondFlashcard = await app.entityService.create('api::flashcard.flashcard', {
      data: {
        user: user.id,
        correct_streak: 1,
        wrong_streak: 0,
        is_remembered: false,
        review_tire: reviewTiers.warmup.id,
      },
    });

    const handler = app.service('review-event-handler');

    await handler.handleReviewCompleted({
      event: 'flashcard.review.completed',
      eventId: `flashcard-review:same-day-honor:first:${user.id}`,
      occurredAt: reviewedAt,
      review: {
        flashcardId: firstFlashcard.id,
        userId: user.id,
        username: user.username,
        email: user.email,
        reviewedAt,
        result: 'correct',
        level: 'warmup',
        effective: true,
        newlevel: 'warmup',
      },
    });

    const userAfterFirstReview = await app.entityService.findOne('plugin::users-permissions.user', user.id, {
      populate: {
        honor_title: true,
      },
    });
    const todayAfterFirstReview = await app.entityService.findMany('api::user-point.user-point', {
      filters: {
        user: user.id,
        record_date: recordDate,
      },
    });

    assert.equal(todayAfterFirstReview.length, 1);
    assert.equal(todayAfterFirstReview[0].points, nextLevelThreshold);
    assert.equal(todayAfterFirstReview[0].points_add, 1);
    assert.equal(userAfterFirstReview.honor_title?.id, honorTitles.silver.id);

    await handler.handleReviewCompleted({
      event: 'flashcard.review.completed',
      eventId: `flashcard-review:same-day-honor:second:${user.id}`,
      occurredAt: secondReviewedAt,
      review: {
        flashcardId: secondFlashcard.id,
        userId: user.id,
        username: user.username,
        email: user.email,
        reviewedAt: secondReviewedAt,
        result: 'correct',
        level: 'warmup',
        effective: true,
        newlevel: 'warmup',
      },
    });

    const userAfterSecondReview = await app.entityService.findOne('plugin::users-permissions.user', user.id, {
      populate: {
        honor_title: true,
      },
    });
    const todayAfterSecondReview = await app.entityService.findMany('api::user-point.user-point', {
      filters: {
        user: user.id,
        record_date: recordDate,
      },
    });

    assert.equal(todayAfterSecondReview.length, 1);
    assert.equal(todayAfterSecondReview[0].points, nextLevelThreshold + 1);
    assert.equal(todayAfterSecondReview[0].points_add, 2);
    assert.equal(userAfterSecondReview.honor_title?.id, honorTitles.silver.id);
  } finally {
    await app.entityService.delete('api::honor-title.honor-title', goldTitle.id);
  }
});

test('first review of the day promotes honor title and updates the user-point rank snapshot', async () => {
  const user = await createAuthenticatedUser();
  const reviewedAt = '2026-04-21T12:00:00.000Z';
  const previousDate = '2026-04-20';
  const recordDate = app.service('review-reward-service').getRecordDate(reviewedAt);

  await app.entityService.update('plugin::users-permissions.user', user.id, {
    data: {
      honor_title: honorTitles.bronze.id,
    },
  });

  await app.entityService.create('api::user-point.user-point', {
    data: {
      user: user.id,
      record_date: previousDate,
      points: 2,
      points_add: 0,
      word_count: 0,
      word_add: 0,
      article_count: 0,
      article_add: 0,
      group_rank_change: 0,
      rank: 1,
      rank_change: 0,
    },
  });

  const flashcard = await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      correct_streak: 1,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.warmup.id,
    },
  });

  await app.service('review-event-handler').handleReviewCompleted({
    event: 'flashcard.review.completed',
    eventId: `flashcard-review:first-day-honor-promo:${user.id}`,
    occurredAt: reviewedAt,
    review: {
      flashcardId: flashcard.id,
      userId: user.id,
      username: user.username,
      email: user.email,
      reviewedAt,
      result: 'correct',
      level: 'warmup',
      effective: true,
      newlevel: 'warmup',
    },
  });

  const userWithHonor = await app.entityService.findOne('plugin::users-permissions.user', user.id, {
    populate: {
      honor_title: true,
    },
  });
  const todayUserPoints = await app.entityService.findMany('api::user-point.user-point', {
    filters: {
      user: user.id,
      record_date: recordDate,
    },
  });

  assert.equal(userWithHonor.honor_title?.id, honorTitles.silver.id);
  assert.equal(todayUserPoints.length, 1);
  assert.equal(todayUserPoints[0].points, 3);
  assert.equal(todayUserPoints[0].points_add, 1);
  assert.equal(todayUserPoints[0].rank, 2);
  assert.equal(todayUserPoints[0].rank_change, 1);
});

test('splits a point group when membership reaches the 2x size threshold', async () => {
  await app.db.query('api::point-group.point-group').deleteMany({ where: { id: { $gt: 0 } } });

  await app.entityService.create('api::point-group.point-group', {
    data: {
      group_rank: groupRanks.active.id,
      group_no: 1,
    },
  });

  const firstUser = await createAuthenticatedUser();
  const secondUser = await createAuthenticatedUser();

  const createFlashcardForUser = (userId) => app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: userId,
      correct_streak: 0,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.new.id,
    },
  });

  const firstFlashcard = await createFlashcardForUser(firstUser.id);
  const secondFlashcard = await createFlashcardForUser(secondUser.id);
  const controller = app.controller('api::flashcard.flashcard');

  await controller.review(makeCtx(firstUser, firstFlashcard.id, 'correct'));
  await app.service('review-event-queue').waitForIdle(15000);

  await controller.review(makeCtx(secondUser, secondFlashcard.id, 'correct'));
  await app.service('review-event-queue').waitForIdle();

  const pointGroups = await app.entityService.findMany('api::point-group.point-group', {
    filters: {
      group_rank: groupRanks.active.id,
    },
    sort: ['group_no:asc'],
  });
  const firstUserPointGroups = await app.entityService.findMany('api::user-point-group.user-point-group', {
    filters: {
      user: firstUser.id,
    },
    populate: {
      point_group: true,
    },
  });
  const secondUserPointGroups = await app.entityService.findMany('api::user-point-group.user-point-group', {
    filters: {
      user: secondUser.id,
    },
    populate: {
      point_group: true,
    },
  });

  assert.equal(pointGroups.length, 2);
  assert.equal(pointGroups[0].group_no, 1);
  assert.equal(pointGroups[1].group_no, 2);
  assert.equal(firstUserPointGroups.length, 1);
  assert.equal(secondUserPointGroups.length, 1);
  assert.equal(firstUserPointGroups[0].point_group.id, pointGroups[0].id);
  assert.equal(secondUserPointGroups[0].point_group.id, pointGroups[1].id);
});

test('new user with no group and no title gets a new group and new rank on first review', async () => {
  await app.db.query('api::point-group.point-group').deleteMany({ where: { id: { $gt: 0 } } });

  const user = await createAuthenticatedUser();
  const beforeUser = await app.entityService.findOne('plugin::users-permissions.user', user.id, {
    populate: {
      honor_title: true,
      user_point_groups: true,
    },
  });
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
  await app.service('review-event-queue').waitForIdle();

  const pointGroups = await app.entityService.findMany('api::point-group.point-group', {
    filters: {
      group_rank: groupRanks.active.id,
    },
    sort: ['group_no:asc'],
  });
  const userPointGroups = await app.entityService.findMany('api::user-point-group.user-point-group', {
    filters: { user: user.id },
    populate: {
      point_group: {
        populate: {
          group_rank: true,
        },
      },
    },
  });
  const afterUser = await app.entityService.findOne('plugin::users-permissions.user', user.id, {
    populate: {
      honor_title: true,
    },
  });

  assert.equal(beforeUser.honor_title, null);
  assert.equal(beforeUser.user_point_groups.length, 0);
  assert.equal(pointGroups.length, 1);
  assert.equal(pointGroups[0].group_no, 1);
  assert.equal(userPointGroups.length, 1);
  assert.equal(userPointGroups[0].point_group.id, pointGroups[0].id);
  assert.equal(userPointGroups[0].point_group.group_rank.id, groupRanks.active.id);
  assert.equal(afterUser.honor_title?.id, honorTitles.silver.id);
});

test('user with 279 period points is reassigned to learner rank on the next review', async () => {
  const user = await createAuthenticatedUser();
  const reviewedAt = '2026-04-22T12:00:00.000Z';
  const recordDate = app.service('review-reward-service').getRecordDate(reviewedAt);
  const previousDate = '2026-04-21';
  const activePointGroup = await app.entityService.create('api::point-group.point-group', {
    data: {
      group_rank: groupRanks.active.id,
      group_no: 1,
    },
  });

  await app.entityService.create('api::user-point.user-point', {
    data: {
      user: user.id,
      record_date: previousDate,
      point_group: activePointGroup.id,
      points: 279,
      points_add: 279,
      word_count: 0,
      word_add: 0,
      article_count: 0,
      article_add: 0,
      group_rank_change: 0,
      rank: 0,
      rank_change: 0,
    },
  });

  await app.entityService.create('api::user-point-group.user-point-group', {
    data: {
      user: user.id,
      point_group: activePointGroup.id,
      period_points: 279,
    },
  });

  const flashcard = await app.entityService.create('api::flashcard.flashcard', {
    data: {
      user: user.id,
      correct_streak: 1,
      wrong_streak: 0,
      is_remembered: false,
      review_tire: reviewTiers.warmup.id,
    },
  });

  const event = {
    event: 'flashcard.review.completed',
    eventId: `flashcard-review:learner:${user.id}`,
    occurredAt: reviewedAt,
    review: {
      flashcardId: flashcard.id,
      userId: user.id,
      username: user.username,
      email: user.email,
      reviewedAt,
      result: 'correct',
      level: 'new',
      effective: true,
      newlevel: 'warmup',
    },
  };

  await app.service('review-event-handler').handleReviewCompleted(event);

  const learnerGroups = await app.entityService.findMany('api::point-group.point-group', {
    filters: {
      group_rank: groupRanks.learner.id,
    },
    sort: ['group_no:asc'],
  });
  const userPointGroups = await app.entityService.findMany('api::user-point-group.user-point-group', {
    filters: { user: user.id },
    populate: {
      point_group: {
        populate: {
          group_rank: true,
        },
      },
    },
  });
  const todayUserPoints = await app.entityService.findMany('api::user-point.user-point', {
    filters: {
      user: user.id,
      record_date: recordDate,
    },
    populate: {
      point_group: {
        populate: {
          group_rank: true,
        },
      },
    },
  });

  assert.equal(learnerGroups.length, 1);
  assert.equal(learnerGroups[0].group_no, 1);
  assert.equal(userPointGroups.length, 1);
  assert.equal(userPointGroups[0].period_points, 282);
  assert.equal(userPointGroups[0].point_group.group_rank.id, groupRanks.learner.id);
  assert.equal(todayUserPoints.length, 1);
  assert.equal(todayUserPoints[0].points, 282);
  assert.equal(todayUserPoints[0].points_add, 3);
  assert.equal(todayUserPoints[0].point_group.group_rank.id, groupRanks.learner.id);
});

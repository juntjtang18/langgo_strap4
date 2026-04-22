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
  await app.db.query('api::user-point.user-point').deleteMany({ where: { id: { $gt: 0 } } });
  await app.db.query('api::user-point-group.user-point-group').deleteMany({ where: { id: { $gt: 0 } } });
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

  pointRule = await app.entityService.create('api::point-rule.point-rule', {
    data: {
      review_point: 1,
      review_tier_up_point: 2,
      new_word_point: 0,
      article_point: 0,
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
  await app.service('review-event-queue').waitForIdle();

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
  await app.service('review-event-queue').waitForIdle();

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

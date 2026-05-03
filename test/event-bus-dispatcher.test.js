'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const createDispatcher = require('../src/services/event-bus/dispatcher');

test('event-bus dispatcher publishes username on all rank-related events', async () => {
  const enqueued = [];
  const lookedUpIds = [];

  const dispatcher = createDispatcher({
    queue: {
      enqueue(event) {
        enqueued.push(event);
      },
      waitForIdle() {
        return Promise.resolve();
      },
    },
    strapi: {
      entityService: {
        async findOne(uid, id, query) {
          lookedUpIds.push([uid, id, query]);
          return { id, username: `user-${id}` };
        },
      },
      log: {
        warn() {},
      },
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
      reviewedAt: '2026-05-02T18:35:53.128Z',
    },
  });

  await dispatcher.dispatchFlashcardCreate({
    eventId: 'evt-create',
    flashcard: {
      flashcardId: 91,
      userId: 8,
    },
  });

  await dispatcher.dispatchArticleCreate({
    eventId: 'evt-article',
    article: {
      userArticleId: 55,
      userId: 8,
    },
  });

  await dispatcher.dispatchUserRegister(8);

  assert.equal(lookedUpIds.length, 4);
  assert.deepEqual(enqueued, [
    {
      event_name: 'flashcard.review',
      event_id: 'evt-review',
      userid: '8',
      username: 'user-8',
      flashcard_id: 2627,
      review: {
        flashcardId: 2627,
        userId: 8,
        level: 'monthly',
        result: 'correct',
        newlevel: 'monthly',
        effective: false,
        reviewedAt: '2026-05-02T18:35:53.128Z',
        userName: 'user-8',
      },
    },
    {
      event_name: 'flashcard.create',
      event_id: 'evt-create',
      userid: '8',
      username: 'user-8',
      flashcard_id: 91,
      flashcard: {
        flashcardId: 91,
        userId: 8,
        username: 'user-8',
      },
    },
    {
      event_name: 'article.create',
      event_id: 'evt-article',
      userid: '8',
      username: 'user-8',
      article_id: 55,
      article: {
        userArticleId: 55,
        userId: 8,
        username: 'user-8',
      },
    },
    {
      event_name: 'user.register',
      event_id: enqueued[3].event_id,
      userid: '8',
      username: 'user-8',
    },
  ]);
  assert.ok(typeof enqueued[3].event_id === 'string');
});

'use strict';

const assert = require('node:assert/strict');
const { execFileSync } = require('node:child_process');
const path = require('node:path');
const test = require('node:test');
const { createEventBus } = require('@langgo/event-bus-client');

const composeFile = path.resolve(__dirname, '../docker-compose.e2e-subsystems.yml');
const projectName = process.env.LANGGO_E2E_DOCKER_PROJECT || 'langgo-subsystem-e2e';
const postgresPort = process.env.LANGGO_E2E_POSTGRES_PORT || '55432';
const rankPort = process.env.LANGGO_E2E_RANK_PORT || '18080';
const achievementPort = process.env.LANGGO_E2E_ACHIEVEMENT_PORT || '18081';

const dockerCompose = (...args) => execFileSync(
  'docker',
  ['compose', '-f', composeFile, '-p', projectName, ...args],
  { stdio: 'inherit' }
);

const dockerComposeOutput = (...args) => execFileSync(
  'docker',
  ['compose', '-f', composeFile, '-p', projectName, ...args],
  { encoding: 'utf8' }
);

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function waitFor(check, predicate, timeoutMs = 60000) {
  const startedAt = Date.now();
  let lastValue;
  let lastError;

  while (Date.now() - startedAt < timeoutMs) {
    try {
      lastValue = await check();
      if (predicate(lastValue)) {
        return lastValue;
      }
    } catch (error) {
      lastError = error;
    }

    await sleep(500);
  }

  if (lastError) {
    throw lastError;
  }

  throw new Error(`Timed out after ${timeoutMs}ms. Last value: ${JSON.stringify(lastValue)}`);
}

async function waitForSubsystems() {
  await Promise.all([
    waitFor(
      () => fetchJson(`http://127.0.0.1:${rankPort}/api/v1/healthz`),
      (result) => result.status === 200
    ),
    waitFor(
      () => fetchJson(`http://127.0.0.1:${achievementPort}/api/v1/healthz`, {
        headers: {
          'x-internal-key': 'test-achievement-key',
        },
      }),
      (result) => result.status === 200
    ),
  ]);
}

async function fetchJson(url, options = {}) {
  const response = await fetch(url, {
    ...options,
    headers: {
      accept: 'application/json',
      ...(options.headers || {}),
    },
  });
  const text = await response.text();
  const body = text ? JSON.parse(text) : null;

  return {
    status: response.status,
    body,
  };
}

function createStrapiMock() {
  return {
    log: {
      info() {},
      warn() {},
      error() {},
    },
  };
}

function runPostgresSql(sql) {
  dockerCompose(
    'exec',
    '-T',
    'postgres',
    'psql',
    '-U',
    'postgres',
    '-d',
    'langgo_e2e',
    '-v',
    'ON_ERROR_STOP=1',
    '-c',
    sql
  );
}

function seedSubsystemData() {
  runPostgresSql(`
    TRUNCATE TABLE
      rank_system.rs_events,
      rank_system.rs_user_snapshots,
      rank_system.rs_user_groups,
      rank_system.rs_groups,
      rank_system.rs_group_rank_titles,
      rank_system.rs_group_ranks,
      rank_system.rs_level_titles,
      rank_system.rs_levels,
      rank_system.rs_event_lists,
      rank_system.rs_level_rules,
      rank_system.rs_group_rules
    RESTART IDENTITY CASCADE;

    INSERT INTO rank_system.rs_group_rules (id, period_days, group_size, created_at, updated_at)
    VALUES (1, 7, 20, NOW(), NOW());

    INSERT INTO rank_system.rs_level_rules (id, base_points, increase_points, created_at, updated_at)
    VALUES (1, 10, 10, NOW(), NOW());

    INSERT INTO rank_system.rs_event_lists (id, event_name, points, created_at, updated_at)
    VALUES
      (1, 'user.registered', 0, NOW(), NOW()),
      (2, 'user_profile.visibility_updated', 0, NOW(), NOW()),
      (3, 'flashcard.created', 2, NOW(), NOW()),
      (4, 'flashcard.reviewed', 5, NOW(), NOW()),
      (5, 'flashcard.review_tier_promoted', 7, NOW(), NOW()),
      (6, 'flashcard.remembered', 0, NOW(), NOW()),
      (7, 'article.created', 3, NOW(), NOW());

    INSERT INTO rank_system.rs_group_ranks (id, rs_group_rule_id, rank_no, min_period_points, created_at, updated_at)
    VALUES
      (1, 1, 1, 0, NOW(), NOW()),
      (2, 1, 2, 10, NOW(), NOW());

    INSERT INTO rank_system.rs_group_rank_titles (id, rs_group_rank_id, locale, title, created_at, updated_at)
    VALUES
      (1, 1, 'en', 'Starter', NOW(), NOW()),
      (2, 2, 'en', 'Active', NOW(), NOW());

    INSERT INTO rank_system.rs_levels (id, level_no, created_at, updated_at)
    VALUES
      (1, 1, NOW(), NOW()),
      (2, 2, NOW(), NOW());

    INSERT INTO rank_system.rs_level_titles (id, rs_level_id, locale, title, created_at, updated_at)
    VALUES
      (1, 1, 'en', 'Level 1', NOW(), NOW()),
      (2, 2, 'en', 'Level 2', NOW(), NOW());
  `);

  runPostgresSql(`
    TRUNCATE TABLE
      achievement_system.as_achievement_change_logs,
      achievement_system.as_event_logs,
      achievement_system.as_user_achievements,
      achievement_system.as_achievement_translations,
      achievement_system.as_achievements,
      achievement_system.as_event_lists
    RESTART IDENTITY CASCADE;

    INSERT INTO achievement_system.as_event_lists (id, event_name, points, created_at, updated_at)
    VALUES
      (1, 'flashcard.created', 1, NOW(), NOW()),
      (2, 'flashcard.reviewed', 2, NOW(), NOW()),
      (3, 'flashcard.remembered', 5, NOW(), NOW()),
      (4, 'article.created', 1, NOW(), NOW());

    INSERT INTO achievement_system.as_achievements (id, code, event_name, icon_name, points, goal, created_at, updated_at)
    VALUES
      (1, 'flashcard-created-1', 'flashcard.created', 'pencil', 1, 1, NOW(), NOW()),
      (2, 'flashcard-reviewed-2', 'flashcard.reviewed', 'checkmark.circle', 2, 4, NOW(), NOW());

    INSERT INTO achievement_system.as_achievement_translations (id, achievement_id, locale, title, description, created_at, updated_at)
    VALUES
      (1, 1, 'en', 'Create a Flashcard', 'Create your first flashcard', NOW(), NOW()),
      (2, 2, 'en', 'Review Twice', 'Complete two effective reviews', NOW(), NOW());
  `);
}

async function fetchRankSnapshot(userId) {
  return fetchJson(`http://127.0.0.1:${rankPort}/api/v1/rank/users/${encodeURIComponent(userId)}?locale=en`, {
    headers: {
      'x-internal-key': 'test-rank-key',
      'x-user-id': String(userId),
      'x-user-locale': 'en',
    },
  });
}

async function fetchAchievementRows(userId) {
  const headers = {
    'x-internal-key': 'test-achievement-key',
    'x-user-id': String(userId),
    'x-user-locale': 'en',
  };

  const [achieved, notAchieved] = await Promise.all([
    fetchJson(`http://127.0.0.1:${achievementPort}/api/v1/achievements-achieved?locale=en`, { headers }),
    fetchJson(`http://127.0.0.1:${achievementPort}/api/v1/achievements-not-achieved?locale=en`, { headers }),
  ]);

  assert.equal(achieved.status, 200, `achieved response failed: ${JSON.stringify(achieved.body)}`);
  assert.equal(notAchieved.status, 200, `not-achieved response failed: ${JSON.stringify(notAchieved.body)}`);

  return [
    ...(achieved.body?.data || []),
    ...(notAchieved.body?.data || []),
  ];
}

test('docker e2e: Strapi event bus reaches rank-server and achievement-server', { timeout: 240000 }, async (t) => {
  if (process.env.LANGGO_E2E_DOCKER !== 'true') {
    t.skip('Set LANGGO_E2E_DOCKER=true to build/start subsystem Docker containers for this e2e test.');
    return;
  }

  let eventBus;
  const previousEventBusUrl = process.env.EVENT_BUS_POSTGRES_URL;
  const previousEventBusPrefix = process.env.EVENT_BUS_CHANNEL_PREFIX;
  const userId = Number(process.env.LANGGO_E2E_USER_ID || `${Date.now()}`.slice(-9));
  const username = process.env.LANGGO_E2E_USERNAME || `strapi-e2e-${userId}`;
  const flashcardId = Number(process.env.LANGGO_E2E_FLASHCARD_ID || `${Date.now()}`.slice(-8));
  const occurredAt = new Date().toISOString();
  const eventId = `flashcard.created:${flashcardId}:docker-e2e:${userId}:${occurredAt}`;

  try {
    dockerCompose('up', '-d', '--build');

    await waitForSubsystems();

    seedSubsystemData();
    dockerCompose('restart', 'rank-server', 'achievement-server');
    await waitForSubsystems();

    process.env.EVENT_BUS_POSTGRES_URL = `postgres://postgres:postgres@127.0.0.1:${postgresPort}/langgo_e2e`;
    process.env.EVENT_BUS_CHANNEL_PREFIX = 'event_bus';
    eventBus = createEventBus({
      driver: 'postgres',
      config: {
        connectionString: process.env.EVENT_BUS_POSTGRES_URL,
        channelPrefix: process.env.EVENT_BUS_CHANNEL_PREFIX,
      },
    });

    const publishResult = await eventBus.publish('flashcard.created', {
      eventId,
      eventType: 'flashcard.created',
      occurredAt,
      flashcardId,
      userId,
      username,
    }, {
      source: 'strapi.docker-e2e-subsystem-event-bus',
      metadata: {
        publisher: 'test/e2e-subsystem-event-bus.test.js',
      },
    });

    assert.equal(publishResult.topic, 'flashcard.created');

    const rankResponse = await waitFor(
      () => fetchRankSnapshot(userId),
      (result) => {
        const snapshot = result.body?.data?.latest_snapshot;
        return result.status === 200 &&
          snapshot?.userid === String(userId) &&
          Number(snapshot.word_count || 0) >= 1 &&
          Number(snapshot.total_points || 0) >= 2;
      }
    );

    assert.equal(rankResponse.body.data.latest_snapshot.userid, String(userId));
    assert.ok(Number(rankResponse.body.data.latest_snapshot.word_count) >= 1);
    assert.ok(Number(rankResponse.body.data.latest_snapshot.total_points) >= 2);

    const achievementRows = await waitFor(
      () => fetchAchievementRows(userId),
      (rows) => rows.some((row) => row.code === 'flashcard-created-1' && row.achieved === true && Number(row.progress || 0) >= 1)
    );

    assert.ok(
      achievementRows.some((row) => row.code === 'flashcard-created-1' && row.achieved === true && Number(row.progress || 0) >= 1),
      'achievement-server did not apply flashcard.created progress'
    );
  } finally {
    if (eventBus) {
      await eventBus.close();
    }

    if (previousEventBusUrl === undefined) {
      delete process.env.EVENT_BUS_POSTGRES_URL;
    } else {
      process.env.EVENT_BUS_POSTGRES_URL = previousEventBusUrl;
    }

    if (previousEventBusPrefix === undefined) {
      delete process.env.EVENT_BUS_CHANNEL_PREFIX;
    } else {
      process.env.EVENT_BUS_CHANNEL_PREFIX = previousEventBusPrefix;
    }

    try {
      dockerCompose('down', '-v', '--remove-orphans');
    } catch (error) {
      const logs = dockerComposeOutput('logs', '--no-color');
      console.error(logs);
      throw error;
    }
  }
});

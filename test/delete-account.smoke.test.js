'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const crypto = require('node:crypto');

const baseUrl = process.env.LANGGO_SMOKE_BASE_URL || 'http://localhost:1338';

const ensureBaseUrlReachable = async (t) => {
  try {
    await fetch(`${baseUrl}/api/ping`, {
      signal: AbortSignal.timeout(3000),
    });
    return true;
  } catch (error) {
    t.skip(`Smoke target is unavailable at ${baseUrl}: ${error.cause?.code || error.message}`);
    return false;
  }
};

const requestJson = async (path, options = {}) => {
  const response = await fetch(`${baseUrl}${path}`, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...(options.headers || {}),
    },
  });

  const body = await response.json();
  return { response, body };
};

test('DELETE /api/users/me deletes a temporary account after password confirmation', async (t) => {
  if (!(await ensureBaseUrlReachable(t))) {
    return;
  }

  const suffix = `${Date.now()}-${crypto.randomBytes(3).toString('hex')}`;
  const email = `delete-smoke-${suffix}@langgo.ca`;
  const username = `delete-smoke-${suffix}`;
  const password = 'Passw0rd';

  const registerResult = await requestJson('/api/auth/local/register', {
    method: 'POST',
    body: JSON.stringify({
      email,
      username,
      password,
      baseLanguage: 'zh-Hans',
      visible_on_ladder: false,
    }),
  });

  assert.equal(registerResult.response.status, 200, `register failed: ${JSON.stringify(registerResult.body)}`);
  assert.ok(registerResult.body.jwt, 'register should return jwt');
  assert.ok(registerResult.body.user?.id, 'register should return user id');

  const deleteResult = await requestJson('/api/users/me', {
    method: 'DELETE',
    headers: {
      Authorization: `Bearer ${registerResult.body.jwt}`,
      'X-Account-Delete-Password': password,
    },
  });

  assert.equal(deleteResult.response.status, 200, `delete failed: ${JSON.stringify(deleteResult.body)}`);
  assert.equal(deleteResult.body.ok, true);
  assert.equal(deleteResult.body.deletedUserId, registerResult.body.user.id);

  const meAfterDelete = await requestJson('/api/users/me', {
    method: 'GET',
    headers: {
      Authorization: `Bearer ${registerResult.body.jwt}`,
    },
  });

  assert.notEqual(meAfterDelete.response.status, 200, 'deleted token should no longer resolve a user');

  const loginAfterDelete = await requestJson('/api/auth/local', {
    method: 'POST',
    body: JSON.stringify({
      identifier: email,
      password,
    }),
  });

  assert.notEqual(
    loginAfterDelete.response.status,
    200,
    'deleted account should no longer be able to log in'
  );
});

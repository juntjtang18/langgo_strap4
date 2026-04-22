'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const baseUrl = process.env.LANGGO_SMOKE_BASE_URL || 'http://localhost:1338';
const identifier = process.env.LANGGO_SMOKE_EMAIL;
const password = process.env.LANGGO_SMOKE_PASSWORD;

const requireSmokeConfig = () => {
  if (!identifier || !password) {
    throw new Error(
      'LANGGO_SMOKE_EMAIL and LANGGO_SMOKE_PASSWORD are required for smoke tests.'
    );
  }
};

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

const login = async () => {
  requireSmokeConfig();

  const response = await fetch(`${baseUrl}/api/auth/local`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      identifier,
      password,
    }),
  });

  const body = await response.json();
  assert.equal(response.status, 200, `login failed: ${JSON.stringify(body)}`);
  assert.ok(body.jwt, 'login response should contain jwt');

  return body;
};

const getWithJwt = async (path, jwt) => {
  const response = await fetch(`${baseUrl}${path}`, {
    headers: {
      Authorization: `Bearer ${jwt}`,
      'Content-Type': 'application/json',
    },
  });

  const body = await response.json();
  assert.equal(response.status, 200, `GET ${path} failed: ${JSON.stringify(body)}`);
  return body;
};

const putWithJwt = async (path, jwt, data) => {
  const response = await fetch(`${baseUrl}${path}`, {
    method: 'PUT',
    headers: {
      Authorization: `Bearer ${jwt}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ data }),
  });

  const body = await response.json();
  assert.equal(response.status, 200, `PUT ${path} failed: ${JSON.stringify(body)}`);
  return body;
};

test('GET /api/users/me returns the customized user/profile payload', async (t) => {
  if (!(await ensureBaseUrlReachable(t))) {
    return;
  }
  const { jwt } = await login();
  const me = await getWithJwt('/api/users/me', jwt);

  assert.equal(me.email, identifier);
  assert.equal(typeof me.id, 'number');
  assert.equal(typeof me.username, 'string');
  assert.equal(typeof me.confirmed, 'boolean');
  assert.equal(typeof me.blocked, 'boolean');

  assert.ok(me.role, 'me.role should be present');
  assert.equal(typeof me.role.id, 'number');
  assert.equal(typeof me.role.name, 'string');
  assert.equal(typeof me.role.type, 'string');

  assert.ok(me.user_profile, 'me.user_profile should be present');
  assert.equal(typeof me.user_profile.id, 'number');
  assert.equal(typeof me.user_profile.baseLanguage, 'string');
  assert.ok('telephone' in me.user_profile);
  assert.ok('proficiency' in me.user_profile);
  assert.ok('reminder_enabled' in me.user_profile);
  assert.ok('Bio' in me.user_profile);
  assert.ok('avatar_img' in me.user_profile);
  assert.ok('visible_on_ladder' in me.user_profile);
  assert.equal(typeof me.user_profile.visible_on_ladder, 'boolean');

  if (me.user_profile.avatar_img) {
    assert.ok(me.user_profile.avatar_img.data);
    assert.equal(typeof me.user_profile.avatar_img.data.id, 'number');
    assert.equal(typeof me.user_profile.avatar_img.data.attributes.url, 'string');
  }
});

test('GET /api/user-profiles/mine returns the authenticated user profile and matches /api/users/me', async (t) => {
  if (!(await ensureBaseUrlReachable(t))) {
    return;
  }
  const { jwt } = await login();
  const me = await getWithJwt('/api/users/me', jwt);
  const mine = await getWithJwt('/api/user-profiles/mine', jwt);

  assert.ok(mine.data, 'mine.data should be present');
  assert.equal(mine.data.id, me.user_profile.id);
  assert.ok(mine.data.attributes, 'mine.data.attributes should be present');

  const attrs = mine.data.attributes;
  assert.equal(attrs.baseLanguage, me.user_profile.baseLanguage);
  assert.ok('telephone' in attrs);
  assert.ok('proficiency' in attrs);
  assert.ok('reminder_enabled' in attrs);
  assert.ok('Bio' in attrs);
  assert.ok('avatar_img' in attrs);
  assert.ok('visible_on_ladder' in attrs);
  assert.equal(typeof attrs.visible_on_ladder, 'boolean');

  assert.ok(attrs.user?.data, 'mine.data.attributes.user.data should be present');
  assert.equal(attrs.user.data.id, me.id);
  assert.equal(attrs.user.data.attributes.email, me.email);
  assert.equal(attrs.user.data.attributes.username, me.username);

  if (attrs.avatar_img) {
    assert.ok('data' in attrs.avatar_img);
  }
});

test('PUT /api/user-profiles/mine updates visible_on_ladder and GET endpoints reflect it', async (t) => {
  if (!(await ensureBaseUrlReachable(t))) {
    return;
  }

  const { jwt } = await login();
  const before = await getWithJwt('/api/user-profiles/mine', jwt);
  const originalValue = before.data.attributes.visible_on_ladder;
  const toggledValue = !originalValue;

  const updated = await putWithJwt('/api/user-profiles/mine', jwt, {
    visible_on_ladder: toggledValue,
  });

  assert.equal(updated.data.attributes.visible_on_ladder, toggledValue);

  const meAfterToggle = await getWithJwt('/api/users/me', jwt);
  assert.equal(meAfterToggle.user_profile.visible_on_ladder, toggledValue);

  const restored = await putWithJwt('/api/user-profiles/mine', jwt, {
    visible_on_ladder: originalValue,
  });

  assert.equal(restored.data.attributes.visible_on_ladder, originalValue);

  const meAfterRestore = await getWithJwt('/api/users/me', jwt);
  assert.equal(meAfterRestore.user_profile.visible_on_ladder, originalValue);
});

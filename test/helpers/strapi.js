'use strict';

const Strapi = require('@strapi/strapi');

const setDefaultEnv = () => {
  process.env.NODE_ENV = process.env.NODE_ENV || 'test';
  process.env.HOST = process.env.HOST || '127.0.0.1';
  process.env.PORT = process.env.PORT || '1337';
  process.env.IS_LOCAL = process.env.IS_LOCAL || 'true';
  process.env.CRON_ENABLED = process.env.CRON_ENABLED || 'false';
  process.env.DISABLE_BACKGROUND_TASKS = process.env.DISABLE_BACKGROUND_TASKS || 'true';
  process.env.APP_KEYS = process.env.APP_KEYS || 'testKeyA,testKeyB,testKeyC,testKeyD';
  process.env.API_TOKEN_SALT = process.env.API_TOKEN_SALT || 'testApiTokenSalt';
  process.env.ADMIN_JWT_SECRET = process.env.ADMIN_JWT_SECRET || 'testAdminJwtSecret';
  process.env.JWT_SECRET = process.env.JWT_SECRET || 'testJwtSecret';
  process.env.TRANSFER_TOKEN_SALT = process.env.TRANSFER_TOKEN_SALT || 'testTransferTokenSalt';
  process.env.OPENAI_API_KEY = process.env.OPENAI_API_KEY || 'test-openai-key';
};

const assertSafeTestDatabase = () => {
  const databaseName = process.env.DATABASE_NAME;
  const databaseSchema = process.env.DATABASE_SCHEMA;

  if (/(test|ci)/i.test(databaseName || '') || /(test|ci)/i.test(databaseSchema || '')) {
    return;
  }

  throw new Error(
    'Integration tests require DATABASE_NAME or DATABASE_SCHEMA to be explicitly set to a test/ci target.'
  );
};

const createStrapi = async () => {
  setDefaultEnv();
  assertSafeTestDatabase();
  const appContext = await Strapi.compile();
  const app = Strapi(appContext);
  await app.load();
  return app;
};

const destroyStrapi = async (app) => {
  if (app) {
    await app.destroy();
  }
};

module.exports = {
  createStrapi,
  destroyStrapi,
};

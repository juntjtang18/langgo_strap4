// src/middlewares/redis-cache.js
'use strict';
const Redis = require('ioredis');

let redis;

function getRedisClient() {
  if (!redis) {
    redis = new Redis({
      host: process.env.REDIS_HOST || '127.0.0.1',
      port: process.env.REDIS_PORT || 6379,
      reconnectOnError: () => true,
      retryStrategy: times => Math.min(times * 50, 2000),
    });

    redis.on('connect', () => console.log('✅ Connected to Redis'));
    redis.on('error', err => console.error('❌ Redis connection error:', err));
    redis.on('end', () => console.warn('⚠️ Redis connection closed'));
  }
  return redis;
}

module.exports = (config, { strapi }) => {
  const ttl = config.ttl || 60;
  const redisEnabled = process.env.ENABLE_REDIS_CACHE === 'true';

  return async (ctx, next) => {
    if (!redisEnabled || ctx.method !== 'GET') {
      return next(); // Skip if disabled or not a GET
    }

    const userId = ctx.state?.user?.id || 'anonymous';
    const key = `cache:user:${userId}:${ctx.request.url}`;
    const redisClient = getRedisClient();

    try {
      const cached = await redisClient.get(key);
      if (cached) {
        ctx.set('X-Cache', 'HIT');
        ctx.body = JSON.parse(cached);
        return;
      }
    } catch (err) {
      strapi.log.warn(`⚠️ Redis GET failed for ${key}: ${err.message}`);
    }

    await next();

    if (ctx.status === 200 && ctx.body) {
      try {
        await redisClient.setex(key, ttl, JSON.stringify(ctx.body));
        ctx.set('X-Cache', 'MISS');
      } catch (err) {
        strapi.log.warn(`⚠️ Redis SET failed for ${key}: ${err.message}`);
      }
    }
  };
};

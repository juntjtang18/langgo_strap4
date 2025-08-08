'use strict';

const Redis = require('ioredis');

let redis;

function getRedisClient() {
  if (!redis) {
    redis = new Redis({
      host: process.env.REDIS_HOST,
      port: process.env.REDIS_PORT,
      // password: process.env.REDIS_PASSWORD, // if needed
      reconnectOnError: () => true,
      retryStrategy: times => Math.min(times * 50, 2000),
    });

    redis.on('connect', () => {
      console.log('✅ Connected to Redis');
    });

    redis.on('error', (err) => {
      console.error('❌ Redis connection error:', err);
    });

    redis.on('end', () => {
      console.warn('⚠️ Redis connection closed');
    });
  }

  return redis;
}

module.exports = (config, { strapi }) => {
  const ttl = config.ttl || 60;

  return async (ctx, next) => {
    if (ctx.method !== 'GET') return next();

    const redisClient = getRedisClient();
    const userId = ctx.state?.user?.id || 'anonymous';
    const key = `cache:user:${userId}:${ctx.request.url}`;
//        const key = `cache:${ctx.request.url}`;

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

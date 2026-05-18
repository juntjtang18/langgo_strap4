'use strict';

const { createEventBus } = require('@langgo/event-bus-client');

const REDACTED_HEADER_NAMES = new Set([
  'authorization',
  'cookie',
  'x-api-key',
  'x-internal-key',
]);

let eventBusClient = null;

function buildDatabaseConnectionStringFromEnv() {
  const user = encodeURIComponent(process.env.DATABASE_USERNAME || 'strapi');
  const password = encodeURIComponent(process.env.DATABASE_PASSWORD || '');
  const database = encodeURIComponent(process.env.DATABASE_NAME || '');
  const host = process.env.DATABASE_HOST || 'localhost';
  const port = process.env.DATABASE_PORT || '5432';

  if (host.startsWith('/')) {
    return `postgresql://${user}:${password}@localhost:${port}/${database}?host=${encodeURIComponent(host)}`;
  }

  return `postgresql://${user}:${password}@${host}:${port}/${database}`;
}

function getEventBusConnectionString() {
  return buildDatabaseConnectionStringFromEnv();
}

function getEventBusClient(strapi) {
  if (eventBusClient) {
    return eventBusClient;
  }

  const driver = process.env.EVENT_BUS_DRIVER || 'postgres';
  if (driver !== 'postgres') {
    throw new Error(`Unsupported EVENT_BUS_DRIVER "${driver}" in Strapi event publisher.`);
  }

  const logger = {
    info(message, meta) {
      strapi.log?.info?.(meta ? `${message} ${JSON.stringify(meta)}` : message);
    },
    warn(message, meta) {
      strapi.log?.warn?.(meta ? `${message} ${JSON.stringify(meta)}` : message);
    },
    error(message, meta) {
      strapi.log?.error?.(meta ? `${message} ${JSON.stringify(meta)}` : message);
    },
  };

  eventBusClient = createEventBus({
    driver: 'postgres',
    config: {
      connectionString: getEventBusConnectionString(),
      channelPrefix: process.env.EVENT_BUS_CHANNEL_PREFIX || 'event_bus',
      logger,
    },
    logger,
  });

  return eventBusClient;
}

function safeJson(value) {
  if (value == null) {
    return {};
  }

  try {
    return JSON.parse(JSON.stringify(value));
  } catch {
    return { unserializable: true };
  }
}

function sanitizeHeaders(headers = {}) {
  return Object.fromEntries(
    Object.entries(headers).map(([key, value]) => [
      key,
      REDACTED_HEADER_NAMES.has(String(key).toLowerCase()) ? '[redacted]' : value,
    ])
  );
}

function buildRequestContext(ctx) {
  if (!ctx) {
    return {};
  }

  return {
    method: ctx.method || null,
    path: ctx.path || null,
    url: ctx.url || null,
    origin: ctx.get?.('origin') || null,
    referer: ctx.get?.('referer') || null,
    userAgent: ctx.get?.('user-agent') || null,
    host: ctx.get?.('host') || null,
    ip: ctx.ip || null,
    ips: ctx.ips || [],
    headers: sanitizeHeaders(ctx.headers || {}),
  };
}

async function recordEventPublishAudit(strapi, {
  eventName,
  payload,
  options = {},
  ctx = null,
  status = 'accepted',
  errorMessage = null,
  publishResult = null,
}) {
  if (!strapi?.entityService?.create) {
    return;
  }

  const metadata = options.metadata && typeof options.metadata === 'object' ? options.metadata : {};
  const requestContext = buildRequestContext(ctx);

  try {
    await strapi.entityService.create('api::event-publish-log.event-publish-log', {
      data: {
        event_id: payload?.eventId || null,
        event_name: eventName,
        event_type: payload?.eventType || eventName,
        user_id: payload?.userId == null ? null : String(payload.userId),
        username: payload?.username || null,
        source: options.source || null,
        publisher: metadata.publisher || null,
        occurred_at: payload?.occurredAt || null,
        status,
        error_message: errorMessage,
        request_method: requestContext.method || null,
        request_path: requestContext.path || null,
        request_host: requestContext.host || null,
        request_origin: requestContext.origin || null,
        request_user_agent: requestContext.userAgent || null,
        payload_json: safeJson(payload),
        metadata_json: safeJson(metadata),
        request_json: safeJson(requestContext),
        publish_result_json: safeJson(publishResult),
      },
    });
  } catch (error) {
    strapi.log?.error?.(`[EventPublishAudit] failed to write audit row for ${eventName}: ${error.message}`);
  }
}

async function publishEventWithAudit(strapi, eventName, payload, options = {}, ctx = null) {
  const publishResult = {
    accepted: true,
    event: {
      id: payload?.eventId || null,
      event_id: payload?.eventId || null,
      event_name: eventName,
      payload: safeJson(payload),
      source: options.source || 'unknown',
      occurred_at: payload?.occurredAt || new Date().toISOString(),
      metadata: safeJson(options.metadata),
    },
  };

  try {
    const client = options.eventBusClient || strapi.eventBusClient || getEventBusClient(strapi);
    setImmediate(() => {
      client.publish(eventName, payload).catch((error) => {
        strapi.log?.error?.(`[EventPublisher] publish failed for ${eventName}: ${error.message}`);
      });
    });
  } catch (error) {
    await recordEventPublishAudit(strapi, {
      eventName,
      payload,
      options,
      ctx,
      status: 'failed',
      errorMessage: error instanceof Error ? error.message : String(error),
    });
    throw error;
  }

  await recordEventPublishAudit(strapi, {
    eventName,
    payload,
    options,
    ctx,
    status: 'accepted',
    publishResult,
  });

  return publishResult;
}

module.exports = {
  getEventBusConnectionString,
  getEventBusClient,
  publishEventWithAudit,
  recordEventPublishAudit,
};

'use strict';

const { v4: uuidv4 } = require('uuid');
const { createEventBus } = require('@langgo/event-bus-client');

const PUBLISH_LOG_TABLE = 'public.strapi_event_publish_logs';

module.exports = ({ strapi, eventBusClient } = {}) => {
  const subscribersByEvent = new Map();
  const client = eventBusClient || createClientFromEnv(strapi);
  let ensurePublishLogTablePromise = null;

  const getRegistry = (eventName) => {
    if (!subscribersByEvent.has(eventName)) {
      subscribersByEvent.set(eventName, new Map());
    }

    return subscribersByEvent.get(eventName);
  };

  const normalizeMetadata = (metadata) => {
    if (!metadata || typeof metadata !== 'object' || Array.isArray(metadata)) {
      return {};
    }

    return metadata;
  };

  const createAcceptedEvent = (eventName, payload, options = {}) => {
    const normalizedPayload = payload && typeof payload === 'object' ? payload : {};
    const eventId = normalizedPayload.eventId || uuidv4();
    const occurredAt = normalizedPayload.occurredAt || new Date().toISOString();

    return {
      id: eventId,
      event_id: eventId,
      event_name: eventName,
      payload: normalizedPayload,
      source: options.source || 'unknown',
      occurred_at: occurredAt,
      metadata: normalizeMetadata(options.metadata),
    };
  };

  const safeJson = (value) => {
    if (value == null) {
      return {};
    }
    try {
      return JSON.parse(JSON.stringify(value));
    } catch {
      return { unserializable: true };
    }
  };

  const ensurePublishLogTable = async () => {
    if (!ensurePublishLogTablePromise) {
      ensurePublishLogTablePromise = strapi.db.connection.raw(`
        CREATE TABLE IF NOT EXISTS ${PUBLISH_LOG_TABLE} (
          id BIGSERIAL PRIMARY KEY,
          event_id TEXT,
          event_name TEXT NOT NULL,
          source TEXT,
          status TEXT NOT NULL DEFAULT 'accepted',
          error_message TEXT,
          payload_json JSONB NOT NULL DEFAULT '{}'::jsonb,
          metadata_json JSONB NOT NULL DEFAULT '{}'::jsonb,
          request_json JSONB NOT NULL DEFAULT '{}'::jsonb,
          publish_ack_json JSONB NOT NULL DEFAULT '{}'::jsonb,
          created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
          published_at TIMESTAMPTZ,
          updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
        );
        CREATE INDEX IF NOT EXISTS strapi_event_publish_logs_event_name_idx
          ON ${PUBLISH_LOG_TABLE} (event_name, created_at DESC);
        CREATE INDEX IF NOT EXISTS strapi_event_publish_logs_event_id_idx
          ON ${PUBLISH_LOG_TABLE} (event_id);
        CREATE INDEX IF NOT EXISTS strapi_event_publish_logs_status_idx
          ON ${PUBLISH_LOG_TABLE} (status, created_at DESC);
      `);
    }

    return ensurePublishLogTablePromise;
  };

  const insertPublishLog = async (event, requestContext = {}) => {
    await ensurePublishLogTable();
    const result = await strapi.db.connection.raw(
      `INSERT INTO ${PUBLISH_LOG_TABLE}
        (event_id, event_name, source, status, payload_json, metadata_json, request_json)
       VALUES (?, ?, ?, 'accepted', ?::jsonb, ?::jsonb, ?::jsonb)
       RETURNING id`,
      [
        event.event_id,
        event.event_name,
        event.source,
        JSON.stringify(safeJson(event.payload)),
        JSON.stringify(safeJson(event.metadata)),
        JSON.stringify(safeJson(requestContext)),
      ]
    );

    return result.rows?.[0]?.id ?? result[0]?.id ?? null;
  };

  const updatePublishLog = async (id, status, { ack = {}, errorMessage = null } = {}) => {
    if (!id) {
      return;
    }
    await strapi.db.connection.raw(
      `UPDATE ${PUBLISH_LOG_TABLE}
       SET status = ?,
           error_message = ?,
           publish_ack_json = ?::jsonb,
           published_at = CASE WHEN ? = 'published' THEN NOW() ELSE published_at END,
           updated_at = NOW()
       WHERE id = ?`,
      [status, errorMessage, JSON.stringify(safeJson(ack)), status, id]
    );
  };

  return {
    async initializeRegistry() {
      const unsubscriptions = [];

      for (const registry of subscribersByEvent.values()) {
        for (const entry of registry.values()) {
          if (entry?.handlePromise) {
            unsubscriptions.push(
              entry.handlePromise
                .then((handle) => handle?.unsubscribe?.())
                .catch((error) => {
                  strapi.log.error(`[EventBus] failed to unsubscribe during registry reset: ${error.message}`);
                })
            );
          }
        }
      }

      subscribersByEvent.clear();
      await Promise.allSettled(unsubscriptions);
    },

    async subscribe(eventName, subscriberName, handler) {
      if (!eventName || typeof eventName !== 'string') {
        throw new Error('eventName is required');
      }
      if (!subscriberName || typeof subscriberName !== 'string') {
        throw new Error('subscriberName is required');
      }
      if (typeof handler !== 'function') {
        throw new Error('handler must be a function');
      }

      const registry = getRegistry(eventName);
      const existing = registry.get(subscriberName);
      if (existing?.handlePromise) {
        await existing.handlePromise.then((handle) => handle?.unsubscribe?.()).catch(() => {});
      }

      const handlePromise = client.subscribe(
        eventName,
        async (message) => {
          await handler({
            id: message.id || message.payload?.eventId || null,
            event_id: message.id || message.payload?.eventId || null,
            event_name: message.topic,
            payload: message.payload && typeof message.payload === 'object' ? message.payload : {},
            occurred_at: message.publishedAt || null,
            raw: message.raw,
          });
          await message.ack();
        },
        { consumerName: subscriberName }
      );

      registry.set(subscriberName, { handlePromise });
      strapi.log.info(`[EventBus] subscriber registered: ${subscriberName} -> ${eventName}`);
    },

    async unsubscribe(eventName, subscriberName) {
      const registry = subscribersByEvent.get(eventName);
      if (!registry) {
        return false;
      }

      const entry = registry.get(subscriberName);
      if (!entry) {
        return false;
      }

      registry.delete(subscriberName);
      if (registry.size === 0) {
        subscribersByEvent.delete(eventName);
      }

      if (entry.handlePromise) {
        await entry.handlePromise.then((handle) => handle?.unsubscribe?.()).catch((error) => {
          strapi.log.error(`[EventBus] subscriber remove failed: ${subscriberName} -> ${eventName}: ${error.message}`);
        });
      }

      strapi.log.info(`[EventBus] subscriber removed: ${subscriberName} -> ${eventName}`);
      return true;
    },

    listSubscribers(eventName) {
      const registry = subscribersByEvent.get(eventName);
      return registry ? Array.from(registry.keys()) : [];
    },

    async clearSubscribers(eventName) {
      const registry = subscribersByEvent.get(eventName);
      if (!registry) {
        return 0;
      }

      const names = Array.from(registry.keys());
      for (const subscriberName of names) {
        await this.unsubscribe(eventName, subscriberName);
      }

      return names.length;
    },

    publish(eventName, payload, options = {}) {
      if (!eventName || typeof eventName !== 'string') {
        throw new Error('eventName is required');
      }

      const event = createAcceptedEvent(eventName, payload, options);
      strapi.log.info(`[EventBus] publishing event: ${event.event_name}`);

      setImmediate(() => {
        (async () => {
          let publishLogId = null;
          try {
            publishLogId = await insertPublishLog(event, options.requestContext);
            const ack = await client.publish(eventName, event.payload);
            await updatePublishLog(publishLogId, 'published', { ack });
          } catch (error) {
            await updatePublishLog(publishLogId, 'failed', {
              errorMessage: error instanceof Error ? error.message : String(error),
            }).catch(() => {});
            strapi.log.error(`[EventBus] publish failed for ${eventName}: ${error.message}`);
          }
        })();
      });

      return {
        accepted: true,
        event,
      };
    },

    async close() {
      await this.initializeRegistry();
      if (typeof client.close === 'function') {
        await client.close();
      }
    },
  };
};

function createClientFromEnv(strapi) {
  const logger = {
    info(message, meta) {
      strapi.log.info(meta ? `${message} ${JSON.stringify(meta)}` : message);
    },
    warn(message, meta) {
      strapi.log.warn(meta ? `${message} ${JSON.stringify(meta)}` : message);
    },
    error(message, meta) {
      strapi.log.error(meta ? `${message} ${JSON.stringify(meta)}` : message);
    },
  };

  const driver = process.env.EVENT_BUS_DRIVER || 'postgres';
  if (driver !== 'postgres') {
    throw new Error(`Unsupported EVENT_BUS_DRIVER "${driver}" in Strapi event bus service.`);
  }

  return createEventBus({
    driver: 'postgres',
    config: {
      connectionString: process.env.EVENT_BUS_POSTGRES_URL || buildDatabaseConnectionStringFromEnv(),
      channelPrefix: process.env.EVENT_BUS_CHANNEL_PREFIX || 'event_bus',
      logger,
    },
    logger,
  });
}

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

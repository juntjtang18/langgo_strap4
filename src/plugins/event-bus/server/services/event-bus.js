'use strict';

const { v4: uuidv4 } = require('uuid');

module.exports = ({ strapi }) => {
  const subscribersByEvent = new Map();

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

  const executeSubscribers = async ({ subscribers, event }) =>
    Promise.allSettled(
      subscribers.map(async ([subscriberName, handler]) => {
        try {
          await handler(event);
          strapi.log.info(`[EventBus] subscriber success: ${subscriberName} -> ${event.event_name}`);
        } catch (error) {
          strapi.log.error(`[EventBus] subscriber failed: ${subscriberName} -> ${event.event_name}: ${error.message}`);
        }
      })
    );

  const runPublish = async ({ event, subscribers }) => {
    const persistedEvent = await strapi.entityService.create('plugin::event-bus.eb-event', {
      data: {
        event_id: event.event_id,
        event_name: event.event_name,
        payload: event.payload,
        source: event.source,
        occurred_at: event.occurred_at,
        metadata: event.metadata,
      },
    });

    if (subscribers.length === 0) {
      strapi.log.info(`[EventBus] no subscribers: ${event.event_name}`);
      return;
    }

    await executeSubscribers({ subscribers, event });
  };

  const service = {
    initializeRegistry() {
      subscribersByEvent.clear();
    },

    subscribe(eventName, subscriberName, handler) {
      if (!eventName || typeof eventName !== 'string') {
        throw new Error('eventName is required');
      }
      if (!subscriberName || typeof subscriberName !== 'string') {
        throw new Error('subscriberName is required');
      }
      if (typeof handler !== 'function') {
        throw new Error('handler must be a function');
      }

      getRegistry(eventName).set(subscriberName, handler);
      strapi.log.info(`[EventBus] subscriber registered: ${subscriberName} -> ${eventName}`);
    },

    unsubscribe(eventName, subscriberName) {
      const registry = subscribersByEvent.get(eventName);
      if (!registry) {
        return false;
      }

      const removed = registry.delete(subscriberName);
      if (registry.size === 0) {
        subscribersByEvent.delete(eventName);
      }

      if (removed) {
        strapi.log.info(`[EventBus] subscriber removed: ${subscriberName} -> ${eventName}`);
      }

      return removed;
    },

    listSubscribers(eventName) {
      const registry = subscribersByEvent.get(eventName);
      return registry ? Array.from(registry.keys()) : [];
    },

    clearSubscribers(eventName) {
      const registry = subscribersByEvent.get(eventName);
      if (!registry) {
        return 0;
      }

      const count = registry.size;
      subscribersByEvent.delete(eventName);
      return count;
    },

    publish(eventName, payload, options = {}) {
      if (!eventName || typeof eventName !== 'string') {
        throw new Error('eventName is required');
      }

      const eventId = uuidv4();
      const event = {
        id: eventId,
        event_id: eventId,
        event_name: eventName,
        payload: payload && typeof payload === 'object' ? payload : {},
        source: options.source || 'unknown',
        occurred_at: new Date().toISOString(),
        metadata: normalizeMetadata(options.metadata),
      };

      strapi.log.info(`[EventBus] publishing event: ${event.event_name}`);
      const registry = subscribersByEvent.get(eventName);
      const subscribers = registry ? Array.from(registry.entries()) : [];
      setImmediate(() => {
        runPublish({ event, subscribers }).catch((error) => {
          strapi.log.error(`[EventBus] publish failed for ${eventName}: ${error.message}`);
        });
      });

      return {
        accepted: true,
        event,
      };
    },
  };

  return service;
};

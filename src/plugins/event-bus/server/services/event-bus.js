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

  return {
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

    async publish(eventName, payload, options = {}) {
      if (!eventName || typeof eventName !== 'string') {
        throw new Error('eventName is required');
      }

      const event = {
        id: uuidv4(),
        event_name: eventName,
        payload: payload && typeof payload === 'object' ? payload : {},
        source: options.source || 'unknown',
        occurred_at: new Date().toISOString(),
        metadata: normalizeMetadata(options.metadata),
      };

      strapi.log.info(`[EventBus] publishing event: ${event.event_name}`);

      const persistedEvent = await strapi.entityService.create('plugin::event-bus.eb-event', {
        data: event,
      });

      const registry = subscribersByEvent.get(eventName);
      const subscribers = registry ? Array.from(registry.entries()) : [];

      if (subscribers.length === 0) {
        strapi.log.info(`[EventBus] no subscribers: ${event.event_name}`);
        return {
          event: persistedEvent,
          results: [],
        };
      }

      const deliveries = await Promise.all(
        subscribers.map(([subscriberName]) =>
          strapi.entityService.create('plugin::event-bus.eb-event-delivery', {
            data: {
              event: persistedEvent.id,
              subscriber_name: subscriberName,
              status: 'pending',
              error_message: null,
              processed_at: null,
            },
          })
        )
      );

      const settled = await Promise.allSettled(
        subscribers.map(async ([subscriberName, handler], index) => {
          const delivery = deliveries[index];

          try {
            const value = await handler(event);
            await strapi.entityService.update('plugin::event-bus.eb-event-delivery', delivery.id, {
              data: {
                status: 'success',
                error_message: null,
                processed_at: new Date().toISOString(),
              },
            });
            strapi.log.info(`[EventBus] subscriber success: ${subscriberName} -> ${event.event_name}`);
            return {
              subscriberName,
              deliveryId: delivery.id,
              status: 'success',
              value,
            };
          } catch (error) {
            await strapi.entityService.update('plugin::event-bus.eb-event-delivery', delivery.id, {
              data: {
                status: 'failed',
                error_message: error.message,
                processed_at: new Date().toISOString(),
              },
            });
            strapi.log.error(`[EventBus] subscriber failed: ${subscriberName} -> ${event.event_name}: ${error.message}`);
            throw Object.assign(error, {
              subscriberName,
              deliveryId: delivery.id,
            });
          }
        })
      );

      const results = settled.map((entry) => {
        if (entry.status === 'fulfilled') {
          return entry.value;
        }

        return {
          subscriberName: entry.reason.subscriberName || 'unknown',
          deliveryId: entry.reason.deliveryId || null,
          status: 'failed',
          error: entry.reason.message,
        };
      });

      return {
        event: persistedEvent,
        results,
      };
    },
  };
};

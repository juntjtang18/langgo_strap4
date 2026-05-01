'use strict';

const handleRank = require('./rank');

// All five canonical events update the rank subsystem
const RANK_EVENTS = new Set([
  'user.register',
  'flashcard.create',
  'flashcard.review',
  'flashcard.review_tier_promote',
  'article.create',
]);

module.exports = async ({ strapi, event }) => {
  const promises = [];

  if (RANK_EVENTS.has(event.event_name)) {
    promises.push(handleRank({ strapi, event }));
  }

  if (promises.length === 0) {
    strapi.log.warn(`[EventBus] No handler registered for event: ${event.event_name}`);
    return;
  }

  const results = await Promise.allSettled(promises);
  for (const r of results) {
    if (r.status === 'rejected') {
      strapi.log.error(`[EventBus] Handler error for "${event.event_name}": ${r.reason?.message}`);
    }
  }
};

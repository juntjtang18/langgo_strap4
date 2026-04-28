'use strict';

// Creates a reviewlog entry for a flashcard.review event.
// Idempotent via event_id deduplication.
module.exports = async ({ strapi, event }) => {
  const { review, event_id: eventId } = event;

  if (!eventId || !review?.userId || !review?.flashcardId || !review?.reviewedAt || !review?.result) {
    throw new Error('[EventBus/flashcard-review] Invalid payload.');
  }

  const existing = await strapi.entityService.findMany('api::reviewlog.reviewlog', {
    filters: { event_id: eventId },
    limit: 1,
  });
  if (existing.length > 0) {
    return { reviewlogId: existing[0].id, pointsAwarded: existing[0].points_awarded ?? 0, duplicate: true };
  }

  const pointsAwarded = await strapi.service('point-service').calculateReviewPoints(event);

  let reviewlog;
  try {
    await strapi.db.transaction(async ({ trx }) => {
      reviewlog = await strapi.entityService.create('api::reviewlog.reviewlog', {
        data: {
          user: review.userId,
          flashcard: review.flashcardId,
          reviewed_at: review.reviewedAt,
          event_id: eventId,
          result: review.result,
          level: review.level,
          effective: review.effective,
          points_awarded: pointsAwarded,
          newlevel: review.newlevel,
        },
        db: trx,
      });
    });
  } catch (err) {
    if (err.code === '23505') {
      const dup = await strapi.entityService.findMany('api::reviewlog.reviewlog', {
        filters: { event_id: eventId },
        limit: 1,
      });
      if (dup.length > 0) {
        return { reviewlogId: dup[0].id, pointsAwarded: dup[0].points_awarded ?? 0, duplicate: true };
      }
    }
    throw err;
  }

  return { reviewlogId: reviewlog.id, pointsAwarded, duplicate: false };
};

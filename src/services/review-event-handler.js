'use strict';

module.exports = ({ strapi }) => {
  const findExistingReviewlogByEventId = async (eventId) => {
    if (!eventId) {
      return null;
    }

    const reviewlogs = await strapi.entityService.findMany('api::reviewlog.reviewlog', {
      filters: { event_id: eventId },
      limit: 1,
    });

    return reviewlogs[0] || null;
  };

  const calculatePointsAwarded = async (event) => {
    return strapi.service('review-reward-service').calculatePoints(event);
  };

  const persistPointsAwarded = async ({ review, pointsAwarded }, trx) => {
    if (pointsAwarded === null || pointsAwarded === undefined) {
      return null;
    }

    return strapi.service('review-reward-service').applyPoints(
      {
        userId: review.userId,
        delta: pointsAwarded,
        reviewedAt: review.reviewedAt,
      },
      trx
    );
  };

  const handleReviewCompleted = async (event) => {
    const review = event?.review;

    if (!event?.eventId || !review?.userId || !review?.flashcardId || !review?.reviewedAt || !review?.result) {
      throw new Error('Invalid review event payload.');
    }

    const existingReviewlog = await findExistingReviewlogByEventId(event.eventId);

    if (existingReviewlog) {
      return {
        reviewlogId: existingReviewlog.id,
        pointsAwarded: existingReviewlog.points_awarded ?? 0,
        duplicate: true,
      };
    }

    const pointsAwarded = await calculatePointsAwarded(event);
    let reviewlog;

    try {
      await strapi.db.transaction(async ({ trx }) => {
        reviewlog = await strapi.entityService.create('api::reviewlog.reviewlog', {
          data: {
            user: review.userId,
            flashcard: review.flashcardId,
            reviewed_at: review.reviewedAt,
            event_id: event.eventId,
            result: review.result,
            level: review.level,
            effective: review.effective,
            points_awarded: pointsAwarded,
            newlevel: review.newlevel,
          },
          db: trx,
        });

        await persistPointsAwarded({ event, review, reviewlog, pointsAwarded }, trx);
      });
    } catch (error) {
      if (error.code === '23505') {
        const duplicateReviewlog = await findExistingReviewlogByEventId(event.eventId);

        if (duplicateReviewlog) {
          return {
            reviewlogId: duplicateReviewlog.id,
            pointsAwarded: duplicateReviewlog.points_awarded ?? 0,
            duplicate: true,
          };
        }
      }

      throw error;
    }

    return {
      reviewlogId: reviewlog.id,
      pointsAwarded,
      duplicate: false,
    };
  };

  return {
    handleReviewCompleted,
    calculatePointsAwarded,
    persistPointsAwarded,
  };
};

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
    return strapi.service('point-service').calculateReviewPoints(event);
  };

  const persistPointsAwarded = async (event, trx) => {
    return strapi.service('point-service').applyReviewEvent(event, trx);
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

        await persistPointsAwarded(event, trx);
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

  const handleWordDefinitionCreated = async (event) => {
    const payload = event?.wordDefinition;

    if (!event?.eventId || !payload?.userId || !payload?.wordDefinitionId || !payload?.createdAt) {
      throw new Error('Invalid word_definition.created event payload.');
    }

    const result = await strapi.db.transaction(async ({ trx }) => {
      return strapi.service('point-service').applyWordDefinitionCreatedEvent(event, trx);
    });

    return {
      wordDefinitionId: payload.wordDefinitionId,
      pointsAwarded: result?.pointsAwarded ?? 0,
      duplicate: false,
    };
  };

  const handleArticleCreated = async (event) => {
    const payload = event?.article;

    if (!event?.eventId || !payload?.userId || !payload?.userArticleId || !payload?.createdAt) {
      throw new Error('Invalid user_article.created event payload.');
    }

    const result = await strapi.db.transaction(async ({ trx }) => {
      return strapi.service('point-service').applyArticleCreatedEvent(event, trx);
    });

    return {
      userArticleId: payload.userArticleId,
      pointsAwarded: result?.pointsAwarded ?? 0,
      duplicate: false,
    };
  };

  const handleEvent = async (event) => {
    switch (event?.event) {
      case 'flashcard.review.completed':
        return handleReviewCompleted(event);
      case 'word_definition.created':
        return handleWordDefinitionCreated(event);
      case 'user_article.created':
        return handleArticleCreated(event);
      default:
        throw new Error(`Unsupported queued event type: ${event?.event || '(missing)'}`);
    }
  };

  return {
    handleEvent,
    handleReviewCompleted,
    handleWordDefinitionCreated,
    handleArticleCreated,
    calculatePointsAwarded,
    persistPointsAwarded,
  };
};

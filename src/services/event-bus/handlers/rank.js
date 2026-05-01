'use strict';

const TIER_ORDER = ['new', 'warmup', 'daily', 'weekly', 'monthly', 'remembered'];
const tierRank = (level) => TIER_ORDER.indexOf((level || '').toLowerCase());

module.exports = async ({ strapi, event }) => {
  const rank = strapi.service('rank-dispatcher');

  switch (event.event_name) {
    case 'flashcard.review':
      await rank.onFlashcardReview(event.userid, event.flashcard_id, event.review);
      if (tierRank(event.review?.newlevel) > tierRank(event.review?.level)) {
        await rank.onFlashcardReviewTierPromote(event.userid, event.flashcard_id, event.review);
      }
      break;
    case 'flashcard.review_tier_promote':
      await rank.onFlashcardReviewTierPromote(event.userid, event.flashcard_id, event.review);
      break;
    case 'flashcard.create':
      await rank.onFlashcardCreate(event.userid, event.flashcard_id);
      break;
    case 'article.create':
      await rank.onArticleCreate(event.userid, event.article_id);
      break;
    case 'user.register':
      await rank.onUserRegister(event.userid);
      break;
    default:
      strapi.log.warn(`[EventBus/rank] No rank handler for event: ${event.event_name}`);
  }
};

'use strict';

module.exports = async ({ strapi, event }) => {
  const rank = strapi.service('rank-dispatcher');

  switch (event.event_name) {
    case 'flashcard.review':
      await rank.onFlashcardReview(event.userid, event.flashcard_id);
      break;
    case 'flashcard.review_tier_promote':
      await rank.onFlashcardReviewTierPromote(event.userid, event.flashcard_id);
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

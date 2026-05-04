'use strict';

module.exports = async ({ strapi, event }) => {
  const rank = strapi.service('rank-dispatcher');

  switch (event.event_name) {
    case 'flashcard.review':
      await rank.onFlashcardReview(event.userid, event.flashcard_id, event.review, event.username, event.event_id);
      break;
    case 'flashcard.review_tier_promote':
      await rank.onFlashcardReviewTierPromote(event.userid, event.flashcard_id, event.review, event.username, event.event_id);
      break;
    case 'flashcard.create':
      await rank.onFlashcardCreate(event.userid, event.flashcard_id, event.username, event.event_id, event.flashcard);
      break;
    case 'article.create':
      await rank.onArticleCreate(event.userid, event.article_id, event.username, event.event_id, event.article);
      break;
    case 'user.register':
      await rank.onUserRegister(event.userid, event.username, event.event_id);
      break;
    default:
      strapi.log.warn(`[EventBus/rank] No rank handler for event: ${event.event_name}`);
  }
};

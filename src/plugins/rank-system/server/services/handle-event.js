'use strict';

module.exports = ({ strapi }) => async (event) => {
  const rank = strapi.plugin('rank-system').service('dispatcher');

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
      await rank.onUserRegister(event.userid, event.username, event.event_id, event.payload);
      break;
    case 'user.profile.update':
      await rank.onUserProfileUpdate(event.userid, event.username, event.event_id, event.payload);
      break;
    default:
      strapi.log.warn(`[Rank] No handler for event: ${event.event_name}`);
  }
};

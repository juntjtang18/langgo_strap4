'use strict';

module.exports = ({ strapi }) => async (event) => {
  const rank = strapi.plugin('rank-system').service('dispatcher');

  switch (event.event_name) {
    case 'flashcard.reviewed':
      await rank.onFlashcardReview(event.userid, event.flashcard_id, event.payload, event.username, event.event_id);
      break;
    case 'flashcard.review_tier_promoted':
      await rank.onFlashcardReviewTierPromote(event.userid, event.flashcard_id, event.payload, event.username, event.event_id);
      break;
    case 'flashcard.created':
      await rank.onFlashcardCreate(event.userid, event.flashcard_id, event.username, event.event_id, event.payload);
      break;
    case 'article.created':
      await rank.onArticleCreate(event.userid, event.article_id, event.username, event.event_id, event.payload);
      break;
    case 'user.registered':
      await rank.onUserRegister(event.userid, event.username, event.event_id, event.payload);
      break;
    case 'user_profile.visibility_updated':
      await rank.onUserProfileUpdate(event.userid, event.username, event.event_id, event.payload);
      break;
    default:
      strapi.log.warn(`[Rank] No handler for event: ${event.event_name}`);
  }
};

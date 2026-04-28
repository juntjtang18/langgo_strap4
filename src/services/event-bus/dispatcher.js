'use strict';

const { v4: uuidv4 } = require('uuid');

const TIER_ORDER = ['new', 'warmup', 'daily', 'weekly', 'monthly', 'remembered'];
const tierRank = (level) => TIER_ORDER.indexOf((level || '').toLowerCase());

// Sole public interface for emitting domain events into the event bus.
// Normalises controller payloads into canonical event objects before queuing.
module.exports = ({ queue }) => ({
  dispatchFlashcardReviewCompleted(event) {
    const { review, eventId } = event;
    const id = eventId || uuidv4();
    const userid = String(review.userId);

    queue.enqueue({
      event_name: 'flashcard.review',
      event_id: id,
      userid,
      flashcard_id: review.flashcardId,
      review,           // kept for reviewlog handler
    });

    if (tierRank(review.newlevel) > tierRank(review.level)) {
      queue.enqueue({
        event_name: 'flashcard.review_tier_promote',
        event_id: uuidv4(),
        userid,
        flashcard_id: review.flashcardId,
      });
    }
  },

  dispatchFlashcardCreate(event) {
    const { wordDefinition, eventId } = event;
    queue.enqueue({
      event_name: 'flashcard.create',
      event_id: eventId || uuidv4(),
      userid: String(wordDefinition.userId),
      flashcard_id: wordDefinition.flashcardId,
    });
  },

  dispatchArticleCreate(event) {
    const { article, eventId } = event;
    queue.enqueue({
      event_name: 'article.create',
      event_id: eventId || uuidv4(),
      userid: String(article.userId),
      article_id: article.userArticleId,
    });
  },

  dispatchUserRegister(userid) {
    queue.enqueue({
      event_name: 'user.register',
      event_id: uuidv4(),
      userid: String(userid),
    });
  },

  waitForIdle(timeoutMs = 5000) {
    return queue.waitForIdle(timeoutMs);
  },
});

'use strict';

const { toFlashcardDbTimestamp } = require('../../../utils/flashcard-datetime');

const buildDueFlashcardFilters = (userId, now = new Date()) => ({
  user: userId,
  word_definition: { $not: null },
  $or: [
    { next_review_at: null },
    { next_review_at: { $lte: toFlashcardDbTimestamp(now) } },
  ],
});

module.exports = {
  buildDueFlashcardFilters,
};

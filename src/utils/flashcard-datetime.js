'use strict';

const pad = (value, width = 2) => String(value).padStart(width, '0');

const toFlashcardDbTimestamp = (input = new Date()) => {
  const date = input instanceof Date ? input : new Date(input);

  return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())} `
    + `${pad(date.getHours())}:${pad(date.getMinutes())}:${pad(date.getSeconds())}.`
    + `${pad(date.getMilliseconds(), 3)}`;
};

const addHoursAsFlashcardDbTimestamp = (input, hours = 0) => (
  toFlashcardDbTimestamp(new Date(new Date(input).getTime() + ((hours || 0) * 3600 * 1000)))
);

module.exports = {
  toFlashcardDbTimestamp,
  addHoursAsFlashcardDbTimestamp,
};

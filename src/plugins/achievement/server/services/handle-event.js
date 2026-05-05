'use strict';

const pickUserId = (payload = {}) =>
  payload.userid
  || payload.userId
  || payload.review?.userid
  || payload.review?.userId
  || payload.flashcard?.userid
  || payload.flashcard?.userId
  || payload.article?.userid
  || payload.article?.userId
  || null;

const pickUsername = (payload = {}) =>
  payload.username
  || payload.userName
  || payload.review?.username
  || payload.review?.userName
  || payload.flashcard?.username
  || payload.flashcard?.userName
  || payload.article?.username
  || payload.article?.userName
  || null;

module.exports = ({ strapi }) => async (event) => {
  const payload = event?.payload || {};

  return strapi.plugin('achievement').service('progress').applyEvent({
    event_name: event.event_name,
    userid: pickUserId(payload),
    username: pickUsername(payload),
    payload,
  });
};

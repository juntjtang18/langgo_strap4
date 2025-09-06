'use strict';

module.exports = {
  routes: [
    { method: 'POST', path: '/cefr-syllabus/generate-topic',       handler: 'cefr-syllabus.generateTopicFromTemplate', config: { auth: false } },
    { method: 'POST', path: '/cefr-syllabus/generate-topic-bulk',  handler: 'cefr-syllabus.generateTopicBulk',         config: { auth: false } },
  ],
};

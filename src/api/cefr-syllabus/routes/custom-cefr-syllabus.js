'use strict';

module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/cefr-syllabus/generate-topic',
      handler: 'cefr-syllabus.generateTopicFromTemplate',
      config: { auth: false, policies: [] },
    },
  ],
};

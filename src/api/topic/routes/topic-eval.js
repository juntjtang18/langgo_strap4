'use strict';

module.exports = {
  routes: [
    { method: 'POST', path: '/topics/evaluate',       handler: 'topic-eval.evaluate',       config: { auth: false } },
    { method: 'POST', path: '/topics/evaluate/range', handler: 'topic-eval.evaluateRange', config: { auth: false } },
  ]
};

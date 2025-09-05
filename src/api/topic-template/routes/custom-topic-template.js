'use strict';

module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/topic-templates/design',
      handler: 'topic-template.design',
      config: { auth: false, policies: [] },
    },
    {
      method: 'POST',
      path: '/topic-templates/design/bulk',
      handler: 'topic-template.designBulk',
      config: { auth: false, policies: [] },
    },
  ],
};




  'use strict';

// Path: src/api/vbsetting/routes/vbsetting.js

module.exports = {
    routes: [
      {
        method: 'GET',
        path: '/vbsettings/mine',
        handler: 'vbsetting.findMine',
        config: {
          // must be an object, not `true`
          auth: {}
        },
      },
      {
        method: 'PUT',
        path: '/vbsettings/mine',
        handler: 'vbsetting.updateMine',
        config: {
          auth: {}
        },
      },
    ],
  };
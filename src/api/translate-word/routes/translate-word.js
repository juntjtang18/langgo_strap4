module.exports = {
    routes: [
      {
        method: 'POST',
        path: '/translate-word',
        handler: 'translate-word.translate',
        config: {
          policies: [],
          middlewares: [],
        },
      },
      {
        method: 'POST',
        path: '/translate-word-context',
        handler: 'translate-word.translateWordInContext',
        config: {
          policies: [],
          middlewares: [],
        },
      },
    ],
  };
  
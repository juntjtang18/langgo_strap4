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
    ],
  };
  
// config/middlewares.js
console.log('Middlewares loaded'); // Confirm file is loaded

module.exports = [
  {
    name: 'strapi::cors',
    config: {
      origin: [
        'https://strapi.geniusparentingai.ca',
        'http://localhost:8080',
        'http://localhost:8081',
        'https://www.geniusparentingai.ca',
        'https://my-strapi-app-852311377699.us-west1.run.app',
        'https://chatbot.geniusparentingai.ca',
        'http://192.168.1.66:8080',
        'http://192.168.1.73',
	'http://localhost:1338',
      ],
      methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
      headers: '*',
      credentials: true,
    },
  },
  {
    name: 'strapi::errors',
    config: {
      stackTrace: true,
    },
  },
  {
    name: 'strapi::logger',
    config: {
      level: 'debug',
      exposeInContext: true,
      requests: true,
    },
  },
  'strapi::security',
  'strapi::poweredBy',
  'strapi::query',
  {
    name: 'strapi::body',
    config: {
      formLimit: '1024mb',
      jsonLimit: '1024mb',
      textLimit: '1024mb',
      formidable: {
        maxFileSize: 1024 * 1024 * 1024, // 1GB
        maxFiles: 10,
      },
      onError: (error, ctx) => {
        console.error('Body middleware error:', error.message, error.stack);
        throw error;
      },
    },
  },
  'strapi::session',
  'strapi::favicon',
  'strapi::public',
];

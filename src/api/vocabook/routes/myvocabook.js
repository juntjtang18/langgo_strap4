// src/api/vocabook/routes/custom-vocabook.js
module.exports = {
    routes: [
      {
        method: 'GET',
        path: '/v1/myvocabook',
        handler: 'vocabook.findMyVocabook',
      },
    ],
  };
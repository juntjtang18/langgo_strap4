// src/api/vocapage/routes/custom-vocapage.js
module.exports = {
    routes: [
      {
        method: 'GET',
        path: '/v1/myvocapage/:id',
        handler: 'vocapage.findMyVocapage',
      },
    ],
  };
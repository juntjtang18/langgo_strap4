'use strict';

const { TranslationServiceClient } = require('@google-cloud/translate');

const client = new TranslationServiceClient();

module.exports = {
  async translate(ctx) {
    const { word, source, target } = ctx.request.body;

    if (!word || !source || !target) {
      return ctx.badRequest('Missing required fields: "word", "source", and "target" are all required.');
    }

    const projectId = process.env.GOOGLE_PROJECT_ID;

    try {
      const [response] = await client.translateText({
        parent: `projects/${projectId}/locations/global`,
        contents: [word],
        mimeType: 'text/plain',
        sourceLanguageCode: source,
        targetLanguageCode: target,
      });

      const translation = response.translations[0]?.translatedText;

      ctx.send({ translation });
    } catch (error) {
      console.error('Google Translate v3 error:', error.message || error);
      ctx.internalServerError('Translation failed');
    }
  },
};

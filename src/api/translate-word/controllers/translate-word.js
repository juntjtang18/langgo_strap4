'use strict';

const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
const { TranslationServiceClient } = require('@google-cloud/translate');

const client = new TranslationServiceClient();

module.exports = {
  /**
   * Translates a single word using Google Translate and gets its part of speech from OpenAI.
   */
  async translate(ctx) {
    const { word, source, target } = ctx.request.body;

    if (!word || !source || !target) {
      return ctx.badRequest('Missing required fields: "word", "source", and "target" are all required.');
    }

    const projectId = process.env.GOOGLE_PROJECT_ID;
    if (!projectId) {
      strapi.log.error('GOOGLE_PROJECT_ID environment variable is not set.');
      return ctx.internalServerError('Server configuration error: Missing Google Project ID.');
    }

    try {
      // --- MODIFICATION START ---
      // Run Google Translate and OpenAI Part of Speech calls in parallel
      const [googleTranslateResponse, posResponse] = await Promise.all([
        client.translateText({
          parent: `projects/${projectId}/locations/global`,
          contents: [word],
          mimeType: 'text/plain',
          sourceLanguageCode: source,
          targetLanguageCode: target,
        }),
        openai.chat.completions.create({
          model: 'gpt-4-turbo',
          messages: [
            { role: 'system', content: 'You are a linguistic assistant that identifies the part of speech.' },
            { role: 'user', content: `What is the part of speech of the word "${word}"? Return only the part of speech (e.g., Noun, Verb, Adjective), nothing else.` },
          ],
          temperature: 0,
          max_tokens: 10,
        })
      ]);

      // Extract the translation from the Google response
      const translation = googleTranslateResponse[0]?.translations[0]?.translatedText;
      
      // Extract the part of speech from the OpenAI response
      const partOfSpeech = posResponse.choices[0]?.message?.content?.trim();
      
      if (!translation) {
        strapi.log.error('Google Translate returned no translation:', googleTranslateResponse);
        return ctx.internalServerError('Translation service failed to return a valid result.');
      }

      // Send both pieces of data in the response
      ctx.send({ translation, partOfSpeech });
      // --- MODIFICATION END ---
    } catch (error) {
      console.error('Error in translate (Google/OpenAI):', error.message || error);
      ctx.internalServerError('Translation failed');
    }
  },

  /**
   * Translates a word and sentence in context and identifies the part of speech using OpenAI.
   */
  async translateWordInContext(ctx) {
    const { word, sentence, sourceLang, targetLang } = ctx.request.body;

    if (!word || !sentence || !sourceLang || !targetLang) {
      return ctx.badRequest('Missing required fields: "word", "sentence", "sourceLang", and "targetLang".');
    }

    strapi.log.info(`Translating word "${word}" in context from ${sourceLang} to ${targetLang}...`);

    const wordOnlyPrompt = `You are a professional translator.
    Translate only the word "${word}" in this sentence: "${sentence}" from ${sourceLang} to ${targetLang}.    
    Use the full sentence to understand the context, but return only the best translation of the word "${word}" in this context.    
    Return only the translated word or phrase, no extra explanation or punctuation.`;

    const sentencePrompt = `You are a professional translator.
Translate the sentence "${sentence}" from ${sourceLang} to ${targetLang}, making sure the translated version preserves the original structure and clearly reflects the role of the word "${word}".
Return only the translated sentence, without quotes or explanation.`;
    
    // --- MODIFICATION START ---
    // New prompt to get the part of speech in context
    const posPrompt = `You are a linguist.
In the sentence: "${sentence}", what is the part of speech of the word "${word}"?
Return only the part of speech (e.g., verb, noun, adjective).`;

    try {
      // Add the part of speech call to Promise.all
      const [wordResult, sentenceResult, posResult] = await Promise.all([
        openai.chat.completions.create({
          model: 'gpt-4-turbo',
          messages: [
            { role: 'system', content: 'You are a precise, context-aware translation assistant. Return only the translated word.' },
            { role: 'user', content: wordOnlyPrompt },
          ],
          temperature: 0,
          max_tokens: 20,
        }),
        openai.chat.completions.create({
          model: 'gpt-4-turbo',
          messages: [
            { role: 'system', content: 'You are a translator that returns only the full translated sentence.' },
            { role: 'user', content: sentencePrompt },
          ],
          temperature: 0,
          max_tokens: 100,
        }),
        // New API call for Part of Speech
        openai.chat.completions.create({
          model: 'gpt-4-turbo',
          messages: [
            { role: 'system', content: 'You are a linguist that identifies parts of speech.' },
            { role: 'user', content: posPrompt },
          ],
          temperature: 0,
          max_tokens: 10,
        })
      ]);

      const translatedWord = wordResult.choices[0].message.content.trim().replace(/^"|"$/g, '');
      const translatedSentence = sentenceResult.choices[0].message.content.trim().replace(/^"|"$/g, '');
      // Extract the part of speech from the new result
      const partOfSpeech = posResult.choices[0].message.content.trim();

      // Add partOfSpeech to the response payload
      ctx.send({ translation: translatedWord, sentence: translatedSentence, partOfSpeech });
      // --- MODIFICATION END ---
    } catch (error) {
      strapi.log.error('Error in translateWordInContext:', error.message || error);
      ctx.internalServerError('Translation failed');
    }
  },
};
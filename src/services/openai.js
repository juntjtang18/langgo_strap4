'use strict';
const OpenAI = require('openai');

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

module.exports = ({ strapi }) => ({
  /**
   * Generates multiple-choice exam options for a given word.
   * @param {string} correctWord - The correct word for the question.
   * @param {string} language - The language of the word (e.g., 'en', 'es').
   * @param {number | string} userWordId - The ID of the user_word for logging purposes.
   * @returns {Promise<Array<object>>} - An array of 4 exam options.
   */
  async generateExamOptions(correctWord, language, userWordId = 'N/A') {
    const prompt = `Generate 3 incorrect alternative words in ${language} that are similar in category or difficulty to "${correctWord}". The output should be a JSON array of objects, where each object has "text" and "isCorrect" (boolean). The correct word should also be included with "isCorrect": true. Ensure the correct word is randomly placed among the options.`;
    try {
      const chatCompletion = await openai.chat.completions.create({
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a helpful assistant that generates multiple-choice options for language learning. Provide only the JSON array." },
          { role: "user", content: prompt }
        ],
        response_format: { type: "json_object" },
      });

      const responseContent = chatCompletion.choices[0].message.content;
      let generatedOptions = JSON.parse(responseContent);
      generatedOptions = Array.isArray(generatedOptions)
        ? generatedOptions
        : generatedOptions.options || generatedOptions.choices || Object.values(generatedOptions)[0];

      if (!Array.isArray(generatedOptions)) {
        throw new Error("OpenAI response did not contain a valid array of options.");
      }

      let finalOptions = [
        ...generatedOptions.filter(opt => !opt.isCorrect),
        { text: correctWord, isCorrect: true }
      ];
      while (finalOptions.length < 4) {
        finalOptions.push({ text: `Placeholder ${finalOptions.length}`, isCorrect: false });
      }
      finalOptions = finalOptions.slice(0, 4);

      for (let i = finalOptions.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [finalOptions[i], finalOptions[j]] = [finalOptions[j], finalOptions[i]];
      }
      return finalOptions;

    } catch (error) {
      strapi.log.error(
        `Error calling OpenAI API for ${language} for user_word ${userWordId}:`,
        error.message
      );
      // Return fallback options on error
      return [
        { text: correctWord, isCorrect: true },
        { text: `Error opt 1`, isCorrect: false },
        { text: `Error opt 2`, isCorrect: false },
        { text: `Error opt 3`, isCorrect: false }
      ].sort(() => Math.random() - 0.5);
    }
  }
});
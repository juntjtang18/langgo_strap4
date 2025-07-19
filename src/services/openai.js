'use strict';
const OpenAI = require('openai');

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

module.exports = ({ strapi }) => ({
  /**
   * Generates a natural, conversational reply based on the chat history.
   * @param {Array<object>} history - The conversation history (e.g., [{ role: 'user', content: '...' }]).
   * @param {object|null} topic - An optional topic object from Strapi to provide context.
   * @returns {Promise<string>} - The AI-generated conversational response.
   */
  async generateConversationalReply(history, topic = null) {
    strapi.log.info('Generating conversational reply...');

    // --- REVISED SYSTEM MESSAGE ---
    let systemMessage = `You are an AI English learning partner. Your goal is to keep the conversation going naturally and help the user practice. Keep your replies friendly, encouraging, and relatively short. IMPORTANT: To keep it simple for the learner, if you ask a question, ask only ONE single question at a time.`;

    if (topic) {
      systemMessage += ` The current topic is "${topic.title}". You can use the topic's description ("${topic.description}") or its predefined questions as inspiration, but do not just list the questions. Weave them into the conversation naturally.`;
    }

    const messages = [
      { role: 'system', content: systemMessage },
      ...history,
    ];

    try {
      const chatCompletion = await openai.chat.completions.create({
        model: 'gpt-4-turbo',
        messages: messages,
      });

      const reply = chatCompletion.choices[0].message.content;
      strapi.log.info(`AI generated reply: "${reply}"`);
      return reply;

    } catch (error) {
      strapi.log.error('Error calling OpenAI for conversational reply:', error.message);
      return "I'm sorry, I'm having a little trouble thinking of a reply right now. Could you say that again?";
    }
  },
    
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
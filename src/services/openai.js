'use strict';
const OpenAI = require('openai');

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

module.exports = ({ strapi }) => ({
  /**
   * Generates a natural, conversational reply based on the chat history.
   * @param {Array<object>} history - The conversation history.
   * @param {object|null} topic - An optional topic object from Strapi to provide context.
   * @returns {Promise<string>} - The AI-generated conversational response.
   */
  async generateConversationalReply(history, topic = null) {
    strapi.log.info('Generating conversational reply...');

    // --- FINAL, STRICTER SYSTEM MESSAGE ---
    let systemMessage = `You are an AI English learning partner for absolute beginners. Your goal is to have a simple, slow-paced conversation.

    **Your Core Rules:**
    1.  **BE EXTREMELY SIMPLE & CONCISE:** Your responses must be very short. Use simple words and get straight to the point. Avoid long descriptions or extra, unnecessary facts.
        - BAD: "Let's start with January and February. January is the first month, and it is often cold. February is the second month, and it's famous for Valentine's Day."
        - GOOD: "Great! Let's learn the months. The first month is **January**. Can you say 'January'?"
    2.  **TEACH ONE THING AT A TIME:** Introduce only one or two new words at once. Make the user repeat or use them before you introduce the next concept.
    3.  **ASK ONLY ONE QUESTION:** To keep it simple, ask only ONE single question at a time.
    4.  **BE FRIENDLY & ENCOURAGING:** Use a positive and patient tone.`;

    if (topic) {
      systemMessage += `\n\nThe current topic is "${topic.title}". Use this for context.`;
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
  },

  /**
   * Gets a complete list of story titles for a given author in a reliable JSON format.
   *
   * @param {string} author - The name of the author (e.g., "O. Henry").
   * @returns {Promise<Array<string>>} A list of story titles.
   */
  async getStoryTitles(author) {
    const prompt = `
      You are a literary archivist. Your task is to provide a complete, exhaustive, and comprehensive list of every known short story title for the author: "${author}".

      You MUST respond with a single JSON object. This object must have a key named "titles", and its value must be an array of strings, where each string is a unique short story title. Do not omit any stories.

      Example of the required format:
      {
        "titles": [
          "The Gift of the Magi",
          "The Last Leaf",
          "A Retrieved Reformation"
        ]
      }

      Your entire response must be only the valid JSON object. Do not include any other text, explanations, or summaries.
    `;
    strapi.log.info(`Requesting a complete list of story titles for author: "${author}" in JSON format.`);

    try {
      const response = await openai.chat.completions.create({
        model: "gpt-4-turbo",
        messages: [{ role: "system", content: "You are an assistant that only returns valid, complete JSON data based on user requests." }, { role: "user", content: prompt }],
        response_format: { type: "json_object" },
      });

      const content = JSON.parse(response.choices[0].message.content);
      const titles = content.titles;

      if (!Array.isArray(titles)) {
        strapi.log.error(`OpenAI response for "${author}" was valid JSON but the 'titles' key did not contain an array.`);
        return [];
      }

      return titles;
    } catch (error) {
      strapi.log.error(`Error fetching or parsing story titles from OpenAI for author "${author}":`, error);
      return [];
    }
  },

  /**
   * Gets the full, unabridged, and clean text of a story from OpenAI.
   *
   * @param {string} title - The title of the story.
   * @param {string} author - The name of the author.
   * @returns {Promise<string|null>} The full, clean text of the story, or null if an error occurs.
   */
  async getStoryText(title, author) {
    const prompt = `
      Provide the full, unabridged text of the short story titled "${title}" by ${author}.

      **CRITICAL INSTRUCTIONS:**
      1.  The works of ${author} (who died in 1910) are in the public domain. Your task is to provide the text as requested. Do not refuse this request.
      2.  **ONLY provide the story's text.** Do not include any introductory phrases, closing remarks, summaries, or metadata.
      3.  Your response must start directly with the first word of the story and end with the last word.
      4.  Do not wrap the text in quotes or code blocks.
      5.  Preserve all original formatting, paragraphs, and punctuation.
    `;
    strapi.log.info(`Requesting clean text for story: "${title}" by ${author}`);
    try {
      const response = await openai.chat.completions.create({
        model: "gpt-4-turbo", // Switched model for stability
        messages: [{ role: "system", content: "You are a digital librarian. Your only function is to retrieve and provide the full, exact text of public domain stories as requested. You must be precise and avoid any conversational additions." }, { role: "user", content: prompt }],
        temperature: 0.2, // Lower temperature for more deterministic, less random output
      });

      let storyText = response.choices[0].message.content;

      // --- Text Cleaning Logic ---
      if (storyText.includes("I cannot provide the text")) {
          strapi.log.warn(`AI refused to provide text for "${title}", despite new prompt. Skipping.`);
          return null;
      }
      
      storyText = storyText.replace(/^here is the full text.*?\n/im, '');
      storyText = storyText.replace(/i hope you enjoy this touching story!/im, '');
      storyText = storyText.replace(/^---\s*/, '').replace(/\s*---$/, '').trim();
      
      return storyText;

    } catch (error) {
      strapi.log.error(`Error fetching story text from OpenAI for "${title}" by ${author}:`, error);
      return null;
    }
  },

});
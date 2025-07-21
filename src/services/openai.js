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
          model: "gpt-4-turbo",
          messages: [{ role: "system", content: "You are a digital librarian. Your only function is to retrieve and provide the full, exact text of public domain stories as requested. You must be precise and avoid any conversational additions." }, { role: "user", content: prompt }],
          temperature: 0.2,
        });
  
        let storyText = response.choices[0].message.content;
  
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
    /**
     * Analyzes a story's text and returns its CEFR difficulty level.
     *
     * @param {string} storyText - The full text of the story to analyze.
     * @returns {Promise<string|null>} The CEFR code (e.g., "A1", "B2") or null on error.
     */
    async getStoryDifficulty(storyText) {
      const prompt = `
        You are an expert in linguistics and English language teaching. Your task is to analyze the following story text and determine its difficulty level based on the Common European Framework of Reference for Languages (CEFR).
  
        Here are the CEFR levels for reference:
        - A1 (Beginner): Understands familiar, everyday expressions.
        - A2 (Elementary): Can communicate in simple, routine tasks.
        - B1 (Intermediate): Can handle most situations while traveling.
        - B2 (Upper-Intermediate): Can interact with fluency and spontaneity.
        - C1 (Advanced): Can produce clear, well-structured text on complex topics.
        - C2 (Proficient): Can understand virtually everything heard or read.
  
        Analyze the vocabulary, sentence structure, grammar, and overall complexity of the provided text. Then, respond with ONLY the corresponding CEFR code.
  
        The response MUST be a single JSON object with a single key "cefr_code". For example: {"cefr_code": "B1"}
  
        Story Text to Analyze:
        ---
        ${storyText.substring(0, 8000)}
        ---
      `;
      strapi.log.info("Analyzing story text for CEFR difficulty level...");
  
      try {
        const response = await openai.chat.completions.create({
          model: "gpt-4-turbo",
          messages: [
            { role: "system", content: "You are a language analysis expert that only returns JSON." },
            { role: "user", content: prompt }
          ],
          response_format: { type: "json_object" },
          temperature: 0.1,
        });
        const content = JSON.parse(response.choices[0].message.content);
        return content.cefr_code || null;
      } catch (error) {
        strapi.log.error("Error analyzing story difficulty:", error);
        return null;
      }
    },
  /**
   * Generates a concise summary (brief) for a given story text.
   *
   * @param {string} storyText - The full text of the story to summarize.
   * @returns {Promise<string|null>} The generated brief, or null on error.
   */
  async generateStoryBrief(storyText) {
    const prompt = `
      Generate a concise, one-paragraph summary (a brief) for the following story text. The brief should capture the main characters, setting, and plot points without revealing the ending if it's a surprise.

      The response must be a single JSON object with a key named "brief".
      Example: {"brief": "A young, impoverished couple searches for the perfect Christmas gift for each other, leading to an ironic and touching sacrifice."}

      Story Text to Summarize:
      ---
      ${storyText.substring(0, 8000)}
      ---
    `;
    strapi.log.info("Generating a brief for the story...");
    try {
      const response = await openai.chat.completions.create({
        model: "gpt-4-turbo",
        messages: [
          { role: "system", content: "You are a literary assistant who excels at writing concise summaries. You only respond in JSON." },
          { role: "user", content: prompt }
        ],
        response_format: { type: "json_object" },
        temperature: 0.5, // Allow for a little more creativity in summarization
      });
      const content = JSON.parse(response.choices[0].message.content);
      return content.brief || null;
    } catch (error) {
      strapi.log.error("Error generating story brief:", error);
      return null;
    }
  },
  /**
   * Generates a descriptive prompt for creating a cover image for a story.
   *
   * @param {string} title - The title of the story.
   * @param {string} author - The author of the story.
   * @param {string} brief - The brief summary of the story.
   * @returns {Promise<string|null>} The generated image prompt, or null on error.
   */
  async generateCoverImagePrompt(title, author, brief) {
    const prompt = `
      You are an expert prompt engineer for AI image generation models like Sora or Midjourney.
      Your task is to create a single, powerful prompt to generate a compelling cover image for the short story "${title}" by ${author}.

      The summary of the story is: "${brief}"

      Based on this brief, create a prompt that captures the essence of the story. The prompt should be descriptive, evocative, and include details about the style, mood, lighting, and composition.

      **CRITICAL INSTRUCTIONS:**
      - The output MUST be a single JSON object with one key: "image_prompt".
      - The value should be the text of the prompt you create.
      - Do not include any other text or explanations.

      Example format: {"image_prompt": "A young, nervous woman stands under a dim gaslight on a cobblestone street in 19th-century Paris, clutching a single red rose. Cinematic, moody lighting, dramatic shadows, photorealistic style."}
    `;
    strapi.log.info(`Generating cover image prompt for "${title}"...`);
    try {
      const response = await openai.chat.completions.create({
        model: "gpt-4-turbo",
        messages: [
          { role: "system", content: "You are a prompt engineer that only returns JSON." },
          { role: "user", content: prompt }
        ],
        response_format: { type: "json_object" },
        temperature: 0.6, // Allow for some creativity in prompt generation
      });
      const content = JSON.parse(response.choices[0].message.content);
      return content.image_prompt || null;
    } catch (error) {
      strapi.log.error("Error generating cover image prompt:", error);
      return null;
    }
  },
    /**
   * Generates a scene-by-scene prompt for creating a short video based on a story's brief.
   *
   * @param {string} title - The title of the story.
   * @param {string} brief - The brief summary of the story.
   * @returns {Promise<string|null>} The generated video prompt, or null on error.
   */
    async generateBriefVideoPrompt(title, brief) {
      const prompt = `
        You are a creative director specializing in creating prompts for text-to-video AI models.
        Your task is to create a multi-scene video prompt based on the brief for the story "${title}".
  
        The story's brief is: "${brief}"
  
        Based on this, create a video prompt that describes 3-4 short, sequential scenes. Each scene should describe the setting, character actions, and camera angles. The overall mood should be cinematic and match the tone of the story.
  
        **CRITICAL INSTRUCTIONS:**
        - The output MUST be a single JSON object with one key: "video_prompt".
        - The value should be a single string containing the multi-scene prompt.
        - Do not include any other text or explanations.
  
        Example format: {"video_prompt": "Scene 1: Wide shot of a dusty, sun-baked town square in the Old West. A lone cowboy slowly walks towards the saloon. Golden hour lighting, cinematic. Scene 2: Close-up on the cowboy's determined face, his hand hovering over his holster. High tension. Scene 3: A dramatic, sweeping aerial shot as the saloon doors burst open."}
      `;
      strapi.log.info(`Generating brief video prompt for "${title}"...`);
      try {
        const response = await openai.chat.completions.create({
          model: "gpt-4-turbo",
          messages: [
            { role: "system", content: "You are a creative director that only returns JSON." },
            { role: "user", content: prompt }
          ],
          response_format: { type: "json_object" },
          temperature: 0.7, // Higher temperature for more creative video concepts
        });
        const content = JSON.parse(response.choices[0].message.content);
        return content.video_prompt || null;
      } catch (error) {
        strapi.log.error("Error generating brief video prompt:", error);
        return null;
      }
    },

  /**
   * Generates a series of descriptive prompts for in-text illustrations.
   *
   * @param {string} title - The title of the story.
   * @param {string} storyText - The full text of the story.
   * @returns {Promise<Array<string>|null>} An array of 3-5 prompt strings, or null on error.
   */
  async generateIllustrationPrompts(title, storyText) {
    const prompt = `
      You are an art director tasked with creating a series of illustrations for the short story "${title}".
      Read the following story text and identify 3 to 5 key, visually compelling scenes that capture the story's progression from beginning to end.

      For each scene you identify, create a detailed, evocative prompt for an AI image generation model. Each prompt should describe the characters, setting, action, and mood.

      **CRITICAL INSTRUCTIONS:**
      - The output MUST be a single JSON object with one key: "prompts".
      - The value of "prompts" must be an array containing 3 to 5 strings, where each string is a unique illustration prompt.
      - Do not include any other text or explanations.

      Example format:
      {
        "prompts": [
          "A description for the first key scene...",
          "A description for a second, different key scene...",
          "A description for a climactic third scene..."
        ]
      }

      Story Text:
      ---
      ${storyText.substring(0, 12000)}
      ---
    `;
    strapi.log.info(`Generating illustration prompts for "${title}"...`);
    try {
      const response = await openai.chat.completions.create({
        model: "gpt-4-turbo",
        messages: [
          { role: "system", content: "You are an art director that only returns JSON." },
          { role: "user", content: prompt }
        ],
        response_format: { type: "json_object" },
        temperature: 0.6,
      });
      const content = JSON.parse(response.choices[0].message.content);
      
      // Validate that the response is an array of strings before returning
      if (Array.isArray(content.prompts) && content.prompts.every(p => typeof p === 'string')) {
        return content.prompts;
      }
      
      strapi.log.warn(`OpenAI response for illustration prompts was not a valid array for story "${title}".`);
      return []; // Return an empty array on invalid format

    } catch (error) {
      strapi.log.error("Error generating illustration prompts:", error);
      return []; // Return an empty array on error
    }
  },
});
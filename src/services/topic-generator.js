// src/services/topic-generator.js
'use strict';

const OpenAI = require('openai');

module.exports = ({ strapi }) => ({
  /**
   * Determines the next logical topic for a beginner English learner.
   * @param {OpenAI} openai - The OpenAI client instance.
   * @returns {Promise<string>} The title of the next topic to be generated.
   */
  async getNextBeginnerTopic(openai) {
    // Find the most recently created topic to see what was last taught.
    const lastTopic = await strapi.entityService.findMany('api::topic.topic', {
      sort: { createdAt: 'desc' },
      limit: 1,
    });

    let prompt;
    if (lastTopic && lastTopic.length > 0) {
      // If a topic exists, ask the AI for the next logical step.
      const lastTopicTitle = lastTopic[0].title;
      strapi.log.info(`Last topic taught was: "${lastTopicTitle}". Asking AI for the next one.`);
      prompt = `An absolute beginner English learner just completed a lesson on "${lastTopicTitle}". What is the single most logical, simple next topic for them to learn? Respond with ONLY the topic title, nothing else.`;
    } else {
      // If no topics exist, this is the very first run. Start with the absolute basics.
      strapi.log.info('No topics found. Generating the very first topic for beginners.');
      prompt = `What is the absolute first topic an English learner with zero knowledge should learn? Respond with ONLY the topic title, nothing else. Example: "Basic Greetings".`;
    }

    const response = await openai.chat.completions.create({
      model: "gpt-4-turbo",
      messages: [{ role: "user", content: prompt }],
    });

    const nextTopicTitle = response.choices[0].message.content.trim().replace(/"/g, ''); // Clean up response
    strapi.log.info(`AI suggested next topic is: "${nextTopicTitle}"`);
    return nextTopicTitle;
  },

  /**
   * Generates the detailed questions and structure for a given beginner topic.
   * @param {OpenAI} openai - The OpenAI client instance.
   * @param {string} topicTitle - The specific topic to generate content for.
   * @returns {Promise<Array<object>>} The structured data for Strapi.
   */
  async getBeginnerTopicDetails(openai, topicTitle) {
    strapi.log.info(`Generating beginner-focused questions for "${topicTitle}"...`);
    const prompt = `
    You are an expert curriculum designer for absolute beginner English learners (ESL Level 1).
    Your task is to create a simple lesson for the topic: "${topicTitle}".

    The output must be a single JSON object with this exact structure:
    {
      "difficulty_level_name": "Beginner",
      "difficulty_level_value": 1,
      "topic_title": "${topicTitle}",
      "topic_description": "A very simple, one-sentence description of this topic.",
      "tags": "beginner, vocabulary, basic",
      "questions": [
        // Generate 5 to 7 questions here
      ]
    }

    Follow these critical rules for the questions:
    - Questions must be very simple and closed-ended.
    - Focus on fundamental vocabulary (nouns, simple verbs) and basic sentence structure.
    - Expected answers must be short, direct, and easy for a beginner.
    - Each question object in the array must have a "prompt" and an "expected_answer".
    `;

    const response = await openai.chat.completions.create({
        model: "gpt-4-turbo",
        messages: [
            { role: "system", content: "You are a helpful assistant that generates JSON for an English learning curriculum." },
            { role: "user", content: prompt }
        ],
        response_format: { type: "json_object" },
    });

    const contentString = response.choices[0].message.content;
    return JSON.parse(contentString);
  },

  /**
   * Main function to generate and populate a new, progressive beginner lesson.
   */
  async generateProgressiveLesson() {
    strapi.log.info('Starting progressive lesson generation...');
    const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

    try {
      // Step 1: Dynamically determine the very next topic to teach.
      const topicTitle = await this.getNextBeginnerTopic(openai);

      // Step 2: Generate the beginner-focused content for that topic.
      const lessonData = await this.getBeginnerTopicDetails(openai, topicTitle);

      // Step 3: Find or create the 'Beginner' difficulty level.
      let beginnerLevel = await strapi.db.query('api::difficulty-level.difficulty-level').findOne({
        where: { level: 1 },
      });

      if (!beginnerLevel) {
        strapi.log.info('"Beginner" difficulty level not found, creating it...');
        beginnerLevel = await strapi.entityService.create('api::difficulty-level.difficulty-level', {
          data: {
            name: lessonData.difficulty_level_name,
            level: lessonData.difficulty_level_value,
            publishedAt: new Date(),
          },
        });
      }

      // Step 4: Create the new topic and link it to the beginner level.
      await strapi.entityService.create('api::topic.topic', {
        data: {
          title: lessonData.topic_title,
          description: lessonData.topic_description,
          tags: lessonData.tags,
          is_active: true,
          difficulty_level: beginnerLevel.id,
          questions: lessonData.questions, // Components are created automatically
          publishedAt: new Date(),
        },
      });

      strapi.log.info(`Successfully created and populated new lesson: "${lessonData.topic_title}"`);
      return { success: true, topic: lessonData.topic_title };

    } catch (error) {
      strapi.log.error('An error occurred during the progressive lesson generation process:', error.message);
      return { success: false, error: error.message };
    }
  }
});
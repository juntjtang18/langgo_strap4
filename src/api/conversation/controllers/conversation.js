'use strict';

/**
 * Controller for the AI conversation feature.
 */

module.exports = {
  /**
   * Starts a conversation by suggesting a random topic.
   * GET /v1/conversation/start
   */
  async start(ctx) {
    try {
      // Fetch all active topics
      const topics = await strapi.entityService.findMany('api::topic.topic', {
        filters: { is_active: true },
        fields: ['title'],
      });

      if (!topics || topics.length === 0) {
        return ctx.send({
          next_prompt: "Hello! I'm your English learning partner. I'm ready to chat whenever you are. What's on your mind today?"
        });
      }

      // Select one random topic to suggest
      const randomTopic = topics[Math.floor(Math.random() * topics.length)];

      const welcomeMessage = `Hello, I am your learning partner. Glad to help you practice English. How about we talk about "${randomTopic.title}"? Or, you can tell me what you have in mind.`;

      ctx.send({
        next_prompt: welcomeMessage,
        suggested_topic: randomTopic.title
      });

    } catch (error) {
      strapi.log.error('Failed to start conversation:', error);
      ctx.internalServerError('An error occurred while preparing the conversation.');
    }
  },

  /**
   * Generates the next conversational prompt using AI.
   * POST /v1/conversation/nextprompt
   */
  async nextPrompt(ctx) {
    const { history, topic_title } = ctx.request.body;

    if (!history || !Array.isArray(history) || history.length === 0) {
      return ctx.badRequest('Request body must include a non-empty "history" array.');
    }

    const openAIService = strapi.service('openai');
    let topicContext = null;

    try {
      // If a topic_title is provided, fetch its details to give the AI more context.
      if (topic_title) {
        const topics = await strapi.entityService.findMany('api::topic.topic', {
          filters: { title: topic_title },
          limit: 1,
        });
        if (topics && topics.length > 0) {
          topicContext = topics[0];
        }
      }

      // Call the AI service to get a smart, conversational reply
      const reply = await openAIService.generateConversationalReply(history, topicContext);

      ctx.send({
        next_prompt: reply,
      });

    } catch (error) {
      strapi.log.error('Failed to get next AI prompt:', error);
      ctx.internalServerError('An error occurred while generating the next prompt.');
    }
  },
};
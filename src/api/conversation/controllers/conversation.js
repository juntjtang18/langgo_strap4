// src/api/conversation/controllers/conversation.js
'use strict';

const { v4: uuidv4 } = require('uuid');

/**
 * Conversation controller
 */
module.exports = {
  /**
   * Starts a conversation, creates a log entry, and returns a session ID.
   */
  async start(ctx) {
    try {
      const topics = await strapi.entityService.findMany('api::topic.topic', {
        filters: { is_active: true },
        fields: ['title'],
      });

      if (!topics || topics.length === 0) {
        return ctx.send({
          next_prompt: "Hello! I'm ready to chat. What's on your mind today?"
        });
      }

      const randomTopic = topics[Math.floor(Math.random() * topics.length)];
      const welcomeMessage = `Hello! How about we talk about "${randomTopic.title}"? Or, you can suggest a topic.`;

      const sessionId = uuidv4();
      const initialHistory = [{ role: 'assistant', content: welcomeMessage }];

      await strapi.entityService.create('api::conversation.conversation', {
        data: {
          sessionId,
          history: initialHistory,
        },
      });

      strapi.log.info(`Anonymous conversation started. Session ID: ${sessionId}`);

      ctx.send({
        sessionId: sessionId,
        next_prompt: welcomeMessage,
        suggested_topic: randomTopic.title,
      });

    } catch (error) {
      strapi.log.error('Failed to start conversation:', error);
      ctx.internalServerError('Error starting conversation.');
    }
  },

  /**
   * Generates the next prompt and appends the turn to the conversation log.
   */
  async nextPrompt(ctx) {
    const { history, topic_title, sessionId } = ctx.request.body;

    if (!sessionId) {
      return ctx.badRequest('A "sessionId" is required for the conversation.');
    }
    if (!history || !Array.isArray(history) || history.length === 0) {
      return ctx.badRequest('A non-empty "history" array is required.');
    }

    const openAIService = strapi.service('openai');
    let topicContext = null;

    try {
      if (topic_title) {
        const topics = await strapi.entityService.findMany('api::topic.topic', {
          filters: { title: topic_title },
          limit: 1,
        });
        if (topics.length > 0) {
          topicContext = topics[0];
        }
      }

      const reply = await openAIService.generateConversationalReply(history, topicContext);

      const [logEntry] = await strapi.entityService.findMany('api::conversation.conversation', {
        filters: { sessionId },
      });

      if (logEntry) {
        const updatedHistory = [...history, { role: 'assistant', content: reply }];

        await strapi.entityService.update('api::conversation.conversation', logEntry.id, {
          data: {
            history: updatedHistory,
          },
        });
        strapi.log.info(`Updated conversation log for session ID: ${sessionId}`);
      } else {
        strapi.log.warn(`Could not find conversation log for session ID: ${sessionId}`);
      }

      // --- FINAL CHANGE ---
      // Include the sessionId in the response for the client.
      ctx.send({
        sessionId: sessionId,
        next_prompt: reply,
      });
      // --- END ---

    } catch (error) {
      strapi.log.error('Failed to get next AI prompt:', error);
      ctx.internalServerError('Error generating the next prompt.');
    }
  },
};
'use strict';

const { v4: uuidv4 } = require('uuid');

module.exports = {
  /** GET /v1/conversation/start?proficiency=auto|BEGINNER|...&sampleSize=4&includeHints=true */
  async start(ctx) {
    try {
      const svc = strapi.service('api::conversation.conversation-service');

      const proficiency = (ctx.query?.proficiency || 'auto').toString();
      const includeHints =
        typeof ctx.query?.includeHints === 'string'
          ? ['1','true','yes','y'].includes(ctx.query.includeHints.toLowerCase())
          : false;
      const n = Number.parseInt(ctx.query?.sampleSize, 10);
      const sampleSize = Number.isFinite(n) && n > 0 ? n : 4;

      // Pure service call (no persistence)
      const { selected_topic, first_turn, inferred_level } =
        await svc.kickoffFromStrapiTopics({ sampleSize, proficiency, includeHints });

      // Controller creates the session row
      const sessionId = uuidv4();
      await strapi.entityService.create('api::conversation.conversation', {
        data: {
          sessionId,
          history: [{ role: 'assistant', content: first_turn }],
          topicTitle: selected_topic || null,
        },
      });

      ctx.send({
        sessionId,
        next_prompt: first_turn,
        selected_topic,
        suggested_topic: selected_topic || null, // backward compat
        level_group: inferred_level || null,
      });
    } catch (error) {
      strapi.log.error('Failed to start conversation:', error);
      ctx.internalServerError('Error starting conversation.');
    }
  },

  /** POST /v1/conversation/nextprompt  { sessionId, history, topic_title?, proficiency? } */
  async nextPrompt(ctx) {
    const { history, topic_title, sessionId, proficiency = 'auto', mode = null } = ctx.request.body || {};

    if (!sessionId) return ctx.badRequest('A "sessionId" is required for the conversation.');
    if (!history || !Array.isArray(history) || history.length === 0) {
      return ctx.badRequest('A non-empty "history" array is required.');
    }

    try {
      const svc = strapi.service('api::conversation.conversation-service');
      // Pure service call (no persistence)
      const {
        reply,
        inferred_proficiency_key,
        inferred_cefr_code,
        inferred_group,
        decided_mode,
      } = await svc.generateNextPrompt({
        history,
        topicTitle: topic_title || null,
        proficiency,
        mode, // optional override: 'practice' | 'scenario' | 'auto'
      });

      // Append to conversation log
      const [logEntry] = await strapi.entityService.findMany('api::conversation.conversation', {
        filters: { sessionId },
        limit: 1,
      });

      if (logEntry) {
        const updatedHistory = [...history, { role: 'assistant', content: reply }];
        await strapi.entityService.update('api::conversation.conversation', logEntry.id, {
          data: { history: updatedHistory },
        });
        strapi.log.info(`Updated conversation log for session ID: ${sessionId}`);
      } else {
        strapi.log.warn(`Could not find conversation log for session ID: ${sessionId}`);
      }

      ctx.send({
        sessionId,
        next_prompt: reply,
        inferred_proficiency_key: inferred_proficiency_key || null,
        inferred_cefr_code: inferred_cefr_code || null,
        inferred_group: inferred_group || null,
        topic_title: topic_title || null,
        decided_mode,
      });
    } catch (error) {
      strapi.log.error('Failed to get next AI prompt:', error);
      ctx.internalServerError('Error generating the next prompt.');
    }
  },
};

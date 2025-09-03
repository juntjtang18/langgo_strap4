'use strict';

const { v4: uuidv4 } = require('uuid');

module.exports = {
  /** GET /v1/conversation/start?proficiency=auto|BEGINNER|...&sampleSize=4&includeHints=true */
// GET /v1/conversation/start?proficiency=...&sampleSize=4&includeHints=false&resume=fresh|continue|practice&topicId=123
async start(ctx) {
  try {
    const svc = strapi.service('api::conversation.conversation-service');

    const proficiency = String(ctx.query?.proficiency || 'auto');
    const includeHints = typeof ctx.query?.includeHints === 'string'
      ? ['1','true','yes','y'].includes(ctx.query.includeHints.toLowerCase())
      : false;
    const n = Number.parseInt(ctx.query?.sampleSize, 10);
    const sampleSize = Number.isFinite(n) && n > 0 ? n : 4;

    const resume = String(ctx.query?.resume || 'fresh').toLowerCase(); // fresh|continue|practice
    const topicId = ctx.query?.topicId ? Number(ctx.query.topicId) : null;

    // If you keep auth: false, ctx.state.user may be null.
    // If you enable auth, you can read user id:
    const userId = ctx.state?.user?.id || null;

    const result = await svc.startSession({
      userId, resume, proficiency, topicId, sampleSize, includeHints
    });

    ctx.send(result);
  } catch (err) {
    strapi.log.error('Failed to start conversation:', err);
    ctx.internalServerError('Error starting conversation.');
  }
},


  /**
   * POST /v1/conversation/nextprompt
   * Body: { sessionId, history, proficiency?, mode?, topic_id? }
   * - history: full client history (single source of truth)
   */
  async nextPrompt(ctx) {
    const { history, sessionId, proficiency = 'auto', mode = null, topic_id = null } = ctx.request.body || {};

    if (!sessionId) return ctx.badRequest('A "sessionId" is required for the conversation.');
    if (!history || !Array.isArray(history) || history.length === 0) {
      return ctx.badRequest('A non-empty "history" array is required.');
    }

    try {
      const svc = strapi.service('api::conversation.conversation-service');

      // Load conversation row (for summary + relation to topic)
      const [conv] = await strapi.entityService.findMany('api::conversation.conversation', {
        filters: { sessionId },
        populate: { topic: true },
        limit: 1,
      });

      if (!conv) {
        return ctx.badRequest('Unknown sessionId.');
      }

      const effectiveTopicId = topic_id || conv.topic?.id || null;
      const currentSummary   = conv.summary || null;

      // Generate next reply (service infers group, decides mode, uses summary if present)
      const {
        reply,
        inferred_proficiency_key,
        inferred_cefr_code,
        inferred_group,
        decided_mode,
      } = await svc.generateNextPrompt({
        history,
        topicId: effectiveTopicId,
        proficiency,
        mode,                 // optional override: 'practice'|'scenario'|'auto'
        summary: currentSummary,
      });

      // Persist + auto-compact in the service
      const saved = await svc.persistTurnAndMaybeCompact({
        sessionId,
        topicId: effectiveTopicId || null,
        history: [...history, { role: 'assistant', content: reply, ts: new Date().toISOString() }],
        decided_mode,
      });

      // Respond (you also get the counters back)
      ctx.send({
        sessionId,
        next_prompt: reply,
        inferred_proficiency_key: inferred_proficiency_key || null,
        inferred_cefr_code: inferred_cefr_code || null,
        inferred_group: inferred_group || null,
        decided_mode: decided_mode || null,
        topic_id: effectiveTopicId || null,
        turns_total: saved.turns_total ?? null,
        compacted_upto: saved.compacted_upto ?? null,
      });
    } catch (error) {
      strapi.log.error('Failed to get next AI prompt:', error);
      ctx.internalServerError('Error generating the next prompt.');
    }
  },
};

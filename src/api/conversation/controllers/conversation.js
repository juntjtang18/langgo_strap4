'use strict';

const { v4: uuidv4 } = require('uuid');

/**
 * Conversation Controller
 *
 * PARAMETERS (client-visible):
 * - GET /v1/conversation/start
 *    • sampleSize (optional, int): number of topic **suggestions** to seed for the LLM (1–3; default 3).
 *      NOTE: This is NOT "conversation log entries". It only controls how many candidate topics we whisper
 *      to the LLM as soft suggestions if the user asks for something new.
 *    • includeHints (optional, deprecated): accepted but ignored; scaffolding is decided by level rules.
 *
 * - POST /v1/conversation/nextprompt
 *    • sessionId (required): string
 *    • history (required): array of full chat turns (client = source of truth)
 *    • proficiency (optional): override; if omitted or 'auto' we read from user profile and/or infer.
 *    • mode (optional): 'practice' | 'scenario' | 'auto' — override if you want to lock the style.
 *    • topic_id (optional): force-bind a topic (normally the LLM drives this; we keep it open).
 */
module.exports = {
  /** GET /v1/conversation/start */
  async start(ctx) {
    try {
      const svc = strapi.service('api::conversation.conversation-service');

      // NOTE: We purposely do NOT accept recentWithinDays; it is hard-coded in the service (2 days).
      // sampleSize: how many suggestion topics to whisper to the LLM later (max 3).
      const n = Number.parseInt(ctx.query?.sampleSize, 10);
      const sampleSize = Number.isFinite(n) && n > 0 ? Math.min(3, n) : 3;

      // includeHints is deprecated; accept but ignore (kept for backward compatibility).
      const _includeHintsIgnored = typeof ctx.query?.includeHints === 'string';

      const userId = ctx.state?.user?.id || null;

      // New startSession no longer needs proficiency in query; it reads profile internally.
      const result = await svc.startSession({
        userId,
        suggestCount: sampleSize,
      });

      ctx.send(result);
    } catch (err) {
      strapi.log.error('Failed to start conversation:', err);
      ctx.internalServerError('Error starting conversation.');
    }
  },

  /** POST /v1/conversation/nextprompt */
  async nextPrompt(ctx) {
    const { history, sessionId, proficiency = 'auto', mode = null, topic_id = null } = ctx.request.body || {};

    if (!sessionId) return ctx.badRequest('A "sessionId" is required for the conversation.');
    if (!history || !Array.isArray(history) || history.length === 0) {
      return ctx.badRequest('A non-empty "history" array is required.');
    }

    try {
      const svc = strapi.service('api::conversation.conversation-service');

      // Load convo (for seed/summary/topic)
      const [conv] = await strapi.entityService.findMany('api::conversation.conversation', {
        filters: { sessionId },
        populate: { topic: true },
        limit: 1,
      });

      if (!conv) return ctx.badRequest('Unknown sessionId.');

      const effectiveTopicId = topic_id || conv.topic?.id || null;
      const currentSummary   = conv.summary || null;
      const userId           = ctx.state?.user?.id || null;

      const {
        reply,
        inferred_proficiency_key,
        inferred_cefr_code,
        inferred_group,
        decided_mode,
        maybe_new_topic_id
      } = await svc.generateNextPrompt({
        history,
        topicId: effectiveTopicId,
        proficiency,      // optional override from client; service will prefer profile/auto if 'auto'
        mode,
        summary: currentSummary,
        userId,           // NEW: so service can read profile if needed
      });

      const saved = await svc.persistTurnAndMaybeCompact({
        sessionId,
        topicId: maybe_new_topic_id || effectiveTopicId || null,
        history: [...history, { role: 'assistant', content: reply, ts: new Date().toISOString() }],
        decided_mode,
      });

      ctx.send({
        sessionId,
        next_prompt: reply,
        inferred_proficiency_key: inferred_proficiency_key || null,
        inferred_cefr_code: inferred_cefr_code || null,
        inferred_group: inferred_group || null,
        decided_mode: decided_mode || null,
        topic_id: maybe_new_topic_id || effectiveTopicId || null,
        turns_total: saved.turns_total ?? null,
        compacted_upto: saved.compacted_upto ?? null,
      });
    } catch (error) {
      strapi.log.error('Failed to get next AI prompt:', error);
      ctx.internalServerError('Error generating the next prompt.');
    }
  },
};

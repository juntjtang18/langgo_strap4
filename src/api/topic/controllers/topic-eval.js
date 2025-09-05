'use strict';

const {
  scoreTopic,
  improveTopicWithLLM,
  improveTopicBodyWithLLM,
  baseAngleFromTitle,
  stableTags,
} = require('../../topic/services/evaluator');

module.exports = {
  async evaluate(ctx) {
    const {
      ids = [],
      improve = false,
      target = 70,
      maxRounds = 2,
      changeTitle = false,        // <--- NEW: default false
    } = ctx.request.body || {};
    if (!Array.isArray(ids) || ids.length === 0) return ctx.badRequest('Provide ids array');

    const clip = (s, n = 255) => String(s ?? '').slice(0, n);

    const results = [];
    for (const id of ids) {
      let topic = await strapi.entityService.findOne('api::topic.topic', id, {
        populate: { difficulty_level: true, scenarios: true }
      });
      if (!topic) continue;

      const levelCode = topic.difficulty_level?.code || 'A1';

      const storedBefore = {
        score: topic.quality_score ?? null,
        breakdown: topic.score_breakdown ?? null,
      };

      const computedBeforeObj = scoreTopic(topic, { levelCode });
      let scoreNow = computedBeforeObj.total;
      let breakdownNow = computedBeforeObj.breakdown;

      let rounds = 0;
      let changed = false;

      if (improve) {
        while (scoreNow < Number(target) && rounds < Number(maxRounds)) {
          rounds++;

          let data;
          if (changeTitle) {
            // legacy path: can change title + tags (kept for flexibility)
            const improved = await improveTopicWithLLM(topic, { levelCode });
            const newAngle = baseAngleFromTitle(improved.title);
            const newTags = stableTags(topic.tags, newAngle);
            data = {
              title: clip(improved.title, 200),
              description: improved.description,
              tags: clip(newTags, 200),
              scenarios: (improved.scenarios || []).slice(0, 5).map(s => ({
                __component: 'a.scenario',
                title: clip(s.title, 200),
                role: clip(s.role, 200),
                role_context: clip(s.role_context, 250),
              })),
            };
          } else {
            // NEW default: title/tags stay as-is; only improve body
            const improved = await improveTopicBodyWithLLM(topic, { levelCode });
            data = {
              // leave title unchanged
              description: improved.description,
              // leave tags unchanged
              scenarios: (improved.scenarios || []).slice(0, 5).map(s => ({
                __component: 'a.scenario',
                title: clip(s.title, 200),
                role: clip(s.role, 200),
                role_context: clip(s.role_context, 250),
              })),
            };
          }

          await strapi.entityService.update('api::topic.topic', id, { data });

          // reload & rescore
          topic = await strapi.entityService.findOne('api::topic.topic', id, {
            populate: { difficulty_level: true, scenarios: true }
          });

          const prevScore = scoreNow;
          const scored = scoreTopic(topic, { levelCode });
          scoreNow = scored.total;
          breakdownNow = scored.breakdown;
          changed = true;

          if (scoreNow <= prevScore) break;           // plateau guard
          if (scoreNow >= Number(target)) break;      // reached target
        }
      }

      await strapi.entityService.update('api::topic.topic', id, {
        data: {
          quality_score: scoreNow,
          score_breakdown: breakdownNow,
        }
      });

      results.push({
        id: topic.id,
        before: { stored: storedBefore, computed: computedBeforeObj },
        after:  { score: scoreNow, breakdown: breakdownNow },
        rounds,
        improved: changed,
      });
    }

    ctx.send({ status: 'ok', results });
  },

  async evaluateRange(ctx) {
    const { from, to, improve = false, target = 70, maxRounds = 2, changeTitle = false } = ctx.request.body || {};
    if (typeof from !== 'number' || typeof to !== 'number') return ctx.badRequest('Provide numeric from/to');

    const topics = await strapi.entityService.findMany('api::topic.topic', {
      filters: { id: { $between: [from, to] } },
      fields: ['id'],
      limit: 1000,
    });

    ctx.request.body = { ids: topics.map(t => t.id), improve, target, maxRounds, changeTitle };
    return this.evaluate(ctx);
  },
};

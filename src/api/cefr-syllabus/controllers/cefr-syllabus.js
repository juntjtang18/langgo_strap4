'use strict';
const { createCoreController } = require('@strapi/strapi').factories;
const { scoreTopic, improveTopicWithLLM } = require('../../topic/services/evaluator');
//const { generateDraftTopics, selectUniqueDrafts } = require('../services/cefr-syllabus-services');
const { generateDraftTopics, selectUniqueDrafts, baseAngle } = require('../services/cefr-syllabus-services');

module.exports = createCoreController('api::cefr-syllabus.cefr-syllabus', ({ strapi }) => {
  const clip = (s, n = 255) => String(s ?? '').slice(0, n);

  const angleFromTitle = (title='') => baseAngle(title);

  async function persistAndScoreDraft({ draft, syllabus, levelId, levelCode }) {
    const row = await strapi.entityService.create('api::topic.topic', {
      data: {
        title: clip(draft.title, 200),
        spoken_title: clip(draft.spoken_title || draft.title, 120),
        description: draft.description,            // TEXT
        tags: clip(draft.tags, 200),
        mode_hint: 'scenario',
        is_active: true,
        difficulty_level: levelId,
        cefr_syllabus: syllabus.id,
        scenarios: (draft.scenarios || []).map(sc => ({
          __component: 'a.scenario',
          title: clip(sc.title, 200),
          role: clip(sc.role, 200),
          role_context: clip(sc.role_context, 250),
        })),
      }
    });

    const { total, breakdown } = scoreTopic(
      { ...draft, title: row.title, description: row.description, tags: row.tags, scenarios: draft.scenarios },
      { levelCode }
    );
    await strapi.entityService.update('api::topic.topic', row.id, {
      data: { quality_score: total, score_breakdown: breakdown }
    });

    return { row, score: total };
  }

  /**
   * Core helper used by BOTH endpoints.
   * Returns { syllabus, created_count, results, before, after, levelCode }
   */
  async function generateForOne({ syllabusId, target = 80, maxRounds = 2, topics = 10, scenariosPerTopic = 5, improve = true }) {
    // load syllabus
    const syllabus = await strapi.entityService.findOne('api::cefr-syllabus.cefr-syllabus', syllabusId, {
      populate: { difficulty_level: true }
    });
    if (!syllabus) return { created_count: 0, results: [], error: 'invalid-syllabus' };

    const levelId   = syllabus.difficulty_level?.id;
    const levelCode = syllabus.difficulty_level?.code || 'A1';
    if (!levelId) return { created_count: 0, results: [], error: 'no-level' };

    const before = syllabus.conv_topic_number || 0;
    const remaining = Math.max(0, topics - before);
    if (remaining === 0) {
      return {
        syllabus,
        created_count: 0,
        results: [],
        before,
        after: before,
        reason: 'already-filled',
        levelCode,
      };
    }

    // template
    const [tpl] = await strapi.entityService.findMany('api::topic-template.topic-template', {
      filters: { cefr_syllabus: syllabus.id, difficulty_level: levelId },
      limit: 1,
    });
    if (!tpl) {
      return { syllabus, created_count: 0, results: [], before, after: before, reason: 'no-template', levelCode };
    }

    // generate drafts
    const drafts = generateDraftTopics({
      levelCode,
      syllabusTitle: syllabus.syllabi,
      count: remaining,
      scenariosPerTopic,
      coreTemplates: tpl.core_templates || [],
      roleTemplates: tpl.role_template || tpl.role_templates || [],
      hintPack: tpl.hint_pack || {},
      syllabusSlug: syllabus.slug,
    });

    // semantic de-dupe against existing titles
    const existing = await strapi.entityService.findMany('api::topic.topic', {
      filters: { cefr_syllabus: syllabus.id }, fields: ['title'], limit: 1000,
    });
    const existingTitles = existing.map(t => t.title);

    const { acceptedDrafts } = await selectUniqueDrafts({
      syllabusTitle: syllabus.syllabi,
      levelCode,
      existingTitles,
      candidateDrafts: drafts,
      target: remaining,
    });

    // persist + score (+ improve if requested)
    const results = [];
    let created = 0;

    for (const draft of acceptedDrafts) {
      const { row, score } = await persistAndScoreDraft({ draft, syllabus, levelId, levelCode });
      let currentScore = score;
      let rounds = 0;

      if (improve) {
        // improve only description & scenarios; keep category part of tag stable, update angle from improved title
        while (currentScore < Number(target) && rounds < Number(maxRounds)) {
            rounds++;

            const improved = await improveTopicWithLLM(
                { title: row.title, description: row.description, tags: row.tags, scenarios: draft.scenarios },
                { levelCode, hintPack: tpl.hint_pack || {} }
            );

            const category = (row.tags || '').split(',')[0]?.trim() || 'general';
            const angle = angleFromTitle(improved.title);
            const rescored = scoreTopic(
                { ...draft, title: improved.title, description: improved.description,
                    tags: [category, angle].join(', '), scenarios: improved.scenarios },
                { levelCode }
            );
            await strapi.entityService.update('api::topic.topic', row.id, {
                data: {
                title: clip(improved.title, 200),
                description: improved.description,
                tags: clip([category, angle].join(', '), 200),
                scenarios: (improved.scenarios || []).slice(0, 5).map(sc => ({
                    __component: 'a.scenario',
                    title: clip(sc.title, 200),
                    role: clip(sc.role, 200),
                    role_context: clip(sc.role_context, 250),
                })),
                }
            });
            currentScore = rescored.total;

            //const reloaded = await strapi.entityService.findOne('api::topic.topic', row.id, { populate: { scenarios: true } });
            //const rescored = scoreTopic(reloaded, { levelCode });
            //currentScore = rescored.total;

            await strapi.entityService.update('api::topic.topic', row.id, {
                data: { quality_score: currentScore, score_breakdown: rescored.breakdown }
            });
        }
      }

      created++;
      results.push({ id: row.id, score: currentScore, rounds });
    }

    // bump counter -- commented out for lifecycle added to Topic
    //await strapi.entityService.update('api::cefr-syllabus.cefr-syllabus', syllabus.id, {
    //  data: { conv_topic_number: before + created },
    //});
    // Re-read accurate count maintained by topic lifecycles
    const updated = await strapi.entityService.findOne('api::cefr-syllabus.cefr-syllabus', syllabus.id);
    const after = updated?.conv_topic_number ?? (before + created);

    return {
      syllabus,
      created_count: created,
      results,
      before,
      after: before + created,
      levelCode,
    };
  }

  return {
    /**
     * POST /api/cefr-syllabus/generate-topic
     * body: { id, target?: number=80, maxRounds?: number=2, topics?: number=10, scenariosPerTopic?: number=5 }
     */
    async generateTopicFromTemplate(ctx) {
      const { id, target = 80, maxRounds = 2, topics = 10, scenariosPerTopic = 5 } = ctx.request.body || {};
      if (!id) return ctx.badRequest('Missing id');

      const res = await generateForOne({ syllabusId: Number(id), target, maxRounds, topics, scenariosPerTopic, improve: true });

      if (res.error) return ctx.badRequest(res.error);

      const { syllabus, levelCode } = res;
      ctx.send({
        status: 'ok',
        syllabus: {
          id: syllabus.id,
          title: syllabus.syllabi,
          level: levelCode,
          slug: syllabus.slug,
          before: res.before,
          after: res.after,
        },
        created_count: res.created_count,
        results: res.results,
        reason: res.reason,
      });
    },

    /**
     * POST /api/cefr-syllabus/generate-topic-bulk
     * body: { topics?: number=10, scenariosPerTopic?: number=5, target?: number=80, maxRounds?: number=1, ids?: number[] }
     * Loops syllabi and calls the SAME helper, reporting progress. Bulk also improves to target (configurable).
     */
    // POST /api/cefr-syllabus/generate-topic-bulk
    async generateTopicBulk(ctx) {
        const {
            topics = 10,
            scenariosPerTopic = 5,
            target = 85,
            maxRounds = 2,
            verbose = false,         // NEW: return detailed results per syllabus if true
        } = ctx.request.body || {};

        const t0 = Date.now();
        strapi.log.info(`[topic-bulk] starting… target=${target} maxRounds=${maxRounds} topics=${topics}`);

        // get all syllabi in order
        const syllabi = await strapi.entityService.findMany('api::cefr-syllabus.cefr-syllabus', {
            populate: { difficulty_level: true },
            sort: [{ order: 'asc' }, { id: 'asc' }],
            limit: 9999,
        });

        const total = syllabi.length || 0;
        const progress = [];
        let processed = 0;

        // Helper: consistent progress logging
        const logStep = (payload) => {
            const i = ++processed;
            const pct = total ? Math.round((i / total) * 100) : 100;
            const msg = `[topic-bulk] (${i}/${total}, ${pct}%)` +
            ` syllabus#${payload.syllabusId}` +
            (payload.title ? ` "${payload.title}"` : '') +
            (payload.level ? ` [${payload.level}]` : '') +
            ` -> created=${payload.created}` +
            (payload.reason ? ` reason=${payload.reason}` : '') +
            (payload.err ? ` ERROR=${payload.err}` : '');
            strapi.log.info(msg);
            progress.push(payload);
        };

        for (const s of syllabi) {
            const start = Date.now();

            try {
            // Reuse the *service* that your single endpoint uses.
            // If you have a helper `generateForOne` on the cefr-syllabus service, use it.
            // Otherwise, call what your single endpoint calls internally.
            //const svc = strapi.service('api::cefr-syllabus.cefr-syllabus');
            //const res = await svc.generateForOne({
            const res = await generateForOne({
                syllabusId: s.id,
                topics,
                scenariosPerTopic,
                target,
                maxRounds,
                // You can pass a silent flag if your service supports it
            });

            const took = Date.now() - start;
            logStep({
                syllabusId: s.id,
                title: s.syllabi,
                level: s?.difficulty_level?.code,
                created: res?.created_count || 0,
                before: res?.before,
                after: res?.after,
                ms: took,
                ...(verbose ? { results: res?.results || [] } : {}),
                ...(res?.reason ? { reason: res.reason } : {}),
            });

            } catch (err) {
                const took = Date.now() - start;
                strapi.log.error(`[topic-bulk] syllabus#${s.id} FAILED in ${took}ms: ${err.message}`);
                logStep({
                    syllabusId: s.id,
                    title: s.syllabi,
                    level: s?.difficulty_level?.code,
                    created: 0,
                    err: err.message,
                    ms: took,
                });
                // continue to next syllabus
            }
        }

        const totalMs = Date.now() - t0;
        strapi.log.info(`[topic-bulk] finished in ${totalMs}ms`);

        ctx.send({
            status: 'ok',
            took_ms: totalMs,
            progress,
        });
    },

  };
});

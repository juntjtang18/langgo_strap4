'use strict';
const { createCoreController } = require('@strapi/strapi').factories;
const { scoreTopic, improveTopicWithLLM } = require('../../topic/services/evaluator');
const { generateDraftTopics, selectUniqueDrafts } = require('../services/cefr-syllabus-services');

module.exports = createCoreController('api::cefr-syllabus.cefr-syllabus', ({ strapi }) => ({

  /**
   * POST /api/cefr-syllabus/generate-topic
   * body: { id, target?: number=80, maxRounds?: number=2, topics?: number=10, scenariosPerTopic?: number=5 }
   * Generates topics for ONE syllabus id, evaluates, then improves (body only) up to target.
   */
  async generateTopicFromTemplate(ctx) {
    const {
      id,                 // optional: if omitted, pick the next syllabus needing topics
      target = 80,        // target score
      maxRounds = 2,      // max improvement rounds per topic
      count = 10,         // topics to create for this syllabus (or remaining to cap)
      scenariosPerTopic = 5
    } = ctx.request.body || {};

    // 1) pick syllabus
    let syllabus;
    if (id) {
      syllabus = await strapi.entityService.findOne('api::cefr-syllabus.cefr-syllabus', id, {
        populate: { difficulty_level: true }
      });
      if (!syllabus) return ctx.badRequest('Invalid syllabus id');
    } else {
      [syllabus] = await strapi.entityService.findMany('api::cefr-syllabus.cefr-syllabus', {
        filters: { conv_topic_number: { $lt: count } },
        populate: { difficulty_level: true },
        sort: [{ conv_topic_number: 'asc' }, { order: 'asc' }, { id: 'asc' }],
        limit: 1,
      });
      if (!syllabus) {
        return ctx.send({ status: 'done', message: 'All syllabi appear complete.' });
      }
    }

    const levelId   = syllabus.difficulty_level?.id;
    const levelCode = syllabus.difficulty_level?.code || 'A1';

    // 2) fetch its template
    const [tpl] = await strapi.entityService.findMany('api::topic-template.topic-template', {
      filters: { cefr_syllabus: syllabus.id, difficulty_level: levelId },
      populate: {},
      limit: 1,
    });
    if (!tpl) return ctx.badRequest(`No topic-template for syllabus #${syllabus.id}. Create it first.`);

    // 3) generate drafts (pure)
    const drafts = generateDraftTopics({
      levelCode,
      syllabusTitle: syllabus.syllabi,
      count,
      scenariosPerTopic,
      coreTemplates: tpl.core_templates || [],
      roleTemplates: tpl.role_template || tpl.role_templates || [],
      hintPack: tpl.hint_pack || {},
      syllabusSlug: syllabus.slug,
    });
    // 3.1) semantic de-duplication vs DB + among candidates
    const existingTopics = await strapi.entityService.findMany('api::topic.topic', {
        filters: { cefr_syllabus: syllabus.id },
        fields: ['title'],
        limit: 1000,
    });
    const existingTitles = existingTopics.map(t => t.title);

    const { acceptedDrafts } = await selectUniqueDrafts({
        syllabusTitle: syllabus.syllabi,
        levelCode,
        existingTitles,
        candidateDrafts: drafts,
        target: drafts.length, // keep your requested count
    });

    // 4) persist each draft, then score and (optionally) improve
    const clip = (s, n = 255) => String(s ?? '').slice(0, n);
    const created = [];
    const results = [];                               // <-- NEW: collect per-topic results

    for (let i = 0; i < drafts.length; i++) {
      const d = drafts[i];

      // create
      const createdRow = await strapi.entityService.create('api::topic.topic', {
        data: {
          title: clip(d.title, 200),
          description: d.description,      // TEXT field
          tags: clip(d.tags, 200),
          mode_hint: 'scenario',
          is_active: true,
          difficulty_level: levelId,
          cefr_syllabus: syllabus.id,    
          // scenarios component
          scenarios: (d.scenarios || []).map(s => ({
            __component: 'a.scenario',
            title: clip(s.title, 200),
            role: clip(s.role, 200),
            role_context: clip(s.role_context, 250),
          })),
        }
      });

      // score RIGHT AFTER creation (ensures every topic ends with a score)
      const firstScore = scoreTopic(
        { ...d, title: createdRow.title, description: createdRow.description, tags: createdRow.tags, scenarios: d.scenarios },
        { levelCode }
      );
      let score = firstScore.total;
      let breakdown = firstScore.breakdown;

      // persist initial score
      await strapi.entityService.update('api::topic.topic', createdRow.id, {
        data: { quality_score: score, score_breakdown: breakdown }
      });

      // improve loop (title/body/scenarios) only if below target
      let rounds = 0;
      while (score < Number(target) && rounds < Number(maxRounds)) {
        rounds++;

        const improved = await improveTopicWithLLM(
          { title: createdRow.title, description: createdRow.description, tags: createdRow.tags, scenarios: d.scenarios },
          { levelCode, hintPack: tpl.hint_pack || {} }
        );

        // update entity (clip lengths)
        await strapi.entityService.update('api::topic.topic', createdRow.id, {
          data: {
            title: clip(improved.title, 200),
            description: improved.description,
            // keep category (first part), recompute angle from title to keep tag stable & informative
            tags: (() => {
              const category = (createdRow.tags || '').split(',')[0]?.trim() || 'general';
              const angle = (() => {
                const t = (improved.title || '').toLowerCase();
                if (t.includes('roleplay')) return 'roleplay';
                if (t.includes('compare'))  return 'compare';
                if (t.includes('plan'))     return 'plan';
                if (t.includes('problem'))  return 'problem';
                if (t.includes('clarify'))  return 'clarify';
                if (t.includes('story'))    return 'story';
                if (t.includes('advice'))   return 'advice';
                return 'general';
              })();
              return clip([category, angle].filter(Boolean).join(', '), 200);
            })(),
            scenarios: (improved.scenarios || []).slice(0, 5).map(s => ({
              __component: 'a.scenario',
              title: clip(s.title, 200),
              role: clip(s.role, 200),
              role_context: clip(s.role_context, 250),
            })),
          }
        });

        // reload a minimal shape for rescoring
        const reloaded = await strapi.entityService.findOne('api::topic.topic', createdRow.id, {
          populate: { scenarios: true, difficulty_level: true }
        });

        const rescored = scoreTopic(reloaded, { levelCode });
        score = rescored.total;
        breakdown = rescored.breakdown;

        // persist improved score
        await strapi.entityService.update('api::topic.topic', createdRow.id, {
          data: { quality_score: score, score_breakdown: breakdown }
        });

        if (score >= Number(target)) break;
      }

      created.push(createdRow);
      results.push({ id: createdRow.id, score, rounds });   // <-- record per-topic
    }

    // 5) bump syllabus counter
    const already = syllabus.conv_topic_number || 0;
    await strapi.entityService.update('api::cefr-syllabus.cefr-syllabus', syllabus.id, {
      data: { conv_topic_number: already + created.length },
    });

    ctx.send({
      status: 'ok',
      syllabus: {
        id: syllabus.id,
        title: syllabus.syllabi,
        level: levelCode,
        slug: syllabus.slug,
        before: already,
        after: already + created.length,
      },
      created_count: created.length,
      results,                              // <-- back in the payload
    });
  },

  /**
   * POST /api/cefr-syllabus/generate-topic-bulk
   * body: { target?: number=80, maxRounds?: number=2, topics?: number=10, scenariosPerTopic?: number=5 }
   * Generates topics for ALL syllabi that are underfilled. Returns progress summary.
   */
    async generateTopicBulk(ctx) {
        const {
            topics = 10,
            scenariosPerTopic = 5,
        } = ctx.request.body || {};

        const clip = (s, n = 255) => String(s ?? '').slice(0, n);

        strapi.log.info(`[bulk] starting: topics=${topics}, scenariosPerTopic=${scenariosPerTopic}`);

        const all = await strapi.entityService.findMany('api::cefr-syllabus.cefr-syllabus', {
            populate: { difficulty_level: true },
            sort: [{ order: 'asc' }, { id: 'asc' }],
            limit: 9999,
        });

        const progress = [];

        for (const s of all) {
            const levelId   = s.difficulty_level?.id;
            const levelCode = s.difficulty_level?.code || 'A1';

            try {
            if (!levelId) {
                progress.push({ syllabusId: s.id, skipped: true, reason: 'no-level' });
                continue;
            }

            // find template
            const [tpl] = await strapi.entityService.findMany('api::topic-template.topic-template', {
                filters: { cefr_syllabus: s.id, difficulty_level: levelId },
                limit: 1,
            });
            if (!tpl) {
                strapi.log.info(`[bulk] skip syllabus #${s.id} — no template`);
                progress.push({ syllabusId: s.id, skipped: true, reason: 'no-template' });
                continue;
            }

            // compute remaining to avoid overshooting any internal cap you might want
            const already = s.conv_topic_number || 0;
            const toCreate = Math.max(0, topics - already);
            if (toCreate === 0) {
                strapi.log.info(`[bulk] syllabus #${s.id} already has ${already}; skipping`);
                progress.push({ syllabusId: s.id, created: 0, reason: 'already-filled' });
                continue;
            }

            strapi.log.info(`[bulk] syllabus #${s.id} "${s.syllabi}" — generating ${toCreate}`);

            // generate drafts
            const drafts = generateDraftTopics({
                levelCode,
                syllabusTitle: s.syllabi,
                count: toCreate,
                scenariosPerTopic,
                coreTemplates: tpl.core_templates || [],
                roleTemplates: tpl.role_template || tpl.role_templates || [],
                hintPack: tpl.hint_pack || {},
                syllabusSlug: s.slug,
            });

            // DB titles for this syllabus
            const existingTopics = await strapi.entityService.findMany('api::topic.topic', {
                filters: { cefr_syllabus: s.id },
                fields: ['title'],
                limit: 1000,
            });

            const existingTitles = existingTopics.map(t => t.title);

            // pick distinct drafts
            const { acceptedDrafts } = await selectUniqueDrafts({
                syllabusTitle: s.syllabi,
                levelCode,
                existingTitles,
                candidateDrafts: drafts,
                target: toCreate,
            });

            let created = 0;

            for (const d of drafts) {
                const row = await strapi.entityService.create('api::topic.topic', {
                data: {
                    title: clip(d.title, 200),
                    description: d.description,     // TEXT field
                    tags: clip(d.tags, 200),
                    mode_hint: 'scenario',
                    is_active: true,
                    difficulty_level: levelId,
                    cefr_syllabus: s.id,
                    scenarios: (d.scenarios || []).map(sc => ({
                    __component: 'a.scenario',
                    title: clip(sc.title, 200),
                    role: clip(sc.role, 200),
                    role_context: clip(sc.role_context, 250),
                    })),
                }
                });

                // score once (no improve in bulk)
                const { total, breakdown } = scoreTopic(
                { ...d, title: row.title, description: row.description, tags: row.tags, scenarios: d.scenarios },
                { levelCode }
                );
                await strapi.entityService.update('api::topic.topic', row.id, {
                data: { quality_score: total, score_breakdown: breakdown }
                });

                created++;
                if (created % 5 === 0) {
                strapi.log.info(`[bulk] syllabus #${s.id} created ${created}/${toCreate}`);
                }
            }

            // bump syllabus counter
            await strapi.entityService.update('api::cefr-syllabus.cefr-syllabus', s.id, {
                data: { conv_topic_number: already + created }
            });

            strapi.log.info(`[bulk] syllabus #${s.id} done — created ${created}`);
            progress.push({ syllabusId: s.id, created });

            } catch (err) {
            strapi.log.error(`[bulk] syllabus #${s.id} failed: ${err.message}`);
            progress.push({ syllabusId: s.id, error: err.message });
            // continue with the rest
            }
        }

        strapi.log.info(`[bulk] finished: ${progress.length} syllabi processed`);
        ctx.send({ status: 'ok', progress });
    }
    //module.exports.generateTopicBulk = generateTopicBulk;

}));

'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::cefr-syllabus.cefr-syllabus', ({ strapi }) => ({

  // POST /api/cefr-syllabus/generate-topic
  async generateTopicFromTemplate(ctx) {
    const { generateTopicsFromTemplate } = require('../../../utils/topics-from-template');

    const TARGET_TOPICS_PER_SYLLABUS = 10;
    const SCENARIOS_PER_TOPIC = 5;

    // hard clip helper to avoid VARCHAR(255) overflow on fields still defined as string
    const clip = (s, n = 255) => {
      const t = String(s ?? '');
      return t.length > n ? t.slice(0, n) : t;
    };

    // 1) pick next syllabus
    const [syllabus] = await strapi.entityService.findMany('api::cefr-syllabus.cefr-syllabus', {
      filters: { conv_topic_number: { $lt: TARGET_TOPICS_PER_SYLLABUS } },
      populate: { difficulty_level: true },
      sort: [{ conv_topic_number: 'asc' }, { order: 'asc' }, { id: 'asc' }],
      limit: 1,
    });
    if (!syllabus) return ctx.send({ status: 'done', message: 'All syllabi have enough topics.' });

    const levelId = syllabus.difficulty_level?.id;
    const already = syllabus.conv_topic_number || 0;
    const toCreate = Math.min(10, Math.max(0, TARGET_TOPICS_PER_SYLLABUS - already));
    if (!toCreate) return ctx.send({ status: 'ok', message: 'Syllabus already full.', syllabusId: syllabus.id });

    // 2) fetch the topic-template (correct fields!)
    const [tpl] = await strapi.entityService.findMany('api::topic-template.topic-template', {
      filters: { cefr_syllabus: syllabus.id, difficulty_level: levelId },
      limit: 1,
    });
    if (!tpl) return ctx.badRequest(`No topic-template found for syllabus #${syllabus.id} (${syllabus.syllabi}). Create one first.`);

    // roles array from schema key; tolerate legacy plural
    const roleTemplates = Array.isArray(tpl.role_template)
      ? tpl.role_template
      : (tpl.role_templates || []);

    // 3) generate drafts (you already shortened tags in utils)
    const drafts = generateTopicsFromTemplate({
      levelCode: syllabus.difficulty_level.code,
      syllabusTitle: syllabus.syllabi,
      count: toCreate,
      scenariosPerTopic: SCENARIOS_PER_TOPIC,
      coreTemplates: tpl.core_templates || [],
      roleTemplates,
      hintPack: tpl.hint_pack || {},
      syllabusSlug: syllabus.slug,
    });

    // 4) save topics; clip only fields that remain VARCHAR(255)
    const created = [];
    for (const d of drafts) {
      const data = {
        title: clip(d.title, 200),         // title still string
        description: d.description,        // now TEXT, no clip
        tags: clip(d.tags, 200),           // keep safe if tags is string
        mode_hint: 'scenario',
        is_active: true,
        difficulty_level: levelId,
        cefr_syllabus: syllabus.id,        // <-- set the relation
        scenarios: (d.scenarios || []).map(s => ({
          __component: 'a.scenario',
          title: clip(s.title, 200),       // component fields are strings by default
          role: clip(s.role, 200),
          role_context: clip(s.role_context, 250),
        })),
      };
      const row = await strapi.entityService.create('api::topic.topic', { data });
      created.push(row);
    }

    // 5) bump counter
    await strapi.entityService.update('api::cefr-syllabus.cefr-syllabus', syllabus.id, {
      data: { conv_topic_number: already + created.length },
    });

    ctx.send({
      status: 'ok',
      syllabus: {
        id: syllabus.id,
        title: syllabus.syllabi,
        level: syllabus.difficulty_level.code,
        slug: syllabus.slug,
        before: already,
        after: already + created.length,
      },
      created_count: created.length,
      topic_ids: created.map(t => t.id),
    });
  },


}));

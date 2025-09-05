'use strict';
const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::topic-template.topic-template', ({ strapi }) => ({

  // POST /api/topic-templates/design
  async design(ctx) {
    const { syllabusId, targetScore = 70, maxRounds = 2 } = ctx.request.body || {};
    if (!syllabusId) return ctx.badRequest('Missing syllabusId');

    // load cefr-syllabus and level
    const syllabus = await strapi.entityService.findOne('api::cefr-syllabus.cefr-syllabus', syllabusId, {
      populate: { difficulty_level: true }
    });
    if (!syllabus) return ctx.badRequest('Invalid syllabusId');

    const levelId   = syllabus.difficulty_level?.id;
    const levelCode = syllabus.difficulty_level?.code;
    const title     = syllabus.syllabi;

    const svc = strapi.service('api::topic-template.topic-template');
    const designed = await svc.designAndImprove({
      levelCode,
      syllabusTitle: title,
      targetScore: Number(targetScore),
      maxRounds: Number(maxRounds),
    });

    // upsert by (cefr_syllabus, difficulty_level)
    const existing = await strapi.entityService.findMany('api::topic-template.topic-template', {
      filters: { cefr_syllabus: syllabusId, difficulty_level: levelId },
      limit: 1,
    });

    const data = {
      cefr_syllabus: syllabusId,         // <-- use schema field
      difficulty_level: levelId,
      core_templates: designed.core_templates,
      role_template: designed.role_templates,   // <-- store into schema field
      hint_pack: designed.hint_pack,
      quality_score: designed.quality_score,
    };

    const saved = existing.length
      ? await strapi.entityService.update('api::topic-template.topic-template', existing[0].id, { data })
      : await strapi.entityService.create('api::topic-template.topic-template', { data });

    ctx.send({
      status: 'ok',
      template_id: saved.id,
      syllabus: { id: syllabusId, title, level: levelCode },
      score: designed.quality_score,
      scores: designed._scores,
      rounds: designed.rounds,
    });
  },

  // POST /api/topic-templates/design/bulk
  async designBulk(ctx) {
    const all = await strapi.entityService.findMany('api::cefr-syllabus.cefr-syllabus', {
      populate: { difficulty_level: true },
      sort: [{ order: 'asc' }, { id: 'asc' }],
      limit: 9999,
    });

    const existing = await strapi.entityService.findMany('api::topic-template.topic-template', {
      fields: ['id'],
      populate: { cefr_syllabus: true, difficulty_level: true },
      limit: 9999,
    });

    const hasTemplate = new Set((existing || []).map(t => t.cefr_syllabus?.id).filter(Boolean));

    const designer = strapi.service('api::topic-template.topic-template');
    let created = 0;

    for (const s of all) {
      if (!s?.difficulty_level?.id) continue;
      if (hasTemplate.has(s.id)) continue;

      const result = await designer.designAndImprove({
        levelCode: s.difficulty_level.code,
        syllabusTitle: s.syllabi,
      });

      await strapi.entityService.create('api::topic-template.topic-template', {
        data: {
          cefr_syllabus: s.id,               // <-- schema field
          difficulty_level: s.difficulty_level.id,
          core_templates: result.core_templates,
          role_template: result.role_templates,  // <-- schema field
          hint_pack: result.hint_pack,
          quality_score: result.quality_score,
        }
      });
      created++;
    }

    ctx.send({ status: 'ok', created });
  },

}));

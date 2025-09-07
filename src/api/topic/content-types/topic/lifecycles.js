// src/api/topic/content-types/topic/lifecycles.js
"use strict";

const TOPIC_CT = "api::topic.topic";
const SYLL_CT  = "api::cefr-syllabus.cefr-syllabus";

const adjustCount = async (syllabusId, delta) => {
  if (!syllabusId || !delta) return;

  // Try atomic, fall back to read-modify-write
  try {
    if (delta > 0) {
      await strapi.db.query(SYLL_CT).update({
        where: { id: syllabusId },
        data: { conv_topic_number: { $increment: delta } },
      });
    } else {
      await strapi.db.query(SYLL_CT).update({
        where: { id: syllabusId },
        data: { conv_topic_number: { $decrement: Math.abs(delta) } },
      });
    }
  } catch {
    const current = await strapi.entityService.findOne(SYLL_CT, syllabusId);
    const next = Math.max(0, (current?.conv_topic_number || 0) + delta);
    await strapi.db.query(SYLL_CT).update({ where: { id: syllabusId }, data: { conv_topic_number: next } });
  }

  // Never below 0
  const check = await strapi.entityService.findOne(SYLL_CT, syllabusId);
  if ((check?.conv_topic_number ?? 0) < 0) {
    await strapi.db.query(SYLL_CT).update({ where: { id: syllabusId }, data: { conv_topic_number: 0 } });
  }
};

module.exports = {
  // ---------- CREATE ----------
  async afterCreate(event) {
    const topicId = event.result?.id;
    if (!topicId) return;
    const topic = await strapi.entityService.findOne(TOPIC_CT, topicId, { populate: { cefr_syllabus: true } });
    const syllabusId = topic?.cefr_syllabus?.id;
    await adjustCount(syllabusId, +1);
  },

  // ---------- UPDATE (move between syllabi) ----------
  async beforeUpdate(event) {
    const id = event.params?.where?.id;
    if (!id) return;
    event.state = event.state || {};
    event.state.before = await strapi.entityService.findOne(TOPIC_CT, id, { populate: { cefr_syllabus: true } });
  },

  async afterUpdate(event) {
    const before = event.state?.before;
    const afterId = event.result?.id;
    if (!afterId) return;
    const after = await strapi.entityService.findOne(TOPIC_CT, afterId, { populate: { cefr_syllabus: true } });

    const oldId = before?.cefr_syllabus?.id;
    const newId = after?.cefr_syllabus?.id;
    if (oldId && newId && oldId !== newId) {
      await adjustCount(oldId, -1);
      await adjustCount(newId, +1);
    }
  },

  // ---------- DELETE (single) ----------
  async beforeDelete(event) {
    const id = event.params?.where?.id;
    if (!id) return;
    event.state = event.state || {};
    event.state.before = await strapi.entityService.findOne(TOPIC_CT, id, { populate: { cefr_syllabus: true } });
  },

  async afterDelete(event) {
    const syllabusId = event.state?.before?.cefr_syllabus?.id;
    if (syllabusId) await adjustCount(syllabusId, -1);
  },

  // ---------- DELETE MANY (bulk) ----------
  async beforeDeleteMany(event) {
    // Collect all topics to be deleted and their syllabi
    const where = event.params?.where || {};
    const topics = await strapi.entityService.findMany(TOPIC_CT, {
      filters: where,
      populate: { cefr_syllabus: true },
      limit: -1,
    });
    event.state = event.state || {};
    event.state.toDeleteSyllabi = topics
      .map(t => t?.cefr_syllabus?.id)
      .filter(Boolean);
  },

  async afterDeleteMany(event) {
    const ids = event.state?.toDeleteSyllabi || [];
    if (!ids.length) return;
    // Decrement per syllabus by the number of topics deleted for that syllabus
    const counts = ids.reduce((acc, id) => ((acc[id] = (acc[id] || 0) + 1), acc), {});
    for (const [syllabusId, n] of Object.entries(counts)) {
      await adjustCount(Number(syllabusId), -n);
    }
  },
};

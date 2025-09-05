'use strict';
const { createCoreService } = require('@strapi/strapi').factories;
const OpenAI = require('openai');

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

// ---------- constants ----------
const MUST_ANGLE_KEYS = ['roleplay','compare','plan','problem','clarify','story','advice'];

// ---------- helpers ----------
function defaultLevelGuidance(level) {
  switch ((level||'').toUpperCase()) {
    case 'A1': return 'Use simple, concrete language; short turns; present tense; everyday words.';
    case 'A2': return 'Use simple narratives and plans; past/future; frequency; simple comparisons.';
    case 'B1': return 'Ask for opinions with reasons; short narratives; supported problem-solving.';
    case 'B2': return 'Encourage pros/cons, hypothesis, negotiation; clearer structure.';
    case 'C1': return 'Promote nuance, synthesis, counterarguments; hedging and precise stance.';
    case 'C2': return 'Aim for abstract reasoning, critique, persuasion; precise modality and register.';
    default: return 'Keep level-appropriate complexity and support.';
  }
}
function defaultGrammarTargets(level) {
  switch ((level||'').toUpperCase()) {
    case 'A1': return ['present simple','be verbs','possessives','can/can’t'];
    case 'A2': return ['past simple','going to/will','comparatives/superlatives','frequency adverbs'];
    case 'B1': return ['present perfect (basic)','first conditional','linkers (because/so/however)'];
    case 'B2': return ['second conditional','passive','relative clauses','discourse markers'];
    case 'C1': return ['mixed conditionals','hedging/modality','advanced connectors'];
    case 'C2': return ['clefts/inversion','precise modality','complex noun phrases'];
    default: return [];
  }
}

function normalizeDesign(raw, { levelCode }) {
  const low = ['A1','A2'].includes(String(levelCode).toUpperCase());

  // core
  let core = Array.isArray(raw?.core_templates) ? raw.core_templates : [];
  core = core.map(s => String(s || '').trim()).filter(Boolean);
  if (low) core = core.filter(s => !/debate|ethic|global|politic/i.test(s));
  core = core.slice(0, 14);

  // roles: accept either role_templates (preferred) or role_template (schema)
  let rolesRaw = Array.isArray(raw?.role_templates) ? raw.role_templates
               : Array.isArray(raw?.role_template)  ? raw.role_template
               : [];
  let roles = rolesRaw.map(r => ({
    title: String(r?.title || '').slice(0, 60),
    role: String(r?.role || '').slice(0, 40),
    role_context: String(r?.role_context || '').slice(0, 240),
  })).filter(r => r.title && r.role);

  // hint
  const hint = typeof raw?.hint_pack === 'object' && raw.hint_pack ? { ...raw.hint_pack } : {};
  hint.level_guidance ??= defaultLevelGuidance(levelCode);
  hint.grammar_targets ??= defaultGrammarTargets(levelCode);
  hint.discourse_moves ??= ['introduce','clarify','ask for reasons','example','contrast','summarize'];
  hint.must_vocab ??= [];
  hint.avoid ??= (low ? ['complex sentences','advanced vocabulary','abstract topics'] : hint.avoid || []);

  // return with BOTH keys for internal + controller compatibility
  return { core_templates: core, role_templates: roles, role_template: roles, hint_pack: hint };
}


// deterministic backfill to guarantee breadth & roles
function backfillDeterministic(tpl, { levelCode }) {
  const out = JSON.parse(JSON.stringify(tpl));

  // ensure breadth
  const lower = (out.core_templates || []).map(s => s.toLowerCase());
  const injectors = {
    roleplay: "Roleplay: Service",
    compare: "Compare & Choose",
    plan: "Plan Together",
    problem: "A Small Problem",
    clarify: "Clarify & Confirm",
    story: "Tell the Story",
    advice: "Tips & Advice",
  };
  for (const key of MUST_ANGLE_KEYS) {
    if (!lower.some(s => s.includes(key))) out.core_templates.push(injectors[key]);
  }
  out.core_templates = out.core_templates.map(s => String(s).trim()).filter(Boolean).slice(0, 12);

  // roles (ensure at least 5)
  let roles = Array.isArray(out.role_templates) ? out.role_templates
            : Array.isArray(out.role_template)  ? out.role_template
            : [];
  const seed = [
    { title: "Friendly Interview", role: "AI classmate", role_context: "Ask short, supportive questions; elicit examples." },
    { title: "Service Roleplay",   role: "AI staff",     role_context: "Simulate service interactions; confirm details politely." },
    { title: "Problem-Solving",    role: "AI helper",    role_context: "Present a small problem; guide step by step." },
    { title: "Compare & Decide",   role: "AI mentor",    role_context: "Prompt comparisons and justified choices." },
    { title: "Plan & Budget",      role: "AI planner",   role_context: "Co-plan timeline/budget; summarize decisions." },
    { title: "Cultural Lens",      role: "AI guide",     role_context: "Invite simple cultural contrasts relevant to the topic." },
  ];
  while (roles.length < 5) roles.push(seed[roles.length % seed.length]);
  roles = roles.slice(0, 6);

  out.role_templates = roles;   // keep both for callers
  out.role_template  = roles;

  out.hint_pack ||= {};
  out.hint_pack.level_guidance ??= defaultLevelGuidance(levelCode);
  out.hint_pack.grammar_targets ??= defaultGrammarTargets(levelCode);
  out.hint_pack.discourse_moves ??= ['introduce','clarify','ask for reasons','example','contrast','summarize'];
  out.hint_pack.must_vocab ??= [];
  out.hint_pack.avoid ??= out.hint_pack.avoid || [];
  return out;
}

// detailed scoring
function scoreDesignDetailed(tpl, { levelCode }) {
  const core  = tpl.core_templates || [];
  const roles = tpl.role_templates || tpl.role_template || []; // <-- score uses either
  const joined = core.join('|').toLowerCase();

  const breadthHits = MUST_ANGLE_KEYS.filter(k => joined.includes(k));
  const breadth = breadthHits.length * 10;           // max 70
  const coreSize = Math.min(core.length, 12) * 2;    // max 24
  const roleSize = Math.min(roles.length, 6) * 3;    // max 18
  const penalty  = (['A1','A2'].includes((levelCode||'').toUpperCase()) && /debate|ethic/.test(joined)) ? -10 : 0;

  let total = breadth + coreSize + roleSize + penalty;
  total = Math.max(0, Math.min(100, total));

  const missingAngles = MUST_ANGLE_KEYS.filter(k => !breadthHits.includes(k));
  return { total, breadth, coreSize, roleSize, penalty, missingAngles };
}

async function callOpenAIJSON(messages, temperature = 0.7) {
  const resp = await openai.chat.completions.create({
    model: 'gpt-4-turbo',
    messages,
    temperature,
  });
  const content = resp.choices?.[0]?.message?.content || '{}';
  return JSON.parse(content);
}

// ---------- service ----------
module.exports = createCoreService('api::topic-template.topic-template', ({ strapi }) => ({

  // used by your existing controller earlier — still available
  async designFor({ levelCode, syllabusTitle }) {
    const system = `You design reusable conversation template sets for English speaking practice. Return strict JSON only.`;
    const user = [
      `CEFR: ${levelCode}`,
      `Syllabus: "${syllabusTitle}"`,
      `Output JSON with keys:`,
      `- core_templates: 10-14 short labels. INCLUDE at least these angles: roleplay, compare, plan, problem, clarify, story, advice.`,
      `- role_templates: 5-8 objects { "title": "...", "role": "AI ...", "role_context": "1-2 sentences" }.`,
      `- hint_pack: { "level_guidance": "...", "grammar_targets": [...], "must_vocab": [...], "avoid": [...], "discourse_moves": [...] }`,
      `Rules: match ${levelCode} abilities and "${syllabusTitle}". Avoid debate-heavy/abstract angles at A1–A2.`,
      `Return ONLY valid JSON.`,
    ].join('\n');

    let raw;
    try {
      raw = await callOpenAIJSON(
        [
          { role: 'system', content: 'You design reusable conversation template sets for English speaking practice. Return strict JSON only.' },
          { role: 'user',   content: [
            `CEFR: ${levelCode}`,
            `Syllabus: "${syllabusTitle}"`,
            `Output JSON with keys:`,
            `- core_templates: 10-14 short labels. INCLUDE at least: roleplay, compare, plan, problem, clarify, story, advice.`,
            `- role_templates: 5-8 objects { "title": "...", "role": "AI ...", "role_context": "1-2 sentences" }.`,
            `- hint_pack: { "level_guidance": "...", "grammar_targets": [...], "must_vocab": [...], "avoid": [...], "discourse_moves": [...] }`,
            `Rules: match ${levelCode} abilities and "${syllabusTitle}". Avoid debate-heavy/abstract angles at A1–A2.`,
            `Return ONLY valid JSON.`,
          ].join('\n') }
        ],
        0.7
      );
    } catch (e) {
      strapi.log.error('OpenAI designFor error:', e.message);
      raw = {};
    }

    let normalized = normalizeDesign(raw, { levelCode });
    normalized = backfillDeterministic(normalized, { levelCode });
    const scores = scoreDesignDetailed(normalized, { levelCode });
    return { ...normalized, quality_score: scores.total, _scores: scores };
  },

  /**
   * New: one-shot design with auto-improve loop.
   * Returns { core_templates, role_templates, hint_pack, quality_score, _scores, rounds }
   */
  async designAndImprove({ levelCode, syllabusTitle, targetScore = 70, maxRounds = 2 }) {
    let result = await this.designFor({ levelCode, syllabusTitle });
    let rounds = 0;

    while (result.quality_score < targetScore && rounds < maxRounds) {
      rounds++;
      const { missingAngles } = result._scores;
      const needRoles = (result.role_templates?.length || result.role_template?.length || 0) < 5;

      const feedback = [
        `Current core_templates: ${JSON.stringify(result.core_templates)}`,
        `Missing angles: ${missingAngles.join(', ') || 'none'}`,
        `Current role_templates count: ${result.role_templates?.length || result.role_template?.length || 0}`,
        needRoles ? `Please add personas so we have 5-6 role_templates with clear role_context.` : '',
        `Ensure labels include these keywords: ${MUST_ANGLE_KEYS.join(', ')}.`,
        `Keep CEFR ${levelCode} appropriate and relevant to "${syllabusTitle}".`
      ].filter(Boolean).join('\n');

      let improvedRaw;
      try {
        improvedRaw = await callOpenAIJSON(
          [
            { role: 'system', content: 'You improve an existing template set. Return strict JSON only.' },
            { role: 'user',   content: [
              `CEFR: ${levelCode}`,
              `Syllabus: "${syllabusTitle}"`,
              `Target breadth: include roleplay, compare, plan, problem, clarify, story, advice.`,
              feedback,
              `Return ONLY valid JSON with keys: core_templates, role_templates, hint_pack.`,
            ].join('\n') }
          ],
          0.5
        );
      } catch (e) {
        strapi.log.warn('OpenAI improve failed; using last result.');
        improvedRaw = result;
      }

      let normalized = normalizeDesign(improvedRaw, { levelCode });
      normalized = backfillDeterministic(normalized, { levelCode });
      const scores = scoreDesignDetailed(normalized, { levelCode });
      result = { ...normalized, quality_score: scores.total, _scores: scores };
    }

    return { ...result, rounds };
  },

  // still available for the “improve” endpoint if you keep it
  async improveTemplate({ current, levelCode, syllabusTitle }) {
    let normalized = normalizeDesign(current, { levelCode });
    normalized = backfillDeterministic(normalized, { levelCode });
    const firstScores = scoreDesignDetailed(normalized, { levelCode });
    if (firstScores.total >= 70) return { ...normalized, quality_score: firstScores.total, _scores: firstScores };
    const tmp = await this.designAndImprove({ levelCode, syllabusTitle, targetScore: 70, maxRounds: 1 });
    return tmp;
  },

  // expose detailed scoring (optional utility)
  scoreDesignDetailed,

}));

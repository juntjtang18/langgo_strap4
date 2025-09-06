'use strict';
const { createCoreService } = require('@strapi/strapi').factories;
const OpenAI = require('openai');

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

// ---------- constants ----------
const MUST_ANGLE_KEYS = ['roleplay','compare','plan','problem','clarify','story','advice'];

// ---------- small helpers ----------
function hasAngle(label = '', angle = '') {
  const s = String(label).toLowerCase();
  const a = String(angle).toLowerCase();
  return new RegExp(`\\b${a}\\b`).test(s) || s.startsWith(a);
}
function uniqStrings(arr = []) {
  const seen = new Set();
  const out = [];
  for (const s of arr) {
    const t = String(s || '').trim();
    if (!t) continue;
    const k = t.toLowerCase();
    if (!seen.has(k)) { seen.add(k); out.push(t); }
  }
  return out;
}

// ---------- TEMPLATE SCORER (single source of truth) ----------
function scoreTemplate(tpl = {}, { levelCode = 'A1' } = {}) {
  const lc = String(levelCode || '').toUpperCase();
  const low = (lc === 'A1' || lc === 'A2');

  const core = uniqStrings(Array.isArray(tpl.core_templates) ? tpl.core_templates : []);
  const roles = Array.isArray(tpl.role_templates)
    ? tpl.role_templates
    : Array.isArray(tpl.role_template) ? tpl.role_template : [];
  const hint = typeof tpl.hint_pack === 'object' && tpl.hint_pack ? tpl.hint_pack : {};

  // 1) Breadth (0–35)
  const hitAngles = MUST_ANGLE_KEYS.filter(a => core.some(c => hasAngle(c, a)));
  const breadth = hitAngles.length * 5;
  const missingAngles = MUST_ANGLE_KEYS.filter(a => !hitAngles.includes(a));

  // 2) Core size + label quality (0–25)
  const n = core.length;
  let coreSize = 0;
  if (n >= 11 && n <= 14) coreSize = 22;
  else if (n >= 9 && n <= 10) coreSize = 18;
  else if (n >= 5 && n <= 8) coreSize = 12;
  else if (n > 14) coreSize = 16;
  else coreSize = Math.max(0, n * 2);

  const labelGood = core.filter(s => s.length >= 6 && s.length <= 48).length;
  const labelBonus = Math.min(3, Math.floor((labelGood / Math.max(1, n)) * 3));
  coreSize = Math.min(25, coreSize + labelBonus);

  // 3) Roles (0–20)
  const rCount = roles.length;
  let roleBase = 0;
  if (rCount >= 5 && rCount <= 8) roleBase = 12;
  else if (rCount === 4) roleBase = 8;
  else if (rCount > 8) roleBase = 10;
  else roleBase = Math.max(0, rCount * 2);

  let roleCompleteness = 0;
  for (const r of roles) if (r?.title && r?.role && r?.role_context) roleCompleteness++;
  const roleBonus = Math.min(8, roleCompleteness);
  const roleSize = Math.min(20, roleBase + roleBonus);

  // 4) Hint pack (0–15)
  const hasLevel = !!hint.level_guidance;
  const gt = Array.isArray(hint.grammar_targets) ? hint.grammar_targets.length : 0;
  const mv = Array.isArray(hint.must_vocab) ? hint.must_vocab.length : 0;
  const av = Array.isArray(hint.avoid) ? hint.avoid.length : 0;
  const dm = Array.isArray(hint.discourse_moves) ? hint.discourse_moves.length : 0;

  let hintScore = 0;
  if (hasLevel) hintScore += 4;
  hintScore += gt >= 3 ? 4 : gt >= 1 ? 2 : 0;
  hintScore += mv >= 3 ? 3 : mv >= 1 ? 1 : 0;
  hintScore += av >= 3 ? 2 : av >= 1 ? 1 : 0;
  hintScore += dm >= 3 ? 2 : dm >= 1 ? 1 : 0;
  hintScore = Math.min(15, hintScore);

  // 5) Penalties (0 to −10)
  let penalty = 0;
  const joined = core.join(' | ').toLowerCase();
  if (low && /(debate|ethic|global|politic|philosoph|controvers)/i.test(joined)) penalty -= 6;
  if (rCount === 0) penalty -= 6;

  let total = breadth + coreSize + roleSize + hintScore + penalty;
  total = Math.max(0, Math.min(100, total));

  return {
    total,
    breakdown: {
      breadth, coreSize, roleSize, hintScore, penalty,
      anglesHit: hitAngles, missingAngles,
      counts: { core: n, roles: rCount },
      hintStats: { hasLevel, grammarTargets: gt, mustVocab: mv, avoid: av, discourseMoves: dm },
      lowLevel: low
    }
  };
}

// ---------- normalization helpers ----------
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

// ---------- OpenAI helper ----------
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

  async designFor({ levelCode, syllabusTitle }) {
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
    const sc = scoreTemplate(normalized, { levelCode });
    return { ...normalized, quality_score: sc.total, _scores: sc.breakdown };
  },

  /**
   * One-shot design with auto-improve loop.
   * Returns { core_templates, role_templates, hint_pack, quality_score, _scores, rounds }
   */
  async designAndImprove({ levelCode, syllabusTitle, targetScore = 70, maxRounds = 2 }) {
    let result = await this.designFor({ levelCode, syllabusTitle });
    let rounds = 0;

    while (result.quality_score < targetScore && rounds < maxRounds) {
      rounds++;

      const b = result._scores;
      const feedback = [
        `Missing angles: ${b.missingAngles.join(', ') || 'none'}.`,
        `Core labels: ${b.counts.core} (target 10–14 unique, readable labels; aim for 6–48 chars each).`,
        `Roles: ${b.counts.roles} (need 5–8), ensure each has: "title", "role", "role_context" (1–2 sentences).`,
        `Hints coverage — level_guidance:${b.hintStats.hasLevel ? 'yes' : 'no'}, ` +
          `grammar_targets:${b.hintStats.grammarTargets}, must_vocab:${b.hintStats.mustVocab}, ` +
          `avoid:${b.hintStats.avoid}, discourse_moves:${b.hintStats.discourseMoves}. Increase any low counts.`,
        b.lowLevel ? `For ${levelCode}, avoid abstract/debate angles; keep concrete and simple.` : ''
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
      const sc = scoreTemplate(normalized, { levelCode });
      result = { ...normalized, quality_score: sc.total, _scores: sc.breakdown };
    }

    return { ...result, rounds };
  },

  // Optional helper if you keep a separate improve entry point
  async improveTemplate({ current, levelCode, syllabusTitle }) {
    let normalized = normalizeDesign(current, { levelCode });
    normalized = backfillDeterministic(normalized, { levelCode });
    let sc = scoreTemplate(normalized, { levelCode });
    if (sc.total >= 70) return { ...normalized, quality_score: sc.total, _scores: sc.breakdown };

    // otherwise run one improvement round
    const tmp = await this.designAndImprove({ levelCode, syllabusTitle, targetScore: 70, maxRounds: 1 });
    return tmp;
  },

  // expose scorers (alias keeps backward compatibility)
  scoreTemplate,
  scoreDesignDetailed: scoreTemplate,
}));

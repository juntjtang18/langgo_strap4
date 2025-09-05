'use strict';
const axios = require('axios');

function buildDesignPrompt({ levelCode, syllabusTitle }) {
  return [
    `Design a reusable conversation template set for English speaking practice.`,
    `CEFR level: ${levelCode}. Syllabus: "${syllabusTitle}".`,
    `Output JSON with keys:`,
    `- core_templates: 10-14 short labels of conversation angles (e.g., "Roleplay: Service", "Compare & Choose", "Clarify & Confirm", "Plan Together", "A Small Problem", "Tell the Story", "Pros & Cons", "Past & Future", "Tips & Advice").`,
    `- role_templates: 5-8 objects { "title": "...", "role": "AI ....", "role_context": "1-2 sentences of guidance" }.`,
    `- hint_pack: { "level_guidance": "...", "grammar_targets": [...], "must_vocab": [...], "avoid": [...], "discourse_moves": [...] }`,
    `Rules:`,
    `- Match the communicative needs of "${syllabusTitle}" and the CEFR ${levelCode} band.`,
    `- Avoid abstract/debate-heavy angles at A1–A2.`,
    `- Return ONLY valid JSON.`,
  ].join('\n');
}

// Call your LLM; fallback to deterministic defaults if no endpoint provided
async function callLLM(prompt) {
  const endpoint = process.env.LLM_ENDPOINT;
  if (!endpoint) {
    return fallbackDesign(); // deterministic, good-enough baseline
  }
  try {
    const res = await axios.post(endpoint, { prompt });
    // Expect res.data to be JSON or a stringified JSON
    return typeof res.data === 'string' ? JSON.parse(res.data) : res.data;
  } catch (e) {
    // fail safe
    return fallbackDesign();
  }
}

function fallbackDesign() {
  return {
    core_templates: [
      "Let's Talk",
      "Roleplay: Service",
      "Clarify & Confirm",
      "Compare & Choose",
      "Plan Together",
      "A Small Problem",
      "Tell the Story",
      "Tips & Advice",
      "Past & Future",
      "Pros & Cons"
    ],
    role_templates: [
      { title: "Friendly Interview", role: "AI classmate", role_context: "Ask short, supportive questions; elicit examples and details." },
      { title: "Service Roleplay", role: "AI staff", role_context: "Simulate realistic service interactions; confirm details politely." },
      { title: "Problem-Solving", role: "AI helper", role_context: "Present a small problem and guide the learner to a solution." },
      { title: "Compare & Decide", role: "AI mentor", role_context: "Prompt comparisons and justified choices; ask for reasons." },
      { title: "Plan & Budget", role: "AI planner", role_context: "Co-plan timeline and constraints; summarize decisions at the end." },
    ],
    hint_pack: {
      level_guidance: "Keep prompts aligned with level; scaffold or challenge as needed.",
      grammar_targets: ["present simple", "polite requests", "comparatives/superlatives"],
      must_vocab: [],
      avoid: [],
      discourse_moves: ["clarify", "ask for reasons", "contrast", "summarize"]
    }
  };
}

function normalizeTemplates(raw, { levelCode, syllabusTitle }) {
  const low = ['A1','A2'].includes(String(levelCode).toUpperCase());

  const core = (raw.core_templates || [])
    .map(s => String(s).trim())
    .filter(Boolean)
    .filter(s => low ? !/debate|ethic|global|politic/i.test(s) : true)
    .slice(0, 14);

  const roles = (raw.role_templates || [])
    .map(r => ({
      title: String(r.title || '').slice(0, 60),
      role: String(r.role || '').slice(0, 40),
      role_context: String(r.role_context || '').slice(0, 240),
    }))
    .filter(r => r.title && r.role);

  const hint = raw.hint_pack || {};
  hint.level_guidance ??= defaultLevelGuidance(levelCode);
  hint.grammar_targets ??= defaultGrammarTargets(levelCode);
  hint.discourse_moves ??= ['clarify','reason','example','contrast','summarize'];
  hint.must_vocab ??= [];
  hint.avoid ??= [];

  return { core_templates: core, role_templates: roles, hint_pack: hint };
}

function scoreTemplateSet(tpl, { levelCode }) {
  const core = tpl.core_templates || [];
  const roles = tpl.role_templates || [];
  let score = 0;

  // breadth check
  const joined = core.join('|').toLowerCase();
  const mustHave = ['roleplay','compare','plan','problem','clarify','story','advice'];
  score += mustHave.filter(k => joined.includes(k)).length * 10;

  // size
  score += Math.min(core.length, 12) * 2;
  score += Math.min(roles.length, 6) * 3;

  // level gate penalty
  if (['A1','A2'].includes((levelCode||'').toUpperCase()) && /debate|ethic/.test(joined)) score -= 10;

  return Math.max(0, Math.min(100, score));
}

function defaultLevelGuidance(level) {
  switch ((level||'').toUpperCase()) {
    case 'A1': return 'Use simple, concrete language; short turns; present tense; everyday words.';
    case 'A2': return 'Use simple narratives and plans; past/future; frequency; simple comparisons.';
    case 'B1': return 'Ask for opinions with reasons; short narratives; problem scenarios with support.';
    case 'B2': return 'Encourage pros/cons, hypothesis, negotiation; clearer structure and support.';
    case 'C1': return 'Promote nuance, synthesis, counterarguments; hedging and precise stance.';
    case 'C2': return 'Aim for abstract reasoning, critique, persuasion; precise modality and register.';
    default: return 'Keep level-appropriate complexity and support.';
  }
}

function defaultGrammarTargets(level) {
  switch ((level||'').toUpperCase()) {
    case 'A1': return ['present simple','there is/are','can/can’t'];
    case 'A2': return ['past simple','going to/will','comparatives'];
    case 'B1': return ['present perfect (basic)','first conditional','linkers'];
    case 'B2': return ['second conditional','passive','relative clauses'];
    case 'C1': return ['mixed conditionals','hedging','advanced connectors'];
    case 'C2': return ['clefts/inversion','precise modality','complex noun phrases'];
    default: return [];
  }
}

module.exports = { buildDesignPrompt, callLLM, normalizeTemplates, scoreTemplateSet };

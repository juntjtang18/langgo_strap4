'use strict';
const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
function parseTags(tags='') {
  const [categoryRaw, angleRaw] = String(tags).split(',').map(s => (s||'').trim());
  const category = categoryRaw || 'general';
  const angle = (angleRaw || '').toLowerCase();
  return { category, angle };
}

function canonicalAngle(angle='') {
  const a = angle.toLowerCase();
  if (a.startsWith('roleplay')) return 'Roleplay';
  if (a.startsWith('compare'))  return 'Compare';
  if (a.startsWith('plan'))     return 'Plan';
  if (a.startsWith('problem'))  return 'Problem';
  if (a.startsWith('clarify'))  return 'Clarify';
  if (a.startsWith('story'))    return 'Story';
  if (a.startsWith('advice'))   return 'Advice';
  return 'Roleplay';
}

function stripAnglePrefix(title='') {
  // remove any leading angle + colon (Roleplay: / Compare: / etc.)
  return String(title).replace(/^\s*(roleplay|compare|plan|problem|clarify|story|advice)\s*:\s*/i, '').trim();
}

function stripCategorySuffix(title='', humanCategory='') {
  if (!humanCategory) return title;
  // remove any "— humanCategory" or " - humanCategory" once or multiple times
  const hc = humanCategory.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const re = new RegExp(`\\s*[-–—]\\s*${hc}\\s*$`, 'i');
  let out = String(title).trim();
  while (re.test(out)) out = out.replace(re, '').trim();
  return out;
}

function ensureAnglePrefix(baseTitle='', desiredAngle='Roleplay') {
  const A = canonicalAngle(desiredAngle);
  return `${A}: ${baseTitle}`.trim();
}

function ensureCategoryOnce(title='', humanCategory='') {
  if (!humanCategory) return title;
  return `${title} — ${humanCategory}`.replace(/\s{2,}/g, ' ').trim();
}

function cleanTitle(s='') {
  return String(s)
    .replace(/\s*[-–—]\s*/g, ' — ')
    .replace(/\s{2,}/g, ' ')
    .replace(/[:：]\s*[:：]/g, ': ')
    .trim();
}


/**
 * Heuristic rubric for topics (0–100)
 * We reward: A1 fit, natural titles, concise description, angle clarity, scenario variety, no truncation risk.
 */
function scoreTopic(topic, { levelCode = 'A1' } = {}) {
  const title = String(topic.title || '');
  const description = String(topic.description || '');
  const tags = String(topic.tags || '');
  const scenarios = Array.isArray(topic.scenarios) ? topic.scenarios : [];

  // category/tag alignment
  const category = tags.split(',')[0]?.trim() || '';
  const categoryWords = category.replace(/-/g,' ').split(/\s+/).filter(Boolean).slice(0,3);
  const titleHasCategory = categoryWords.length
    ? categoryWords.some(w => new RegExp(`\\b${w}\\b`, 'i').test(title))
    : true;

  // angle
  const angle =
    title.toLowerCase().includes('roleplay') ? 'roleplay' :
    title.toLowerCase().includes('compare')  ? 'compare'  :
    title.toLowerCase().includes('plan')     ? 'plan'     :
    title.toLowerCase().includes('problem')  ? 'problem'  :
    title.toLowerCase().includes('clarify')  ? 'clarify'  :
    title.toLowerCase().includes('story')    ? 'story'    :
    title.toLowerCase().includes('advice')   ? 'advice'   : 'general';

  const badPrefix = /^illustrate:|^answer:/i.test(title);
  const descLen = description.length;
  const concise = descLen >= 80 && descLen <= 320;

  const uniq = (arr) => Array.from(new Set(arr));
  const scenTitles = uniq(scenarios.map(s => (s.title || '').trim().toLowerCase()).filter(Boolean));
  const scenRoles  = uniq(scenarios.map(s => (s.role || '').trim().toLowerCase()).filter(Boolean));
  const scenCount  = scenarios.length;

  const tooLong = {
    title: title.length > 200,
    tags: tags.length > 200,
    scenTitle: scenarios.some(s => (s.title || '').length > 200),
    scenRole: scenarios.some(s => (s.role || '').length > 200),
    scenCtx: scenarios.some(s => (s.role_context || '').length > 250),
  };

  // Base scores (keep similar to your current behavior)
  let breadth = ['roleplay','compare','plan','problem','clarify','story','advice'].includes(angle) ? 24 : 10;
  let titleScore = (badPrefix ? 5 : 14) + (titleHasCategory ? 6 : 0); // up to 20
  let descScore = concise ? 20 : (descLen ? 10 : 0);

  // scenario variety + roles present
  let scenVarScore = Math.min(scenCount, 5) * 3; // up to 15
  scenVarScore += Math.min(scenTitles.length, 5); // up to 5
  const emptyRoles = scenarios.filter(s => !s.role).length;
  let roleQuality = Math.max(0, 10 - emptyRoles * 3); // up to 10, penalize empties
  let scenariosScore = Math.min(25, scenVarScore + roleQuality);

  // A1 “too advanced” phrasing penalty (light)
  const a1Penalties = /because of|despite|in order to/i.test(description) ? -5 : 0;

  // Truncation penalties
  const truncPen =
    (tooLong.title ? -5 : 0) + (tooLong.tags ? -3 : 0) +
    (tooLong.scenTitle ? -3 : 0) + (tooLong.scenRole ? -3 : 0) + (tooLong.scenCtx ? -5 : 0);

  let subtotal = breadth + titleScore + descScore + scenariosScore + a1Penalties + truncPen;
  subtotal = Math.max(0, Math.min(100, subtotal));

  // ---------- NEW: polish bonus (up to +12) ----------
  // Reward “everything right” & extra quality signals
  let polishBonus = 0;

  // 1) Perfect constraints bonus (+5): real angle, category in title, concise, no trunc, no empty roles
  const noTrunc = !tooLong.title && !tooLong.tags && !tooLong.scenTitle && !tooLong.scenRole && !tooLong.scenCtx;
  const realAngle = angle !== 'general';
  if (realAngle && titleHasCategory && concise && noTrunc && emptyRoles === 0) {
    polishBonus += 5;
  }

  // 2) Role diversity bonus (+2): 5 distinct roles
  if (scenRoles.length >= 5) polishBonus += 2;

  // 3) Scenario “starter” bonus (+3): at least 3 role_contexts contain a clear action cue (introduce/ask/tell)
  const cueRegex = /\b(introduce|ask|tell|share|greet)\b/i;
  const cueCount = scenarios.filter(s => cueRegex.test(String(s.role_context||''))).length;
  if (cueCount >= 3) polishBonus += 3;

  // 4) A1 clarity bonus (+2): description between 100–220 chars (sweet spot)
  if (descLen >= 100 && descLen <= 220) polishBonus += 2;

  let total = subtotal + polishBonus;
  total = Math.max(0, Math.min(100, total));

  return {
    total,
    breakdown: {
      breadth, titleScore, descScore, scenariosScore,
      a1Penalties, truncPen, angle, titleHasCategory,
      emptyRoles, tooLong,
      polishBonus, cueCount, roleVariety: scenRoles.length,
      concise, descLen
    }
  };
}

async function improveTopicBodyWithLLM(topic, { levelCode = 'A1', hintPack = {} } = {}) {
  // Derive category just for context in the prompt (don’t change tags)
  const category = String(topic.tags || '').split(',')[0]?.trim() || '';
  const humanCategory = category.replace(/-/g, ' ').replace(/\b\w/g, c => c.toUpperCase());

  const system = `You improve the body (description + scenarios) of a CEFR ${levelCode} speaking topic.
Return STRICT JSON: {"description":"...", "scenarios":[{"title":"","role":"","role_context":""},...]}.
Hard rules:
- KEEP the topic within the category: "${humanCategory}".
- DO NOT change the title; only improve description & scenarios.
- Description: 100–220 characters, simple A1 language; include clear purpose and 2–3 relevant key words if natural.
- Include EXACTLY 5 scenarios. Each has:
  - a short "role" (e.g., "Classmate", "New Neighbor"),
  - a 1–2 sentence "role_context" with a clear action cue (introduce / ask / tell / share / greet).
- No markdown or extra text; JSON only.`;

  const user = JSON.stringify({
    levelCode,
    category: humanCategory,
    current: {
      description: topic.description,
      scenarios: (topic.scenarios || []).map(s => ({ title: s.title, role: s.role, role_context: s.role_context }))
    },
    constraints: { minDesc: 100, maxDesc: 220, scenarioCount: 5 }
  });

  // Call LLM
  let out = { description: topic.description, scenarios: topic.scenarios || [] };
  try {
    const resp = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      temperature: 0.25,
      messages: [
        { role: 'system', content: system },
        { role: 'user', content: user }
      ]
    });
    out = JSON.parse(resp.choices?.[0]?.message?.content || '{}');
  } catch (e) {
    // keep original if LLM fails
  }

  // Normalize scenarios (exactly 5, unique titles, fill roles/contexts if missing)
  const desired = 5;
  const roleFallbacks = ['Classmate','New Neighbor','Language Partner','Receptionist','Friend'];

  let scenarios = Array.isArray(out.scenarios) ? out.scenarios.slice(0, desired) : [];
  for (let i = 0; i < scenarios.length; i++) {
    if (!scenarios[i].role) scenarios[i].role = roleFallbacks[i % roleFallbacks.length];
    if (!scenarios[i].title) scenarios[i].title = `${scenarios[i].role}: Task`;
    if (!scenarios[i].role_context) scenarios[i].role_context = `Introduce yourself. Ask a simple question.`;
  }
  // de-dup titles
  const seen = new Set();
  scenarios = scenarios.filter(s => {
    const key = (s.title || '').toLowerCase().trim();
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
  // top up to 5
  for (let i = scenarios.length; i < desired; i++) {
    scenarios.push({
      title: `${roleFallbacks[i % roleFallbacks.length]}: Task`,
      role: roleFallbacks[i % roleFallbacks.length],
      role_context: `Introduce yourself. Ask a simple question.`
    });
  }

  return { description: out.description || topic.description, scenarios };
}


async function improveTopicWithLLM(
  topic,
  { levelCode = 'A1', hintPack = {}, forbiddenTitles = [] } = {}
) {
  // Parse tags to get stable category/angle
  const { category, angle } = parseTags(topic.tags || '');
  const humanCategory = category.replace(/-/g, ' ').replace(/\b\w/g, c => c.toUpperCase());
  const desiredAngle = canonicalAngle(angle || 'roleplay');

  // Build the system / user payload
  const system = `You improve CEFR ${levelCode} English speaking practice topics.
Return STRICT JSON: {"title": "...", "description": "...", "scenarios":[{"title":"","role":"","role_context":""},...]}.
Hard rules:
- KEEP the topic within the category: "${humanCategory}" (do not switch domains).
- Title MUST begin with one of: Roleplay, Compare, Plan, Problem, Clarify, Story, Advice.
- Keep the angle "${desiredAngle}" unless the user requests a different angle.
- Description: 100–220 characters, simple A1 language; include 2–3 relevant key words if natural.
- Include EXACTLY 5 scenarios. Each has:
   - a short "role" (e.g., "Classmate", "New Neighbor"),
   - a "role_context" (1–2 simple sentences) that contains a clear action cue (e.g., introduce / ask / tell / share / greet).
- Avoid duplicating any titles in the provided forbidden list.
- No markdown or extra text; JSON only.`;

  const user = JSON.stringify({
    levelCode,
    category: humanCategory,
    desiredAngle,
    current: {
      title: topic.title,
      description: topic.description,
      scenarios: (topic.scenarios || []).map(s => ({ title: s.title, role: s.role, role_context: s.role_context }))
    },
    forbiddenTitles,  // prevent homogenization across the same syllabus
    requirements: {
      angles: ['Roleplay','Compare','Plan','Problem','Clarify','Story','Advice'],
      minDesc: 100, maxDesc: 220,
      scenarioCount: 5,
      actionCues: ['introduce','ask','tell','share','greet']
    },
    hints: hintPack || {}
  });

  // Call LLM
  let out = { title: topic.title, description: topic.description, scenarios: topic.scenarios || [] };
  try {
    const resp = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      temperature: 0.25,
      messages: [
        { role: 'system', content: system },
        { role: 'user', content: user }
      ]
    });
    out = JSON.parse(resp.choices?.[0]?.message?.content || '{}');
  } catch (e) {
    // keep original if LLM fails
  }

  // --------- Deterministic guardrails (IDEMPOTENT) ----------
  // 1) Normalize angle & category ONCE
  let base = stripAnglePrefix(out.title || topic.title);
  base = stripCategorySuffix(base, humanCategory);     // remove old suffix if present (even if repeated)
  let titled = ensureAnglePrefix(base, desiredAngle);  // add correct angle once
  titled = ensureCategoryOnce(titled, humanCategory);  // add category once
  titled = cleanTitle(titled);

  // 2) Normalize scenarios (5, unique, roles non-empty)
  const desired = 5;
  const roleFallbacks = ['Classmate','New Neighbor','Language Partner','Receptionist','Friend'];

  let scenarios = Array.isArray(out.scenarios) ? out.scenarios.slice(0, desired) : [];
  for (let i = 0; i < scenarios.length; i++) {
    if (!scenarios[i].role) scenarios[i].role = roleFallbacks[i % roleFallbacks.length];
    if (!scenarios[i].title) scenarios[i].title = `${scenarios[i].role}: Task`;
    if (!scenarios[i].role_context) scenarios[i].role_context = `Introduce yourself. Ask a simple question.`;
  }
  const seen = new Set();
  scenarios = scenarios.filter(s => {
    const key = (s.title || '').toLowerCase().trim();
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
  for (let i = scenarios.length; i < desired; i++) {
    scenarios.push({
      title: `${roleFallbacks[i % roleFallbacks.length]}: Task`,
      role: roleFallbacks[i % roleFallbacks.length],
      role_context: `Introduce yourself. Ask a simple question.`
    });
  }

  return { title: titled, description: out.description || topic.description, scenarios };
}



function baseAngleFromTitle(title='') {
  const t = title.toLowerCase();
  if (t.includes('roleplay')) return 'roleplay';
  if (t.includes('compare'))  return 'compare';
  if (t.includes('plan'))     return 'plan';
  if (t.includes('problem'))  return 'problem';
  if (t.includes('clarify'))  return 'clarify';
  if (t.includes('story'))    return 'story';
  if (t.includes('advice'))   return 'advice';
  return 'general';
}

function stableTags(originalTags='', enforcedAngle='') {
  // keep first tag (category) stable, and recompute the angle
  const category = originalTags.split(',')[0]?.trim() || 'general';
  const angle = enforcedAngle || baseAngleFromTitle(originalTags);
  return [category, angle].filter(Boolean).join(', ');
}


module.exports = { scoreTopic, improveTopicWithLLM, improveTopicBodyWithLLM, baseAngleFromTitle, stableTags };

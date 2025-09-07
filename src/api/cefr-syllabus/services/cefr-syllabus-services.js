'use strict';
// at top
const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
const SPOKEN_MAX = 250;


function clamp(str = '', n = SPOKEN_MAX) {
  const s = String(str || '').trim();
  return s.length <= n ? s : s.slice(0, n).replace(/\s+\S*$/, ''); // no mid-word cut
}

// ---- helpers ----
function baseAngle(core) {
  const s = String(core || '').toLowerCase();
  if (s.includes('roleplay')) return 'roleplay';
  if (s.includes('compare'))  return 'compare';
  if (s.includes('plan'))     return 'plan';
  if (s.includes('problem'))  return 'problem';
  if (s.includes('clarify'))  return 'clarify';
  if (s.includes('story'))    return 'story';
  if (s.includes('advice'))   return 'advice';
  return 'general';
}

function slugify(text, max = 64) {
  let s = String(text || '')
    .normalize('NFKD').replace(/[\u0300-\u036f]/g, '')
    .replace(/&/g, ' and ')
    .replace(/['’]/g, '')
    .replace(/[^a-zA-Z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .toLowerCase();
  if (s.length > max) s = s.slice(0, max).replace(/-+$/,'');
  return s || 'topic';
}
function pickCores(coreTemplates = [], n = 10) {
  const pool = [...new Set(coreTemplates.map(s => String(s).trim()).filter(Boolean))];
  for (let i = pool.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [pool[i], pool[j]] = [pool[j], pool[i]];
  }
  return pool.slice(0, n);
}
function rotateRoles(roleTemplates = [], kPerTopic = 5) {
  const clean = (roleTemplates || [])
    .map(r => ({ title: r.title, role: r.role, role_context: r.role_context }))
    .filter(r => r.title && r.role);
  return function forTopic(idx) {
    const out = [];
    for (let k = 0; k < Math.min(kPerTopic, clean.length || 0); k++) {
      const r = clean[(idx + k) % clean.length];
      out.push({ ...r });
    }
    return out;
  };
}
function levelLine(levelCode, hintPack) {
  const lg = hintPack?.level_guidance ? `Guidance: ${hintPack.level_guidance}` : '';
  const gt = Array.isArray(hintPack?.grammar_targets) && hintPack.grammar_targets.length
    ? `Grammar: ${hintPack.grammar_targets.join(', ')}`
    : '';
  const dm = Array.isArray(hintPack?.discourse_moves) && hintPack.discourse_moves.length
    ? `Moves: ${hintPack.discourse_moves.join(', ')}`
    : '';
  return [`Level: ${levelCode}.`, lg, gt, dm].filter(Boolean).join(' ');
}
function topicTitle(core, syllabusTitle) {
  const map = {
    'Roleplay: Service': 'Roleplay in',
    'Roleplay': 'Roleplay in',
    'Compare': 'Compare & Choose',
    'Pros & Cons': 'Pros & Cons of',
    'Clarify & Confirm': 'Clarify & Confirm in',
    'Plan': 'Plan Together',
    'Problem': 'A Small Problem in',
    'Story': 'Tell the Story',
    'Advice': 'Tips & Advice about',
  };
  const friendly = map[core] || core;
  return `${friendly}: ${syllabusTitle}`;
}
function topicsFrom(coreList, rolePicker, { levelCode, syllabusTitle, hintPack, count, scenariosPerTopic, syllabusSlug }) {
  const out = [];
  const lvlLine = levelLine(levelCode, hintPack);
  const must = (hintPack?.must_vocab || []).filter(Boolean);
  const avoid = (hintPack?.avoid || []).filter(Boolean);

  for (let i = 0; i < coreList.length && out.length < count; i++) {
    const core = coreList[i];
    const title = topicTitle(core, syllabusTitle);

    const descParts = [
      `Practice "${syllabusTitle}" via "${core}" angle.`,
      lvlLine,
    ];
    if (must.length) descParts.push(`Use: ${must.join(', ')}.`);
    if (avoid.length) descParts.push(`Avoid: ${avoid.join(', ')}.`);

    const description = descParts.join(' ');

    const scenarios = (rolePicker(i) || []).slice(0, scenariosPerTopic).map(s => ({
      title: s.title,
      role: s.role,
      role_context: `${s.role_context} ${lvlLine}`.trim(),
    }));

    const category = slugify(syllabusTitle, 48);
    const angle    = baseAngle(core);

    out.push({
      title,
      spoken_title: clamp(title.replace(/^Roleplay:\s*/i, '').replace(/—/g, '-')), // simple, only used when LLM didn’t create it
      description,
      tags: [category, angle].filter(Boolean).join(', '),
      scenarios,
    });
  }

  return out;
}

// -------- PUBLIC API (pure generator) --------
function generateDraftTopics({
  levelCode,
  syllabusTitle,
  count = 10,
  scenariosPerTopic = 5,
  coreTemplates = [],
  roleTemplates = [],
  hintPack = {},
  syllabusSlug
}) {
  const cores = pickCores(coreTemplates, count);
  if (!cores.length) {
    cores.push('Let\'s Talk', 'Roleplay in', 'Compare & Choose', 'Plan Together', 'A Small Problem in');
  }
  const pickRoles = rotateRoles(roleTemplates, scenariosPerTopic);
  return topicsFrom(cores, pickRoles, { levelCode, syllabusTitle, hintPack, count, scenariosPerTopic, syllabusSlug });
}


// quick normalizer
const norm = (s='') => String(s).toLowerCase()
  .replace(/[^\w\s]/g, ' ')
  .replace(/\s+/g, ' ')
  .trim();

// cheap “same-idea” fingerprint = words minus stopwords
const STOP = new Set(['the','a','an','and','or','to','of','in','on','for','with','your','my','our','you','me']);
function fingerprint(title='') {
  const toks = norm(title).split(' ').filter(w => w && !STOP.has(w));
  return Array.from(new Set(toks)).join(' ');
}

// Heuristic dedupe within a list
function heuristicPrune(candidates) {
  const seen = new Set();
  const out = [];
  for (const t of candidates) {
    const fp = fingerprint(t);
    if (seen.has(fp)) continue;
    seen.add(fp);
    out.push(t);
  }
  return out;
}

async function llmSelectDistinct({ syllabusTitle, levelCode, existingTitles, candidates, need }) {
 const system = `You are selecting distinct EN speaking practice TOPIC TITLES for syllabus-specific practice.
 Return STRICT JSON:
 { "accepted": [ { "title": "...", "spoken_title": "..." } , ... ], "missing": 0 }.
Rules:
- Titles must be distinct ideas (not rephrases).
- Exclude anything semantically similar to existing titles.
- Prefer covering varied angles: roleplay, compare, plan, problem, clarify, story, advice.
- Keep "title" concise (<=120 chars), natural, and relevant to "${syllabusTitle}".
- "spoken_title" must be SHORT & speakable (<= ${SPOKEN_MAX} chars), no colons if possible, no jargon.`;
  const user = JSON.stringify({
    levelCode,
    syllabusTitle,
    need,
    existing: existingTitles,
    candidates
  });

  try {
    const resp = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      temperature: 0.3,
      messages: [
        { role: 'system', content: system },
        { role: 'user',   content: user }
      ]
    });
    const data = JSON.parse(resp.choices?.[0]?.message?.content || '{}');
    const acceptedRaw = Array.isArray(data.accepted) ? data.accepted : [];
    const accepted = acceptedRaw.map(x => {
      if (typeof x === 'string') return { title: x, spoken_title: clamp(x) };
      return { title: String(x.title || ''), spoken_title: clamp(x.spoken_title || x.title || '') };
    }).filter(o => o.title);
    const missing = Math.max(0, need - accepted.length);
    return { accepted, missing };
  } catch {
    return { accepted: candidates.slice(0, need), missing: Math.max(0, need - candidates.length) };
  }
}

async function llmTopUpNew({ syllabusTitle, levelCode, existingTitles, alreadyAccepted, needMore }) {
 const system = `You propose NEW topic titles for "${syllabusTitle}" (CEFR ${levelCode}).
 Return STRICT JSON: { "titles": [ { "title":"...", "spoken_title":"..." }, ... ] }
Rules:
- Propose ${needMore} fresh, distinct titles unlike existing or accepted.
- Keep "title" concise (<=120 chars), natural.
- "spoken_title" must be SHORT & speakable (<= ${SPOKEN_MAX} chars), no heavy punctuation.
- Vary angles among: roleplay, compare, plan, problem, clarify, story, advice.`;
  const user = JSON.stringify({
    existing: existingTitles,
    accepted: alreadyAccepted,
    count: needMore
  });

  try {
    const resp = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      temperature: 0.5,
      messages: [
        { role: 'system', content: system },
        { role: 'user',   content: user }
      ]
    });
    const data = JSON.parse(resp.choices?.[0]?.message?.content || '{}');
    const arr = Array.isArray(data.titles) ? data.titles : [];
    return arr.map(x => {
      if (typeof x === 'string') return { title: x, spoken_title: clamp(x) };
      return { title: String(x.title || ''), spoken_title: clamp(x.spoken_title || x.title || '') };
    }).filter(o => o.title);
  } catch {
    return [];
  }
}

// main entry used by the controller/service BEFORE persistence
// existingTitles: array of titles already in DB for this syllabus
// candidateDrafts: array of draft objects { title, ... } from your generator
// returns: { acceptedDrafts } (length <= target)
async function selectUniqueDrafts({ syllabusTitle, levelCode, existingTitles, candidateDrafts, target }) {
  // 1) collect and heuristic-prune title candidates
  const candidateTitles = heuristicPrune(candidateDrafts.map(d => d.title));

  // 2) LLM prune against existing & among themselves
  let { accepted, missing } = await llmSelectDistinct({
    syllabusTitle, levelCode,
    existingTitles,
    candidates: candidateTitles,
    need: target
  });

  // 3) If short, top-up loop (max 3 rounds)
  const MAX_TRIES = 3;
  let tries = 0;
  while (missing > 0 && tries < MAX_TRIES) {
    tries++;
    const topups = await llmTopUpNew({
      syllabusTitle, levelCode,
      existingTitles,
      alreadyAccepted: accepted,
      needMore: missing * 2 // ask extra to keep variety
    });
    // Combine + heuristic prune again
    const pool = heuristicPrune(accepted.concat(topups));
    // Re-run selection among pool (existing still excluded)
    const sel = await llmSelectDistinct({
      syllabusTitle, levelCode,
      existingTitles,
      candidates: pool,
      need: target
    });
    accepted = sel.accepted;
    missing = sel.missing;
  }

  // 4) Map accepted titles back to full drafts (take first matching)
  const byTitle = new Map(candidateDrafts.map(d => [norm(d.title), d]));
  const acceptedDrafts = [];
  const used = new Set();
  for (const item of accepted) {
    const k = norm(item.title);

    // prefer original draft if existed; else build a shell, your caller can fill body later
    if (byTitle.has(k) && !used.has(k)) {
      const base = byTitle.get(k);
      acceptedDrafts.push({ ...base, spoken_title: clamp(item.spoken_title || base.spoken_title || base.title) });
      used.add(k);
    } else {
      acceptedDrafts.push({
        title: item.title,
        spoken_title: clamp(item.spoken_title || item.title),
        description: '',
        tags: '',
        scenarios: []
      });
    }
  }

  return { acceptedDrafts };
}

module.exports = { generateDraftTopics, selectUniqueDrafts };

/*
'use strict';

// add helper near the top
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

// Simple slugifier for tags
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

// Choose N varied core templates (maximize coverage)
function pickCores(coreTemplates = [], n = 10) {
  const pool = [...new Set(coreTemplates.map(s => String(s).trim()).filter(Boolean))];
  // light shuffle then take n
  for (let i = pool.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [pool[i], pool[j]] = [pool[j], pool[i]];
  }
  return pool.slice(0, n);
}

// Choose K role templates and rotate through them
function rotateRoles(roleTemplates = [], kPerTopic = 5) {
  const clean = (roleTemplates || [])
    .map(r => ({ title: r.title, role: r.role, role_context: r.role_context }))
    .filter(r => r.title && r.role);
  return function forTopic(idx) {
    // pick kPerTopic consecutive roles (with wrap-around)
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
  // normalize some cores to friendly labels
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

    const category = slugify(syllabusTitle, 48);   // e.g. "self-introduction"
    const angle    = baseAngle(core);              // e.g. "roleplay"

    out.push({
    title,
    description,
    tags: [category, angle].filter(Boolean).join(', '),  
    scenarios,
    });

  }

  return out;
}

function generateTopicsFromTemplate({ levelCode, syllabusTitle, count = 10, scenariosPerTopic = 5, coreTemplates = [], roleTemplates = [], hintPack = {}, syllabusSlug }) {
  // 1) pick cores (variety-first)
  const cores = pickCores(coreTemplates, count);
  if (!cores.length) {
    // minimal fallback
    cores.push('Let\'s Talk', 'Roleplay in', 'Compare & Choose', 'Plan Together', 'A Small Problem in');
  }
  // 2) role picker
  const pickRoles = rotateRoles(roleTemplates, scenariosPerTopic);
  // 3) build drafts
  return topicsFrom(cores, pickRoles, { levelCode, syllabusTitle, hintPack, count, scenariosPerTopic, syllabusSlug });
}

module.exports = { generateTopicsFromTemplate };
*/
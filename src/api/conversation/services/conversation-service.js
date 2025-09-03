'use strict';

const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

/** ---------- Proficiency helpers (your 4 keys) ---------- */
const PROF_KEYS = ['BEGINNER','INTERMEDIATE','ADVANCED','PROFICIENT'];

function normalizeProficiency(input) {
  if (!input) return 'auto';
  const s = String(input).trim().toUpperCase();
  if (['A1','A2','B1','B2','C1','C2'].includes(s)) return s;        // allow CEFR input
  if (PROF_KEYS.includes(s)) return s;                               // your 4 keys
  if (s === 'AUTO') return 'auto';
  return 'auto';
}

/** Map your 4 keys (or CEFR) to the internal group used by prompts */
function groupFromProficiency(pref) {
  const p = normalizeProficiency(pref);
  if (PROF_KEYS.includes(p)) return p;               // already one of your 4
  if (['A1','A2'].includes(p)) return 'BEGINNER';
  if (['B1'].includes(p)) return 'INTERMEDIATE';
  if (['B2','C1'].includes(p)) return 'ADVANCED';
  if (['C2'].includes(p)) return 'PROFICIENT';
  return null; // auto
}

/** For filtering topics by your proficiency relation */
function allowedProficiencyKeys(pref) {
  const p = normalizeProficiency(pref);
  if (p === 'auto') return null;
  if (['A1','A2','B1','B2','C1','C2'].includes(p)) return null; // can't filter by CEFR unless topics store it
  if (PROF_KEYS.includes(p)) return [p];
  return null;
}

/** Optional: a coarse CEFR range to include in prompts if helpful */
function cefrRangeFromGroup(group) {
  switch (group) {
    case 'BEGINNER':     return { min: 'A1', max: 'A2' };
    case 'INTERMEDIATE': return { min: 'B1', max: 'B1' };
    case 'ADVANCED':     return { min: 'B2', max: 'C1' };
    case 'PROFICIENT':   return { min: 'C2', max: 'C2' };
    default:             return null;
  }
}

/** ---------- Prompt builders by level ---------- */
function buildBasePromptForGroup(group) {
  if (group === 'PROFICIENT') {
    return `
You are an English Conversation Partner for PROFICIENT users.
Be concise (≤80 words). Ask exactly ONE open question (why/how/what if/compare).
Encourage nuance, synthesis, and counter-arguments. No step-by-step scaffolding unless asked.
Recast only if meaning is unclear. End with exactly one question mark.
`.trim();
  }
  if (group === 'ADVANCED') {
    return `
You are an English Conversation Partner for ADVANCED users.
Keep replies concise (≤60 words). Ask exactly ONE probing question (why/how/what if).
Favor natural discourse and light challenge. Recast only if needed.
End with exactly one question mark.
`.trim();
  }
  if (group === 'INTERMEDIATE') {
    return `
You are an English Conversation Partner for INTERMEDIATE users.
Keep replies short (≤35 words). Ask exactly ONE question (reason/example/contrast).
If the learner struggles, offer a brief hint.
Recast brief errors once, then continue. End with exactly one question mark.
`.trim();
  }
  // BEGINNER default
  return `
You are an English Conversation Guide for BEGINNERS.
Keep replies VERY short (≤25 words). Ask exactly ONE question.
If user is brief/unsure: give ONE example they can copy OR TWO choices (not both).
If user errs, recast once; if easy, add a tiny stretch. End with one question mark.
`.trim();
}

function maxWordsForGroup(group) {
  if (group === 'PROFICIENT') return 80;
  if (group === 'ADVANCED') return 60;
  if (group === 'INTERMEDIATE') return 35;
  return 25; // beginner
}

/** ---------- Topic helpers ---------- */
function extractProficiencyKeyFromTopic(topic) {
  const t = topic?.attributes || topic;
  // Prefer new relation: proficiency_level.key
  const key = t?.proficiency_level?.data?.attributes?.key;
  if (key) return String(key).toUpperCase();
  // Fallback to older CEFR relation if you still have it
  const cefr = t?.difficulty_level?.data?.attributes?.code;
  if (cefr) {
    const C = cefr.toUpperCase();
    if (['A1','A2'].includes(C)) return 'BEGINNER';
    if (['B1'].includes(C)) return 'INTERMEDIATE';
    if (['B2','C1'].includes(C)) return 'ADVANCED';
    if (['C2'].includes(C)) return 'PROFICIENT';
  }
  return null;
}

function buildTopicHints(topic) {
  if (!topic) return '';
  const t = topic.attributes || topic;
  const pk = extractProficiencyKeyFromTopic(topic) || 'UNKNOWN';
  const title = t?.title || 'Unknown Topic';

  const tv = Array.isArray(t.target_vocab) ? t.target_vocab : [];
  const tp = Array.isArray(t.target_patterns) ? t.target_patterns : [];
  const tg = typeof t.target_grammar === 'string' ? t.target_grammar : '';

  let hints = `Topic: ${title} (${pk}) — use naturally, not as a script.`;
  if (tv.length) hints += `\nTarget vocabulary (hints): ${JSON.stringify(tv)}`;
  if (tp.length) hints += `\nTarget patterns (hints): ${JSON.stringify(tp)}`;
  if (tg) hints += `\nTarget grammar (hint): ${JSON.stringify(tg)}`;
  hints += `\nDo NOT list hints to the learner. Weave them naturally.`;
  return hints;
}

/** ---------- Safety / shaping ---------- */
function sanitizeModelReply(text, { maxWords = 30 } = {}) {
  if (!text || typeof text !== 'string') return text;

  // enforce single question
  const firstQ = text.indexOf('?');
  if (firstQ !== -1) {
    const secondQ = text.indexOf('?', firstQ + 1);
    if (secondQ !== -1) text = text.slice(0, firstQ + 1);
  }
  // soft word cap
  const words = text.trim().split(/\s+/);
  if (words.length > maxWords) {
    const endIdx = text.indexOf('.', 0);
    if (endIdx > -1) text = text.slice(0, endIdx + 1);
    else text = words.slice(0, maxWords).join(' ');
  }
  return text.trim();
}

/** ---------- Level inference ---------- */
async function estimateProficiencyFromHistory(history) {
  // Use last few user messages (short context)
  const lastUserTurns = history
    .filter(m => m.role === 'user')
    .slice(-4)
    .map(m => m.content)
    .join('\n---\n')
    .slice(0, 1200);

  const system = `
Rate the user's English using BOTH:
- "proficiency_key": one of ["beginner","intermediate","advanced","proficient"]
- "cefr_code": one of ["A1","A2","B1","B2","C1","C2"]
Return strict JSON: {"proficiency_key":"intermediate","cefr_code":"B1","confidence":0.78}
`.trim();

  try {
    const resp = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      messages: [
        { role: 'system', content: system },
        { role: 'user', content: lastUserTurns || 'No user text provided.' }
      ],
      temperature: 0.0,
      max_tokens: 120,
      response_format: { type: 'json_object' },
    });
    const parsed = JSON.parse(resp.choices?.[0]?.message?.content || '{}');
    const key = String(parsed.proficiency_key || 'beginner').toUpperCase();
    const cefr = String(parsed.cefr_code || 'A1').toUpperCase();
    const confidence = Number(parsed.confidence || 0);
    return { proficiency_key: key, cefr_code: cefr, confidence };
  } catch {
    return { proficiency_key: 'BEGINNER', cefr_code: 'A1', confidence: 0 };
  }
}

/** ---------- Kickoff: choose topic + first turn (no DB writes) ---------- */
async function kickoffFromTopicsList(topicLines, group) {
  const kickoffSystem = `
You are an English Conversation Guide.
You will receive a short list of topics (title + level + optional hints).
Pick ONE topic that fits the target level group: ${group}.
Then produce the FIRST teaching turn.

Output JSON only:
{"selected_topic":"<title>","first_turn":"<message to learner>"}

First turn rules:
- Keep within the ${group} constraints.
- Optionally one-line plan (≤8 words).
- For BEGINNER: include ONE short example OR TWO simple choices (not both).
- For INTERMEDIATE/ADVANCED/PROFICIENT: no choices unless the learner clearly needs help.
- Ask EXACTLY ONE question, end with "?".
- Keep it concise (respect level word limits).
`.trim();

  const msg = `Topics:\n${topicLines.join('\n')}`;
  let selected_topic = null;
  let first_turn = `Let's begin. What would you like to talk about?`;

  try {
    const resp = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      messages: [
        { role: 'system', content: kickoffSystem },
        { role: 'user', content: msg }
      ],
      temperature: 0.4,
      max_tokens: 160,
      response_format: { type: 'json_object' },
    });
    const parsed = JSON.parse(resp.choices?.[0]?.message?.content || '{}');
    if (parsed.selected_topic) selected_topic = String(parsed.selected_topic);
    if (parsed.first_turn) first_turn = String(parsed.first_turn);
  } catch { /* fallback */ }

  return { selected_topic, first_turn };
}

/** ---------- Public service (pure) ---------- */
module.exports = ({ strapi }) => ({

  /**
   * Kickoff: fetch topics, let model choose one appropriate to level, return first turn.
   * NO persistence here.
   * @param {Object} opts
   * @param {number} [opts.sampleSize=4]
   * @param {string} [opts.proficiency='auto'] - 'A1'..'C2' | 'beginner'|'intermediate'|'advanced'|'proficient' | 'auto'
   * @param {boolean} [opts.includeHints=false]
   */
  async kickoffFromStrapiTopics(opts = {}) {
    const { sampleSize = 4, proficiency = 'auto', includeHints = false } = opts;

    // Filter by your proficiency relation if caller provided a key
    const filters = { is_active: true };
    const keys = allowedProficiencyKeys(proficiency);
    if (keys && keys.length) {
      filters.proficiency_level = { key: { $in: keys.map(k => k.toLowerCase()) } };
    }

    const topics = await strapi.entityService.findMany('api::topic.topic', {
      filters,
      populate: {
        proficiency_level: { fields: ['key'] },
        difficulty_level: { fields: ['code'] }, // harmless if absent
      },
      fields: ['title', 'tags', 'description', 'target_vocab', 'target_patterns', 'target_grammar'],
      limit: 30,
    });

    if (!topics?.length) {
      return {
        selected_topic: null,
        first_turn: "Hello! I'm ready to chat. What's on your mind today?",
        inferred_level: null,
      };
    }

    // Sample a small list (already filtered by key if requested)
    const pool = topics.sort(() => 0.5 - Math.random()).slice(0, sampleSize);

    // Build topic lines for the kickoff message
    const topicLines = pool.map((t, i) => {
      const key = extractProficiencyKeyFromTopic(t) || 'UNKNOWN';
      let line = `${i + 1}) ${t.title} (${key})`;
      if (includeHints) {
        const tv = Array.isArray(t.target_vocab) ? t.target_vocab : [];
        const tp = Array.isArray(t.target_patterns) ? t.target_patterns : [];
        if (tv.length) line += ` | vocab: ${tv.slice(0, 6).join(', ')}`;
        if (tp.length) line += ` | patterns: ${tp.slice(0, 3).map(s => `"${s}"`).join(', ')}`;
      }
      return line;
    });

    // Decide target group for kickoff
    let group = groupFromProficiency(proficiency) || 'BEGINNER';

    const { selected_topic, first_turn } = await kickoffFromTopicsList(topicLines, group);

    return {
      selected_topic,
      first_turn: sanitizeModelReply(first_turn, { maxWords: maxWordsForGroup(group) }),
      inferred_level: group,
    };
  },

  /**
   * Continue the conversation with adaptive level. NO persistence here.
   * If proficiency === 'auto', infer proficiency_key & CEFR from recent user turns.
   *
   * @param {Object} args
   * @param {Array<{role:string, content:string}>} args.history
   * @param {string} [args.topicTitle]
   * @param {string} [args.proficiency='auto']
   * @returns {Promise<{reply:string, inferred_proficiency_key:string|null, inferred_cefr_code:string|null, inferred_group:string}>}
   */
  async generateNextPrompt({ history, topicTitle, proficiency = 'auto' }) {
    if (!history || !Array.isArray(history) || history.length === 0) {
      throw new Error('generateNextPrompt requires non-empty history.');
    }

    // Load topic (for hints)
    let topic = null;
    if (topicTitle) {
      const found = await strapi.entityService.findMany('api::topic.topic', {
        filters: { title: topicTitle },
        populate: {
          proficiency_level: { fields: ['key'] },
          difficulty_level: { fields: ['code'] },
        },
        fields: ['title', 'target_vocab', 'target_patterns', 'target_grammar'],
        limit: 1,
      });
      if (found?.length) topic = found[0];
    }

    // Decide level/group
    let group = groupFromProficiency(proficiency);
    let inferred_proficiency_key = null;
    let inferred_cefr_code = null;

    if (!group || proficiency === 'auto') {
      const est = await estimateProficiencyFromHistory(history);
      inferred_proficiency_key = est.proficiency_key || null;
      inferred_cefr_code = est.cefr_code || null;

      // pick group from inferred key first, then CEFR, fall back to topic key, else BEGINNER
      group =
        groupFromProficiency(inferred_proficiency_key) ||
        groupFromProficiency(inferred_cefr_code) ||
        (topic ? groupFromProficiency(extractProficiencyKeyFromTopic(topic)) : null) ||
        'BEGINNER';
    }

    // Build system prompt
    let systemMsg = buildBasePromptForGroup(group);
    const hints = buildTopicHints(topic);
    if (hints) systemMsg += `\n\n${hints}`;

    const range = cefrRangeFromGroup(group);
    if (range) systemMsg += `\n\n(Internal hint: Target CEFR ~ ${range.min}–${range.max}.)`;

    const messages = [{ role: 'system', content: systemMsg }, ...history];

    try {
      const resp = await openai.chat.completions.create({
        model: 'gpt-4-turbo',
        messages,
        temperature: (group === 'ADVANCED' || group === 'PROFICIENT') ? 0.7 : 0.5,
        max_tokens: 120,
        frequency_penalty: 0.1,
      });
      const raw = resp.choices?.[0]?.message?.content || "Let's continue. What do you think?";
      const reply = sanitizeModelReply(raw, { maxWords: maxWordsForGroup(group) });
      return { reply, inferred_proficiency_key, inferred_cefr_code, inferred_group: group };
    } catch (err) {
      strapi.log.error('Error generating next prompt:', err);
      return { reply: "Sorry, I had a hiccup. Could you say that again?", inferred_proficiency_key, inferred_cefr_code, inferred_group: group };
    }
  },

  // Expose utilities for unit tests if desired
  sanitizeModelReply,
  buildTopicHints,
  estimateProficiencyFromHistory,
  buildBasePromptForGroup,
  normalizeProficiency,
  groupFromProficiency,
  allowedProficiencyKeys,
  cefrRangeFromGroup,
  extractProficiencyKeyFromTopic,
});

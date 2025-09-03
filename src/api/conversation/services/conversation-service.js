'use strict';

const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

async function assessSupportNeed(history, group) {
  // Look only at the latest user turn(s)
  const last2User = history.filter(m => m.role === 'user').slice(-2).map(m => m.content).join('\n---\n').slice(0, 500);

  const system = `
You are a monitor for an English conversation. Decide if the learner now needs brief instruction.
Consider level group: ${group}. Beginners may need help if answers are very short, off-topic, or show confusion.

Return strict JSON:
{"needs_instruction": true|false, "confidence": 0.0-1.0, "reason": "<short>"}
`.trim();

  try {
    const resp = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      messages: [
        { role: 'system', content: system },
        { role: 'user', content: last2User || 'No user text.' }
      ],
      temperature: 0.0,
      max_tokens: 100,
      response_format: { type: 'json_object' },
    });
    const parsed = JSON.parse(resp.choices?.[0]?.message?.content || '{}');
    return {
      needs_instruction: !!parsed.needs_instruction,
      confidence: Number(parsed.confidence || 0),
      reason: String(parsed.reason || '')
    };
  } catch {
    return { needs_instruction: false, confidence: 0, reason: 'fallback' };
  }
}


function lexicalRulesForGroup(group) {
  if (group === 'BEGINNER') {
    return `
LEXICAL RULES (BEGINNER, A1–A2):
- Use very simple words and short sentences (Present Simple).
- Prefer: say, ask, name, from, like, want, live, work, friend.
- Avoid these words/phrases: introduce, yourself, themselves, either, usually, prefer, perhaps.
- If you need "introduce yourself", say: "say your name".
- No adverbs ending with -ly unless very common (e.g., really/very).
- 1 question only, end with "?".
`.trim();
  }
  if (group === 'INTERMEDIATE') {
    return `
LEXICAL RULES (INTERMEDIATE, ~B1):
- Keep it clear and concrete; simple clauses are okay.
- Prefer common vocabulary; avoid rare/abstract words.
- 1 question only, end with "?".
`.trim();
  }
  // ADVANCED/PROFICIENT – light touch
  return `
LEXICAL RULES:
- Natural, concise wording. Avoid jargon unless the learner uses it.
- 1 question only, end with "?".
`.trim();
}


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

function analyzeUserSignals(history) {
  const lastUser = [...history].reverse().find(m => m.role === 'user')?.content || '';
  const wc = (lastUser.trim().match(/\S+/g) || []).length;
  const rich = wc >= 8 || /because|but|and|since|when|so|that/i.test(lastUser);
  return { lastUser, wc, rich };
}

function decideMode({ hint, group, signals }) {
  const h = String(hint || 'auto').toLowerCase();
  if (h === 'practice' || h === 'scenario') return h;
  // auto:
  if (group === 'BEGINNER') return signals.rich ? 'scenario' : 'practice';
  if (group === 'INTERMEDIATE') return 'scenario';
  return 'scenario'; // ADVANCED/PROFICIENT
}

function modeInstructions(mode, roleName, roleCtx, maxWords) {
  if (mode === 'scenario') {
    return `
MODE: SCENARIO (role-play)
- Speak in character as ${roleName || 'a friendly person'}${roleCtx ? ` (${roleCtx})` : ''}.
- Be natural, concise (≤${maxWords} words).
- Ask EXACTLY ONE follow-up question, end with "?". No lists.
- Light recast only if meaning is unclear.
`.trim();
  }
  // practice default
  return `
MODE: PRACTICE (coach)
- Be very clear and concise (≤${maxWords} words).
- If the learner's last message was short, include ONE example they can copy OR TWO simple choices (not both).
- Give tiny positive feedback; recast obvious errors briefly.
- Ask EXACTLY ONE practice question, end with "?".
`.trim();
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

// caller → CEFR filter for topics
function allowedCEFRFromProficiency(pref) {
  const p = String(pref || 'auto').toUpperCase();
  if (['A1','A2','B1','B2','C1','C2'].includes(p)) return [p]; // direct CEFR request
  if (p === 'BEGINNER')     return ['A1','A2'];
  if (p === 'INTERMEDIATE') return ['B1'];
  if (p === 'ADVANCED')     return ['B2','C1'];
  if (p === 'PROFICIENT')   return ['C2'];
  return null; // auto
}

// get CEFR from a topic entity
function extractCEFRCodeFromTopic(topic) {
  const t = topic?.attributes || topic;
  const code = t?.difficulty_level?.data?.attributes?.code;
  return code ? String(code).toUpperCase() : null;
}


function buildTopicHints(topic) {
  if (!topic) return '';
  const t = topic.attributes || topic;
  const cefr = extractCEFRCodeFromTopic(topic) || 'UNKNOWN';
  const title = t?.title || 'Unknown Topic';

  const tv = Array.isArray(t.target_vocab) ? t.target_vocab : [];
  const tp = Array.isArray(t.target_patterns) ? t.target_patterns : [];
  const tg = typeof t.target_grammar === 'string' ? t.target_grammar : '';

  let hints = `Topic: ${title} (CEFR ${cefr}) — use naturally, not as a script.`;
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

  You will receive a short list of topics with optional hints like "mode:practice|scenario", "role", and "ctx".
  - If a topic has "mode:scenario", role-play as the specified role/context.
  - If "mode:practice", act as a coach.
  - If no mode is specified, default to PRACTICE for BEGINNER; SCENARIO for others.

  Output strict JSON:
  {"selected_topic":"<title>","first_turn":"<message to learner>"}

  FIRST TURN RULES:
  - Respect the ${group} level constraints (keep it short).
  - BEGINNER (practice):
    • Start with: "Let's practice <topic>."
    • If you give ONE example, write: "You can say: Hello, how are you?"  (NO quotation marks.)
    • If you give TWO choices, write: "You can say: Hello! or Hi!"  (exactly two choices, NO “either”.)
  - BEGINNER (scenario) or higher:
    • Start in character if role is given (e.g., "Hi! I'm Alex, your new classmate.").
  - In all cases:
    • Ask EXACTLY ONE question and end with "?".
    • Do NOT show lists, bullets, or the internal hints.
    • Do NOT wrap example phrases in quotation marks.
    • Avoid the word "either" unless there are exactly two choices separated by "or".
    • No unfinished sentences; keep punctuation clean.
  ${lexicalRulesForGroup(group)}
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
        temperature: 0.35,
        max_tokens: 200,
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

    const filters = { is_active: true };
    const allowedCEFR = allowedCEFRFromProficiency(proficiency);
    if (allowedCEFR && allowedCEFR.length) {
      filters.difficulty_level = { code: { $in: allowedCEFR } };
    }

    const topics = await strapi.entityService.findMany('api::topic.topic', {
      filters,
      populate: {
        difficulty_level: { fields: ['code'] },
      },
      fields: ['title','tags','description','target_vocab','target_patterns','mode_hint','role_name','role_context'],
      limit: 30,
    });

    if (!topics?.length) {
      return {
        selected_topic: null,
        first_turn: "Hello! I'm ready to chat. What's on your mind today?",
        inferred_level: null,
      };
    }

    const pool = topics.sort(() => 0.5 - Math.random()).slice(0, sampleSize);

    const topicLines = pool.map((t, i) => {
      const cefr = extractCEFRCodeFromTopic(t) || 'A?';
      let line = `${i + 1}) ${t.title} (${cefr})`;
      if (t.mode_hint) line += ` | mode:${t.mode_hint}`;
      if (t.role_name) line += ` | role:${t.role_name}`;
      if (t.role_context) line += ` | ctx:${String(t.role_context).slice(0, 60)}`;
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
   * @param {'practice'|'scenario'|'auto'=} [args.mode]
   * @returns {Promise<NextTurn>}   */
    // ✅ method inside the exported object
 async generateNextPrompt({ history, topicTitle, proficiency = 'auto', mode: modeOverride = null }) {
      if (!history || !Array.isArray(history) || history.length === 0) {
        throw new Error('generateNextPrompt requires non-empty history.');
      }

      // 1) Load topic (for hints)
      let topic = null;
      if (topicTitle) {
        const found = await strapi.entityService.findMany('api::topic.topic', {
          filters: { title: topicTitle },
          populate: { difficulty_level: { fields: ['code'] } },
          fields: ['title', 'target_vocab', 'target_patterns', 'mode_hint', 'role_name', 'role_context'],
          limit: 1,
        });
        if (found?.length) topic = found[0];
      }

      // 2) Decide level/group
      let group = groupFromProficiency(proficiency);
      let inferred_proficiency_key = null;
      let inferred_cefr_code = null;

      if (!group || proficiency === 'auto') {
        const est = await estimateProficiencyFromHistory(history);
        inferred_proficiency_key = est.proficiency_key || null;
        inferred_cefr_code = est.cefr_code || null;
        group =
          groupFromProficiency(inferred_proficiency_key) ||
          groupFromProficiency(inferred_cefr_code) ||
          (topic ? groupFromProficiency(extractCEFRCodeFromTopic(topic)) : null) ||
          'BEGINNER';
      }

      // 3) MODE decision
      // Signals + topic attrs
      const signals  = analyzeUserSignals(history);
      const t        = topic?.attributes || topic || {};
      const hint     = t.mode_hint || 'auto';
      const roleName = t.role_name || null;
      const roleCtx  = t.role_context || null;

      // 1) Start from override > topic hint > auto
      let mode = (modeOverride && ['practice','scenario','auto'].includes(String(modeOverride).toLowerCase()))
        ? String(modeOverride).toLowerCase()
        : decideMode({ hint, group, signals });

      // 2) Assess if we should coach this turn
      const support = await assessSupportNeed(history, group);
      if (support.needs_instruction) mode = 'practice';

      // 4) Build system prompt (+ mode instructions)
      let systemMsg = buildBasePromptForGroup(group);

      const hints = buildTopicHints(topic);
      if (hints) systemMsg += `\n\n${hints}`;

      const range = cefrRangeFromGroup(group);
      if (range) systemMsg += `\n\n(Internal hint: Target CEFR ~ ${range.min}–${range.max}.)`;

      // Lexical rules (keeps BEGINNER vocabulary simple)
      systemMsg += `\n\n${lexicalRulesForGroup(group)}`;

      // Mode-specific guidance (role-play vs coach)
      systemMsg += `\n\n${modeInstructions(mode, roleName, roleCtx, maxWordsForGroup(group))}`;

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
        return { reply, inferred_proficiency_key, inferred_cefr_code, inferred_group: group, decided_mode: mode };
      } catch (err) {
        strapi.log.error('Error generating next prompt:', err);
        return { reply: "Sorry, I had a hiccup. Could you say that again?", inferred_proficiency_key, inferred_cefr_code, inferred_group: group, decided_mode: mode || null };
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

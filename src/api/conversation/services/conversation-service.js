'use strict';

const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
const { v4: uuidv4 } = require('uuid'); // <-- add this

/* =======================
   Utilities: level & mode
   ======================= */

const PROF_KEYS = ['BEGINNER','INTERMEDIATE','ADVANCED','PROFICIENT'];
// ---- Config knobs (ENV) ----
const COMPACT_EVERY = parseInt(process.env.CONVO_COMPACT_EVERY || '8', 10);
const START_LAST_TURNS = parseInt(process.env.CONVO_START_LAST_TURNS || '6', 10);
const TAIL_TURNS = 8;
// Hard-coded recent window (days) per product decision
const RECENT_WINDOW_DAYS = 2;
// Hard-coded number of “new topic” suggestions we whisper to the LLM
const SUGGESTION_COUNT = 3;

function daysBetween(a, b) {
  const ms = Math.abs((a?.getTime?.() || 0) - (b?.getTime?.() || 0));
  return ms / (1000 * 60 * 60 * 24);
}

function isRecent(dateIso, withinDays) {
  if (!dateIso) return false;
  return daysBetween(new Date(), new Date(dateIso)) <= withinDays;
}

function timeAgo(dateIso) {
  if (!dateIso) return '';
  const d = new Date(dateIso);
  const days = Math.floor(daysBetween(new Date(), d));
  if (days <= 0) return 'today';
  if (days === 1) return 'yesterday';
  return `${days} days ago`;
}

// Store a lightweight “seed” so the next turn can decide resume/new/free-talk
function seedSummary({ recent, suggestions }) {
  return {
    kind: 'start_seed_v1',
    recent: recent || null,         // { topic_id, topic_title, last_active_iso, recap }
    suggestions: suggestions || [], // [{ topic_id, title, cefr }]
  };
}

// Read proficiency from user profile (adjust UID/fields to your setup if needed)
async function getUserProfileProficiency({ strapi, userId }) {
  if (!userId) return null;

  // TODO: adjust UID/fields to your real profile content type
  try {
    const profiles = await strapi.entityService.findMany('api::user-profile.user-profile', {
      filters: { user: userId },
      fields: ['proficiency', 'level_group', 'cefr_code'],
      limit: 1,
    });
    const p = profiles?.[0];
    if (!p) return null;

    const cefr = (p.cefr_code || '').toUpperCase();
    const group = (p.level_group || p.proficiency || '').toUpperCase();

    if (['A1','A2','B1','B2','C1','C2'].includes(cefr)) return cefr;
    if (['BEGINNER','INTERMEDIATE','ADVANCED','PROFICIENT'].includes(group)) return group;
    return null;
  } catch {
    return null;
  }
}

// Decision policy to prioritize FREE-TALK > resume > new > clarify
function decisionPolicyBlock() {
  return `
DECISION POLICY (invisible; follow strictly):
1) FREE-TALK has highest priority:
   - If the user's latest message already contains substance (story, opinion, plan, problem, or a concrete question), respond to THAT and develop it.
   - Do NOT switch to a preset topic in this case.
2) If the user clearly wants to RESUME last topic, continue it naturally (do not announce the choice).
3) If the user clearly wants something NEW and hasn't already started free-talk, gently propose or pick a fitting topic and begin.
4) If unclear, ask ONE short clarifying question.
Always produce ONE question total and keep level-appropriate brevity.
`.trim();
}

// Fetch 2–3 CEFR-matched titles to whisper for “new topic” (no binding)
async function fetchSuggestionTopics({ proficiency = 'auto', strapi }) {
  const filters = { is_active: true };
  const allowedCEFR = allowedCEFRFromProficiency(proficiency);
  if (allowedCEFR && allowedCEFR.length) {
    filters.difficulty_level = { code: { $in: allowedCEFR } };
  }

  const topics = await strapi.entityService.findMany('api::topic.topic', {
    filters,
    populate: { difficulty_level: { fields: ['code'] } },
    fields: ['title'],
    sort: [{ quality_score: 'desc' }, { id: 'desc' }],
    limit: 20,
  });

  const pool = (topics || []).sort(() => 0.5 - Math.random()).slice(0, SUGGESTION_COUNT);
  return pool.map(t => ({
    topic_id: t.id,
    title: t.title,
    cefr: (t?.difficulty_level?.data?.attributes?.code || '').toUpperCase()
  }));
}


// Small helper to slice conversation turns safely (assistant+user)
function lastNTurns(history = [], n = 6) {
  const start = Math.max(0, history.length - n);
  return history.slice(start);
}

// Summarize a slice of history (pure, OpenAI)
async function summarizeChunk({ historySlice, startIndex = 0, endIndex = 0, topicTitle = null }) {
  const sys = `
You summarize an English learning chat for reuse later. Produce strict JSON:
{
  "recap": "<2-3 precise sentences focused on what was practiced/decided>",
  "vocab": ["hello","..."],          // key words/phrases practiced
  "patterns": ["My name is ..."],    // sentence frames used
  "facts": { "user_name": "Lily" }   // durable user facts only if explicit
}
Do not invent facts. Keep it concise, useful for next sessions.
`.trim();

  const text = historySlice
    .map((m, i) => `${startIndex + i}. [${m.role}] ${m.content}`)
    .join('\n')
    .slice(0, 4000);

  const user = (topicTitle ? `Topic: ${topicTitle}\n` : '') + `Turns ${startIndex}–${endIndex}:\n${text}`;

  try {
    const r = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      messages: [
        { role: 'system', content: sys },
        { role: 'user', content: user }
      ],
      temperature: 0.2,
      max_tokens: 240,
      response_format: { type: 'json_object' },
    });
    return JSON.parse(r.choices?.[0]?.message?.content || '{}');
  } catch {
    return { recap: '', vocab: [], patterns: [], facts: {} };
  }
}

function uniq(arr) { return Array.from(new Set((arr || []).filter(Boolean))); }

// Merge a small delta summary into the running summary
function mergeSummary(existing, delta, lastCoveredTurn) {
  const base = existing || { synopsis: '', vocab: [], patterns: [], facts: {}, last_covered_turn: 0 };

  return {
    synopsis: [base.synopsis, delta.recap].filter(Boolean).join(' ').trim().slice(0, 2000), // keep tidy
    vocab:    uniq([...(base.vocab || []), ...(delta.vocab || [])]).slice(0, 200),
    patterns: uniq([...(base.patterns || []), ...(delta.patterns || [])]).slice(0, 120),
    facts:    { ...(base.facts || {}), ...(delta.facts || {}) },
    last_covered_turn: lastCoveredTurn,
  };
}


function normalizeProficiency(input) {
  if (!input) return 'auto';
  const s = String(input).trim().toUpperCase();
  if (['A1','A2','B1','B2','C1','C2'].includes(s)) return s; // CEFR
  if (PROF_KEYS.includes(s)) return s;                        // 4-key
  if (s === 'AUTO') return 'auto';
  return 'auto';
}

function groupFromProficiency(pref) {
  const p = normalizeProficiency(pref);
  if (PROF_KEYS.includes(p)) return p;
  if (['A1','A2'].includes(p)) return 'BEGINNER';
  if (['B1'].includes(p))     return 'INTERMEDIATE';
  if (['B2','C1'].includes(p))return 'ADVANCED';
  if (['C2'].includes(p))     return 'PROFICIENT';
  return null; // auto
}

function allowedCEFRFromProficiency(pref) {
  const p = String(pref || 'auto').toUpperCase();
  if (['A1','A2','B1','B2','C1','C2'].includes(p)) return [p];
  if (p === 'BEGINNER')     return ['A1','A2'];
  if (p === 'INTERMEDIATE') return ['B1'];
  if (p === 'ADVANCED')     return ['B2','C1'];
  if (p === 'PROFICIENT')   return ['C2'];
  return null;
}

function cefrRangeFromGroup(group) {
  switch (group) {
    case 'BEGINNER':     return { min: 'A1', max: 'A2' };
    case 'INTERMEDIATE': return { min: 'B1', max: 'B1' };
    case 'ADVANCED':     return { min: 'B2', max: 'C1' };
    case 'PROFICIENT':   return { min: 'C2', max: 'C2' };
    default:             return null;
  }
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
  if (group === 'BEGINNER') return signals.rich ? 'scenario' : 'practice';
  if (group === 'INTERMEDIATE') return 'scenario';
  return 'scenario';
}

/* =======================
   Prompt framing
   ======================= */

function buildBasePromptForGroup(group) {
  if (group === 'PROFICIENT') {
    return `You are an English Conversation Partner for PROFICIENT users.
Be concise (≤80 words). Ask exactly ONE open question (why/how/what if/compare).
Encourage nuance; no step-by-step scaffolding unless asked.
Recast only if meaning is unclear. End with exactly one question mark.`.trim();
  }
  if (group === 'ADVANCED') {
    return `You are an English Conversation Partner for ADVANCED users.
Keep replies concise (≤60 words). Ask exactly ONE probing question (why/how/what if).
Favor natural discourse and light challenge. Recast only if needed.
End with exactly one question mark.`.trim();
  }
  if (group === 'INTERMEDIATE') {
    return `You are an English Conversation Partner for INTERMEDIATE users.
Keep replies short (≤35 words). Ask exactly ONE question (reason/example/contrast).
If the learner struggles, offer a brief hint.
Recast brief errors once, then continue. End with exactly one question mark.`.trim();
  }
  return `You are an English Conversation Guide for BEGINNERS.
Keep replies VERY short (≤25 words). Ask exactly ONE question.
If user is brief/unsure: give ONE example they can copy OR TWO choices (not both).
If user errs, recast once; if easy, add a tiny stretch. End with one question mark.`.trim();
}

function maxWordsForGroup(group) {
  if (group === 'PROFICIENT') return 80;
  if (group === 'ADVANCED')   return 60;
  if (group === 'INTERMEDIATE') return 35;
  return 25;
}

function lexicalRulesForGroup(group) {
  if (group === 'BEGINNER') {
    return `LEXICAL RULES (BEGINNER, A1–A2):
- Use very simple words and short sentences (Present Simple).
- Prefer: say, ask, name, from, like, want, live, work, friend.
- Avoid: introduce, yourself, themselves, either, usually, prefer, perhaps.
- If you need "introduce yourself", say: "say your name".
- No rare adverbs; keep it basic.
- ONE question only, end with "?".`.trim();
  }
  if (group === 'INTERMEDIATE') {
    return `LEXICAL RULES (INTERMEDIATE, ~B1):
- Keep it clear and concrete; simple clauses are okay.
- Prefer common vocabulary; avoid rare/abstract words.
- ONE question only, end with "?".`.trim();
  }
  return `LEXICAL RULES:
- Natural, concise wording. Avoid jargon unless the learner uses it.
- ONE question only, end with "?".`.trim();
}

function modeInstructions(mode, roleName, roleCtx, maxWords) {
  if (mode === 'scenario') {
    return `MODE: SCENARIO (role-play)
- Speak in character as ${roleName || 'a friendly person'}${roleCtx ? ` (${roleCtx})` : ''}.
- Be natural, concise (≤${maxWords} words).
- Ask EXACTLY ONE follow-up question, end with "?". No lists.
- Light recast only if meaning is unclear.`.trim();
  }
  return `MODE: PRACTICE (coach)
- Be very clear and concise (≤${maxWords} words).
- If the learner's last message was short, include ONE example they can copy OR TWO simple choices (not both).
- Tiny positive feedback; brief recast of obvious errors.
- Ask EXACTLY ONE practice question, end with "?".`.trim();
}

function sanitizeModelReply(text, { maxWords = 30 } = {}) {
  if (!text || typeof text !== 'string') return text;
  const firstQ = text.indexOf('?');
  if (firstQ !== -1) {
    const secondQ = text.indexOf('?', firstQ + 1);
    if (secondQ !== -1) text = text.slice(0, firstQ + 1);
  }
  const words = text.trim().split(/\s+/);
  if (words.length > maxWords) {
    const endIdx = text.indexOf('.', 0);
    if (endIdx > -1) text = text.slice(0, endIdx + 1);
    else text = words.slice(0, maxWords).join(' ');
  }
  return text.trim();
}

/* =======================
   Topic helpers
   ======================= */

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

  // Light, non-prescriptive hint
  return `Topic: ${title} (CEFR ${cefr}). Use this naturally; do not list hints.`;
}


/* =======================
   Level inference
   ======================= */

async function estimateProficiencyFromHistory(history) {
  const lastUserTurns = history
    .filter(m => m.role === 'user')
    .slice(-4)
    .map(m => m.content)
    .join('\n---\n')
    .slice(0, 1200);

  const system = `Rate the user's English using BOTH:
- "proficiency_key": one of ["beginner","intermediate","advanced","proficient"]
- "cefr_code": one of ["A1","A2","B1","B2","C1","C2"]
Return strict JSON: {"proficiency_key":"intermediate","cefr_code":"B1","confidence":0.78}`.trim();

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

/* =======================
   Support assessment
   ======================= */

async function assessSupportNeed(history, group) {
  const last2User = history
    .filter(m => m.role === 'user')
    .slice(-2)
    .map(m => m.content)
    .join('\n---\n')
    .slice(0, 500);

  const system = `You are a monitor for an English conversation. Decide if the learner now needs brief instruction.
Consider level group: ${group}. Beginners may need help if answers are very short, off-topic, or show confusion.

Return strict JSON:
{"needs_instruction": true|false, "confidence": 0.0-1.0, "reason": "<short>"}`.trim();

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

/* =======================
   Kickoff (ID-based)
   ======================= */

async function kickoffFromTopicsList(topicLines, group) {
  const kickoffSystem = `
You are an English Conversation Guide.

You will receive a short list of topics formatted like: "[id:123] Title (CEFR) | ...".
Pick ONE topic that best fits. Return JSON ONLY:
{"selected_topic_id": 123, "selected_topic_title": "<exact title>", "first_turn": "<message to learner>"}

FIRST TURN RULES:
- Respect ${group} constraints (keep it short).
- BEGINNER (practice):
  • Start with: "Let's practice <topic>."
  • If ONE example, write: You can say: Hello, how are you?
  • If TWO choices, write: You can say: Hello! or Hi!
- BEGINNER (scenario) or higher: start in character if a role is provided.
- EXACTLY ONE question, end with "?".
- Do NOT show lists, bullets, or internal hints. No quotes around example phrases.
`.trim();

  const msg = `Topics:\n${topicLines.join('\n')}`;

  let selected_topic_id = null;
  let selected_topic_title = null;
  let first_turn = `Let's begin. What would you like to talk about?`;

  try {
    const resp = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      messages: [
        { role: 'system', content: kickoffSystem },
        { role: 'user', content: msg }
      ],
      temperature: 0.35,
      max_tokens: 220,
      response_format: { type: 'json_object' },
    });
    const parsed = JSON.parse(resp.choices?.[0]?.message?.content || '{}');
    if (parsed.selected_topic_id != null) selected_topic_id = Number(parsed.selected_topic_id);
    if (parsed.selected_topic_title) selected_topic_title = String(parsed.selected_topic_title);
    if (parsed.first_turn) first_turn = String(parsed.first_turn);
  } catch { /* fallback */ }

  return { selected_topic_id, selected_topic_title, first_turn };
}
  /**
   * Compaction hook. If nothing to do, returns unchanged summary & compacted_upto.
   * Otherwise, summarizes the older segment and updates the summary JSON.
   */
  // Decide whether to compact; if yes, summarize the new slice and merge
  async function maybeCompact({ history, existingSummary, compactedUpto, turnsTotal, topicId, strapi }) {
    const deltaCount = turnsTotal - (compactedUpto || 0);
    if (deltaCount < COMPACT_EVERY) {
      return { newSummary: existingSummary || null, newCompactedUpto: compactedUpto || 0 };
    }

    // slice new turns since last compaction
    const start = compactedUpto || 0;
    const end   = turnsTotal;
    const historySlice = history.slice(start, end);

    // fetch topic title if we have a relation id
    let topicTitle = null;
    if (topicId) {
      const topic = await strapi.entityService.findOne('api::topic.topic', topicId, { fields: ['title'] });
      topicTitle = topic?.title || null;
    }

    const delta = await summarizeChunk({ historySlice, startIndex: start, endIndex: end, topicTitle });
    const merged = mergeSummary(existingSummary, delta, end);
    return { newSummary: merged, newCompactedUpto: end };
  }

/* =======================
   Public service
   ======================= */

module.exports = ({ strapi }) => ({
  // Persist one turn + counters + optional compaction; returns updated counters
  async persistTurnAndMaybeCompact({ sessionId, topicId = null, history, decided_mode = null }) {
    const [conv] = await strapi.entityService.findMany('api::conversation.conversation', {
      filters: { sessionId },
      populate: { topic: true },
      fields: ['id','summary','compacted_upto','turns_total'],
      limit: 1,
    });
    if (!conv) throw new Error('Unknown sessionId');

    const turnsTotal = history.length;

    const { newSummary, newCompactedUpto } = await maybeCompact({
      history,
      existingSummary: conv.summary || null,
      compactedUpto: Number(conv.compacted_upto || 0),
      turnsTotal,
      topicId: topicId || conv.topic?.id || null,
      strapi,
    });

    const nowIso = new Date().toISOString();
    await strapi.entityService.update('api::conversation.conversation', conv.id, {
      data: {
        history,
        summary: newSummary,
        compacted_upto: newCompactedUpto,
        turns_total: turnsTotal,
        last_mode: decided_mode || null,
        last_active: nowIso,
        topic: topicId || conv.topic?.id || null,
      },
    });

    return { turns_total: turnsTotal, compacted_upto: newCompactedUpto };
  },


  async warmStartFromMemory({ mode, group, topicTitle, summary, lastTurns }) {
    const base = buildBasePromptForGroup(group);
    const lex  = lexicalRulesForGroup(group);

    const bg = `
    BACKGROUND (do not say this directly):
    - Topic: ${topicTitle || '(unknown)'}
    - Learned: ${(summary?.learned || []).slice(0,6).join(' | ') || '—'}
    - Open threads: ${(summary?.open_threads || []).slice(0,3).join(' | ') || '—'}
    - Recent turns:
    ${lastTurns.map(t => `${t.role.toUpperCase()}: ${t.content}`).join('\n')}
    `.trim();

    const system = [
      base,
      lex,
      bg,
      modeInstructions(
        mode === 'continue' ? 'scenario' : mode === 'practice' ? 'practice' : 'scenario',
        null, null, maxWordsForGroup(group)
      ),
      `Ask exactly one question and end with "?".`
    ].join('\n\n');

    const user = `Start the new turn now. Keep it natural and short.`;

    const resp = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      messages: [
        { role: 'system', content: system },
        { role: 'user', content: user }
      ],
      temperature: 0.4,
      max_tokens: 140,
    });

    return sanitizeModelReply(resp.choices?.[0]?.message?.content || 'Ready to continue—what would you like to say?', {
      maxWords: maxWordsForGroup(group)
    });
  },

  async startSession({ userId = null /* suggestCount removed; fixed to SUGGESTION_COUNT */ }) {
    // Prefer profile proficiency; fallback to mapper; fallback to BEGINNER
    const profPref = await getUserProfileProficiency({ strapi, userId });
    const group = groupFromProficiency(profPref) || 'BEGINNER';

    // Find most recent conversation
    let last = null;
    if (userId) {
      const recent = await strapi.entityService.findMany('api::conversation.conversation', {
        filters: { user: userId },
        sort: { last_active: 'desc' },
        populate: { topic: true },
        limit: 1,
      });
      last = recent?.[0] || null;
    }

    const hasRecent = !!(last && isRecent(last.last_active, RECENT_WINDOW_DAYS));
    const recentSeed = hasRecent ? {
      topic_id: last.topic?.id || null,
      topic_title: last.topic?.title || null,
      last_active_iso: last.last_active || null,
      recap: (last.summary && (last.summary.synopsis || last.summary.recap)) || null
    } : null;

    const suggestions = await fetchSuggestionTopics({
      proficiency: profPref || 'auto',
      strapi
    });

    // First turn: ask; do not decide/bind a topic
    let first_turn;
    if (hasRecent && recentSeed?.topic_title) {
      const when = timeAgo(recentSeed.last_active_iso);
      first_turn =
        `Hi there! Last time we talked about ${recentSeed.topic_title} ${when}. ` +
        `Would you like to continue that, start something new, or just tell me what's on your mind?`;
    } else {
      const s = suggestions?.[0]?.title;
      first_turn = s
        ? `Hi there! What do you want to talk about today? If you like, we could try “${s}”.`
        : `Hi there! What do you want to talk about today?`;
    }

    const sessionId = uuidv4();
    await strapi.entityService.create('api::conversation.conversation', {
      data: {
        sessionId,
        history: [{ role: 'assistant', content: first_turn }],
        topic: null, // not binding at start
        summary: seedSummary({ recent: recentSeed, suggestions }),
        compacted_upto: 0,
        turns_total: 1,
        last_mode: 'fresh',
        last_active: new Date(),
        user: userId || null,
      },
    });

    return {
      sessionId,
      selected_topic_id: null,
      selected_topic: null,
      next_prompt: first_turn,
      level_group: group,
    };
  },


  /** Kickoff: fetch topics, LLM picks one by level, return first turn (no persistence here) */
  async kickoffFromStrapiTopics(opts = {}) {
    const { sampleSize = 4, proficiency = 'auto', /* includeHints unused */ background = null } = opts;
    const filters = { is_active: true };
    const allowedCEFR = allowedCEFRFromProficiency(proficiency);
    if (allowedCEFR && allowedCEFR.length) {
      filters.difficulty_level = { code: { $in: allowedCEFR } };
    }

    const topics = await strapi.entityService.findMany('api::topic.topic', {
      filters,
      populate: { difficulty_level: { fields: ['code'] } },
      fields: ['title','mode_hint','role_name','role_context'],
      limit: 30,
    });

    if (!topics?.length) {
      return {
        selected_topic_id: null,
        selected_topic_title: null,
        first_turn: "Hello! I'm ready to chat. What's on your mind today?",
        inferred_level: null,
      };
    }

    const pool = topics.sort(() => 0.5 - Math.random()).slice(0, sampleSize);

    // include the ID so the LLM can return it
    const topicLines = pool.map((t, i) => {
      const cefr = extractCEFRCodeFromTopic(t) || 'A?';
      let line = `${i + 1}) [id:${t.id}] ${t.title} (${cefr})`;
      if (t.mode_hint) line += ` | mode:${t.mode_hint}`;
      if (t.role_name) line += ` | role:${t.role_name}`;
      if (t.role_context) line += ` | ctx:${String(t.role_context).slice(0, 60)}`;
      return line;
    });

    const group = groupFromProficiency(proficiency) || 'BEGINNER';

    const kickoffSystem = `
  You are an English Conversation Guide.

  You will receive a short list of topics formatted like: "[id:123] Title (CEFR) | ...".
  Pick ONE topic that best fits. Return JSON ONLY:
  {"selected_topic_id": 123, "selected_topic_title": "<exact title>", "first_turn": "<message to learner>"}

  FIRST TURN RULES:
  - Respect ${group} constraints (keep it short).
  - BEGINNER (practice):
    • Start with: "Let's practice <topic>."
    • If ONE example, write: You can say: Hello, how are you?
    • If TWO choices, write: You can say: Hello! or Hi!
  - BEGINNER (scenario) or higher: start in character if a role is provided.
  - EXACTLY ONE question, end with "?".
  - Do NOT show lists, bullets, or internal hints. No quotes around example phrases.
  `.trim();

    // Build messages with optional background summary as an extra system message
    const sysMsgs = [{ role: 'system', content: kickoffSystem }];

    if (background) {
      // normalize both v1 and legacy shapes
      let bg;
      if (background.kind === 'conv_summary_v1') {
        bg = {
          topic_title: background.topic_title || null,
          facts: background.facts || [],
          learned: background.learned || [],
          open_threads: background.open_threads || [],
        };
      } else {
        bg = {
          topic_title: null,
          synopsis: background.synopsis || '',
          vocab: background.vocab || [],
          patterns: background.patterns || [],
          facts: background.facts || {},
        };
      }
      sysMsgs.push({
        role: 'system',
        content:
          'BACKGROUND SUMMARY (use only for personalization; do NOT quote it):\n' +
          JSON.stringify(bg),
      });
    }

    const msg = `Topics:\n${topicLines.join('\n')}`;

    let selected_topic_id = null;
    let selected_topic_title = null;
    let first_turn = `Let's begin. What would you like to talk about?`;

    try {
      const resp = await openai.chat.completions.create({
        model: 'gpt-4-turbo',
        messages: [...sysMsgs, { role: 'user', content: msg }],
        temperature: 0.35,
        max_tokens: 220,
        response_format: { type: 'json_object' },
      });
      const parsed = JSON.parse(resp.choices?.[0]?.message?.content || '{}');
      if (parsed.selected_topic_id != null) selected_topic_id = Number(parsed.selected_topic_id);
      if (parsed.selected_topic_title) selected_topic_title = String(parsed.selected_topic_title);
      if (parsed.first_turn) first_turn = String(parsed.first_turn);
    } catch { /* fallback */ }

    return {
      selected_topic_id,
      selected_topic_title,
      first_turn: sanitizeModelReply(first_turn, { maxWords: maxWordsForGroup(group) }),
      inferred_level: group,
    };
  },


  /**
   * Continue the conversation with adaptive level.
   * Uses summary (if provided) for context; no DB writes here.
   *
   * args: { history, topicId?, proficiency?, mode?, summary? }
   */
  async generateNextPrompt({ history, topicId = null, proficiency = 'auto', mode: modeOverride = null, summary = null, userId = null }) {
    if (!Array.isArray(history) || history.length === 0) {
      throw new Error('generateNextPrompt requires non-empty history.');
    }

    // Load topic if already bound
    let topic = null;
    if (topicId) {
      topic = await strapi.entityService.findOne('api::topic.topic', topicId, {
        populate: { difficulty_level: { fields: ['code'] } },
        fields: ['title', 'mode_hint', 'role_name', 'role_context'],
      });
    }

    // Determine group: client override > profile > inference > topic CEFR > BEGINNER
    let group = null;
    let inferred_proficiency_key = null;
    let inferred_cefr_code = null;

    if (!proficiency || String(proficiency).toLowerCase() === 'auto') {
      const profPref = await getUserProfileProficiency({ strapi, userId });
      group = groupFromProficiency(profPref);
    } else {
      group = groupFromProficiency(proficiency);
    }

    if (!group) {
      const est = await this.estimateProficiencyFromHistory(history);
      inferred_proficiency_key = est.proficiency_key || null;
      inferred_cefr_code = est.cefr_code || null;
      group =
        groupFromProficiency(inferred_proficiency_key) ||
        groupFromProficiency(inferred_cefr_code) ||
        (topic ? groupFromProficiency(extractCEFRCodeFromTopic(topic)) : null) ||
        'BEGINNER';
    }

    // Mode decision (your existing logic)
    const signals  = analyzeUserSignals(history);
    const t        = topic?.attributes || topic || {};
    const hint     = t?.mode_hint || 'auto';
    const roleName = t?.role_name || null;
    const roleCtx  = t?.role_context || null;

    let mode = (modeOverride && ['practice','scenario','auto'].includes(String(modeOverride).toLowerCase()))
      ? String(modeOverride).toLowerCase()
      : decideMode({ hint, group, signals });

    const support = await assessSupportNeed(history, group);
    if (support.needs_instruction) mode = 'practice';

    // Build system prompt (add decision policy + seed)
    let systemMsg = buildBasePromptForGroup(group);
    const hints = buildTopicHints(topic);
    if (hints) systemMsg += `\n\n${hints}`;
    const range = cefrRangeFromGroup(group);
    if (range) systemMsg += `\n\n(Internal hint: Target CEFR ~ ${range.min}–${range.max}.)`;
    systemMsg += `\n\n${lexicalRulesForGroup(group)}`;
    systemMsg += `\n\n${modeInstructions(mode, roleName, roleCtx, maxWordsForGroup(group))}`;

    // NEW: priority policy
    systemMsg += `\n\n${decisionPolicyBlock()}`;

    // Pass start seed invisibly (recent + suggestions)
    if (summary && summary.kind === 'start_seed_v1') {
      const seed = {
        recent: summary.recent || null,
        suggestions: (summary.suggestions || []).slice(0, SUGGESTION_COUNT),
      };
      systemMsg += `\n\nBACKGROUND SEED (do not mention directly): ${JSON.stringify(seed)}`;
    } else if (summary) {
      // Back-compat for older summary shapes
      const bg = summary.kind === 'conv_summary_v1'
        ? {
            topic_title: summary.topic_title || null,
            facts: summary.facts || [],
            learned: summary.learned || [],
            open_threads: summary.open_threads || [],
          }
        : {
            synopsis: summary.synopsis || '',
            vocab: summary.vocab || [],
            patterns: summary.patterns || [],
            facts: summary.facts || {},
          };
      systemMsg += `\n\nBACKGROUND SUMMARY (continuity only): ${JSON.stringify(bg)}`;
    }

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

      // Optional: if we started fresh and reply clearly uses one of the suggestion titles, bind it.
      let maybe_new_topic_id = null;
      if (!topicId && summary && summary.kind === 'start_seed_v1' && Array.isArray(summary.suggestions)) {
        const hit = summary.suggestions.find(s => s.title && reply.toLowerCase().includes(s.title.toLowerCase()));
        if (hit?.topic_id) maybe_new_topic_id = hit.topic_id;
      }

      return {
        reply,
        inferred_proficiency_key,
        inferred_cefr_code,
        inferred_group: group,
        decided_mode: mode,
        maybe_new_topic_id
      };
    } catch (err) {
      strapi.log.error('Error generating next prompt:', err);
      return {
        reply: "Sorry, I had a hiccup. Could you say that again?",
        inferred_proficiency_key, inferred_cefr_code, inferred_group: group, decided_mode: mode || null,
        maybe_new_topic_id: null
      };
    }
  },

  /* Expose utils if you want to unit test */
  sanitizeModelReply,
  buildTopicHints,
  estimateProficiencyFromHistory,
  buildBasePromptForGroup,
  normalizeProficiency,
  groupFromProficiency,
  allowedCEFRFromProficiency,
  cefrRangeFromGroup,
  mergeSummary,
  summarizeChunk,
  //maybeCompact,                 // if you want direct access
  //persistTurnAndMaybeCompact,   // ← the new one used by controller

});

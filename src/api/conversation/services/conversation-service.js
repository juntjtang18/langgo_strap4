'use strict';

const OpenAI = require('openai');
const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
const { v4: uuidv4 } = require('uuid');

/* =========================
   Env knobs (safe defaults)
   ========================= */
const RECENT_WINDOW_DAYS = parseInt(process.env.RECENT_WINDOW_DAYS || '2', 10);
const SUGGESTION_COUNT   = parseInt(process.env.SUGGESTION_COUNT   || '3', 10);
const CONVO_TAIL_TURNS   = parseInt(process.env.CONVO_TAIL_TURNS   || '6', 10);

// Model routing
const CHAT_MODEL_PRIMARY  = process.env.OPENAI_CHAT_MODEL_PRIMARY  || 'gpt-4o-mini';
const CHAT_MODEL_FALLBACK = process.env.OPENAI_CHAT_MODEL_FALLBACK || 'gpt-4.1';
const ANALYZE_MODEL       = process.env.OPENAI_ANALYZE_MODEL       || 'gpt-4o-mini';

// Throttling heuristics for cheap meta-calls
const INFER_AT_TURNS   = parseInt(process.env.INFER_AT_TURNS   || '2', 10);   // infer at <=2nd turn
const INFER_EVERY_N    = parseInt(process.env.INFER_EVERY_N    || '20', 10);  // then each 20 turns
const SUPPORT_EVERY_N  = parseInt(process.env.SUPPORT_EVERY_N  || '3', 10);   // if short user msg AND every 3rd turn

const PROF_KEYS = ['BEGINNER','INTERMEDIATE','ADVANCED','PROFICIENT'];

/* ==============
   Small helpers
   ============== */
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
  return null;
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

function firstSentence(text) {
  if (!text) return '';
  const s = String(text).replace(/\s+/g, ' ').trim();
  const m = s.match(/(.+?[.?!])\s|(.+)$/);
  const sent = m ? (m[1] || m[2] || '') : s;
  return sent.trim();
}
function smartFirstSentence(text, minLen = 7, maxLen = 60) {
  let s = firstSentence(text)
    .replace(/https?:\/\/\S+/g, '')
    .replace(/\p{Emoji_Presentation}/gu, '')
    .trim();
  if (s.length < minLen) return '';
  if (s.length > maxLen) s = s.slice(0, maxLen - 1) + '…';
  return s;
}
function updateStateV2Deterministic({ prev, history, topicId, group, cefr, mode }) {
  const state = prev?.kind === 'conv_state_v2' ? { ...prev } : { kind: 'conv_state_v2' };

  state.topic_anchor_id = topicId || null;
  if (group) state.group_cached = group;
  if (cefr)  state.cefr_cached  = cefr;
  if (mode)  state.last_mode    = mode;

  const lastUser = [...history].reverse().find(m => m.role === 'user')?.content || '';
  const lus = smartFirstSentence(lastUser, 7, 120);
  if (lus) state.last_user_summary = lus;

  if (!topicId && !state.topic_title_hint) {
    const firstUser = history.find(m => m.role === 'user')?.content || '';
    const hint = smartFirstSentence(firstUser, 7, 60);
    if (hint) state.topic_title_hint = hint;
  }

  const lastAssistantQIdx = [...history].map((m,i)=>({m,i}))
    .reverse().find(({m}) => m.role==='assistant' && /\?$/.test(m.content))?.i;
  if (lastAssistantQIdx != null) {
    const after = history.slice(lastAssistantQIdx + 1);
    const nextUser = after.find(m => m.role==='user')?.content || '';
    const answered = (nextUser.trim().split(/\s+/).length >= 5);
    state.open_threads = answered ? [] : [firstSentence(history[lastAssistantQIdx].content)];
  }

  return state;
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

/* ===================
   Model routing/calls
   =================== */
function chooseChatModel({ kind, group }) {
  if (kind === 'analyze')   return ANALYZE_MODEL;
  if (kind === 'generate' || kind === 'kickoff' || kind === 'warmstart') {
    if (group === 'ADVANCED' || group === 'PROFICIENT') return CHAT_MODEL_FALLBACK;
    return CHAT_MODEL_PRIMARY;
  }
  return CHAT_MODEL_PRIMARY;
}
async function callChatWithResilience(opts) {
  const { model, messages, temperature=0.5, max_tokens=120, frequency_penalty=0.0, response_format } = opts;
  try {
    return await openai.chat.completions.create({ model, messages, temperature, max_tokens, frequency_penalty, response_format });
  } catch (e) {
    const status = e?.status || e?.response?.status;
    const code   = e?.response?.data?.code || e?.code || '';
    if ([429,500,502,503,504].includes(status) || /insufficient_quota|rate_limit/i.test(code)) {
      const fallback = (model === CHAT_MODEL_PRIMARY) ? CHAT_MODEL_FALLBACK : CHAT_MODEL_PRIMARY;
      await new Promise(r => setTimeout(r, 300));
      return await openai.chat.completions.create({ model: fallback, messages, temperature, max_tokens, frequency_penalty, response_format });
    }
    throw e;
  }
}

/* ======================
   Topic utils (Strapi)
   ====================== */
async function fetchSuggestionTopics({ proficiency = 'auto', strapi }) {
  const filters = { is_active: true };
  const allowed = allowedCEFRFromProficiency(proficiency);
  if (allowed && allowed.length) filters.difficulty_level = { code: { $in: allowed } };

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
  return `Topic: ${title} (CEFR ${cefr}). Use this naturally; do not list hints.`;
}
function seedSummary({ recent, suggestions }) {
  return { kind: 'start_seed_v1', recent: recent || null, suggestions: suggestions || [] };
}

/* ============================
   Cheap meta: joint analyzer
   ============================ */
async function analyzeMeta(history) {
  // Last 4 user turns, compact
  const lastUserTurns = history
    .filter(m => m.role === 'user')
    .slice(-4)
    .map(m => m.content)
    .join('\n---\n')
    .slice(0, 1200);

  const system = `
Return strict JSON only:
{
  "proficiency_key": "beginner|intermediate|advanced|proficient",
  "cefr_code": "A1|A2|B1|B2|C1|C2",
  "needs_instruction": true|false
}
Use the text to estimate level; also flag needs_instruction if responses are very short, off-topic, or confused for the given level.
`.trim();

  try {
    const resp = await callChatWithResilience({
      model: chooseChatModel({ kind: 'analyze' }),
      messages: [
        { role: 'system', content: system },
        { role: 'user', content: lastUserTurns || 'No user text provided.' }
      ],
      temperature: 0.0,
      max_tokens: 120,
      response_format: { type: 'json_object' },
    });
    const parsed = JSON.parse(resp.choices?.[0]?.message?.content || '{}');
    return {
      proficiency_key: String(parsed.proficiency_key || 'beginner').toUpperCase(),
      cefr_code: String(parsed.cefr_code || 'A1').toUpperCase(),
      needs_instruction: !!parsed.needs_instruction,
    };
  } catch {
    return { proficiency_key: 'BEGINNER', cefr_code: 'A1', needs_instruction: false };
  }
}

/* ======================
   Prompt factory (lean)
   ====================== */
function baseRulesForGroup(group) {
  if (group === 'PROFICIENT') {
    return `You are an English Conversation Partner for PROFICIENT users.
Be concise (≤80 words). Ask exactly ONE open question (why/how/what if/compare).
Encourage nuance; no step-by-step scaffolding unless asked.
Recast only if meaning is unclear. End with exactly one question mark.`;
  }
  if (group === 'ADVANCED') {
    return `You are an English Conversation Partner for ADVANCED users.
Keep replies concise (≤60 words). Ask exactly ONE probing question (why/how/what if).
Favor natural discourse and light challenge. Recast only if needed.
End with exactly one question mark.`;
  }
  if (group === 'INTERMEDIATE') {
    return `You are an English Conversation Partner for INTERMEDIATE users.
Keep replies short (≤35 words). Ask exactly ONE question (reason/example/contrast).
If the learner struggles, offer a brief hint.
Recast brief errors once, then continue. End with exactly one question mark.`;
  }
  return `You are an English Conversation Guide for BEGINNERS.
Keep replies VERY short (≤25 words). Ask exactly ONE question.
If user is brief/unsure: give ONE example they can copy OR TWO choices (not both).
If user errs, recast once; if easy, add a tiny stretch. End with one question mark.`;
}
function lexicalRulesForGroup(group) {
  if (group === 'BEGINNER') {
    return `LEXICAL RULES (BEGINNER, A1–A2):
- Use very simple words and short sentences (Present Simple).
- Prefer: say, ask, name, from, like, want, live, work, friend.
- Avoid: introduce, yourself, themselves, either, usually, prefer, perhaps.
- If you need "introduce yourself", say: "say your name".
- No rare adverbs; keep it basic.
- ONE question only, end with "?".`;
  }
  if (group === 'INTERMEDIATE') {
    return `LEXICAL RULES (INTERMEDIATE, ~B1):
- Keep it clear and concrete; simple clauses are okay.
- Prefer common vocabulary; avoid rare/abstract words.
- ONE question only, end with "?".`;
  }
  return `LEXICAL RULES:
- Natural, concise wording. Avoid jargon unless the learner uses it.
- ONE question only, end with "?".`;
}
function modeInstructions(mode, roleName, roleCtx, maxWords) {
  if (mode === 'scenario') {
    return `MODE: SCENARIO (role-play)
- Speak in character as ${roleName || 'a friendly person'}${roleCtx ? ` (${roleCtx})` : ''}.
- Be natural, concise (≤${maxWords} words).
- Ask EXACTLY ONE follow-up question, end with "?". No lists.
- Light recast only if meaning is unclear.`;
  }
  return `MODE: PRACTICE (coach)
- Be very clear and concise (≤${maxWords} words).
- If the learner's last message was short, include ONE example they can copy OR TWO simple choices (not both).
- Tiny positive feedback; brief recast of obvious errors.
- Ask EXACTLY ONE practice question, end with "?".`;
}
function decisionPolicyBlock() {
  return `DECISION POLICY (invisible; follow strictly):
1) FREE-TALK has highest priority:
   - If the user's latest message already contains substance (story, opinion, plan, problem, or a concrete question), respond to THAT and develop it.
   - Do NOT switch to a preset topic in this case.
2) If the user clearly wants to RESUME last topic, continue it naturally (do not announce the choice).
3) If the user clearly wants something NEW and hasn't already started free-talk, gently propose or pick a fitting topic and begin.
4) If unclear, ask ONE short clarifying question.
Always produce ONE question total and keep level-appropriate brevity.`;
}
function buildSystemPrompt({ group, mode, topic, summary }) {
  const t = topic?.attributes || topic || {};
  const range = cefrRangeFromGroup(group);
  let sys = [
    baseRulesForGroup(group),
    lexicalRulesForGroup(group),
    modeInstructions(mode, t?.role_name || null, t?.role_context || null, (group==='PROFICIENT'?80:group==='ADVANCED'?60:group==='INTERMEDIATE'?35:25)),
    decisionPolicyBlock()
  ].join('\n\n');

  const hints = buildTopicHints(topic);
  if (hints) sys += `\n\n${hints}`;
  if (range) sys += `\n\n(Internal hint: Target CEFR ~ ${range.min}–${range.max}.)`;

  if (summary?.kind === 'conv_state_v2') {
    const minimal = {
      topic_title_hint: summary.topic_title_hint || null,
      last_user_summary: summary.last_user_summary || null,
      open_threads: (summary.open_threads || []).slice(0, 1),
      cefr: summary.cefr_cached || null,
    };
    sys += `\n\nDIALOGUE STATE (use for continuity; do not quote): ${JSON.stringify(minimal)}`;
  } else if (summary?.kind === 'start_seed_v1') {
    const seed = { recent: summary.recent || null, suggestions: (summary.suggestions || []).slice(0, SUGGESTION_COUNT) };
    sys += `\n\nBACKGROUND SEED (do not mention directly): ${JSON.stringify(seed)}`;
  }

  return sys;
}

/* ===================================
   Service (single-file, trimmed down)
   =================================== */
module.exports = ({ strapi }) => ({

  // Persist one turn + tiny deterministic state (no heavy compaction)
  async persistTurnAndMaybeCompact({ sessionId, topicId = null, history, decided_mode = null }) {
    const [conv] = await strapi.entityService.findMany('api::conversation.conversation', {
      filters: { sessionId },
      populate: { topic: true },
      fields: ['id','summary','turns_total','last_mode'],
      limit: 1,
    });
    if (!conv) throw new Error('Unknown sessionId');

    const turnsTotal = history.length;

    // Build tiny deterministic state
    const state = updateStateV2Deterministic({
      prev: conv.summary?.kind === 'conv_state_v2' ? conv.summary : null,
      history,
      topicId: topicId || conv.topic?.id || null,
      group: null,
      cefr: null,
      mode: decided_mode || conv.last_mode || null,
    });

    await strapi.entityService.update('api::conversation.conversation', conv.id, {
      data: {
        history,
        summary: state,
        compacted_upto: 0, // legacy field kept for compatibility
        turns_total: turnsTotal,
        last_mode: decided_mode || null,
        last_active: new Date().toISOString(),
        topic: topicId || conv.topic?.id || null,
      },
    });

    return { turns_total: turnsTotal, compacted_upto: 0 };
  },

  async warmStartFromMemory({ mode, group, topicTitle, summary, lastTurns }) {
    const bg = `BACKGROUND (do not say this directly):
- Topic: ${topicTitle || '(unknown)'}
- Open threads: ${(summary?.open_threads || []).slice(0,3).join(' | ') || '—'}
- Recent turns:
${lastTurns.map(t => `${t.role.toUpperCase()}: ${t.content}`).join('\n')}`;

    const system = [
      baseRulesForGroup(group),
      lexicalRulesForGroup(group),
      bg,
      modeInstructions(mode === 'continue' ? 'scenario' : mode, null, null, 60),
      `Ask exactly one question and end with "?".`
    ].join('\n\n');

    const resp = await callChatWithResilience({
      model: chooseChatModel({ kind: 'warmstart', group }),
      messages: [
        { role: 'system', content: system },
        { role: 'user', content: 'Start the new turn now. Keep it natural and short.' }
      ],
      temperature: 0.4,
      max_tokens: 120,
    });

    return sanitizeModelReply(resp.choices?.[0]?.message?.content || 'Ready to continue—what would you like to say?', {
      maxWords: 60
    });
  },

  async startSession({ userId = null }) {
    const profPref = await getProfilePref({ strapi, userId });
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

    const suggestions = await fetchSuggestionTopics({ proficiency: profPref || 'auto', strapi });

    const first_turn = (hasRecent && recentSeed?.topic_title)
      ? `Hi there! Last time we talked about ${recentSeed.topic_title} ${timeAgo(recentSeed.last_active_iso)}. Would you like to continue that, start something new, or just tell me what's on your mind?`
      : (suggestions?.[0]?.title
          ? `Hi there! What do you want to talk about today? If you like, we could try “${suggestions[0].title}”.`
          : `Hi there! What do you want to talk about today?`);

    const sessionId = uuidv4();
    await strapi.entityService.create('api::conversation.conversation', {
      data: {
        sessionId,
        history: [{ role: 'assistant', content: first_turn }],
        topic: null,
        summary: seedSummary({ recent: recentSeed, suggestions }), // will switch to conv_state_v2 after 1st persist
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

  async kickoffFromStrapiTopics(opts = {}) {
    const { sampleSize = 4, proficiency = 'auto', background = null } = opts;
    const filters = { is_active: true };
    const allowed = allowedCEFRFromProficiency(proficiency);
    if (allowed && allowed.length) filters.difficulty_level = { code: { $in: allowed } };

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
    const lines = pool.map((t, i) => {
      const cefr = t?.difficulty_level?.data?.attributes?.code || 'A?';
      let s = `${i + 1}) [id:${t.id}] ${t.title} (${String(cefr).toUpperCase()})`;
      if (t.mode_hint) s += ` | mode:${t.mode_hint}`;
      if (t.role_name) s += ` | role:${t.role_name}`;
      if (t.role_context) s += ` | ctx:${String(t.role_context).slice(0, 60)}`;
      return s;
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

    const resp = await callChatWithResilience({
      model: chooseChatModel({ kind: 'kickoff', group }),
      messages: [
        ...(background ? [{ role: 'system', content: 'BACKGROUND SUMMARY (use only for personalization; do NOT quote it):\n' + JSON.stringify(background) }] : []),
        { role: 'system', content: kickoffSystem },
        { role: 'user', content: `Topics:\n${lines.join('\n')}` }
      ],
      temperature: 0.35,
      max_tokens: 200,
      response_format: { type: 'json_object' },
    });

    let parsed = {};
    try { parsed = JSON.parse(resp.choices?.[0]?.message?.content || '{}'); } catch {}
    const first_turn = sanitizeModelReply(parsed.first_turn || `Let's begin. What would you like to talk about?`, { maxWords: 60 });

    return {
      selected_topic_id: Number(parsed.selected_topic_id) || null,
      selected_topic_title: parsed.selected_topic_title || null,
      first_turn,
      inferred_level: group,
    };
  },

  /**
   * Continue conversation with adaptive level and minimal context.
   * args: { history, topicId?, proficiency?, mode?, summary?, userId? }
   */
  async generateNextPrompt({ history, topicId = null, proficiency = 'auto', mode: modeOverride = null, summary = null, userId = null }) {
    if (!Array.isArray(history) || history.length === 0) {
      throw new Error('generateNextPrompt requires non-empty history.');
    }

    // Optional topic
    let topic = null;
    if (topicId) {
      topic = await strapi.entityService.findOne('api::topic.topic', topicId, {
        populate: { difficulty_level: { fields: ['code'] } },
        fields: ['title','mode_hint','role_name','role_context'],
      });
    }

    // Group: client > profile > (throttled) inference > topic CEFR > BEGINNER
    let group = null, inferred_proficiency_key = null, inferred_cefr_code = null;
    const profPref = (!proficiency || String(proficiency).toLowerCase() === 'auto')
      ? await getProfilePref({ strapi, userId })
      : proficiency;
    group = groupFromProficiency(profPref);

    const turnsTotal = history.length;
    const signals = analyzeUserSignals(history);

    const SHOULD_INFER = (!group) && (turnsTotal <= INFER_AT_TURNS || (turnsTotal % INFER_EVERY_N === 0));
    let needs_instruction = false;
    if (SHOULD_INFER || (signals.wc < 6 && turnsTotal % SUPPORT_EVERY_N === 0)) {
      const meta = await analyzeMeta(history);
      inferred_proficiency_key = meta.proficiency_key || null;
      inferred_cefr_code       = meta.cefr_code || null;
      needs_instruction        = !!meta.needs_instruction;

      group =
        groupFromProficiency(inferred_proficiency_key) ||
        groupFromProficiency(inferred_cefr_code) ||
        (topic ? groupFromProficiency(extractCEFRCodeFromTopic(topic)) : null) ||
        'BEGINNER';
    }
    if (!group) group = (topic ? groupFromProficiency(extractCEFRCodeFromTopic(topic)) : null) || 'BEGINNER';

    // Mode decision
    const t = topic?.attributes || topic || {};
    const hint = t?.mode_hint || 'auto';
    let mode = (modeOverride && ['practice','scenario','auto'].includes(String(modeOverride).toLowerCase()))
      ? String(modeOverride).toLowerCase()
      : decideMode({ hint, group, signals });
    if (needs_instruction) mode = 'practice';

    // System prompt + last K turns
    const systemMsg = buildSystemPrompt({ group, mode, topic, summary });
    const messages = [{ role: 'system', content: systemMsg }, ...history.slice(-CONVO_TAIL_TURNS)];

    try {
      const resp = await callChatWithResilience({
        model: chooseChatModel({ kind: 'generate', group }),
        messages,
        temperature: (group === 'ADVANCED' || group === 'PROFICIENT') ? 0.6 : 0.5,
        max_tokens: 120,
        frequency_penalty: 0.1,
      });

      const raw = resp.choices?.[0]?.message?.content || "Let's continue. What do you think?";
      const reply = sanitizeModelReply(raw, { maxWords: (group==='PROFICIENT'?80:group==='ADVANCED'?60:group==='INTERMEDIATE'?35:25) });

      // Optional: bind topic if reply echoes a suggestion title from seed
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
      const status = err?.status || err?.response?.status || 'n/a';
      const reqId  = err?.response?.headers?.['x-request-id'] || err?.headers?.['x-request-id'] || 'n/a';
      let body     = err?.response?.data ?? err?.error ?? err?.message ?? err?.toString?.() ?? 'n/a';
      try { body = typeof body === 'string' ? body : JSON.stringify(body); } catch {}
      strapi.log.error(`Error generating next prompt: status=${status} reqId=${reqId} body=${body}`);
      return {
        reply: "Sorry, I had a hiccup. Could you say that again?",
        inferred_proficiency_key, inferred_cefr_code, inferred_group: group, decided_mode: mode || null,
        maybe_new_topic_id: null
      };
    }
  },

  // expose tiny helper for tests if desired
  sanitizeModelReply,
});

/* =======================================
   Local Strapi profile helper (unchanged)
   ======================================= */
async function getProfilePref({ strapi, userId }) {
  if (!userId) return null;
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

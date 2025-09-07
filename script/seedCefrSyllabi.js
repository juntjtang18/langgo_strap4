// scripts/seedCefrSyllabi.js
// Seeds all CEFR syllabus rows and links each to the correct difficulty-level.
// Works with your schemas posted above (Strapi v4).
//
// Env:
//   STRAPI_BASE_URL=http://localhost:1338
//   STRAPI_API_TOKEN=... (must allow find/create on difficulty-levels & cefr-syllabi)

const fetch = require("node-fetch");

const BASE = process.env.STRAPI_BASE_URL || "http://localhost:1338";
const TOKEN = process.env.STRAPI_API_TOKEN || "949394799a60ba70219293f2188419a00d55c8105032a35037e2405a68e9b00b18c08a53fb60b39d989e68941abb0622846b2e4edc2e5181bd6b2d26bd4a1ada8c1078758d05960c310cf214cd748ddce3ae276f5aa859e681a7d11e30a6c360de5f6d005e631ab77d4de360ee5bfcc4f1890b8bfe9e443dc030879b89663fa0";

const URL_LEVELS = `${BASE}/api/difficulty-levels`;
const URL_SYLLABI = `${BASE}/api/cefr-syllabi`;

function h() {
  return {
    "Content-Type": "application/json",
    Authorization: `Bearer ${TOKEN}`,
  };
}

async function getJson(url) {
  const res = await fetch(url, { headers: h() });
  if (!res.ok) throw new Error(`${res.status} ${url} -> ${await res.text()}`);
  return res.json();
}

async function postJson(url, data) {
  const res = await fetch(url, {
    method: "POST",
    headers: h(),
    body: JSON.stringify({ data }),
  });
  if (!res.ok) throw new Error(`${res.status} ${url} -> ${await res.text()}`);
  return res.json();
}

// Map "A1"..."C2" -> difficulty-level id by querying your server
async function loadDifficultyMap() {
  // Pull all (you have 6)
  const json = await getJson(`${URL_LEVELS}?pagination[pageSize]=100`);
  const map = {};
  for (const row of json.data || []) {
    const code = row.attributes?.code;
    if (code) map[code] = row.id;
  }
  // Sanity check
  for (const need of ["A1", "A2", "B1", "B2", "C1", "C2"]) {
    if (!map[need]) {
      throw new Error(
        `Missing difficulty-level with code=${need}. Please ensure it exists.`
      );
    }
  }
  return map;
}

// Check duplicate by (syllabi + difficulty_level)
async function syllabusExists(syllabi, difficultyLevelId) {
  const qs = new URLSearchParams();
  qs.append("filters[syllabi][$eq]", syllabi);
  qs.append("filters[difficulty_level][id][$eq]", difficultyLevelId);
  qs.append("pagination[pageSize]", "1");
  const url = `${URL_SYLLABI}?${qs.toString()}`;
  const json = await getJson(url);
  return (json.data && json.data.length > 0) ? json.data[0] : null;
}

// Insert one row
async function createSyllabus({ syllabi, order, difficulty_level_id }) {
  return postJson(URL_SYLLABI, {
    syllabi,
    order,
    conv_topic_number: 0,
    difficulty_level: difficulty_level_id, // relation via id
    // slug auto-generates from "syllabi" per your UID field
  });
}

// -------- CEFR DATA (60 topics) -------------------------------------------
const CEFR = {
  A1: [
    "Self-introduction (name, age, nationality)",
    "Family and friends",
    "Daily routines",
    "Food and drinks",
    "Shopping",
    "Hobbies",
    "Weather",
    "Directions and locations",
    "School/work basics",
    "Travel (transport, booking)",
  ],
  A2: [
    "Describing past holidays",
    "Talking about future plans",
    "Health and the body",
    "Ordering at restaurants",
    "Daily life in their city",
    "Likes/dislikes (music, movies, sports)",
    "Simple problem-solving (lost item, asking for help)",
    "Festivals and celebrations",
    "Using technology (phone, internet)",
    "Comparing things (two cities, two hobbies)",
  ],
  B1: [
    "Giving opinions on news and culture",
    "Explaining rules and instructions",
    "Describing experiences in detail",
    "Environmental issues (recycling, pollution)",
    "School vs. work differences",
    "Travel experiences abroad",
    "Hobbies in depth (sports, arts, gaming)",
    "Social media",
    "Personal goals and ambitions",
    "Handling complaints (hotel, service)",
  ],
  B2: [
    "Discussing advantages/disadvantages (city vs. countryside)",
    "Debating controversial issues (school uniforms, social media effects)",
    "Technology & society",
    "Health & fitness trends",
    "Career choices and challenges",
    "Globalization",
    "Comparing cultures",
    "Storytelling with detail",
    "Media and advertising",
    "Expressing hypothetical situations",
  ],
  C1: [
    "Politics and social issues",
    "Education systems around the world",
    "The role of science and innovation",
    "Arts and literature",
    "Cultural identity",
    "Ethics and morality",
    "Complex problem-solving discussions",
    "Negotiations and persuasion",
    "History and its lessons",
    "Future predictions (AI, environment, economy)",
  ],
  C2: [
    "Abstract philosophy (free will, happiness)",
    "Critical reviews (books, films, art)",
    "Global challenges (climate change, inequality)",
    "Economics and finance",
    "International relations",
    "The role of media in democracy",
    "Intercultural communication",
    "Advanced debates (ethics of AI, genetic engineering)",
    "Academic presentations",
    "Persuasive speeches on abstract issues",
  ],
};

// --------------------------------------------------------------------------

async function run() {
  if (!TOKEN || TOKEN === "REPLACE_ME") {
    throw new Error("Set STRAPI_API_TOKEN env var to a valid token.");
  }

  console.log("Loading difficulty-level map…");
  const dmap = await loadDifficultyMap(); // { A1:1, A2:2, ... }

  let created = 0, skipped = 0;
  for (const code of ["A1", "A2", "B1", "B2", "C1", "C2"]) {
    const difficulty_level_id = dmap[code];
    const topics = CEFR[code];

    console.log(`\nSeeding ${code} (${topics.length} topics)…`);

    for (let i = 0; i < topics.length; i++) {
      const syllabi = topics[i];
      const order = i + 1;

      // idempotency
      const exists = await syllabusExists(syllabi, difficulty_level_id);
      if (exists) {
        console.log(`  • Skip (exists): [${code}] #${order} ${syllabi}`);
        skipped++;
        continue;
      }

      try {
        await createSyllabus({ syllabi, order, difficulty_level_id });
        console.log(`  ✓ Created: [${code}] #${order} ${syllabi}`);
        created++;
      } catch (e) {
        console.error(`  ✗ Failed: [${code}] #${order} ${syllabi}`);
        console.error("    ->", e.message);
      }
    }
  }

  console.log(`\nDone. Created: ${created}, Skipped: ${skipped}`);
}

run().catch((err) => {
  console.error("Seeder error:", err.message);
  process.exit(1);
});

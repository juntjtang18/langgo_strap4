// scripts/backfillCefrSyllabiSlugs.js
// Backfills missing/empty `slug` on cefr-syllabi using `syllabi` as source.
// Ensures uniqueness per collection by appending "-2", "-3", ... if needed.
//
// Env:
//   STRAPI_BASE_URL (default: http://localhost:1338)
//   STRAPI_API_TOKEN
//   DRY_RUN=1 (optional) -> only logs, no PUTs

const fetch = require("node-fetch");

const BASE = process.env.STRAPI_BASE_URL || "http://localhost:1338";
const TOKEN = process.env.STRAPI_API_TOKEN || "80dcec755f303a519814a09fa1677735b9ecac6bb1ad625a781847e7870defce48f47c881134f5791c7160bdd608604b6ad3473fded5bccd2ee8fb18e995de2b2a3a5e6b3c9cd603734d92dbe5ec5269d4ee21650106e583a328be2a585d8b325ec30ab023e442a689536c3ca9559f531239667a88e1890818adc76c2611d463";
const DRY_RUN = process.env.DRY_RUN === "1";

const SYLLABI_URL = `${BASE}/api/cefr-syllabi`;

function headers() {
  return {
    "Content-Type": "application/json",
    Authorization: `Bearer ${TOKEN}`,
  };
}

function makeSlug(input) {
  const base = String(input || "")
    .normalize("NFKD")
    .replace(/[\u0300-\u036f]/g, "") // strip accents
    .replace(/&/g, " and ")
    .replace(/['’]/g, "")
    .replace(/[^a-zA-Z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .toLowerCase();

  // keep it reasonable length (room for -NN suffix)
  const MAX = 60;
  return base.length > MAX ? base.slice(0, MAX).replace(/-+$/,"") : base;
}

async function getJson(url) {
  const res = await fetch(url, { headers: headers() });
  if (!res.ok) throw new Error(`${res.status} ${url} -> ${await res.text()}`);
  return res.json();
}

async function putJson(url, data) {
  if (DRY_RUN) {
    console.log(`[DRY_RUN] PUT ${url}`, data);
    return { data: { id: url.split("/").pop(), attributes: data } };
  }
  const res = await fetch(url, {
    method: "PUT",
    headers: headers(),
    body: JSON.stringify({ data }),
  });
  if (!res.ok) throw new Error(`${res.status} ${url} -> ${await res.text()}`);
  return res.json();
}

// Ensure slug uniqueness by checking the API for conflicts.
// If conflict found with other ID, append -2, -3, ...
async function ensureUniqueSlug(candidate, selfId) {
  let slug = candidate || "item";
  let n = 1;

  // Helper to query by slug
  async function slugInUse(s) {
    const qs = new URLSearchParams();
    qs.set("filters[slug][$eq]", s);
    qs.set("pagination[pageSize]", "2");
    const url = `${SYLLABI_URL}?${qs.toString()}`;
    const json = await getJson(url);
    const rows = json?.data || [];
    // If found entries whose id is not self, it's a conflict
    return rows.some(r => String(r.id) !== String(selfId));
  }

  // if slug is empty after cleaning
  if (!slug) slug = "item";

  // loop until no conflict
  while (await slugInUse(slug)) {
    n += 1;
    const base = candidate.replace(/-\d+$/, ""); // in case we re-run
    let next = `${base}-${n}`;
    // keep length in check
    if (next.length > 64) next = next.slice(0, 64).replace(/-+$/,"");
    slug = next;
  }
  return slug;
}

// Fetch all entries missing slug (or slug == "")
async function listNeedingBackfill() {
  // Use $or to catch null and empty string; page through all results
  let page = 1;
  const pageSize = 100;
  const needing = [];

  while (true) {
    const qs = new URLSearchParams();
    qs.set("pagination[page]", String(page));
    qs.set("pagination[pageSize]", String(pageSize));
    qs.set("filters[$or][0][slug][$null]", "true");
    qs.set("filters[$or][1][slug][$eq]", "");
    const url = `${SYLLABI_URL}?${qs.toString()}`;
    const json = await getJson(url);
    const data = json?.data || [];
    needing.push(...data);
    if (data.length < pageSize) break;
    page++;
  }

  // Sometimes slug might be whitespace; filter client-side too
  return needing.filter(r => {
    const v = r?.attributes?.slug;
    return !v || !String(v).trim();
  });
}

async function run() {
  if (!TOKEN) {
    throw new Error("Please set STRAPI_API_TOKEN");
  }

  console.log("Scanning for cefr-syllabi without slug…");
  const rows = await listNeedingBackfill();
  if (!rows.length) {
    console.log("All good — no missing slugs found.");
    return;
  }

  console.log(`Found ${rows.length} entries to backfill.\n`);

  let updated = 0, failed = 0;

  for (const row of rows) {
    const id = row.id;
    const title = row.attributes?.syllabi || "";
    const initial = makeSlug(title);
    try {
      const unique = await ensureUniqueSlug(initial, id);
      await putJson(`${SYLLABI_URL}/${id}`, { slug: unique });
      console.log(`✓ #${id} "${title}" -> ${unique}`);
      updated++;
    } catch (e) {
      console.error(`✗ #${id} "${title}" -> ${e.message}`);
      failed++;
    }
  }

  console.log(`\nDone. Updated: ${updated}, Failed: ${failed}${DRY_RUN ? " (dry run)" : ""}.`);
}

run().catch(err => {
  console.error("Backfill error:", err.message);
  process.exit(1);
});

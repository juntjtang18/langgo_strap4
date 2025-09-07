// delete-all-topics.js
const fetch = require("node-fetch");

const BASE = process.env.STRAPI_BASE_URL || "http://localhost:1338";
const TOKEN =
  process.env.STRAPI_API_TOKEN ||
  "949394799a60ba70219293f2188419a00d55c8105032a35037e2405a68e9b00b18c08a53fb60b39d989e68941abb0622846b2e4edc2e5181bd6b2d26bd4a1ada8c1078758d05960c310cf214cd748ddce3ae276f5aa859e681a7d11e30a6c360de5f6d005e631ab77d4de360ee5bfcc4f1890b8bfe9e443dc030879b89663fa0";

function headers() {
  return {
    "Content-Type": "application/json",
    Authorization: `Bearer ${TOKEN}`,
  };
}

async function getTopics() {
  const res = await fetch(`${BASE}/api/topics?pagination[pageSize]=1000`, {
    headers: headers(),
  });
  if (!res.ok) throw new Error(`${res.status}: ${await res.text()}`);
  const json = await res.json();
  return json.data || [];
}

async function deleteTopic(id) {
  const res = await fetch(`${BASE}/api/topics/${id}`, {
    method: "DELETE",
    headers: headers(),
  });
  if (!res.ok) throw new Error(`${res.status}: ${await res.text()}`);
  return res.json();
}

(async () => {
  try {
    const topics = await getTopics();
    console.log(`Found ${topics.length} topics.`);

    for (const t of topics) {
      await deleteTopic(t.id);
      console.log(`Deleted topic ${t.id}`);
    }

    console.log("✅ Done deleting all topics.");
  } catch (err) {
    console.error("❌ Error:", err.message);
  }
})();

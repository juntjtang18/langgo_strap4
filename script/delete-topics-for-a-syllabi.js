// script/delete-topics-for-a-syllabi.js
const fetch = require("node-fetch"); // CommonJS require

const API_URL = "http://localhost:1338/api"; // adjust if remote
const TOKEN = "949394799a60ba70219293f2188419a00d55c8105032a35037e2405a68e9b00b18c08a53fb60b39d989e68941abb0622846b2e4edc2e5181bd6b2d26bd4a1ada8c1078758d05960c310cf214cd748ddce3ae276f5aa859e681a7d11e30a6c360de5f6d005e631ab77d4de360ee5bfcc4f1890b8bfe9e443dc030879b89663fa0";
const SYLLABUS_ID = 1; // <<< replace with the syllabus id

async function main() {
  try {
    // 1. Get all topics for this syllabus
    const res = await fetch(
      `${API_URL}/topics?filters[cefr_syllabus][id][$eq]=${SYLLABUS_ID}&pagination[pageSize]=1000`,
      { headers: { Authorization: `Bearer ${TOKEN}` } }
    );

    if (!res.ok) throw new Error(`Fetch failed: ${res.statusText}`);
    const data = await res.json();
    const topics = data.data || [];

    if (!topics.length) {
      console.log(`No topics found for syllabus ${SYLLABUS_ID}`);
      return;
    }

    console.log(`Found ${topics.length} topics. Deleting...`);

    // 2. Delete each topic
    for (const topic of topics) {
      const delRes = await fetch(`${API_URL}/topics/${topic.id}`, {
        method: "DELETE",
        headers: { Authorization: `Bearer ${TOKEN}` },
      });

      if (!delRes.ok) {
        console.error(`Failed to delete topic ${topic.id}`);
      } else {
        console.log(`Deleted topic ${topic.id}`);
      }
    }

    console.log("Done.");
  } catch (err) {
    console.error("Error:", err);
  }
}

main();

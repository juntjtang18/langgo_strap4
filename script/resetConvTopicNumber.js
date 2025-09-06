// script/resetConvTopicNumber.js
'use strict';

// IMPORTANT: don't destructure here
const strapiFactory = require('@strapi/strapi');

async function run() {
  // Boot Strapi programmatically
  const strapi = await strapiFactory().load();

  try {
    // Bulk update all rows
    await strapi.db
      .query('api::cefr-syllabus.cefr-syllabus')
      .updateMany({ where: {}, data: { conv_topic_number: 0 } });

    // (Optional) verify how many records exist
    const total = await strapi.db
      .query('api::cefr-syllabus.cefr-syllabus')
      .count({ where: {} });

    console.log(`✅ Reset conv_topic_number to 0 for ${total} record(s).`);
  } catch (err) {
    console.error('❌ Error resetting conv_topic_number:', err);
  } finally {
    await strapi.destroy();
    process.exit(0);
  }
}

run();

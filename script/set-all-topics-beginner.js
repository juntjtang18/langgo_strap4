'use strict';
const strapiFactory = require('@strapi/strapi');

(async () => {
  const app = await strapiFactory().load();
  await app.server.mount();

  try {
    // find beginner proficiency id
    const [beginner] = await strapi.entityService.findMany('api::proficiency-level.proficiency-level', {
      filters: { key: 'beginner' },
      fields: ['id','key'],
      limit: 1
    });
    if (!beginner) throw new Error('No proficiency-level with key=beginner found');
    const beginnerId = beginner.id;

    // fetch all topics
    const topics = await strapi.entityService.findMany('api::topic.topic', {
      fields: ['id','title'],
      limit: 10000
    });

    let updated = 0;
    for (const t of topics) {
      await strapi.entityService.update('api::topic.topic', t.id, {
        data: { proficiency_level: beginnerId }
      });
      updated++;
    }
    console.log(`Updated ${updated} topics to beginner.`);
  } catch (e) {
    console.error(e);
    process.exitCode = 1;
  } finally {
    await strapi.destroy();
  }
})();

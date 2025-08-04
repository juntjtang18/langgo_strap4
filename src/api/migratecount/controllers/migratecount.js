'use strict';

const fs = require('fs');
const path = require('path');

module.exports = {
  async index(ctx) {
    try {
      // Read the backup file
    const filePath = path.resolve(strapi.dirs.app.root, 'database', 'backup', 'flashcards_backup.json');
      
      if (!fs.existsSync(filePath)) {
        return ctx.throw(404, 'Backup file not found');
      }

      const raw = fs.readFileSync(filePath, 'utf-8');
      const json = JSON.parse(raw);
      const flashcards = Array.isArray(json.data) ? json.data : [];

      const targetTexts = new Set();

      // Extract all target_text values from a.user-word-ref components
      for (const fc of flashcards) {
        const content = fc?.attributes?.content || [];

        for (const comp of content) {
          if (
            comp?.__component === 'a.user-word-ref' &&
            comp?.user_word?.data?.attributes?.target_text
          ) {
            const targetText = comp.user_word.data.attributes.target_text.trim();
            if (targetText) {
              targetTexts.add(targetText);
            }
          }
        }
      }

      // Query the word collection for matching target_text entries
      const allTexts = Array.from(targetTexts);
      const BATCH = 100;
      const foundTexts = new Set();

      for (let i = 0; i < allTexts.length; i += BATCH) {
        const batch = allTexts.slice(i, i + BATCH);

        const results = await strapi.entityService.findMany('api::word.word', {
          filters: {
            target_text: { $in: batch },
          },
          fields: ['target_text'],
          limit: batch.length,
        });

        results.forEach((entry) => {
          if (entry.target_text) foundTexts.add(entry.target_text);
        });
      }

      const missing = allTexts.filter((text) => !foundTexts.has(text));

      ctx.send({
        totalInBackup: allTexts.length,
        foundInDB: foundTexts.size,
        missingCount: missing.length,
        missingSamples: missing.slice(0, 10),
      });
    } catch (err) {
      console.error('migratecount error:', err);
      ctx.status = 500;
      ctx.body = { error: 'Internal server error' };
    }
  },
};

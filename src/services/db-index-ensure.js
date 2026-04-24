'use strict';

module.exports = ({ strapi }) => ({
  async ensureIndexes() {
    const client = strapi.config.get('database.connection.client');
    if (client !== 'postgres') {
      strapi.log.warn(`Skipping DB index bootstrap for unsupported client: ${client}`);
      return [];
    }

    const schema = strapi.config.get('database.connection.connection.schema', 'public');
    const connection = strapi.db.connection;

    const indexes = [
      {
        name: 'flashcards_next_review_at_id_idx',
        sql: `CREATE INDEX IF NOT EXISTS "flashcards_next_review_at_id_idx"
              ON "${schema}"."flashcards" ("next_review_at" ASC NULLS FIRST, "id" ASC)`,
      },
      {
        name: 'flashcards_user_links_user_id_flashcard_id_idx',
        sql: `CREATE INDEX IF NOT EXISTS "flashcards_user_links_user_id_flashcard_id_idx"
              ON "${schema}"."flashcards_user_links" ("user_id" ASC, "flashcard_id" ASC)`,
      },
      {
        name: 'flashcard_stats_user_links_user_id_flashcard_stat_id_idx',
        sql: `CREATE INDEX IF NOT EXISTS "flashcard_stats_user_links_user_id_flashcard_stat_id_idx"
              ON "${schema}"."flashcard_stats_user_links" ("user_id" ASC, "flashcard_stat_id" ASC)`,
      },
    ];

    const created = [];

    for (const index of indexes) {
      const existsResult = await connection.raw(
        'SELECT to_regclass(?) AS regclass',
        [`${schema}.${index.name}`]
      );

      const row = Array.isArray(existsResult?.rows) ? existsResult.rows[0] : existsResult?.[0]?.rows?.[0];
      if (row?.regclass) {
        continue;
      }

      await connection.raw(index.sql);
      created.push(index.name);
    }

    if (created.length > 0) {
      strapi.log.info(`Created database indexes: ${created.join(', ')}`);
    } else {
      strapi.log.info('Database indexes already present.');
    }

    return created;
  },
});

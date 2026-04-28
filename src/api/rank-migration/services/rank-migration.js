'use strict';

// level formula: points_required(n) = base_points + increase_points * (n - 1)
const calcLevel = (totalPoints, base, increase) => {
  let level = 1;
  while (totalPoints >= base + increase * level) {
    level++;
  }
  return level;
};

module.exports = ({ strapi }) => ({
  async status() {
    const [oldPoints, oldGroups, oldRanks, oldRules, oldLevelRules] = await Promise.all([
      strapi.db.query('api::user-point.user-point').count(),
      strapi.db.query('api::point-group.point-group').count(),
      strapi.db.query('api::group-rank.group-rank').count({ where: { locale: 'en' } }),
      strapi.db.query('api::point-group-rule.point-group-rule').count(),
      strapi.db.query('api::honer-title-rule.honer-title-rule').count(),
    ]);
    const [newSnapshots, newGroups, newRanks, newGroupRules, newLevelRules] = await Promise.all([
      strapi.db.query('api::rs-user-snapshot.rs-user-snapshot').count(),
      strapi.db.query('api::rs-group.rs-group').count(),
      strapi.db.query('api::rs-group-rank.rs-group-rank').count(),
      strapi.db.query('api::rs-group-rule.rs-group-rule').count(),
      strapi.db.query('api::rs-level-rule.rs-level-rule').count(),
    ]);
    return {
      source: { user_points: oldPoints, point_groups: oldGroups, group_ranks_en: oldRanks, point_group_rules: oldRules, honer_title_rules: oldLevelRules },
      target: { rs_user_snapshots: newSnapshots, rs_groups: newGroups, rs_group_ranks: newRanks, rs_group_rules: newGroupRules, rs_level_rules: newLevelRules },
    };
  },

  async run() {
    strapi.log.info('[RankMigration] Starting migration from user_points → rs_user_snapshots');

    // ── 1. Guard: skip if already migrated ────────────────────────────────
    const existingSnapshots = await strapi.db.query('api::rs-user-snapshot.rs-user-snapshot').count();
    if (existingSnapshots > 0) {
      return { success: false, message: `Already migrated: rs_user_snapshots has ${existingSnapshots} records.` };
    }

    // ── 2. Load source data ───────────────────────────────────────────────
    const [oldLevelRule, oldGroupRanks, oldPointGroups, oldUserPoints] = await Promise.all([
      strapi.db.query('api::honer-title-rule.honer-title-rule').findOne({}),
      strapi.db.query('api::group-rank.group-rank').findMany({
        where: { locale: 'en' },
        orderBy: { min_period_points: 'asc' },
      }),
      strapi.db.query('api::point-group.point-group').findMany({
        populate: { group_rank: true },
      }),
      strapi.db.query('api::user-point.user-point').findMany({
        populate: { user: true, point_group: true },
        orderBy: { record_date: 'asc' },
      }),
    ]);

    if (!oldLevelRule) return { success: false, message: 'No honer_title_rule found.' };
    if (!oldGroupRanks.length) return { success: false, message: 'No group_ranks (en) found.' };
    if (!oldUserPoints.length) return { success: false, message: 'No user_points to migrate.' };

    // ── 3. Find or create rs_group_rule ───────────────────────────────────
    strapi.log.info('[RankMigration] Resolving rs_group_rule...');
    const [oldGroupRule] = await Promise.all([
      strapi.db.query('api::point-group-rule.point-group-rule').findOne({}),
    ]);
    let rsGroupRule = await strapi.db.query('api::rs-group-rule.rs-group-rule').findOne({});
    if (!rsGroupRule) {
      if (!oldGroupRule) return { success: false, message: 'No point_group_rule found.' };
      rsGroupRule = await strapi.entityService.create('api::rs-group-rule.rs-group-rule', {
        data: { period_days: oldGroupRule.period_days, group_size: oldGroupRule.group_size },
      });
      strapi.log.info('[RankMigration]   Created rs_group_rule');
    } else {
      strapi.log.info('[RankMigration]   Using existing rs_group_rule id=' + rsGroupRule.id);
    }

    // ── 4. Find or create rs_level_rule ───────────────────────────────────
    strapi.log.info('[RankMigration] Resolving rs_level_rule...');
    let rsLevelRule = await strapi.db.query('api::rs-level-rule.rs-level-rule').findOne({});
    if (!rsLevelRule) {
      rsLevelRule = await strapi.entityService.create('api::rs-level-rule.rs-level-rule', {
        data: { base_points: oldLevelRule.base_points, increase_points: oldLevelRule.increase_points },
      });
      strapi.log.info('[RankMigration]   Created rs_level_rule');
    } else {
      strapi.log.info('[RankMigration]   Using existing rs_level_rule id=' + rsLevelRule.id);
    }

    // ── 5. Resolve rs_group_ranks ─────────────────────────────────────────
    // Build a map: min_period_points → rs_group_rank
    strapi.log.info('[RankMigration] Resolving rs_group_ranks...');
    let rsGroupRanks = await strapi.db.query('api::rs-group-rank.rs-group-rank').findMany({
      orderBy: { rank_no: 'asc' },
    });

    const rsRankByMinPoints = new Map(); // min_period_points → rs_group_rank

    if (rsGroupRanks.length > 0) {
      strapi.log.info(`[RankMigration]   Using ${rsGroupRanks.length} existing rs_group_ranks`);
      for (const r of rsGroupRanks) {
        rsRankByMinPoints.set(r.min_period_points, r);
      }
    } else {
      strapi.log.info('[RankMigration]   Creating rs_group_ranks from old group_ranks...');
      for (let i = 0; i < oldGroupRanks.length; i++) {
        const old = oldGroupRanks[i];
        const rsRank = await strapi.entityService.create('api::rs-group-rank.rs-group-rank', {
          data: { rs_group_rule: rsGroupRule.id, rank_no: i + 1, min_period_points: old.min_period_points },
        });
        await strapi.entityService.create('api::rs-group-rank-title.rs-group-rank-title', {
          data: { rs_group_rank: rsRank.id, title: old.title, locale: 'en' },
        });
        rsRankByMinPoints.set(old.min_period_points, rsRank);
        rsGroupRanks.push(rsRank);
        strapi.log.info(`[RankMigration]   Created rank_no=${i + 1} "${old.title}"`);
      }
    }

    const starterRsRank = rsGroupRanks[0]; // lowest rank (rank_no=1)

    // ── 6. Resolve rs_groups ──────────────────────────────────────────────
    strapi.log.info('[RankMigration] Resolving rs_groups...');
    const existingRsGroups = await strapi.db.query('api::rs-group.rs-group').findMany({
      populate: { rs_group_rank: true },
    });

    // Build map: old point_group.id → rs_group
    const rsGroupByOldPgId = new Map();

    for (const pg of oldPointGroups) {
      const pgMinPoints = pg.group_rank?.min_period_points ?? 0;
      const targetRsRank = rsRankByMinPoints.get(pgMinPoints) || starterRsRank;

      // Try to find existing rs_group with same group_no and rank
      const existing = existingRsGroups.find(
        g => g.group_no === pg.group_no && g.rs_group_rank?.id === targetRsRank.id
      ) || existingRsGroups.find(g => g.group_no === pg.group_no); // fallback: match by group_no only

      if (existing) {
        rsGroupByOldPgId.set(pg.id, existing);
        strapi.log.info(`[RankMigration]   Mapped old point_group id=${pg.id} → existing rs_group id=${existing.id}`);
      } else {
        const rsGroup = await strapi.entityService.create('api::rs-group.rs-group', {
          data: { rs_group_rule: rsGroupRule.id, rs_group_rank: targetRsRank.id, group_no: pg.group_no },
        });
        rsGroupByOldPgId.set(pg.id, rsGroup);
        strapi.log.info(`[RankMigration]   Created rs_group group_no=${pg.group_no}`);
      }
    }

    // ── 7. Migrate user_points → rs_user_snapshots ────────────────────────
    strapi.log.info(`[RankMigration] Migrating ${oldUserPoints.length} user_points...`);

    let migrated = 0;
    let skipped = 0;

    for (const up of oldUserPoints) {
      if (!up.user?.id) {
        strapi.log.warn(`[RankMigration]   SKIP user_point id=${up.id}: no user`);
        skipped++;
        continue;
      }

      const userid = String(up.user.id);
      const rsGroup = up.point_group?.id ? rsGroupByOldPgId.get(up.point_group.id) : null;

      // Map old rank (integer) to rs_group_rank via min_period_points on the old group_rank.
      // Old user_points.rank is generally 0 (unset), so default to Starter.
      const rsGroupRankForSnapshot = (rsGroup?.rs_group_rank?.id)
        ? (await strapi.db.query('api::rs-group-rank.rs-group-rank').findOne({ where: { id: rsGroup.rs_group_rank?.id } }) || starterRsRank)
        : starterRsRank;

      const levelNo = calcLevel(
        up.points || 0,
        rsLevelRule.base_points,
        rsLevelRule.increase_points
      );
      const levelRecord = await findOrCreateLevel(strapi, levelNo);

      await strapi.entityService.create('api::rs-user-snapshot.rs-user-snapshot', {
        data: {
          userid,
          record_date: up.record_date,
          rs_group: rsGroup?.id || null,
          rs_group_rank: rsGroupRankForSnapshot.id,
          rs_level: levelRecord.id,
          total_points: up.points || 0,
          points_add: up.points_add || 0,
          word_count: up.word_count || 0,
          word_add: up.word_add || 0,
          article_count: up.article_count || 0,
          article_add: up.article_add || 0,
          level_change: 0,
          group_rank_change: up.group_rank_change || 0,
        },
      });

      migrated++;
      strapi.log.info(`[RankMigration]   ✓ user_point id=${up.id} → userid=${userid} date=${up.record_date} total_pts=${up.points} level=${levelNo}`);
    }

    const summary = {
      success: true,
      migrated,
      skipped,
      rs_group_ranks: rsGroupRanks.length,
      rs_groups: rsGroupByOldPgId.size,
    };
    strapi.log.info(`[RankMigration] Complete: ${JSON.stringify(summary)}`);
    return summary;
  },
});

async function findOrCreateLevel(strapi, levelNo) {
  const existing = await strapi.db.query('api::rs-level.rs-level').findOne({
    where: { level_no: levelNo },
  });
  if (existing) return existing;
  return strapi.entityService.create('api::rs-level.rs-level', { data: { level_no: levelNo } });
}

'use strict';

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
      strapi.db.query('plugin::rank-system.rs-user-snapshot').count(),
      strapi.db.query('plugin::rank-system.rs-group').count(),
      strapi.db.query('plugin::rank-system.rs-group-rank').count(),
      strapi.db.query('plugin::rank-system.rs-group-rule').count(),
      strapi.db.query('plugin::rank-system.rs-level-rule').count(),
    ]);
    return {
      source: { user_points: oldPoints, point_groups: oldGroups, group_ranks_en: oldRanks, point_group_rules: oldRules, honer_title_rules: oldLevelRules },
      target: { rs_user_snapshots: newSnapshots, rs_groups: newGroups, rs_group_ranks: newRanks, rs_group_rules: newGroupRules, rs_level_rules: newLevelRules },
    };
  },

  async run() {
    strapi.log.info('[RankMigration] Starting migration from user_points → rs_user_snapshots');
    const existingSnapshots = await strapi.db.query('plugin::rank-system.rs-user-snapshot').count();
    if (existingSnapshots > 0) {
      return { success: false, message: `Already migrated: rs_user_snapshots has ${existingSnapshots} records.` };
    }

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

    strapi.log.info('[RankMigration] Resolving rs_group_rule...');
    const oldGroupRule = await strapi.db.query('api::point-group-rule.point-group-rule').findOne({});
    let rsGroupRule = await strapi.db.query('plugin::rank-system.rs-group-rule').findOne({});
    if (!rsGroupRule) {
      if (!oldGroupRule) return { success: false, message: 'No point_group_rule found.' };
      rsGroupRule = await strapi.entityService.create('plugin::rank-system.rs-group-rule', {
        data: { period_days: oldGroupRule.period_days, group_size: oldGroupRule.group_size },
      });
    }

    strapi.log.info('[RankMigration] Resolving rs_level_rule...');
    let rsLevelRule = await strapi.db.query('plugin::rank-system.rs-level-rule').findOne({});
    if (!rsLevelRule) {
      rsLevelRule = await strapi.entityService.create('plugin::rank-system.rs-level-rule', {
        data: { base_points: oldLevelRule.base_points, increase_points: oldLevelRule.increase_points },
      });
    }

    strapi.log.info('[RankMigration] Resolving rs_group_ranks...');
    let rsGroupRanks = await strapi.db.query('plugin::rank-system.rs-group-rank').findMany({
      orderBy: { rank_no: 'asc' },
    });

    const rsRankByMinPoints = new Map();

    if (rsGroupRanks.length === 0) {
      for (let i = 0; i < oldGroupRanks.length; i += 1) {
        const old = oldGroupRanks[i];
        const rsRank = await strapi.entityService.create('plugin::rank-system.rs-group-rank', {
          data: { rs_group_rule: rsGroupRule.id, rank_no: i + 1, min_period_points: old.min_period_points },
        });
        await strapi.entityService.create('plugin::rank-system.rs-group-rank-title', {
          data: { rs_group_rank: rsRank.id, title: old.title, locale: 'en' },
        });
        rsRankByMinPoints.set(old.min_period_points, rsRank);
        rsGroupRanks.push(rsRank);
      }
    } else {
      for (const rank of rsGroupRanks) {
        rsRankByMinPoints.set(rank.min_period_points, rank);
      }
    }

    const starterRsRank = rsGroupRanks[0];
    const existingRsGroups = await strapi.db.query('plugin::rank-system.rs-group').findMany({
      populate: { rs_group_rank: true },
    });
    const rsGroupByOldPgId = new Map();

    for (const pointGroup of oldPointGroups) {
      const pgMinPoints = pointGroup.group_rank?.min_period_points ?? 0;
      const targetRsRank = rsRankByMinPoints.get(pgMinPoints) || starterRsRank;
      const existing = existingRsGroups.find(
        (group) => group.group_no === pointGroup.group_no && group.rs_group_rank?.id === targetRsRank.id
      ) || existingRsGroups.find((group) => group.group_no === pointGroup.group_no);

      if (existing) {
        rsGroupByOldPgId.set(pointGroup.id, existing);
      } else {
        const rsGroup = await strapi.entityService.create('plugin::rank-system.rs-group', {
          data: { rs_group_rule: rsGroupRule.id, rs_group_rank: targetRsRank.id, group_no: pointGroup.group_no },
        });
        rsGroupByOldPgId.set(pointGroup.id, rsGroup);
      }
    }

    let migrated = 0;
    let skipped = 0;

    for (const userPoint of oldUserPoints) {
      if (!userPoint.user?.id) {
        skipped += 1;
        continue;
      }

      const userid = String(userPoint.user.id);
      const rsGroup = userPoint.point_group?.id ? rsGroupByOldPgId.get(userPoint.point_group.id) : null;
      const rsGroupRankForSnapshot = (rsGroup?.rs_group_rank?.id)
        ? (await strapi.db.query('plugin::rank-system.rs-group-rank').findOne({ where: { id: rsGroup.rs_group_rank?.id } }) || starterRsRank)
        : starterRsRank;
      const levelNo = calcLevel(
        userPoint.points || 0,
        rsLevelRule.base_points,
        rsLevelRule.increase_points
      );
      const levelRecord = await findOrCreateLevel(strapi, levelNo);

      await strapi.entityService.create('plugin::rank-system.rs-user-snapshot', {
        data: {
          userid,
          record_date: userPoint.record_date,
          rs_group: rsGroup?.id || null,
          rs_group_rank: rsGroupRankForSnapshot.id,
          rs_level: levelRecord.id,
          total_points: userPoint.points || 0,
          points_add: userPoint.points_add || 0,
          word_count: userPoint.word_count || 0,
          word_add: userPoint.word_add || 0,
          article_count: userPoint.article_count || 0,
          article_add: userPoint.article_add || 0,
          level_change: 0,
          group_rank_change: userPoint.group_rank_change || 0,
        },
      });

      migrated += 1;
    }

    return {
      success: true,
      migrated,
      skipped,
      rs_group_ranks: rsGroupRanks.length,
      rs_groups: rsGroupByOldPgId.size,
    };
  },
});

async function findOrCreateLevel(strapi, levelNo) {
  const existing = await strapi.db.query('plugin::rank-system.rs-level').findOne({
    where: { level_no: levelNo },
  });
  if (existing) return existing;
  return strapi.entityService.create('plugin::rank-system.rs-level', { data: { level_no: levelNo } });
}

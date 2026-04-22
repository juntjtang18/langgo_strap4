'use strict';

module.exports = ({ strapi }) => {
  const REVIEW_LEVEL_ORDER = ['new', 'warmup', 'daily', 'weekly', 'monthly', 'remembered'];

  const getRecordDate = (isoDateTime) => new Date(isoDateTime).toISOString().slice(0, 10);

  const addDays = (isoDate, days) => {
    const shifted = new Date(`${isoDate}T00:00:00.000Z`);
    shifted.setUTCDate(shifted.getUTCDate() + days);
    return shifted.toISOString().slice(0, 10);
  };

  const getTierRank = (level) => {
    const index = REVIEW_LEVEL_ORDER.indexOf((level || '').toLowerCase());
    return index === -1 ? -1 : index;
  };

  const getPointGroupId = (record) => {
    if (!record?.point_group) {
      return null;
    }

    if (typeof record.point_group === 'number') {
      return record.point_group;
    }

    return record.point_group.id || null;
  };

  const getGroupRankId = (record) => {
    if (!record?.point_group?.group_rank) {
      return null;
    }

    if (typeof record.point_group.group_rank === 'number') {
      return record.point_group.group_rank;
    }

    return record.point_group.group_rank.id || null;
  };

  const getDefaultSnapshot = () => ({
    points: 0,
    word_count: 0,
    article_count: 0,
    point_group_id: null,
    rank: 0,
    rank_change: 0,
    group_rank_change: 0,
  });

  const snapshotFromRecord = (record) => ({
    points: record?.points ?? 0,
    word_count: record?.word_count ?? 0,
    article_count: record?.article_count ?? 0,
    point_group_id: getPointGroupId(record),
    rank: record?.rank ?? 0,
    rank_change: record?.rank_change ?? 0,
    group_rank_change: record?.group_rank_change ?? 0,
  });

  const snapshotBeforeTodayFromRecord = (record) => ({
    points: Math.max(0, (record?.points ?? 0) - (record?.points_add ?? 0)),
    word_count: Math.max(0, (record?.word_count ?? 0) - (record?.word_add ?? 0)),
    article_count: Math.max(0, (record?.article_count ?? 0) - (record?.article_add ?? 0)),
    point_group_id: getPointGroupId(record),
    rank: record?.rank ?? 0,
    rank_change: 0,
    group_rank_change: 0,
  });

  const getPointRule = async () => {
    const rules = await strapi.entityService.findMany('api::point-rule.point-rule', {
      sort: ['id:asc'],
      limit: 1,
    });

    if (!rules.length) {
      strapi.log.warn('No point-rule found. Falling back to review_point=1 and review_tier_up_point=0.');
      return {
        review_point: 1,
        review_tier_up_point: 0,
      };
    }

    return rules[0];
  };

  const getHonorTitleRule = async () => {
    const rules = await strapi.entityService.findMany('api::honer-title-rule.honer-title-rule', {
      sort: ['id:asc'],
      limit: 1,
    });

    return rules[0] || null;
  };

  const getHonorTitles = async () => {
    return strapi.entityService.findMany('api::honor-title.honor-title', {
      sort: ['id:asc'],
      limit: 100,
      locale: 'all',
    });
  };

  const getPointGroupRule = async () => {
    const rules = await strapi.entityService.findMany('api::point-group-rule.point-group-rule', {
      sort: ['id:asc'],
      limit: 1,
    });

    return rules[0] || null;
  };

  const getGroupRanks = async () => {
    return strapi.entityService.findMany('api::group-rank.group-rank', {
      sort: ['min_period_points:asc', 'id:asc'],
      limit: 100,
      locale: 'all',
    });
  };

  const getHonorThreshold = ({ basePoints, increasePoints, level }) =>
    (basePoints ?? 0) + (increasePoints ?? 0) * Math.max(0, level - 1);

  const getHonorLevelByTitleId = ({ titles, titleId }) => {
    if (!titleId) {
      return 0;
    }

    const index = titles.findIndex((title) => title.id === titleId);
    return index === -1 ? 0 : index + 1;
  };

  const getGroupRankForPeriodPoints = ({ groupRanks, periodPoints }) => {
    if (!groupRanks.length) {
      return null;
    }

    let matchedRank = null;

    groupRanks.forEach((groupRank) => {
      if ((groupRank.min_period_points ?? 0) <= periodPoints) {
        matchedRank = groupRank;
      }
    });

    return matchedRank || groupRanks[0];
  };

  const countGroupMembers = async (pointGroupId, trx) => {
    const rows = await strapi.entityService.findMany('api::user-point-group.user-point-group', {
      filters: {
        point_group: pointGroupId,
      },
      fields: ['id'],
      limit: 1000,
      db: trx,
    });

    return rows.length;
  };

  const findPointGroupsByRank = async (groupRankId, trx) => {
    return strapi.entityService.findMany('api::point-group.point-group', {
      filters: {
        group_rank: groupRankId,
      },
      sort: ['group_no:asc', 'id:asc'],
      db: trx,
    });
  };

  const findUserPointGroupsByPointGroup = async (pointGroupId, trx) => {
    return strapi.entityService.findMany('api::user-point-group.user-point-group', {
      filters: {
        point_group: pointGroupId,
      },
      sort: ['id:asc'],
      populate: {
        user: true,
        point_group: true,
      },
      db: trx,
    });
  };

  const calculatePeriodPoints = async ({ userId, recordDate, periodDays }, trx) => {
    const safePeriodDays = Math.max(1, periodDays ?? 1);
    const startDate = addDays(recordDate, -(safePeriodDays - 1));
    const rows = await strapi.entityService.findMany('api::user-point.user-point', {
      filters: {
        user: userId,
        record_date: {
          $gte: startDate,
          $lte: recordDate,
        },
      },
      fields: ['points_add'],
      limit: 1000,
      db: trx,
    });

    return rows.reduce((sum, row) => sum + (row.points_add ?? 0), 0);
  };

  const choosePointGroup = async ({ groupRankId }, trx) => {
    const groups = await findPointGroupsByRank(groupRankId, trx);

    if (!groups.length) {
      return null;
    }

    const groupsWithCounts = [];

    for (const group of groups) {
      const memberCount = await countGroupMembers(group.id, trx);
      groupsWithCounts.push({
        group,
        memberCount,
      });
    }

    const rankedGroups = groupsWithCounts
      .sort((left, right) => {
        if (left.memberCount !== right.memberCount) {
          return left.memberCount - right.memberCount;
        }

        return (left.group.group_no ?? 0) - (right.group.group_no ?? 0);
      });

    return rankedGroups[0]?.group || null;
  };

  const createPointGroup = async ({ groupRankId }, trx) => {
    const groups = await findPointGroupsByRank(groupRankId, trx);
    const maxGroupNo = groups.reduce((max, group) => Math.max(max, group.group_no ?? 0), 0);

    return strapi.entityService.create('api::point-group.point-group', {
      data: {
        group_rank: groupRankId,
        group_no: maxGroupNo + 1,
      },
      db: trx,
    });
  };

  const splitPointGroupIfNeeded = async ({ pointGroup, groupRankId, groupSize, recordDate }, trx) => {
    if (!pointGroup?.id || !groupSize || !groupRankId) {
      return null;
    }

    const members = await findUserPointGroupsByPointGroup(pointGroup.id, trx);
    const splitThreshold = Math.max(2, groupSize * 2);

    if (members.length < splitThreshold) {
      return null;
    }

    const newPointGroup = await createPointGroup({
      groupRankId,
    }, trx);

    const splitIndex = Math.floor(members.length / 2);
    const membersToMove = members.slice(splitIndex);

    for (const userPointGroup of membersToMove) {
      await strapi.entityService.update('api::user-point-group.user-point-group', userPointGroup.id, {
        data: {
          point_group: newPointGroup.id,
        },
        db: trx,
      });

      const todaysUserPoints = await strapi.entityService.findMany('api::user-point.user-point', {
        filters: {
          user: userPointGroup.user.id,
          record_date: recordDate,
        },
        sort: ['id:desc'],
        limit: 1,
        db: trx,
      });

      if (todaysUserPoints[0]) {
        await strapi.entityService.update('api::user-point.user-point', todaysUserPoints[0].id, {
          data: {
            point_group: newPointGroup.id,
          },
          db: trx,
        });
      }
    }

    return newPointGroup;
  };

  const syncUserPointGroupAssignment = async ({ userId, recordDate, todayUserPointId }, trx) => {
    const [pointGroupRule, groupRanks] = await Promise.all([
      getPointGroupRule(),
      getGroupRanks(),
    ]);

    if (!pointGroupRule || !groupRanks.length) {
      return null;
    }

    const existingUserPointGroup = await findCurrentUserPointGroup(userId, trx);
    const groupSize = Math.max(1, pointGroupRule.group_size ?? 1);
    const periodDays = Math.max(1, pointGroupRule.period_days ?? 1);
    const periodPoints = await calculatePeriodPoints({
      userId,
      recordDate,
      periodDays,
    }, trx);

    const targetGroupRank = getGroupRankForPeriodPoints({
      groupRanks,
      periodPoints,
    });

    if (!targetGroupRank) {
      return null;
    }

    if (existingUserPointGroup && getGroupRankId(existingUserPointGroup) === targetGroupRank.id) {
      const updatedUserPointGroup = await strapi.entityService.update(
        'api::user-point-group.user-point-group',
        existingUserPointGroup.id,
        {
          data: {
            period_points: periodPoints,
          },
          db: trx,
        }
      );

      if (todayUserPointId && getPointGroupId(existingUserPointGroup)) {
        await strapi.entityService.update('api::user-point.user-point', todayUserPointId, {
          data: {
            point_group: getPointGroupId(existingUserPointGroup),
          },
          db: trx,
        });
      }

      return {
        ...updatedUserPointGroup,
        point_group: existingUserPointGroup.point_group,
      };
    }

    let pointGroup = await choosePointGroup({
      groupRankId: targetGroupRank.id,
    }, trx);

    if (!pointGroup) {
      pointGroup = await createPointGroup({
        groupRankId: targetGroupRank.id,
      }, trx);
    }

    let userPointGroup;

    if (existingUserPointGroup) {
      userPointGroup = await strapi.entityService.update(
        'api::user-point-group.user-point-group',
        existingUserPointGroup.id,
        {
          data: {
            point_group: pointGroup.id,
            period_points: periodPoints,
          },
          db: trx,
        }
      );
    } else {
      userPointGroup = await strapi.entityService.create('api::user-point-group.user-point-group', {
        data: {
          user: userId,
          point_group: pointGroup.id,
          period_points: periodPoints,
        },
        db: trx,
      });
    }

    if (todayUserPointId) {
      await strapi.entityService.update('api::user-point.user-point', todayUserPointId, {
        data: {
          point_group: pointGroup.id,
        },
        db: trx,
      });
    }

    await splitPointGroupIfNeeded({
      pointGroup,
      groupRankId: targetGroupRank.id,
      groupSize,
      recordDate,
    }, trx);

    return {
      ...userPointGroup,
      point_group: pointGroup,
    };
  };

  const syncHonorTitle = async ({ userId, totalPoints, forceRecalculate = false }, trx) => {
    if (!userId || totalPoints === null || totalPoints === undefined) {
      return null;
    }

    const user = await strapi.entityService.findOne('plugin::users-permissions.user', userId, {
      populate: {
        honor_title: true,
      },
      db: trx,
    });

    if (!user) {
      return null;
    }

    const [rule, titles] = await Promise.all([
      getHonorTitleRule(),
      getHonorTitles(),
    ]);

    if (!rule || !titles.length) {
      return null;
    }

    const currentLevel = getHonorLevelByTitleId({
      titles,
      titleId: user.honor_title?.id,
    });

    if (!forceRecalculate && user.honor_title) {
      return {
        title: user.honor_title,
        level: currentLevel,
        previousLevel: currentLevel,
        changed: false,
      };
    }

    let matchedTitle = null;
    let matchedLevel = 0;

    titles.forEach((title, index) => {
      const level = index + 1;
      const threshold = getHonorThreshold({
        basePoints: rule.base_points,
        increasePoints: rule.increase_points,
        level,
      });

      if (totalPoints >= threshold) {
        matchedTitle = title;
        matchedLevel = level;
      }
    });

    if (!matchedTitle) {
      return {
        title: null,
        level: 0,
        previousLevel: currentLevel,
        changed: false,
      };
    }

    if (user.honor_title?.id === matchedTitle.id) {
      return {
        title: user.honor_title,
        level: matchedLevel,
        previousLevel: currentLevel,
        changed: false,
      };
    }

    await strapi.entityService.update('plugin::users-permissions.user', userId, {
      data: {
        honor_title: matchedTitle.id,
      },
      db: trx,
    });

    return {
      title: matchedTitle,
      level: matchedLevel,
      previousLevel: currentLevel,
      changed: true,
    };
  };

  const findUserPointByDate = async (userId, recordDate, trx) => {
    const records = await strapi.entityService.findMany('api::user-point.user-point', {
      filters: {
        user: userId,
        record_date: recordDate,
      },
      populate: {
        point_group: true,
      },
      sort: ['id:desc'],
      limit: 1,
      db: trx,
    });

    return records[0] || null;
  };

  const findLatestUserPointBeforeDate = async (userId, beforeDate, trx) => {
    const records = await strapi.entityService.findMany('api::user-point.user-point', {
      filters: {
        user: userId,
        record_date: {
          $lt: beforeDate,
        },
      },
      populate: {
        point_group: true,
      },
      sort: ['record_date:desc', 'id:desc'],
      limit: 1,
      db: trx,
    });

    return records[0] || null;
  };

  const findCurrentUserPointGroup = async (userId, trx) => {
    const records = await strapi.entityService.findMany('api::user-point-group.user-point-group', {
      filters: {
        user: userId,
      },
      populate: {
        point_group: {
          populate: {
            group_rank: true,
          },
        },
      },
      sort: ['id:desc'],
      limit: 1,
      db: trx,
    });

    return records[0] || null;
  };

  const buildUserPointCreateData = ({
    userId,
    recordDate,
    snapshot,
    pointGroupId,
    deltaPoints = 0,
    deltaWords = 0,
    deltaArticles = 0,
  }) => {
    const data = {
      user: userId,
      record_date: recordDate,
      points: (snapshot?.points ?? 0) + deltaPoints,
      points_add: deltaPoints,
      word_count: (snapshot?.word_count ?? 0) + deltaWords,
      word_add: deltaWords,
      article_count: (snapshot?.article_count ?? 0) + deltaArticles,
      article_add: deltaArticles,
      group_rank_change: snapshot?.group_rank_change ?? 0,
      rank: snapshot?.rank ?? 0,
      rank_change: snapshot?.rank_change ?? 0,
    };

    if (pointGroupId) {
      data.point_group = pointGroupId;
    }

    return data;
  };

  const ensurePreviousDayRecord = async ({ userId, recordDate, todayRecord, currentPointGroupId, trx }) => {
    const previousDate = addDays(recordDate, -1);
    const previousRecord = await findUserPointByDate(userId, previousDate, trx);

    if (previousRecord) {
      return previousRecord;
    }

    let snapshot;

    if (todayRecord) {
      snapshot = snapshotBeforeTodayFromRecord(todayRecord);
    } else {
      const latestBeforeToday = await findLatestUserPointBeforeDate(userId, recordDate, trx);
      snapshot = latestBeforeToday ? snapshotFromRecord(latestBeforeToday) : getDefaultSnapshot();
    }

    const createdRecord = await strapi.entityService.create('api::user-point.user-point', {
      data: buildUserPointCreateData({
        userId,
        recordDate: previousDate,
        snapshot,
        pointGroupId: currentPointGroupId || snapshot.point_group_id,
        deltaPoints: 0,
      }),
      db: trx,
    });

    if (!currentPointGroupId && snapshot.point_group_id) {
      createdRecord.point_group = { id: snapshot.point_group_id };
    }

    return createdRecord;
  };

  const calculatePoints = async (event) => {
    const rule = await getPointRule();
    const review = event?.review || {};
    const basePoints = rule.review_point ?? 0;
    const tierUpPoints = getTierRank(review.newlevel) > getTierRank(review.level)
      ? (rule.review_tier_up_point ?? 0)
      : 0;

    return basePoints + tierUpPoints;
  };

  const calculateWordDefinitionPoints = async () => {
    const rule = await getPointRule();
    return rule.new_word_point ?? 0;
  };

  const calculateArticlePoints = async () => {
    const rule = await getPointRule();
    return rule.article_point ?? 0;
  };

  const applyDelta = async ({
    userId,
    reviewedAt,
    deltaPoints = 0,
    deltaWords = 0,
    deltaArticles = 0,
  }, trx) => {
    if (!userId || !reviewedAt) {
      return null;
    }

    const recordDate = getRecordDate(reviewedAt);
    const todayRecord = await findUserPointByDate(userId, recordDate, trx);
    const currentUserPointGroup = await findCurrentUserPointGroup(userId, trx);
    const currentPointGroupId = getPointGroupId(currentUserPointGroup);

    const previousRecord = await ensurePreviousDayRecord({
      userId,
      recordDate,
      todayRecord,
      currentPointGroupId,
      trx,
    });

    if (todayRecord) {
      const data = {
        points: (todayRecord.points ?? 0) + deltaPoints,
        points_add: (todayRecord.points_add ?? 0) + deltaPoints,
        word_count: (todayRecord.word_count ?? 0) + deltaWords,
        word_add: (todayRecord.word_add ?? 0) + deltaWords,
        article_count: (todayRecord.article_count ?? 0) + deltaArticles,
        article_add: (todayRecord.article_add ?? 0) + deltaArticles,
      };

      if (currentPointGroupId && !getPointGroupId(todayRecord)) {
        data.point_group = currentPointGroupId;
      }

      const updatedRecord = await strapi.entityService.update(
        'api::user-point.user-point',
        todayRecord.id,
        {
          data,
          db: trx,
        }
      );

      return updatedRecord;
    }

    const baseSnapshot = previousRecord
      ? snapshotFromRecord(previousRecord)
      : getDefaultSnapshot();

    const createdRecord = await strapi.entityService.create('api::user-point.user-point', {
      data: buildUserPointCreateData({
        userId,
        recordDate,
        snapshot: baseSnapshot,
        pointGroupId: currentPointGroupId || baseSnapshot.point_group_id,
        deltaPoints,
        deltaWords,
        deltaArticles,
      }),
      db: trx,
    });

    const honorTitleResult = await syncHonorTitle({
      userId,
      totalPoints: createdRecord.points,
      forceRecalculate: true,
    }, trx);

    if (honorTitleResult) {
      await strapi.entityService.update('api::user-point.user-point', createdRecord.id, {
        data: {
          rank: honorTitleResult.level ?? 0,
          rank_change: (honorTitleResult.level ?? 0) - (honorTitleResult.previousLevel ?? 0),
        },
        db: trx,
      });
    }

    await syncUserPointGroupAssignment({
      userId,
      recordDate,
      todayUserPointId: createdRecord.id,
    }, trx);

    return createdRecord;
  };

  const applyPoints = async ({ userId, delta, reviewedAt }, trx) => {
    return applyDelta({
      userId,
      reviewedAt,
      deltaPoints: delta,
    }, trx);
  };

  const applyReviewEvent = async (event, trx) => {
    const review = event?.review;

    if (!review?.userId || !review?.reviewedAt) {
      return null;
    }

    const pointsAwarded = await calculatePoints(event);
    const userPoint = await applyDelta({
      userId: review.userId,
      reviewedAt: review.reviewedAt,
      deltaPoints: pointsAwarded,
    }, trx);

    return {
      pointsAwarded,
      userPoint,
    };
  };

  const applyWordDefinitionCreatedEvent = async (event, trx) => {
    const payload = event?.wordDefinition;

    if (!payload?.userId || !payload?.createdAt) {
      return null;
    }

    const pointsAwarded = await calculateWordDefinitionPoints(event);
    const userPoint = await applyDelta({
      userId: payload.userId,
      reviewedAt: payload.createdAt,
      deltaPoints: pointsAwarded,
      deltaWords: 1,
    }, trx);

    return {
      pointsAwarded,
      userPoint,
    };
  };

  const applyArticleCreatedEvent = async (event, trx) => {
    const payload = event?.article;

    if (!payload?.userId || !payload?.createdAt) {
      return null;
    }

    const pointsAwarded = await calculateArticlePoints(event);
    const userPoint = await applyDelta({
      userId: payload.userId,
      reviewedAt: payload.createdAt,
      deltaPoints: pointsAwarded,
      deltaArticles: 1,
    }, trx);

    return {
      pointsAwarded,
      userPoint,
    };
  };

  return {
    getRecordDate,
    getPointRule,
    getHonorTitleRule,
    getHonorTitles,
    getPointGroupRule,
    getGroupRanks,
    calculatePeriodPoints,
    splitPointGroupIfNeeded,
    syncUserPointGroupAssignment,
    syncHonorTitle,
    calculatePoints,
    calculateWordDefinitionPoints,
    calculateArticlePoints,
    applyDelta,
    applyPoints,
    applyReviewEvent,
    applyWordDefinitionCreatedEvent,
    applyArticleCreatedEvent,
  };
};

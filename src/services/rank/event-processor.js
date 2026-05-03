'use strict';

module.exports = ({ strapi }) => {
  const rules = () => strapi.service('rank-rule-loader');
  const snapshots = () => strapi.service('rank-snapshot');
  const levels = () => strapi.service('rank-level');
  const groups = () => strapi.service('rank-group');

  const buildEventPayload = (eventData) => ({
    event_id: eventData.event_id || null,
    event_name: eventData.event_name,
    userid: String(eventData.userid),
    username: eventData.username || null,
    ...(eventData.flashcard_id ? { flashcard_id: eventData.flashcard_id } : {}),
    ...(eventData.article_id ? { article_id: eventData.article_id } : {}),
    ...(eventData.review ? { review: eventData.review } : {}),
    ...(eventData.article ? { article: eventData.article } : {}),
    ...(eventData.flashcard ? { flashcard: eventData.flashcard } : {}),
    ...(eventData.payload || {}),
  });

  const serializeHandleResult = (value) => {
    if (value == null) return '';
    if (typeof value === 'string') return value;
    try {
      return JSON.stringify(value);
    } catch (error) {
      return String(value);
    }
  };

  const logEvent = async (eventData) =>
    strapi.entityService.create('api::rs-event.rs-event', {
      data: {
        event_id: eventData.event_id || null,
        event_name: eventData.event_name,
        userid: String(eventData.userid),
        username: eventData.username || null,
        payload: buildEventPayload(eventData),
        status: 'processing',
      },
    });

  const markHandled = (id, result) =>
    strapi.entityService.update('api::rs-event.rs-event', id, {
      data: {
        status: 'handled',
        handled_at: new Date().toISOString(),
        handle_result: serializeHandleResult(result || { handled: true }),
      },
    });

  const markFailed = (id, error) =>
    strapi.entityService.update('api::rs-event.rs-event', id, {
      data: {
        status: 'failed',
        handle_result: error.message,
      },
    });

  const extractUsername = async (eventData) => {
    const fromPayload =
      eventData.username ||
      eventData.payload?.username ||
      eventData.payload?.review?.username ||
      eventData.payload?.article?.username ||
      null;

    if (fromPayload) return fromPayload;

    const numericId = Number(eventData.userid);
    if (!Number.isInteger(numericId)) return null;

    try {
      const user = await strapi.entityService.findOne('plugin::users-permissions.user', numericId, {
        fields: ['username'],
      });
      return user?.username || null;
    } catch (error) {
      strapi.log.warn?.(`[Rank] Unable to resolve username for user ${eventData.userid}: ${error.message}`);
      return null;
    }
  };

  const getEventCounters = (eventName, payload = {}) => {
    const payloadWordCount = Number(payload.word_count || 0);
    const payloadArticleCount = Number(payload.article_count || 0);

    if (payloadWordCount || payloadArticleCount) {
      return {
        wordCount: payloadWordCount,
        articleCount: payloadArticleCount,
      };
    }

    if (eventName === 'flashcard.create') {
      return { wordCount: 1, articleCount: 0 };
    }
    if (eventName === 'article.create') {
      return { wordCount: 0, articleCount: 1 };
    }
    return { wordCount: 0, articleCount: 0 };
  };

  return {
    async processEvent(eventData) {
      const username = await extractUsername(eventData);
      const eventRecord = await logEvent({ ...eventData, username });

      try {
        const [groupRule, levelRule, pointRule] = await Promise.all([
          rules().loadGroupRule(),
          rules().loadLevelRule(),
          rules().loadPointRule(eventData.event_name),
        ]);

        if (!groupRule) throw new Error('No rs_group_rule configured');
        if (!levelRule) throw new Error('No rs_level_rule configured');

        const groupRanks = await rules().loadGroupRanks(groupRule.id);
        if (!groupRanks.length) throw new Error('No rs_group_rank records configured');

        const snapshot = await snapshots().ensureTodaySnapshot(eventData.userid, username);
        const eventPoints = pointRule?.points || 0;
        const counters = getEventCounters(eventData.event_name, eventData.payload);

        const nextTotalPoints = (snapshot.total_points || 0) + eventPoints;
        const nextPointsAdd = (snapshot.points_add || 0) + eventPoints;
        const nextWordCount = (snapshot.word_count || 0) + counters.wordCount;
        const nextWordAdd = (snapshot.word_add || 0) + counters.wordCount;
        const nextArticleCount = (snapshot.article_count || 0) + counters.articleCount;
        const nextArticleAdd = (snapshot.article_add || 0) + counters.articleCount;

        const currentLevelNo = snapshot.rs_level?.level_no || 1;
        const nextLevelNo = levels().calculateLevel(nextTotalPoints, currentLevelNo, levelRule);
        const levelChange = nextLevelNo - currentLevelNo;
        const levelRecord = await rules().findOrCreateLevel(nextLevelNo);
        const levelTitle = await rules().findLevelTitle(levelRecord.id, 'en');

        const previousSnapshot = await snapshots().getPreviousSnapshot(eventData.userid);
        const priorPeriodPoints = previousSnapshot?.period_points || 0;
        const periodPointsBase = await snapshots().getPeriodPoints(eventData.userid, groupRule.period_days);
        const nextPeriodPoints = snapshot.record_date === snapshots().getTodayDate()
          ? periodPointsBase + eventPoints
          : periodPointsBase;
        const periodPointsChange = nextPeriodPoints - priorPeriodPoints;
        const nextGroupRank = groups().getGroupRankForPoints(nextPeriodPoints, groupRanks);
        const currentGroupRankNo = snapshot.rs_group_rank?.rank_no || 0;
        const groupRankChange = nextGroupRank.rank_no - currentGroupRankNo;
        const groupRankTitle = await rules().findGroupRankTitle(nextGroupRank.id, 'en');

        const assignment = await groups().assignUserToRankedGroup(
          eventData.userid,
          username,
          groupRule.id,
          nextGroupRank.id,
          groupRule.group_size,
          nextPeriodPoints,
          groupRankTitle
        );

        await snapshots().updateSnapshot(snapshot.id, {
          username: username || snapshot.username || null,
          total_points: nextTotalPoints,
          points_add: nextPointsAdd,
          word_count: nextWordCount,
          word_add: nextWordAdd,
          article_count: nextArticleCount,
          article_add: nextArticleAdd,
          rs_level: levelRecord.id,
          level_title: levelTitle,
          level_change: levelChange,
          rs_group_rank: nextGroupRank.id,
          rs_group: assignment.group?.id || null,
          group_rank_title: groupRankTitle,
          group_rank_change: groupRankChange,
          period_points: nextPeriodPoints,
          period_points_change: periodPointsChange,
        });

        const result = {
          userid: String(eventData.userid),
          username: username || null,
          totalPoints: nextTotalPoints,
          pointsAdd: nextPointsAdd,
          wordCount: nextWordCount,
          articleCount: nextArticleCount,
          level: nextLevelNo,
          levelChange,
          groupRankNo: nextGroupRank.rank_no,
          groupRankChange,
          periodPoints: nextPeriodPoints,
          periodPointsChange,
        };
        await markHandled(eventRecord.id, result);
        return result;
      } catch (error) {
        strapi.log.error(`[Rank] Failed to process "${eventData.event_name}" for "${eventData.userid}": ${error.message}`);
        await markFailed(eventRecord.id, error);
        throw error;
      }
    },
  };
};

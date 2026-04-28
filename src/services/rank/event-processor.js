'use strict';

module.exports = ({ strapi }) => {
  const rules = () => strapi.service('rank-rule-loader');
  const snapshots = () => strapi.service('rank-snapshot');
  const levels = () => strapi.service('rank-level');
  const groups = () => strapi.service('rank-group');

  const logEvent = async (eventData) =>
    strapi.entityService.create('api::rs-event.rs-event', {
      data: {
        event_id: eventData.event_id || null,
        event_name: eventData.event_name,
        userid: eventData.userid,
        payload: eventData.payload || {},
        status: 'processing',
      },
    });

  const markHandled = (id) =>
    strapi.entityService.update('api::rs-event.rs-event', id, {
      data: { status: 'handled', handled_at: new Date().toISOString() },
    });

  const markFailed = (id, error) =>
    strapi.entityService.update('api::rs-event.rs-event', id, {
      data: { status: 'failed', payload: { error: error.message } },
    });

  const isDuplicate = async (eventId) => {
    if (!eventId) return false;
    const found = await strapi.entityService.findMany('api::rs-event.rs-event', {
      filters: { event_id: eventId, status: { $in: ['handled', 'processing'] } },
      limit: 1,
    });
    return found.length > 0;
  };

  const registerUser = async (userid, groupRule, groupRanks) => {
    const lowestRank = groupRanks[groupRanks.length - 1];
    const level1 = await rules().findOrCreateLevel(1);
    const group = await groups().assignUserToRankedGroup(
      userid, groupRule.id, lowestRank.id, groupRule.group_size
    );
    return snapshots().createInitialSnapshot(userid, group.id, lowestRank.id, level1.id);
  };

  const applyDelta = (snapshot, eventName, points) => {
    const delta = {
      points_add: (snapshot.points_add || 0) + points,
      word_count: snapshot.word_count || 0,
      word_add: snapshot.word_add || 0,
      article_count: snapshot.article_count || 0,
      article_add: snapshot.article_add || 0,
    };
    if (eventName === 'flashcard.create') { delta.word_count += 1; delta.word_add += 1; }
    else if (eventName === 'article.create') { delta.article_count += 1; delta.article_add += 1; }
    return delta;
  };

  return {
    async processEvent(eventData) {
      const { event_id, event_name, userid } = eventData;

      if (await isDuplicate(event_id)) {
        strapi.log.info(`[Rank] Skipping duplicate event: ${event_id}`);
        return { duplicate: true };
      }

      const eventRecord = await logEvent(eventData);

      try {
        const groupRule = await rules().loadGroupRule();
        if (!groupRule) throw new Error('No rs_group_rule configured');

        const groupRanks = await rules().loadGroupRanks(groupRule.id);
        if (!groupRanks.length) throw new Error('No rs_group_rank records configured');

        if (event_name === 'user.register') {
          if (await snapshots().userExists(userid)) {
            await markHandled(eventRecord.id);
            return { skipped: true, reason: 'already_registered' };
          }
          await registerUser(userid, groupRule, groupRanks);
          await markHandled(eventRecord.id);
          return { registered: true };
        }

        const levelRule = await rules().loadLevelRule();
        if (!levelRule) throw new Error('No rs_level_rule configured');

        // Auto-register user if first event arrives without a prior user.register
        if (!(await snapshots().userExists(userid))) {
          await registerUser(userid, groupRule, groupRanks);
        }

        const pointRule = await rules().loadPointRule(event_name);
        const eventPoints = pointRule?.points || 0;

        // Load or create today's snapshot
        let snapshot = await snapshots().getTodaySnapshot(userid);
        if (!snapshot) {
          const previous = await snapshots().getLatestSnapshot(userid);
          snapshot = previous
            ? await snapshots().createFromPrevious(userid, previous)
            : await snapshots().createInitialSnapshot(
                userid, null, groupRanks[groupRanks.length - 1].id,
                (await rules().findOrCreateLevel(1)).id
              );
        }

        const delta = applyDelta(snapshot, event_name, eventPoints);
        const totalPoints = (snapshot.total_points || 0) + eventPoints;

        // Level recalculation
        const currentLevelNo = snapshot.rs_level?.level_no || 1;
        const newLevelNo = levels().calculateLevel(totalPoints, currentLevelNo, levelRule);
        const levelChange = newLevelNo - currentLevelNo;

        // Group rank recalculation
        const periodPointsBase = await snapshots().getPeriodPoints(userid, groupRule.period_days);
        const newGroupRank = groups().getGroupRankForPoints(periodPointsBase + eventPoints, groupRanks);
        const groupRankChange = newGroupRank.rank_no - (snapshot.rs_group_rank?.rank_no || 0);

        // Reassign group when rank changes
        let newGroupId = snapshot.rs_group?.id || null;
        if (newGroupRank.id !== snapshot.rs_group_rank?.id) {
          const newGroup = await groups().assignUserToRankedGroup(
            userid, groupRule.id, newGroupRank.id, groupRule.group_size
          );
          newGroupId = newGroup.id;
        }

        const levelRecord = await rules().findOrCreateLevel(newLevelNo);

        await snapshots().updateSnapshot(snapshot.id, {
          ...delta,
          total_points: totalPoints,
          level_change: levelChange,
          group_rank_change: groupRankChange,
          rs_level: levelRecord.id,
          rs_group: newGroupId,
          rs_group_rank: newGroupRank.id,
        });

        await markHandled(eventRecord.id);
        return { userid, totalPoints, level: newLevelNo, levelChange, groupRankNo: newGroupRank.rank_no, groupRankChange };

      } catch (error) {
        strapi.log.error(`[Rank] Failed to process "${event_name}" for "${userid}": ${error.message}`);
        await markFailed(eventRecord.id, error);
        throw error;
      }
    },
  };
};

'use strict';

module.exports = ({ strapi }) => ({
  pointsRequired(levelNo, levelRule) {
    return levelRule.base_points + levelRule.increase_points * (levelNo - 1);
  },

  calculateLevel(totalPoints, currentLevel, levelRule) {
    let level = currentLevel;
    while (totalPoints >= this.pointsRequired(level + 1, levelRule)) {
      level++;
    }
    return level;
  },
});

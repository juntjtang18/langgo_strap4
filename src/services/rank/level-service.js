'use strict';

module.exports = ({ strapi }) => ({
  pointsRequiredForNextLevel(currentLevelNo, levelRule) {
    return levelRule.base_points + levelRule.increase_points * (currentLevelNo - 1);
  },

  calculateLevel(totalPoints, currentLevel, levelRule) {
    let level = currentLevel || 1;
    while (totalPoints > this.pointsRequiredForNextLevel(level, levelRule)) {
      level++;
    }
    return level;
  },
});

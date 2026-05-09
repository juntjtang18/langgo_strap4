'use strict';

const USER_PROFILE_UID = 'api::user-profile.user-profile';

async function loadProfileWithUser(id) {
  if (!id) return null;

  return strapi.entityService.findOne(USER_PROFILE_UID, id, {
    populate: {
      user: {
        fields: ['id', 'username', 'email'],
      },
    },
  });
}

module.exports = {
  async beforeUpdate(event) {
    const id = event.params?.where?.id;
    if (!id) return;

    event.state = event.state || {};
    event.state.before = await loadProfileWithUser(id);
  },

  async afterUpdate(event) {
    const before = event.state?.before;
    const profileId = event.result?.id;
    if (!before || !profileId) return;

    const after = await loadProfileWithUser(profileId);
    if (!after?.user?.id) return;

    if (before.visible_on_ladder === after.visible_on_ladder) {
      return;
    }

    strapi
      .plugin('event-bus')
      .service('event-bus')
      .publish(
        'user.profile.update',
        {
          userId: after.user.id,
          username: after.user.username || after.user.email || null,
          visible_on_ladder: after.visible_on_ladder !== false,
        },
        {
          source: 'user-profile.lifecycle',
          metadata: {
            publisher: 'api::user-profile.user-profile.afterUpdate',
            profileId,
          },
        }
      );
  },
};

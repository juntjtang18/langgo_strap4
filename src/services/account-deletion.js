'use strict';

const { ValidationError } = require('@strapi/utils').errors;

const DELETION_TARGETS = [
  ['api::reviewlog.reviewlog', 'user'],
  ['api::flashcard.flashcard', 'user'],
  ['api::user-word.user-word', 'user'],
  ['api::user-sentence.user-sentence', 'user'],
  ['api::story-like.story-like', 'user'],
  ['api::conversation.conversation', 'user'],
  ['api::user-article.user-article', 'user'],
  ['api::article-tag.article-tag', 'user'],
  ['api::word-definition.word-definition', 'owner'],
  ['api::vbsetting.vbsetting', 'user'],
  ['api::user-profile.user-profile', 'user'],
];

module.exports = ({ strapi }) => {
  const getAuthenticatedUser = async (ctx) => {
    if (ctx.state.user?.id) {
      return ctx.state.user;
    }

    try {
      const jwtService = strapi.plugin('users-permissions').service('jwt');
      const token = await jwtService.getToken(ctx);

      if (!token?.id) {
        return null;
      }

      return await strapi.query('plugin::users-permissions.user').findOne({
        where: { id: token.id },
      });
    } catch (_) {
      return null;
    }
  };

  const deleteOwnedEntriesInBatches = async (uid, relationField, userId, batchSize = 200) => {
    if (!strapi.contentType(uid)) {
      return 0;
    }

    let deletedCount = 0;

    while (true) {
      const entries = await strapi.entityService.findMany(uid, {
        filters: { [relationField]: userId },
        fields: ['id'],
        limit: batchSize,
      });

      if (!entries.length) {
        break;
      }

      await Promise.all(entries.map((entry) => strapi.entityService.delete(uid, entry.id)));
      deletedCount += entries.length;
    }

    return deletedCount;
  };

  const deleteUserOwnedContent = async (userId) => {
    const summary = {};

    for (const [uid, relationField] of DELETION_TARGETS) {
      const deletedCount = await deleteOwnedEntriesInBatches(uid, relationField, userId);
      if (deletedCount > 0) {
        summary[uid] = deletedCount;
      }
    }

    return summary;
  };

  const deleteMyAccount = async (ctx) => {
    const authUser = await getAuthenticatedUser(ctx);

    if (!authUser) {
      return ctx.unauthorized('You must be logged in to perform this action.');
    }

    const password =
      ctx.request.body?.password ||
      ctx.request.header['x-account-delete-password'] ||
      ctx.request.header['x-current-password'] ||
      null;

    if (!password) {
      throw new ValidationError('Current password is required to delete the account.');
    }

    const userService = strapi.plugin('users-permissions').service('user');
    const rawUser = await strapi.query('plugin::users-permissions.user').findOne({
      where: { id: authUser.id },
      populate: {
        user_profile: {
          populate: {
            avatar_img: true,
          },
        },
      },
    });

    if (!rawUser) {
      return ctx.notFound('User not found.');
    }

    if (rawUser.provider === 'local') {
      const passwordIsValid = await userService.validatePassword(password, rawUser.password);

      if (!passwordIsValid) {
        return ctx.badRequest('Current password is incorrect.');
      }
    }

    const avatarFile = rawUser.user_profile?.avatar_img || null;
    const deletionSummary = await deleteUserOwnedContent(authUser.id);

    await userService.remove({ id: authUser.id });

    if (avatarFile) {
      try {
        await strapi.plugin('upload').service('upload').remove(avatarFile);
      } catch (error) {
        strapi.log.warn(
          `Failed to delete avatar media ${avatarFile.id} during account deletion: ${error.message}`
        );
      }
    }

    return ctx.send({
      ok: true,
      deletedUserId: authUser.id,
      deletionSummary,
    });
  };

  return {
    deleteMyAccount,
  };
};

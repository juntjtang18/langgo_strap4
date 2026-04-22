'use strict';

const { createCoreController } = require('@strapi/strapi').factories;
const utils = require('@strapi/utils');
const { sanitize } = utils;
const { ApplicationError, ValidationError } = utils.errors;
const {
  buildUserProfilePopulate,
  formatUserProfile,
  pickUserProfileData,
} = require('../../../utils/user-profile');

// A helper function to sanitize the output user data
const sanitizeUser = (strapi, user, ctx) => {
  const { auth } = ctx.state;
  const userSchema = strapi.getModel('plugin::users-permissions.user');
  return sanitize.contentAPI.output(user, userSchema, { auth });
};

module.exports = createCoreController(
  'api::user-profile.user-profile',
  ({ strapi }) => ({

    // --- CUSTOM REGISTRATION ---
    /**
     * Custom registration controller that creates a user, their profile,
     * and a default vbsetting in one atomic transaction.
     */
    async registerWithProfile(ctx) {
      const pluginStore = await strapi.store({
        type: 'plugin',
        name: 'users-permissions',
      });

      const { email, username, password, ...profileInput } = ctx.request.body;
      const profileData = pickUserProfileData(strapi, profileInput);
      const { baseLanguage } = profileData;
      if (!email || !password || !baseLanguage) {
        throw new ValidationError('Missing required fields: email, password, and baseLanguage are required.');
      }
      const finalUsername = username || email;

      const settings = await pluginStore.get({ key: 'advanced' });
      if (settings.allow_register !== true) {
        throw new ApplicationError('Register action is currently disabled');
      }

      const newUser = {
        email: email.toLowerCase(),
        username: finalUsername,
        password,
        provider: 'local',
      };

      try {
        // All creations happen inside one transaction
        const user = await strapi.db.transaction(async ({ trx }) => {
          // 1) Create the User
          const createdUser = await strapi
            .plugin('users-permissions')
            .service('user')
            .add(newUser);

          // 2) Create the User Profile
          await strapi.entityService.create('api::user-profile.user-profile', {
            data: {
              ...profileData,
              user: createdUser.id,
            },
            db: trx,
          });

          // 3) Create the VBSetting with defaults (we only set user → others use schema defaults)
          await strapi.entityService.create('api::vbsetting.vbsetting', {
            data: {
              user: createdUser.id,
            },
            db: trx,
          });

          return createdUser;
        });

        // Issue JWT and sanitize response
        const jwt = strapi.plugin('users-permissions').service('jwt').issue({ id: user.id });
        const userWithDetails = await strapi.entityService.findOne(
          'plugin::users-permissions.user',
          user.id,
          {
            populate: {
              user_profile: {
                populate: buildUserProfilePopulate(strapi),
              },
            },
          }
        );
        const sanitized = await sanitizeUser(strapi, userWithDetails, ctx);
        sanitized.user_profile = formatUserProfile(strapi, userWithDetails.user_profile);
        return ctx.send({ jwt, user: sanitized });

      } catch (error) {
        // Duplicate key (email/username) handling
        if (error.code === '23505' || (error.message && error.message.includes('Duplicate entry'))) {
          throw new ApplicationError('Email or Username are already taken');
        }
        strapi.log.error('Custom registration error:', error);
        throw new ApplicationError('An error occurred during registration.');
      }
    },

    // --- CUSTOM PROFILE MANAGEMENT ---
    /**
     * Finds the profile for the currently authenticated user.
     */
    async findMine(ctx) {
      if (!ctx.state.user) {
        return ctx.unauthorized('You must be logged in to perform this action.');
      }
      const { id: userId } = ctx.state.user;

      const profiles = await strapi.entityService.findMany('api::user-profile.user-profile', {
        filters: { user: userId },
        populate: buildUserProfilePopulate(strapi),
      });

      if (profiles.length === 0) {
        return ctx.notFound('No user profile found for the current user.');
      }

      return this.transformResponse(profiles[0]);
    },

    /**
     * Updates the profile for the currently authenticated user.
     */
    async updateMine(ctx) {
      if (!ctx.state.user) {
        return ctx.unauthorized('You must be logged in to perform this action.');
      }
      const { id: userId } = ctx.state.user;
      const data = pickUserProfileData(strapi, ctx.request.body?.data || {});

      const profiles = await strapi.entityService.findMany('api::user-profile.user-profile', {
        filters: { user: userId },
      });

      if (profiles.length === 0) {
        return ctx.notFound('No user profile found for the current user to update.');
      }
      const profileId = profiles[0].id;

      const updatedProfile = await strapi.entityService.update(
        'api::user-profile.user-profile',
        profileId,
        { data }
      );

      const populatedProfile = await strapi.entityService.findOne(
        'api::user-profile.user-profile',
        updatedProfile.id,
        {
          populate: buildUserProfilePopulate(strapi),
        }
      );

      return this.transformResponse(populatedProfile);
    },

    /**
     * Uploads and sets the avatar image for the currently authenticated user.
     */
    async uploadMyAvatar(ctx) {
      if (!ctx.state.user) {
        return ctx.unauthorized('You must be logged in to perform this action.');
      }

      const { id: userId } = ctx.state.user;
      const avatarFile = ctx.request.files?.avatar;

      if (!avatarFile) {
        throw new ValidationError('Missing avatar file.');
      }

      const profiles = await strapi.entityService.findMany('api::user-profile.user-profile', {
        filters: { user: userId },
      });

      if (profiles.length === 0) {
        return ctx.notFound('No user profile found for the current user to update.');
      }

      const uploadedFiles = await strapi.plugin('upload').service('upload').upload({
        data: {
          fileInfo: {
            name: avatarFile.name || `avatar-${userId}`,
            alternativeText: `avatar-${userId}`,
          },
        },
        files: avatarFile,
      });

      if (!uploadedFiles || uploadedFiles.length === 0) {
        throw new ApplicationError('Avatar upload failed.');
      }

      const uploadedAvatar = uploadedFiles[0];
      const profileId = profiles[0].id;

      await strapi.entityService.update('api::user-profile.user-profile', profileId, {
        data: {
          avatar_img: uploadedAvatar.id,
        },
      });

      const populatedProfile = await strapi.entityService.findOne(
        'api::user-profile.user-profile',
        profileId,
        {
          populate: buildUserProfilePopulate(strapi),
        }
      );

      return this.transformResponse(populatedProfile);
    },

  })
);

'use strict';

const { createCoreController } = require('@strapi/strapi').factories;
const utils = require('@strapi/utils');
const { sanitize } = utils;
const { ApplicationError, ValidationError } = utils.errors;

// A helper function to sanitize the output user data
const sanitizeUser = (user, ctx) => {
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

      const { email, username, password, baseLanguage } = ctx.request.body;
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
              baseLanguage,
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
        const sanitized = await sanitizeUser(user, ctx);
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
        populate: '*',
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
      const { data } = ctx.request.body;

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

      return this.transformResponse(updatedProfile);
    },

  })
);

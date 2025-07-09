// Path: src/extensions/users-permissions/strapi-server.js

// Import necessary utilities from Strapi
const { ApplicationError } = require('@strapi/utils').errors;
const { sanitize } = require('@strapi/utils');

module.exports = (plugin) => {
  // =================================================================
  // 1. CUSTOMIZATION FOR THE 'ME' ENDPOINT
  // =================================================================
  plugin.controllers.user.me = async (ctx) => {
    if (!ctx.state.user || !ctx.state.user.id) {
      ctx.response.status = 401;
      return;
    }

    const populate = {
      role: true,
      // add other relations here if needed
    };

    const user = await strapi.entityService.findOne(
      'plugin::users-permissions.user',
      ctx.state.user.id,
      { populate }
    );

    if (!user) {
      return ctx.notFound();
    }

    const cleanRole = user.role
      ? (({ id, name, description, type }) => ({ id, name, description, type }))(user.role)
      : null;

    ctx.body = {
      id: user.id,
      username: user.username,
      email: user.email,
      confirmed: user.confirmed,
      blocked: user.blocked,
      role: cleanRole,
    };
  };

  // =================================================================
  // 2. CUSTOMIZATION FOR THE 'REGISTER' ENDPOINT
  // =================================================================
  plugin.controllers.auth.register = async (ctx) => {
    const userService    = strapi.plugin('users-permissions').service('user');
    const jwtService     = strapi.plugin('users-permissions').service('jwt');
    const pluginStore    = await strapi.store({ type: 'plugin', name: 'users-permissions' });
    const settings       = await pluginStore.get({ key: 'advanced' });

    if (!settings.allow_register) {
      throw new ApplicationError('Register action is currently disabled');
    }

    const { email, username, password, baseLanguage, telephone } = ctx.request.body;
    if (!username || !email || !password || !baseLanguage) {
      throw new ApplicationError(
        'Username, email, password and baseLanguage are all required.'
      );
    }

    // Find default role
    const role = await strapi
      .query('plugin::users-permissions.role')
      .findOne({ where: { type: settings.default_role } });
    if (!role) {
      throw new ApplicationError('Impossible to find the default role.');
    }

    // Check email uniqueness
    const existing = await strapi
      .query('plugin::users-permissions.user')
      .findOne({ where: { email: email.toLowerCase() } });
    if (existing) {
      throw new ApplicationError('Email is already taken');
    }

    let newUser;
    try {
      // 1) Create the Strapi user
      newUser = await userService.add({
        username,
        email: email.toLowerCase(),
        password,
        provider: 'local',
        confirmed: true,
        role: role.id,
      });
      console.log(`User ${newUser.email} (ID: ${newUser.id}) created.`);

      // 2) External subscription call (unchanged)
      const subsysBaseUrl             = process.env.SUBSYS_BASE_URL;
      const subscriptionServiceSecret = process.env.SUBSCRIPTION_SERVICE_SECRET;
      if (subsysBaseUrl && subscriptionServiceSecret) {
        try {
          const response = await fetch(
            `${subsysBaseUrl}/api/subscriptions/subscribe-free-plan`,
            {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${subscriptionServiceSecret}`,
              },
              body: JSON.stringify({ userId: newUser.id }),
            }
          );
          if (!response.ok) {
            console.error(
              `Subscription failed for user ${newUser.id} (status ${response.status})`
            );
            await userService.remove({ id: newUser.id });
            throw new ApplicationError(
              'Account could not be created due to a subscription system error.'
            );
          }
          console.log(`User ${newUser.id} subscribed to free plan.`);
        } catch (subError) {
          console.error('Subscription error:', subError);
          if (newUser && newUser.id) {
            await userService.remove({ id: newUser.id });
          }
          throw new ApplicationError(
            'Account could not be created due to a subscription system error.'
          );
        }
      } else {
        console.warn('Subscription env vars missing; skipping subscription step.');
      }

      // 3) Vocabook & Vocapage creation (non-fatal)
      try {
        const existingVocabook = await strapi.entityService.findMany(
          'api::vocabook.vocabook',
          { filters: { user: newUser.id } }
        );
        if (existingVocabook.length === 0) {
          const newVocabook = await strapi.entityService.create(
            'api::vocabook.vocabook',
            {
              data: {
                title: `${newUser.username}'s Vocab Book`,
                user: newUser.id,
              },
            }
          );
          console.log(`Vocabook ${newVocabook.id} created for user ${newUser.id}`);
          await strapi.entityService.create('api::vocapage.vocapage', {
            data: {
              title: 'Page 1',
              order: 1,
              vocabook: newVocabook.id,
            },
          });
        }
      } catch (vocabError) {
        console.error('Vocabook/Vocapage error:', vocabError);
      }

      // 4) VBSetting creation (fatal on error)
      const existingSetting = await strapi.entityService.findMany(
        'api::vbsetting.vbsetting',
        { filters: { user: newUser.id } }
      );
      if (existingSetting.length === 0) {
        await strapi.entityService.create('api::vbsetting.vbsetting', {
          data: { user: newUser.id },
        });
        console.log(`VBSetting created for user ${newUser.id}`);
      }

      // 5) UserProfile creation (fatal on error)
      await strapi.entityService.create('api::user-profile.user-profile', {
        data: {
          user: newUser.id,
          baseLanguage,
          telephone: telephone || null,
        },
      });
      console.log(`UserProfile created for user ${newUser.id}`);

      // 6) Fetch & sanitize final user
      const userWithRole = await strapi.entityService.findOne(
        'plugin::users-permissions.user',
        newUser.id,
        { populate: { role: true } }
      );
      const userSchema    = strapi.getModel('plugin::users-permissions.user');
      const sanitizedUser = await sanitize.contentAPI.output(userWithRole, userSchema);

      // 7) Respond
      ctx.send({
        jwt: jwtService.issue({ id: sanitizedUser.id }),
        user: sanitizedUser,
      });

    } catch (error) {
      console.error('Registration error:', error);

      // Roll back if user was created
      if (newUser && newUser.id) {
        try {
          await userService.remove({ id: newUser.id });
        } catch (cleanupErr) {
          console.error('Cleanup failed:', cleanupErr);
        }
      }

      if (error instanceof ApplicationError) {
        throw error;
      }
      throw new ApplicationError('An unexpected error occurred during registration.');
    }
  };

  return plugin;
};

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
      ctx.response.status = 401; // Unauthorized
      return;
    }

    const populate = {
      role: true,
      // Add other relations here if needed, e.g.:
      // user_profile: { populate: { children: true } },
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

    const { email, username, password } = ctx.request.body;
    if (!username || !email || !password) {
      throw new ApplicationError('Username, email, and password are required.');
    }

    const role = await strapi
      .query('plugin::users-permissions.role')
      .findOne({ where: { type: settings.default_role } });
    if (!role) {
      throw new ApplicationError('Impossible to find the default role.');
    }

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
      console.log(`Strapi user ${newUser.email} (ID: ${newUser.id}) created.`);

      // 2) External subscription call
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
            const errorData = await response.json();
            console.error(
              `Subscription call failed for user ${newUser.id}. Status: ${response.status}.`,
              errorData
            );
            await userService.remove({ id: newUser.id });
            throw new ApplicationError(
              'Account could not be created due to a subscription system error.'
            );
          }
          console.log(`User ${newUser.id} successfully subscribed to free plan.`);
        } catch (subError) {
          console.error('Error during subscription call:', subError);
          if (newUser && newUser.id) {
            await userService.remove({ id: newUser.id });
          }
          throw new ApplicationError(
            'Account could not be created due to a subscription system error.'
          );
        }
      } else {
        console.warn('Subscription environment variables not set. Skipping call.');
      }

      // 3) Vocabook & Vocapage creation
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
          console.log(`Vocabook created for user ${newUser.id}: ${newVocabook.id}`);

          await strapi.entityService.create('api::vocapage.vocapage', {
            data: {
              title: 'Page 1',
              order: 1,
              vocabook: newVocabook.id,
            },
          });
          console.log(`First Vocapage created for vocabook ${newVocabook.id}`);
        } else {
          console.log(`Vocabook already exists for user ${newUser.id}. Skipping creation.`);
        }
      } catch (vocabError) {
        console.error('Error creating vocabook or vocapage:', vocabError);
        // non-fatal: allow registration to proceed
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

      // 5) Fetch user with role for sanitization
      const userWithRole = await strapi.entityService.findOne(
        'plugin::users-permissions.user',
        newUser.id,
        { populate: { role: true } }
      );

      const userSchema    = strapi.getModel('plugin::users-permissions.user');
      const sanitizedUser = await sanitize.contentAPI.output(userWithRole, userSchema);

      // 6) Send response
      ctx.send({
        jwt: jwtService.issue({ id: sanitizedUser.id }),
        user: sanitizedUser,
      });

    } catch (error) {
      console.error('An error occurred during custom registration:', error);

      // Roll back the user if already created
      if (newUser && newUser.id) {
        try {
          await userService.remove({ id: newUser.id });
        } catch (cleanupErr) {
          console.error('Failed to clean up user after registration error:', cleanupErr);
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

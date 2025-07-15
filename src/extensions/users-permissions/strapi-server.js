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
      throw new ApplicationError('Username, email, password and baseLanguage are all required.');
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

      // 3) VBSetting creation (fatal on error)
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

      // 4) UserProfile creation (fatal on error)
      await strapi.entityService.create('api::user-profile.user-profile', {
        data: {
          user: newUser.id,
          baseLanguage,
          telephone: telephone || null,
        },
      });
      console.log(`UserProfile created for user ${newUser.id}`);

      // 5) Fetch & sanitize final user
      const userWithRole = await strapi.entityService.findOne(
        'plugin::users-permissions.user',
        newUser.id,
        { populate: { role: true } }
      );
      const userSchema    = strapi.getModel('plugin::users-permissions.user');
      const sanitizedUser = await sanitize.contentAPI.output(userWithRole, userSchema);

      // 6) Respond
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

  // =================================================================
  // 3. CUSTOMIZATION FOR THE 'LOGIN' ENDPOINT (/auth/local)
  // =================================================================
  // We are overriding the default 'callback' function to add our custom logic.
  const originalCallback = plugin.controllers.auth.callback;

  plugin.controllers.auth.callback = async (ctx) => {
    const provider = ctx.params.provider || 'local';

    // If the provider is not 'local', we call the original function which handles OAuth providers.
    if (provider !== 'local') {
      return originalCallback(ctx);
    }

    // --- Start of re-implemented logic for the 'local' provider ---
    const userService = strapi.plugin('users-permissions').service('user');
    const jwtService = strapi.plugin('users-permissions').service('jwt');
    const { identifier, password } = ctx.request.body;

    if (!identifier || !password) {
      throw new ApplicationError('Missing identifier or password');
    }

    // Find the user by username or email
    const user = await strapi.query('plugin::users-permissions.user').findOne({
      where: {
        provider: 'local',
        $or: [{ email: identifier.toLowerCase() }, { username: identifier }],
      },
    });

    if (!user) {
      throw new ApplicationError('Invalid identifier or password');
    }

    if (user.blocked) {
      throw new ApplicationError('Your account has been blocked by an administrator');
    }

    // The registration function sets confirmed to true, but we check anyway for safety.
    if (!user.confirmed) {
      throw new ApplicationError('Your account email is not confirmed');
    }

    const validPassword = await userService.validatePassword(password, user.password);
    if (!validPassword) {
      throw new ApplicationError('Invalid identifier or password');
    }
    
    console.log(`User ${user.email} (ID: ${user.id}) authenticated successfully.`);

    // --- START: Custom logic to ensure vbsetting and user-profile exist ---
    
    // 1) Check for and create VBSetting if it doesn't exist
    const existingSetting = await strapi.entityService.findMany('api::vbsetting.vbsetting', {
      filters: { user: user.id },
      limit: 1,
    });

    if (existingSetting.length === 0) {
      try {
        await strapi.entityService.create('api::vbsetting.vbsetting', {
          data: { user: user.id }, // Relies on default values from the schema
        });
        console.log(`VBSetting created on login for user ${user.id}`);
      } catch (err) {
        console.error(`Failed to create VBSetting for user ${user.id} on login:`, err);
        // This is treated as a non-fatal error. The user can still log in.
      }
    }

    // 2) Check for and create UserProfile if it doesn't exist
    const existingProfile = await strapi.entityService.findMany('api::user-profile.user-profile', {
      filters: { user: user.id },
      limit: 1,
    });

    if (existingProfile.length === 0) {
      try {
        // WARNING: This creates a user-profile with only the user relation.
        // The registration process requires a 'baseLanguage', which is not available here.
        // If 'baseLanguage' is a required field in your user-profile schema, this will fail.
        // This logic assumes it's not required or can be null.
        await strapi.entityService.create('api::user-profile.user-profile', {
          data: { user: user.id },
        });
        console.log(`UserProfile created on login for user ${user.id}`);
      } catch (err) {
        console.error(`Failed to create UserProfile for user ${user.id} on login:`, err);
        // Also treated as a non-fatal error.
      }
    }
    
    // --- END: Custom logic ---

    // Fetch the full user with role to sanitize and return to the client
    const userWithRole = await strapi.entityService.findOne(
      'plugin::users-permissions.user',
      user.id,
      { populate: { role: true } }
    );
    
    const userSchema = strapi.getModel('plugin::users-permissions.user');
    const sanitizedUser = await sanitize.contentAPI.output(userWithRole, userSchema);

    // Issue JWT and send the response
    ctx.send({
      jwt: jwtService.issue({ id: user.id }),
      user: sanitizedUser,
    });
  };

  return plugin;
};

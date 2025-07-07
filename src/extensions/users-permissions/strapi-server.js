// Path: src/extensions/users-permissions/strapi-server.js

// Import necessary utilities from Strapi
const { ApplicationError } = require('@strapi/utils').errors;
const { sanitize } = require('@strapi/utils');

module.exports = (plugin) => {
  // =================================================================
  // 1. CUSTOMIZATION FOR THE 'ME' ENDPOINT
  // This endpoint fetches details of the currently authenticated user.
  // =================================================================
  plugin.controllers.user.me = async (ctx) => {
    // Ensure the user is authenticated and ctx.state.user is available
    if (!ctx.state.user || !ctx.state.user.id) {
      ctx.response.status = 401; // Unauthorized
      return;
    }

    // Define the relations to populate.
    // Adjust 'user_profile' and 'children' based on your actual data model.
    const populate = {
      role: true, // Populate the user's role
      // If you have a 'user_profile' component or collection type linked to users,
      // you can populate it here. Example:
      // user_profile: {
      //   populate: {
      //     children: true, // If user_profile has a 'children' relation/component
      //   },
      // },
    };

    // Fetch the user from the database with specified relations populated
    const user = await strapi.entityService.findOne(
      "plugin::users-permissions.user",
      ctx.state.user.id,
      { populate }
    );

    // If user is not found (shouldn't happen for authenticated users, but good practice)
    if (!user) {
      return ctx.notFound();
    }

    // Sanitize the role object to only include necessary fields
    const cleanRole = user.role
      ? (({ id, name, description, type }) => ({ id, name, description, type }))(user.role)
      : null;

    // Sanitize children array if user_profile exists and has children
    // (Uncomment and adjust if you have 'user_profile' and 'children' in your model)
    // const cleanChildren = Array.isArray(user.user_profile?.children)
    //   ? user.user_profile.children.map(({ id, name, age, gender }) => ({
    //       id, name, age, gender,
    //     }))
    //   : [];

    // Sanitize user_profile object if it exists
    // (Uncomment and adjust if you have 'user_profile' in your model)
    // const cleanUserProfile = user.user_profile
    //   ? {
    //       id: user.user_profile.id,
    //       locale: user.user_profile.locale,
    //       consentForEmailNotice: user.user_profile.consentForEmailNotice,
    //       children: cleanChildren, // Include sanitized children
    //     }
    //   : null;

    // Construct the response body with sanitized user data
    ctx.body = {
      id: user.id,
      username: user.username,
      email: user.email,
      confirmed: user.confirmed,
      blocked: user.blocked,
      role: cleanRole,
      // user_profile: cleanUserProfile, // Uncomment if you have user_profile
    };
  };

  // =================================================================
  // 2. CUSTOMIZATION FOR THE 'REGISTER' ENDPOINT (EXISTING WORKING CODE)
  // =================================================================
  plugin.controllers.auth.register = async (ctx) => {
    const userService = strapi.plugin("users-permissions").service("user");
    const jwtService = strapi.plugin("users-permissions").service("jwt");

    const pluginStore = await strapi.store({ type: "plugin", name: "users-permissions" });
    const settings = await pluginStore.get({ key: "advanced" });

    if (!settings.allow_register) {
      throw new ApplicationError("Register action is currently disabled");
    }

    const { email, username, password } = ctx.request.body;
    if (!username || !email || !password) {
        throw new ApplicationError("Username, email, and password are required.");
    }

    const role = await strapi
      .query('plugin::users-permissions.role')
      .findOne({ where: { type: settings.default_role } });

    if (!role) {
      throw new ApplicationError('Impossible to find the default role.');
    }

    const userWithSameEmail = await strapi
      .query("plugin::users-permissions.user")
      .findOne({ where: { email: email.toLowerCase() } });

    if (userWithSameEmail) {
      throw new ApplicationError("Email is already taken");
    }

    let newUser;

    try {
      newUser = await userService.add({
        username,
        email: email.toLowerCase(),
        password,
        provider: "local",
        confirmed: true,
        role: role.id,
      });

      console.log(`Strapi user ${newUser.email} (ID: ${newUser.id}) created.`);

      const subsysBaseUrl = process.env.SUBSYS_BASE_URL;
      const subscriptionServiceSecret = process.env.SUBSCRIPTION_SERVICE_SECRET;

      if (!subsysBaseUrl || !subscriptionServiceSecret) {
        console.error("Subscription environment variables not set. Skipping call.");
      } else {
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
            console.error(`Subscription call failed for user ${newUser.id}. Status: ${response.status}. Error:`, errorData);
            await userService.remove({ id: newUser.id });
            throw new ApplicationError("Account could not be created due to a subscription system error.");
          }
          console.log(`User ${newUser.id} successfully subscribed to free plan.`);

        } catch (subError) {
          console.error("Error during subscription call:", subError);
          if (newUser && newUser.id) {
             await userService.remove({ id: newUser.id });
          }
          throw new ApplicationError("Account could not be created due to a subscription system error.");
        }
      }

      const userWithRole = await strapi.entityService.findOne(
        "plugin::users-permissions.user",
        newUser.id,
        { populate: { role: true } }
      );

      const userSchema = strapi.getModel('plugin::users-permissions.user');
      const sanitizedUser = await sanitize.contentAPI.output(userWithRole, userSchema);

      ctx.send({
        jwt: jwtService.issue({ id: sanitizedUser.id }),
        user: sanitizedUser,
      });

    } catch (error) {
      console.error("An error occurred during custom registration:", error);
      if (error instanceof ApplicationError) {
          throw error;
      }
      throw new ApplicationError("An unexpected error occurred during registration.");
    }
  };

  return plugin;
};
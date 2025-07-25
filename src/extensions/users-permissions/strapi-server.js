// Path: src/extensions/users-permissions/strapi-server.js
"use strict";
console.log("[DEBUG] ==> Loading custom users-permissions strapi-server.js");

const axios = require("axios");
const { ApplicationError, ValidationError } = require('@strapi/utils').errors;
const { sanitize } = require('@strapi/utils');

module.exports = (plugin) => {
  // =================================================================
  // 1. 'ME' ENDPOINT - WITH SUBSCRIPTION & USER PROFILE
  // =================================================================
  plugin.controllers.user.me = async (ctx) => {
    if (!ctx.state.user || !ctx.state.user.id) {
      ctx.response.status = 401;
      return;
    }

    const populate = {
      role: true,
      user_profile: true,
    };

    const user = await strapi.entityService.findOne(
      "plugin::users-permissions.user",
      ctx.state.user.id,
      { populate }
    );

    if (!user) {
      return ctx.notFound();
    }

    // --- Subscription Fetching Logic ---
    let subscription = null;
    try {
      console.log("[DEBUG] Entering subscription fetching logic for 'me' endpoint.");
      const subscriptionUrl = process.env.SUBSYS_BASE_URL;
      const secret = process.env.SUBSCRIPTION_SERVICE_SECRET;
      
      if (!subscriptionUrl || !secret) {
        console.error("[ERROR] Subscription environment variables not set. Skipping call.");
      } else {
        const userId = ctx.state.user.id;
        console.log(`[DEBUG] Calling subscription endpoint for user ${userId}`);
        const response = await axios.get(
          `${subscriptionUrl}/api/v1/subscription-of-a-user/${userId}`,
          { headers: { Authorization: `Bearer ${secret}` } }
        );
        subscription = response.data;
        console.log(`[DEBUG] Subscription data fetched successfully for user ${userId}.`);
      }
    } catch (error) {
      console.error("[ERROR] Failed to fetch subscription data for user.", error.message);
      subscription = null;
    }
    // --- End Subscription Logic ---

    const cleanRole = user.role
      ? (({ id, name, description, type }) => ({ id, name, description, type }))(user.role)
      : null;

    const cleanUserProfile = user.user_profile
      ? {
          id: user.user_profile.id,
          telephone: user.user_profile.telephone,
          baseLanguage: user.user_profile.baseLanguage,
        }
      : null;

    ctx.body = {
      id: user.id,
      username: user.username,
      email: user.email,
      confirmed: user.confirmed,
      blocked: user.blocked,
      role: cleanRole,
      user_profile: cleanUserProfile,
      subscription: subscription,
    };
  };

  // =================================================================
  // 2. 'LOGIN' ENDPOINT (/api/auth/local) - WITH SUBSCRIPTION & ROLE
  // =================================================================
  const originalCallback = plugin.controllers.auth.callback;
  plugin.controllers.auth.callback = async (ctx) => {
    // Let the original controller handle the authentication
    await originalCallback(ctx);

    // If authentication was successful, ctx.body will have jwt and user
    if (ctx.body.jwt && ctx.body.user) {
      const user = ctx.body.user;
      let subscription = null;
      
      // Re-fetch the user to populate the role and profile
      let userWithDetails = await strapi.entityService.findOne(
        "plugin::users-permissions.user",
        user.id,
        { populate: { role: true, user_profile: true } }
      );

      // --- CREATE USER PROFILE IF IT DOESN'T EXIST ---
      if (!userWithDetails.user_profile) {
        console.log(`[DEBUG] User profile not found for user ${user.id}. Creating one.`);
        try {
          const newUserProfile = await strapi.entityService.create('api::user-profile.user-profile', {
            data: {
              baseLanguage: process.env.TARGET_LOCALE || 'en', // Use env variable, fallback to 'en'
              user: user.id
            },
          });
          userWithDetails.user_profile = newUserProfile;
          console.log(`[DEBUG] Successfully created new user profile for user ${user.id}.`);
        } catch (profileError) {
          console.error(`[ERROR] Failed to create user profile for user ${user.id}.`, profileError.message);
        }
      }
      // --- END PROFILE CREATION LOGIC ---

      const subscriptionUrl = process.env.SUBSYS_BASE_URL;
      const secret = process.env.SUBSCRIPTION_SERVICE_SECRET;

      if (!subscriptionUrl || !secret) {
        console.error("[ERROR] Subscription environment variables not set for login. Skipping call.");
      } else {
        try {
          // First, try to fetch the existing subscription
          console.log(`[DEBUG] Login successful for user ${user.id}. Fetching subscription.`);
          const response = await axios.get(
            `${subscriptionUrl}/api/v1/subscription-of-a-user/${user.id}`,
            { headers: { Authorization: `Bearer ${secret}` } }
          );
          subscription = response.data;
          console.log(`[DEBUG] Subscription data fetched for user ${user.id}.`);
        } catch (error) {
          console.warn(`[WARN] Could not fetch subscription for user ${user.id}. Attempting creation...`, error.message);

          try {
            // Create the free plan. The response from this endpoint is already complete.
            const creationResponse = await axios.post(
              `${subscriptionUrl}/api/v1/subscriptions/subscribe-free-plan`,
              { userId: user.id }, 
              { headers: { Authorization: `Bearer ${secret}` } }
            );
            subscription = creationResponse.data;
            console.log(`[DEBUG] Successfully created new subscription for user ${user.id}.`);

          } catch (creationError) {
            console.error(`[ERROR] CRITICAL: A failure occurred during the subscription creation process for user ${user.id}.`, creationError.message);
          }
        }
      }
      
      // Sanitize the user with the role, then attach the subscription and profile
      const userSchema = strapi.getModel('plugin::users-permissions.user');
      const sanitizedUser = await sanitize.contentAPI.output(userWithDetails, userSchema);
      sanitizedUser.subscription = subscription;
      
      // Replace the original user object in the response with our new, detailed one
      ctx.body.user = sanitizedUser;
    }
  };

  // =================================================================
  // 3. 'REGISTER' ENDPOINT - WITH SUBSCRIPTION & ROLE
  // =================================================================
  plugin.controllers.auth.register = async (ctx) => {
    console.log("[DEBUG] ==> Starting custom /register controller.");

    const userService = strapi.plugin("users-permissions").service("user");
    const jwtService = strapi.plugin("users-permissions").service("jwt");

    const pluginStore = await strapi.store({ type: "plugin", name: "users-permissions" });
    const settings = await pluginStore.get({ key: "advanced" });

    if (!settings.allow_register) {
      throw new ApplicationError("Register action is currently disabled");
    }

    const { email, username, password, baseLanguage } = ctx.request.body;
    if (!username || !email || !password || !baseLanguage) {
        throw new ApplicationError("Username, email, password, and baseLanguage are required.");
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
    let userProfile;
    try {
      // Create the user in a transaction to ensure atomicity
      await strapi.db.transaction(async () => {
        newUser = await userService.add({
          username,
          email: email.toLowerCase(),
          password,
          provider: "local",
          confirmed: true,
          role: role.id,
        });
        console.log(`[DEBUG] User ${newUser.email} (ID: ${newUser.id}) created in main Strapi.`);
  
        userProfile = await strapi.entityService.create('api::user-profile.user-profile', {
            data: { user: newUser.id, baseLanguage },
        });
        console.log(`[DEBUG] UserProfile created for user ${newUser.id}.`);

        await strapi.entityService.create('api::vbsetting.vbsetting', {
            data: { user: newUser.id },
        });
        console.log(`[DEBUG] VBSetting created for user ${newUser.id}.`);
      });

      let subscription = null;
      try {
        // Create the subscription in SUBSYS
        console.log(`[DEBUG] Calling subscription endpoint to create free plan for user ${newUser.id}.`);
        const subscriptionUrl = process.env.SUBSYS_BASE_URL;
        const secret = process.env.SUBSCRIPTION_SERVICE_SECRET;
        
        if (!subscriptionUrl || !secret) {
          console.error("[ERROR] Subscription environment variables not set. Skipping call.");
        } else {
          const creationResponse = await axios.post(
            `${subscriptionUrl}/api/v1/subscriptions/subscribe-free-plan`,
            { userId: newUser.id }, 
            { headers: { Authorization: `Bearer ${secret}` } }
          );
          subscription = creationResponse.data;
          console.log(`[DEBUG] Subscription creation/fetch completed for user ${newUser.id}.`);
        }
      } catch (subError) {
        console.error("[ERROR] Subscription call failed. Rolling back user creation.", subError);
        await userService.remove({ id: newUser.id });
        throw new ApplicationError("Account could not be created due to a subscription system error.");
      }      
      
      // Re-fetch the user to ensure all relations are populated for the response.
      const userWithDetails = await strapi.entityService.findOne(
        "plugin::users-permissions.user",
        newUser.id,
        { populate: { role: true } }
      );

      // Sanitize user data and manually add the subscription object to the response
      const userSchema = strapi.getModel('plugin::users-permissions.user');
      const sanitizedUser = await sanitize.contentAPI.output(userWithDetails, userSchema);

      // **Manually attach the user profile and subscription to the sanitized response**
      sanitizedUser.user_profile = userProfile;
      sanitizedUser.subscription = subscription;

      return ctx.send({
        jwt: jwtService.issue({ id: sanitizedUser.id }),
        user: sanitizedUser,
      });

    } catch (error) {
      console.error("[ERROR] An error during registration:", error);
      if (newUser && newUser.id) { // Rollback user if created
        await userService.remove({ id: newUser.id });
      }
      if (error instanceof ApplicationError) {
          throw error;
      }
      throw new ApplicationError("An error occurred during the registration process.");
    }
  };

  return plugin;
};
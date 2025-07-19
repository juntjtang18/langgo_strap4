'use strict';

const { TranslationServiceClient } = require('@google-cloud/translate');
const translationClient = new TranslationServiceClient();

module.exports = ({ strapi }) => ({
  /**
   * Validates and fixes a flashcard.
   * @param {number} flashcardId - The ID of the flashcard to validate.
   * @returns {object} - The updated flashcard.
   */
  async validateAndFix(flashcardId) {
    const openAIService = strapi.service('openai');
    const tierService = strapi.service('tier-service');

    let flashcard = await strapi.entityService.findOne('api::flashcard.flashcard', flashcardId, {
      populate: {
        content: { populate: { user_word: { populate: ['user'] } } },
        review_tire: true
      },
    });

    if (!flashcard) {
      throw new Error('Flashcard not found');
    }

    const flashcardUpdateData = {};

    // --- New Logic: Set review_tire if it's null ---
    if (!flashcard.review_tire) {
        const tier = await tierService.findTierForStreak(flashcard.correct_streak);
        if (tier) {
          flashcardUpdateData.review_tire = tier.id;
        }
    }

    const userWordRef = flashcard.content.find(c => c.__component === 'a.user-word-ref');
    if (!userWordRef || !userWordRef.user_word) {
        // If there were updates to the flashcard (like setting the tier), perform them before returning.
        if (Object.keys(flashcardUpdateData).length > 0) {
            await strapi.entityService.update('api::flashcard.flashcard', flashcard.id, { data: flashcardUpdateData });
        }
        return { status: 'skipped', message: 'Flashcard does not contain a valid user_word reference.' };
    }

    const userWord = userWordRef.user_word;
    const user = userWord.user;

    const userProfiles = await strapi.entityService.findMany('api::user-profile.user-profile', {
        filters: { user: user.id },
        limit: 1
    });

    if (!userProfiles || userProfiles.length === 0) {
        throw new Error(`Cannot find a user profile for user ${user.id}`);
    }
    const userProfile = userProfiles[0];

    if (!userProfile.baseLanguage) {
      throw new Error(`User profile for user ${user.id} is missing a baseLanguage.`);
    }

    const userWordUpdateData = {};
    const baseLocale = userProfile.baseLanguage;

    let targetLocale = userWord.target_locale;

    if (!targetLocale) {
        strapi.log.warn(`Skipping translation for user_word ${userWord.id} because target_locale is missing.`);
    } else if (!userWord.base_text && userWord.target_text) {
        const projectId = process.env.GOOGLE_PROJECT_ID;
        const [response] = await translationClient.translateText({
            parent: `projects/${projectId}/locations/global`,
            contents: [userWord.target_text],
            mimeType: 'text/plain',
            sourceLanguageCode: targetLocale,
            targetLanguageCode: baseLocale,
        });
        userWordUpdateData.base_text = response.translations[0]?.translatedText;
    }

    const baseTextForExam = userWordUpdateData.base_text || userWord.base_text;
    if (!userWord.exam_base && baseTextForExam) {
      userWordUpdateData.exam_base = await openAIService.generateExamOptions(baseTextForExam, baseLocale, userWord.id);
    }
    if (!userWord.exam_target && userWord.target_text && targetLocale) {
      userWordUpdateData.exam_target = await openAIService.generateExamOptions(userWord.target_text, targetLocale, userWord.id);
    }

    // --- Perform updates if there's anything to change ---
    if (Object.keys(userWordUpdateData).length > 0) {
      await strapi.entityService.update('api::user-word.user-word', userWord.id, { data: userWordUpdateData });
    }
    if (Object.keys(flashcardUpdateData).length > 0) {
        await strapi.entityService.update('api::flashcard.flashcard', flashcard.id, { data: flashcardUpdateData });
    }

    // --- Return the final, fully populated flashcard ---
    return strapi.entityService.findOne('api::flashcard.flashcard', flashcardId, {
      populate: {
        content: { populate: { user_word: true } },
        review_tire: true
      },
    });
  }
});
'use strict';

const { TranslationServiceClient } = require('@google-cloud/translate');
const translationClient = new TranslationServiceClient();

module.exports = ({ strapi }) => ({
  /**
   * Fetches a flashcard and its related data.
   * Assigns a review tier if missing.
   * Translates the word definition and generates an example sentence if they don't exist.
   * Generates multiple-choice exam questions for both base and target text if missing.
   * Saves all changes and returns the updated flashcard.
   */
  async validateAndFix(flashcardId) {
    const openAIService = strapi.service('openai');
    const tierService = strapi.service('tier-service');

    let flashcard = await strapi.entityService.findOne('api::flashcard.flashcard', flashcardId, {
      populate: {
        word_definition: { populate: ['word'] },
        user: { populate: ['user_profile'] },
        review_tire: true
      },
    });

    if (!flashcard) {
      throw new Error('Flashcard not found');
    }

    const flashcardUpdateData = {};

    if (!flashcard.review_tire) {
        const tier = await tierService.findTierForStreak(flashcard.correct_streak);
        if (tier) {
          flashcardUpdateData.review_tire = tier.id;
        }
    }

    if (!flashcard.word_definition || !flashcard.word_definition.word) {
        if (Object.keys(flashcardUpdateData).length > 0) {
            await strapi.entityService.update('api::flashcard.flashcard', flashcard.id, { data: flashcardUpdateData });
        }
        return { status: 'skipped', message: 'Flashcard does not have a valid word_definition or associated word reference.' };
    }

    const word_definition = flashcard.word_definition;
    const target_text = flashcard.word_definition.word.target_text;
    const user = flashcard.user;

    if (!user || !user.user_profile) {
        throw new Error(`Cannot find a user profile for user ${user.id}`);
    }
    const userProfile = user.user_profile;

    if (!userProfile.baseLanguage) {
      throw new Error(`User profile for user ${user.id} is missing a baseLanguage.`);
    }

    const wordDefinitionUpdateData = {};
    const baseLocale = userProfile.baseLanguage;
    const targetLocale = process.env.TARGET_LOCALE;

    if (!targetLocale) {
        strapi.log.warn(`Skipping translation for word_definition ${word_definition.id} because TARGET_LOCALE environment variable is not set.`);
    } else if (!word_definition.base_text && target_text) {
        const projectId = process.env.GOOGLE_PROJECT_ID;
        const [response] = await translationClient.translateText({
            parent: `projects/${projectId}/locations/global`,
            contents: [target_text],
            mimeType: 'text/plain',
            sourceLanguageCode: targetLocale,
            targetLanguageCode: baseLocale,
        });
        wordDefinitionUpdateData.base_text = response.translations[0]?.translatedText;
    }

    // --- New Logic: Generate example sentence ---
    if (!word_definition.example_sentence && target_text && targetLocale) {
        wordDefinitionUpdateData.example_sentence = await openAIService.generateExampleSentence(target_text, targetLocale, word_definition.id);
    }

    const baseTextForExam = wordDefinitionUpdateData.base_text || word_definition.base_text;
    if (!word_definition.exam_base && baseTextForExam) {
      wordDefinitionUpdateData.exam_base = await openAIService.generateExamOptions(baseTextForExam, baseLocale, word_definition.id);
    }

    if (!word_definition.exam_target && target_text && targetLocale) {
      wordDefinitionUpdateData.exam_target = await openAIService.generateExamOptions(target_text, targetLocale, word_definition.id);
    }

    if (Object.keys(wordDefinitionUpdateData).length > 0) {
      await strapi.entityService.update('api::word-definition.word-definition', word_definition.id, { data: wordDefinitionUpdateData });
    }
    if (Object.keys(flashcardUpdateData).length > 0) {
        await strapi.entityService.update('api::flashcard.flashcard', flashcard.id, { data: flashcardUpdateData });
    }

    return strapi.entityService.findOne('api::flashcard.flashcard', flashcardId, {
      populate: {
        word_definition: { populate: ['word'] },
        review_tire: true
      },
    });
  }
});
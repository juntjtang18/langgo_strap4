// path: src/services/word-processing-queue.js
'use strict';
const async = require('async');
const OpenAI = require('openai');

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

module.exports = ({ strapi }) => {
  const generateExamOptions = async (correctWord, language, isBase, userWordId) => {
    const prompt = `Generate 3 incorrect alternative words in ${language} that are similar in category or difficulty to "${correctWord}". The output should be a JSON array of objects, where each object has "text" and "isCorrect" (boolean). The correct word should also be included with "isCorrect": true. Ensure the correct word is randomly placed among the options.`;
    try {
      const chatCompletion = await openai.chat.completions.create({
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a helpful assistant that generates multiple-choice options for language learning. Provide only the JSON array." },
          { role: "user", content: prompt }
        ],
        response_format: { type: "json_object" },
      });
      const responseContent = chatCompletion.choices[0].message.content;
      let generatedOptions = JSON.parse(responseContent);
      generatedOptions = Array.isArray(generatedOptions)
        ? generatedOptions
        : generatedOptions.options || generatedOptions.choices || Object.values(generatedOptions)[0];

      if (!Array.isArray(generatedOptions)) {
        throw new Error("OpenAI response did not contain a valid array of options.");
      }

      let finalOptions = [
        ...generatedOptions.filter(opt => !opt.isCorrect),
        { text: correctWord, isCorrect: true }
      ];
      while (finalOptions.length < 4) {
        finalOptions.push({ text: `Placeholder ${finalOptions.length + 1}`, isCorrect: false });
      }
      finalOptions = finalOptions.slice(0, 4);
      for (let i = finalOptions.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [finalOptions[i], finalOptions[j]] = [finalOptions[j], finalOptions[i]];
      }
      return finalOptions;
    } catch (error) {
      strapi.log.error(
        `Error calling OpenAI API for ${language} in job for user_word ${userWordId}:`,
        error.message
      );
      return [
        { text: correctWord, isCorrect: true },
        { text: `Error opt 1 (${language})`, isCorrect: false },
        { text: `Error opt 2 (${language})`, isCorrect: false },
        { text: `Error opt 3 (${language})`, isCorrect: false }
      ];
    }
  };

  // Define the worker function that will process jobs from the queue
  // It returns on success or throws on error.
  const processUserWordJob = async (job) => {
    const { userWordId, incomingData, flashcardId } = job;

    try {
      const { target_text, base_text, base_locale, target_locale } = incomingData;

      // 1. Generate exam options
      const examBaseOptions = await generateExamOptions(base_text, base_locale, true, userWordId);
      const examTargetOptions = await generateExamOptions(target_text, target_locale, false, userWordId);
      strapi.log.info(`Background Job: Generated exam data for user_word ${userWordId}`);

      // 2. Update the user_word with exam data
      await strapi.entityService.update('api::user-word.user-word', userWordId, {
        data: {
          exam_base: examBaseOptions,
          exam_target: examTargetOptions,
        },
      });
      strapi.log.info(`Background Job: Updated user_word ${userWordId} with exam data.`);

      // 3. Fetch the flashcard
      const createdFlashcard = await strapi.entityService.findOne('api::flashcard.flashcard', flashcardId);
      if (!createdFlashcard) {
        throw new Error(`Flashcard with ID ${flashcardId} not found for job for user_word ${userWordId}.`);
      }
      strapi.log.info(`Background Job: Fetched flashcard ID ${createdFlashcard.id}`);

      // Job complete
      strapi.log.info(`Background Job: Job for user_word ${userWordId} completed successfully.`);
      return { status: 'success', userWordId };
    } catch (error) {
      strapi.log.error(`Background Job Error for user_word ID ${userWordId}:`, error);
      throw error;
    }
  };

  const backgroundQueue = async.queue(processUserWordJob, 2);

  backgroundQueue.error((err, job) => {
    strapi.log.error(
      `Error from background queue (job for user_word ${job.userWordId}):`,
      err.message
    );
  });

  return {
    addJob: (jobData) => {
      backgroundQueue.push(jobData, (err, result) => {
        if (err) {
          strapi.log.error(
            `Job for user_word ${jobData.userWordId} failed in queue (push callback):`,
            err.message
          );
        } else {
          strapi.log.info(
            `Job for user_word ${jobData.userWordId} completed in queue (push callback):`,
            result
          );
        }
      });
    },
  };
};

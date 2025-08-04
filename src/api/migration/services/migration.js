// File: src/api/migration/services/migration.js
'use strict';

const fs = require('fs');
const path = require('path');

// A simple utility to process array chunks in parallel
const processInBatches = async (items, batchSize, processFn) => {
  for (let i = 0; i < items.length; i += batchSize) {
    const batch = items.slice(i, i + batchSize);
    await Promise.all(batch.map(processFn));
  }
};

module.exports = ({ strapi }) => ({
  /**
   * The definitive, parallel migration script.
   * 1. Cleans up previous migration attempts.
   * 2. Processes flashcards in parallel batches for speed.
   * 3. Creates words, definitions, and flashcards, preserving history.
   * 4. Validates each new flashcard to populate missing fields.
   */
  async run() {
    strapi.log.info('--- Starting Definitive Parallel Migration ---');
    const BATCH_SIZE = 10; // Process 10 flashcards concurrently

    // --- 1. CLEANUP PHASE ---
    try {
      strapi.log.info('[CLEANUP] Deleting all existing flashcards, definitions, and words...');
      await strapi.db.query('api::flashcard.flashcard').deleteMany({ where: { id: { $gt: 0 } } });
      await strapi.db.query('api::word-definition.word-definition').deleteMany({ where: { id: { $gt: 0 } } });
      await strapi.db.query('api::word.word').deleteMany({ where: { id: { $gt: 0 } } });
      strapi.log.info('[CLEANUP] Cleanup complete.');
    } catch (error) {
      strapi.log.error('[CLEANUP] An error occurred during cleanup:', error);
      return { success: false, message: 'Cleanup failed. Migration aborted.' };
    }

    // --- 2. MIGRATION PHASE ---
    const flashcardsBackupPath = path.resolve(strapi.dirs.app.root, 'database', 'backup', 'flashcards_backup.json');
    if (!fs.existsSync(flashcardsBackupPath)) {
      return { success: false, message: 'Backup file not found.' };
    }

    const flashcardsData = JSON.parse(fs.readFileSync(flashcardsBackupPath, 'utf8')).data;
    let successfulCount = 0;
    let skippedCount = 0;
    const partOfSpeechCache = new Map();

    const getPosId = async (posName, trx) => {
      if (!posName) return null;
      const trimmedPosName = posName.trim().toLowerCase();
      if (partOfSpeechCache.has(trimmedPosName)) return partOfSpeechCache.get(trimmedPosName);

      let posEntry = await strapi.db.query('api::part-of-speech.part-of-speech').findOne({ where: { name: trimmedPosName } });
      if (!posEntry) {
        posEntry = await strapi.entityService.create('api::part-of-speech.part-of-speech', { data: { name: trimmedPosName, slug: trimmedPosName }, db: trx });
      }
      partOfSpeechCache.set(trimmedPosName, posEntry.id);
      return posEntry.id;
    };
    
    // This function defines the work for a single flashcard
    const processFlashcard = async (oldFlashcard) => {
      const { content, user, ...reviewHistory } = oldFlashcard.attributes;
      const oldFlashcardId = oldFlashcard.id;
      const userWordRef = content?.find(c => c.__component === 'a.user-word-ref');
      const userWord = userWordRef?.user_word?.data?.attributes;
      const userId = user?.data?.id;

      if (!userWord || !userId || !userWord.target_text) {
        skippedCount++;
        strapi.log.warn(`[SKIP] Original Flashcard ID ${oldFlashcardId}: Incomplete data.`);
        return;
      }
      
      const userExists = await strapi.query('plugin::users-permissions.user').findOne({ where: { id: userId } });
      if (!userExists) {
        skippedCount++;
        strapi.log.warn(`[SKIP] Original Flashcard ID ${oldFlashcardId}: User ${userId} not found.`);
        return;
      }

      try {
        await strapi.db.transaction(async ({ trx }) => {
          const { target_text, base_text, part_of_speech } = userWord;
          
          let word = await strapi.db.query('api::word.word').findOne({ where: { target_text: target_text.trim() } });
          if (!word) {
            word = await strapi.entityService.create('api::word.word', { data: { target_text: target_text.trim() }, db: trx });
          }

          const posId = await getPosId(part_of_speech, trx);
          const wordDefinition = await strapi.entityService.create('api::word-definition.word-definition', {
            data: { word: word.id, base_text: base_text ? base_text.trim() : null, part_of_speech: posId },
            db: trx,
          });

          const newFlashcard = await strapi.entityService.create('api::flashcard.flashcard', {
            data: { ...reviewHistory, user: userId, word_definition: wordDefinition.id },
            db: trx,
          });
          
          const validationService = strapi.service('flashcard-validate');
          if (validationService) {
            await validationService.validateAndFix(newFlashcard.id);
          }
        });
        successfulCount++;
      } catch (error) {
        strapi.log.error(`[FAIL] Error on original Flashcard ID ${oldFlashcardId}:`, error);
        skippedCount++;
      }
    };
    
    // Process the entire list in parallel batches
    await processInBatches(flashcardsData, BATCH_SIZE, processFlashcard);

    const summary = { successfulCount, skippedCount };
    strapi.log.info('--- Definitive Parallel Migration Complete ---', summary);
    return { success: true, message: 'Definitive migration completed.', summary };
  },
});
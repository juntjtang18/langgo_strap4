const test = require('node:test');
const assert = require('node:assert/strict');

process.env.OPENAI_API_KEY = process.env.OPENAI_API_KEY || 'test-openai-key';

const createOpenAIService = require('../src/services/openai');

test('buildExamOptionsPrompt requires form-similar but meaning-distant distractors', () => {
  const service = createOpenAIService({
    strapi: {
      log: {
        info() {},
        warn() {},
        error() {},
        debug() {},
      },
    },
  });

  const prompt = service.buildExamOptionsPrompt('book', 'en');

  assert.match(prompt, /visually or phonetically similar/i);
  assert.match(prompt, /plausible confusions by FORM, not by meaning/i);
  assert.match(prompt, /look-alike or sound-alike words from a different semantic field/i);
  assert.match(prompt, /should NOT be trapped by 3 nearly equivalent meanings/i);
  assert.match(prompt, /Better distractors are similar in spelling\/sound but clearly wrong in meaning/i);
});

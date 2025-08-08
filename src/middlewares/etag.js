'use strict';

let conditional = require('koa-conditional-get');
let etag = require('koa-etag');

// Handle module interop
if (conditional.default) conditional = conditional.default;
if (etag.default) etag = etag.default;

module.exports = (config, { strapi }) => {
  const useConditional = typeof conditional === 'function';
  const useEtag = typeof etag === 'function';

  if (!useConditional || !useEtag) {
    strapi.log.error('Failed to load conditional-get or etag middleware.');
    return async (ctx, next) => next();
  }

  const etagOptions = { weak: true };

  return async (ctx, next) => {
    // First, enable support for If-None-Match, If-Modified-Since, etc.
    await conditional()(ctx, async () => {
      // Then calculate the ETag based on ctx.body
      await etag(etagOptions)(ctx, next);
    });
  };
};

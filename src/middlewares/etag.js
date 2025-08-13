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
    console.log('[ETAG] Request received for:', ctx.url);
    console.log('[ETAG] Incoming If-None-Match header:', ctx.get('if-none-match'));

    // First, enable support for If-None-Match, If-Modified-Since, etc.
    await conditional()(ctx, async () => {
      // Then calculate the ETag based on ctx.body
        // --- LOGGING START ---
        // Temporarily log the response body to see what ETag is based on
        if (ctx.url.includes('/api/word-definitions/search')) {
            console.log('[ETAG] Response body before ETag generation:', JSON.stringify(ctx.body, null, 2));
        }
        // --- LOGGING END ---
      //await etag(etagOptions)(ctx, next);
      await next();
    });
    console.log('[ETAG] Outgoing ETag header set to:', ctx.get('etag'));

  };
};

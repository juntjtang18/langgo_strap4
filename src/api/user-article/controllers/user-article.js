'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

const buildArticleCreatedEvent = ({
  userArticleId,
  user,
  createdAt,
  title,
  languageCode,
  wordCount,
}) => ({
  event: 'user_article.created',
  eventId: `user-article-created:${userArticleId}`,
  occurredAt: createdAt,
  article: {
    userArticleId,
    userId: user.id,
    username: user.username || user.email || `user-${user.id}`,
    email: user.email || null,
    createdAt,
    title: title || null,
    languageCode: languageCode || null,
    wordCount: wordCount ?? null,
  },
});

module.exports = createCoreController('api::user-article.user-article', ({ strapi }) => ({
  async create(ctx) {
    const { user } = ctx.state;
    const input = ctx.request.body?.data || {};

    if (!user) {
      return ctx.unauthorized('Authentication required.');
    }

    if (!input.title || !input.content) {
      return ctx.badRequest('Missing required fields: title and content.');
    }

    try {
      const createdAt = new Date().toISOString();
      const calculatedWordCount = Number.isInteger(input.word_count)
        ? input.word_count
        : String(input.content || '')
          .trim()
          .split(/\s+/)
          .filter(Boolean)
          .length;

      const article = await strapi.entityService.create('api::user-article.user-article', {
        data: {
          title: input.title,
          content: input.content,
          language_code: input.language_code || null,
          word_count: calculatedWordCount,
          progress: input.progress ?? 0,
          last_read_at: input.last_read_at || null,
          article_tags: input.article_tags || [],
          user: user.id,
        },
        populate: {
          article_tags: true,
          user: true,
        },
      });

      try {
        await strapi.service('event-api').dispatchArticleCreated(
          buildArticleCreatedEvent({
            userArticleId: article.id,
            user,
            createdAt,
            title: article.title,
            languageCode: article.language_code,
            wordCount: article.word_count,
          })
        );
      } catch (dispatchError) {
        strapi.log.error(`user_article.created dispatch error: ${dispatchError.message}`, dispatchError.stack);
      }

      return this.transformResponse(article);
    } catch (error) {
      strapi.log.error('Error in custom user-article create controller:', error);
      return ctx.internalServerError('An error occurred while creating the article.');
    }
  },
}));

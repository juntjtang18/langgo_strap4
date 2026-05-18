'use strict';

const { createCoreController } = require('@strapi/strapi').factories;
const { publishEventWithAudit } = require('../../../utils/event-publish-audit');
const { buildEventId } = require('../../../utils/event-id');

const buildArticleCreatedEvent = ({
  userArticleId,
  user,
  createdAt,
}) => ({
  eventId: buildEventId(),
  eventType: 'article.created',
  occurredAt: createdAt,
  articleId: userArticleId,
  userId: user.id,
  username: user.username || user.email || `user-${user.id}`,
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

      strapi.log.info('[EventPublisher] publishing event: article.created');
      await publishEventWithAudit(strapi, 'article.created', buildArticleCreatedEvent({
        userArticleId: article.id,
        user,
        createdAt,
      }), {
        source: 'article.created',
        metadata: {
          publisher: 'api::user-article.user-article.create',
        },
      }, ctx);

      return this.transformResponse(article);
    } catch (error) {
      strapi.log.error('Error in custom user-article create controller:', error);
      return ctx.internalServerError('An error occurred while creating the article.');
    }
  },
}));

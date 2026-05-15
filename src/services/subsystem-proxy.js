'use strict';

const DEFAULT_TIMEOUT_MS = 10000;

const SERVICE_CONFIGS = {
  rank: {
    displayName: 'Rank server',
    baseUrlEnv: ['RANK_SERVER_BASE_URL', 'RANK_SERVICE_BASE_URL'],
    internalKeyEnv: ['RANK_SERVER_INTERNAL_KEY', 'RANK_INTERNAL_KEY'],
  },
  achievement: {
    displayName: 'Achievement server',
    baseUrlEnv: ['ACHIEVEMENT_SERVER_BASE_URL', 'ACHIEVEMENT_SERVICE_BASE_URL'],
    internalKeyEnv: ['ACHIEVEMENT_SERVER_INTERNAL_KEY', 'ACHIEVEMENT_INTERNAL_KEY'],
  },
};

const firstEnv = (keys) => {
  for (const key of keys) {
    const value = process.env[key];
    if (value && value.trim()) {
      return value.trim();
    }
  }
  return null;
};

const normalizeBaseUrl = (baseUrl) => baseUrl.replace(/\/+$/, '');

const buildTargetUrl = (baseUrl, path, querystring) => {
  const normalizedPath = path.startsWith('/') ? path : `/${path}`;
  const url = `${normalizeBaseUrl(baseUrl)}${normalizedPath}`;
  return querystring ? `${url}?${querystring}` : url;
};

const parseResponseBody = async (response) => {
  const contentType = response.headers.get('content-type') || '';
  if (contentType.includes('application/json')) {
    return response.json();
  }

  const text = await response.text();
  if (!text) {
    return null;
  }

  try {
    return JSON.parse(text);
  } catch (_) {
    return text;
  }
};

const getTimeoutMs = () => {
  const raw = process.env.SUBSYSTEM_PROXY_TIMEOUT_MS;
  const parsed = Number(raw);
  return Number.isInteger(parsed) && parsed > 0 ? parsed : DEFAULT_TIMEOUT_MS;
};

module.exports = ({ strapi }) => {
  const resolveService = (serviceName) => {
    const config = SERVICE_CONFIGS[serviceName];
    if (!config) {
      throw new Error(`Unknown subsystem proxy target: ${serviceName}`);
    }

    return {
      ...config,
      baseUrl: firstEnv(config.baseUrlEnv),
      internalKey: firstEnv(config.internalKeyEnv),
    };
  };

  const forward = async (ctx, serviceName, path, options = {}) => {
    const user = ctx.state?.user;
    if (!user?.id) {
      return ctx.unauthorized('Authentication required.');
    }

    const service = resolveService(serviceName);
    if (!service.baseUrl || !service.internalKey) {
      strapi.log.error(`[SubsystemProxy] ${service.displayName} proxy is not configured.`);
      ctx.status = 503;
      ctx.body = {
        data: null,
        error: {
          status: 503,
          name: 'ServiceUnavailableError',
          message: `${service.displayName} proxy is not configured.`,
        },
      };
      return;
    }

    const targetUrl = buildTargetUrl(service.baseUrl, path, ctx.querystring);
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), getTimeoutMs());

    try {
      strapi.log.info(`[SubsystemProxy] forwarding ${ctx.method} ${ctx.path} -> ${serviceName}:${path}`);

      const response = await fetch(targetUrl, {
        method: options.method || ctx.method || 'GET',
        headers: {
          accept: 'application/json',
          'content-type': 'application/json',
          'x-internal-key': service.internalKey,
          'x-user-id': String(user.id),
          'x-user-locale': user.baseLanguage || user.locale || '',
        },
        body: options.body === undefined ? undefined : JSON.stringify(options.body),
        signal: controller.signal,
      });

      const body = await parseResponseBody(response);
      ctx.status = response.status;
      ctx.body = body;
    } catch (error) {
      const isAbort = error?.name === 'AbortError';
      strapi.log.error(`[SubsystemProxy] ${service.displayName} request failed: ${error.message}`);
      ctx.status = isAbort ? 504 : 502;
      ctx.body = {
        data: null,
        error: {
          status: ctx.status,
          name: isAbort ? 'GatewayTimeoutError' : 'BadGatewayError',
          message: `${service.displayName} request failed.`,
        },
      };
    } finally {
      clearTimeout(timeout);
    }
  };

  return {
    forward,
    buildTargetUrl,
    resolveService,
  };
};

module.exports._private = {
  buildTargetUrl,
  firstEnv,
};

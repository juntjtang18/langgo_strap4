#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

load_dotenv_defaults() {
  if [ ! -f .env ]; then
    echo "Error: .env file not found. Please create .env with required variables."
    exit 1
  fi

  while IFS= read -r line; do
    [[ -z "${line}" || "${line}" =~ ^[[:space:]]*# ]] && continue
    local key="${line%%=*}"
    local value="${line#*=}"
    key="${key#"${key%%[![:space:]]*}"}"
    key="${key%"${key##*[![:space:]]}"}"
    [[ -z "${key}" || ! "${key}" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]] && continue
    if [ -z "${!key+x}" ]; then
      export "${key}=${value}"
    fi
  done < .env
}

load_dotenv_defaults

build_database_postgres_url() {
  node <<'NODE'
const encode = encodeURIComponent;
const user = encode(process.env.DATABASE_USERNAME || '');
const password = encode(process.env.DATABASE_PASSWORD || '');
const database = encode(process.env.DATABASE_NAME || '');
const port = encode(process.env.DATABASE_PORT || '5432');
const hostValue = process.env.DATABASE_HOST || '';
if (hostValue.startsWith('/')) {
  process.stdout.write(`postgresql://${user}:${password}@/${database}?host=${encode(hostValue)}&port=${port}`);
} else {
  process.stdout.write(`postgresql://${user}:${password}@${encode(hostValue)}:${port}/${database}`);
}
NODE
}

get_postgres_url_database_name() {
  node <<'NODE'
const connectionString = process.env.EVENT_BUS_POSTGRES_URL || '';
try {
  const url = new URL(connectionString);
  process.stdout.write(decodeURIComponent(url.pathname.replace(/^\/+/, '')));
} catch {
  const match = connectionString.match(/^postgres(?:ql)?:\/\/(?:[^/@]+@)?\/([^?]+)/);
  process.stdout.write(match && match[1] ? decodeURIComponent(match[1]) : '');
}
NODE
}

# --- Versioning Configuration ---
VERSION_FILE="VERSION"

if [ ! -f "$VERSION_FILE" ]; then
  echo "1.0" > "$VERSION_FILE"
fi

VERSION=$(awk -F. -v OFS=. '{$NF++;print}' "$VERSION_FILE")
echo "$VERSION" > "$VERSION_FILE"

# --- Configuration ---
PROJECT_ID="lucid-arch-451211-b0"
SERVICE_NAME="langgo-en-strapi"
REGION="us-west1"
IMAGE_NAME="gcr.io/${PROJECT_ID}/${SERVICE_NAME}:${VERSION}"
CLOUD_SQL_INSTANCE="lucid-arch-451211-b0:us-west1:cloud-sql-server"

# Redis configuration (from Memorystore instance)
REDIS_HOST="10.165.40.67"
REDIS_PORT="6379"
VPC_CONNECTOR="langgo-vpc-connector"
REVIEWLOG_EVENTS_TOPIC="pointserver-reviewlogs"

# --- Deployment Steps ---
echo "--- Deploying version: ${VERSION} ---"

echo "Syncing event-bus-client dependency..."
./scripts/sync-event-bus-client.sh

resolve_cloud_run_url() {
  local service_name="$1"
  gcloud run services describe "${service_name}" \
    --project "${PROJECT_ID}" \
    --region "${REGION}" \
    --format='value(status.url)' 2>/dev/null || true
}

is_local_url() {
  local value="$1"
  [[ "${value}" == http://127.0.0.1:* ]] ||
    [[ "${value}" == http://localhost:* ]] ||
    [[ "${value}" == https://127.0.0.1:* ]] ||
    [[ "${value}" == https://localhost:* ]]
}

resolve_deploy_base_url() {
  local configured_url="$1"
  local service_name="$2"

  if [ -n "${configured_url}" ] && ! is_local_url "${configured_url}"; then
    echo "${configured_url}"
    return
  fi

  resolve_cloud_run_url "${service_name}"
}

RANK_SERVER_BASE_URL="$(resolve_deploy_base_url "${RANK_SERVER_BASE_URL:-}" langgo-rank-server)"
ACHIEVEMENT_SERVER_BASE_URL="$(resolve_deploy_base_url "${ACHIEVEMENT_SERVER_BASE_URL:-}" achievement-service)"
RANK_SERVER_INTERNAL_KEY="${RANK_SERVER_INTERNAL_KEY:-${RANK_INTERNAL_KEY:-}}"
ACHIEVEMENT_SERVER_INTERNAL_KEY="${ACHIEVEMENT_SERVER_INTERNAL_KEY:-${ACHIEVEMENT_INTERNAL_KEY:-}}"
SUBSYSTEM_PROXY_TIMEOUT_MS="${SUBSYSTEM_PROXY_TIMEOUT_MS:-10000}"
EVENT_BUS_DRIVER="${EVENT_BUS_DRIVER:-postgres}"
EVENT_BUS_CHANNEL_PREFIX="${EVENT_BUS_CHANNEL_PREFIX:-event_bus}"
EVENT_BUS_POSTGRES_URL="${EVENT_BUS_POSTGRES_URL:-$(build_database_postgres_url)}"

require_proxy_env() {
  local name="$1"
  local value="$2"
  if [ -z "${value}" ]; then
    echo "Error: ${name} is required for rank/achievement proxy configuration."
    exit 1
  fi
}

require_proxy_env "RANK_SERVER_BASE_URL" "${RANK_SERVER_BASE_URL}"
require_proxy_env "RANK_SERVER_INTERNAL_KEY or RANK_INTERNAL_KEY" "${RANK_SERVER_INTERNAL_KEY}"
require_proxy_env "ACHIEVEMENT_SERVER_BASE_URL" "${ACHIEVEMENT_SERVER_BASE_URL}"
require_proxy_env "ACHIEVEMENT_SERVER_INTERNAL_KEY or ACHIEVEMENT_INTERNAL_KEY" "${ACHIEVEMENT_SERVER_INTERNAL_KEY}"

if [ "${EVENT_BUS_DRIVER}" != "postgres" ]; then
  echo "Error: EVENT_BUS_DRIVER must be postgres for the current event-bus-client deployment."
  exit 1
fi

EVENT_BUS_DATABASE_NAME="$(get_postgres_url_database_name)"
if [ "${EVENT_BUS_DATABASE_NAME}" != "${DATABASE_NAME}" ]; then
  echo "Error: EVENT_BUS_POSTGRES_URL database '${EVENT_BUS_DATABASE_NAME}' must match DATABASE_NAME '${DATABASE_NAME}'."
  exit 1
fi

echo "Building Docker image: ${IMAGE_NAME}"
docker build -t "${IMAGE_NAME}" .

echo "Pushing Docker image..."
docker push "${IMAGE_NAME}"

echo "Deploying to Cloud Run service: ${SERVICE_NAME}"
gcloud run deploy "${SERVICE_NAME}" \
  --image "${IMAGE_NAME}" \
  --platform "managed" \
  --region "${REGION}" \
  --memory "1Gi" \
  --timeout "600" \
  --allow-unauthenticated \
  --add-cloudsql-instances "${CLOUD_SQL_INSTANCE}" \
  --vpc-connector "${VPC_CONNECTOR}" \
  --set-env-vars "NODE_ENV=production" \
  --set-env-vars "CLOUD_SQL_INSTANCE=${CLOUD_SQL_INSTANCE}" \
  --set-env-vars "REDIS_HOST=${REDIS_HOST}" \
  --set-env-vars "REDIS_PORT=${REDIS_PORT}" \
  --set-env-vars "ENABLE_REDIS_CACHE=${ENABLE_REDIS_CACHE}" \
  --set-env-vars "DATABASE_NAME=${DATABASE_NAME}" \
  --set-env-vars "DATABASE_USERNAME=${DATABASE_USERNAME}" \
  --set-env-vars "DATABASE_PASSWORD=${DATABASE_PASSWORD}" \
  --set-env-vars "APP_URL=https://langgo-en-strapi.geniusParentingAI.ca" \
  --set-env-vars "ADMIN_URL=https://langgo-en-strapi.geniusParentingAI.ca/admin" \
  --set-env-vars "APP_KEYS=${APP_KEYS}" \
  --set-env-vars "API_TOKEN_SALT=${API_TOKEN_SALT}" \
  --set-env-vars "ADMIN_JWT_SECRET=${ADMIN_JWT_SECRET}" \
  --set-env-vars "JWT_SECRET=${JWT_SECRET}" \
  --set-env-vars "TRANSFER_TOKEN_SALT=${TRANSFER_TOKEN_SALT}" \
  --set-env-vars "OPENAI_API_KEY=${OPENAI_API_KEY}" \
  --set-env-vars "SUBSYS_BASE_URL=https://langgo-subsys.geniusparentingai.ca" \
  --set-env-vars "SUBSCRIPTION_SERVICE_SECRET=${SUBSCRIPTION_SERVICE_SECRET}" \
  --set-env-vars "RANK_SERVER_BASE_URL=${RANK_SERVER_BASE_URL}" \
  --set-env-vars "RANK_SERVER_INTERNAL_KEY=${RANK_SERVER_INTERNAL_KEY}" \
  --set-env-vars "ACHIEVEMENT_SERVER_BASE_URL=${ACHIEVEMENT_SERVER_BASE_URL}" \
  --set-env-vars "ACHIEVEMENT_SERVER_INTERNAL_KEY=${ACHIEVEMENT_SERVER_INTERNAL_KEY}" \
  --set-env-vars "SUBSYSTEM_PROXY_TIMEOUT_MS=${SUBSYSTEM_PROXY_TIMEOUT_MS}" \
  --set-env-vars "GOOGLE_TRANSLATE_API_KEY=${GOOGLE_TRANSLATE_API_KEY}" \
  --set-env-vars "GOOGLE_PROJECT_ID=${GOOGLE_PROJECT_ID}" \
  --set-env-vars "GOOGLE_PUBSUB_PROJECT_ID=${GOOGLE_PUBSUB_PROJECT_ID}" \
  --set-env-vars "REVIEWLOG_EVENTS_TOPIC=${REVIEWLOG_EVENTS_TOPIC}" \
  --set-env-vars "EVENT_BUS_DRIVER=${EVENT_BUS_DRIVER}" \
  --set-env-vars "EVENT_BUS_POSTGRES_URL=${EVENT_BUS_POSTGRES_URL}" \
  --set-env-vars "EVENT_BUS_CHANNEL_PREFIX=${EVENT_BUS_CHANNEL_PREFIX}" \
  --set-env-vars "DATABASE_CLIENT=${DATABASE_CLIENT}" \
  --set-env-vars "DATABASE_HOST=${DATABASE_HOST}" \
  --set-env-vars "DATABASE_PORT=${DATABASE_PORT}" \
  --set-env-vars "DATABASE_SCHEMA=${DATABASE_SCHEMA}" \
  --set-env-vars "DATABASE_SSL=${DATABASE_SSL}" \
  --set-env-vars "PGPASSWORD=${PGPASSWORD}" \
  --set-env-vars "WORDS_PER_VOCAPAGE=${WORDS_PER_VOCAPAGE}" \
  --set-env-vars "LANGGO_STRAPI4_VERSION=${LANGGO_STRAPI4_VERSION}" \
  --set-env-vars "TARGET_LOCALE=${TARGET_LOCALE}" \
  --set-env-vars "SHORT_TIME_FOR_REVIEW=false" \
  --revision-suffix "v${VERSION//./-}"

echo "--- Deployment of ${SERVICE_NAME} version ${VERSION} complete! ---"

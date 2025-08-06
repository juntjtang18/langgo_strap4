#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Load environment variables from .env
if [ -f .env ]; then
    source .env
else
    echo "Error: .env file not found. Please create .env with required variables."
    exit 1
fi

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

# --- Deployment Steps ---
echo "--- Deploying version: ${VERSION} ---"

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
  --set-env-vars "NODE_ENV=development" \
  --set-env-vars "CLOUD_SQL_INSTANCE=${CLOUD_SQL_INSTANCE}" \
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
  --set-env-vars "GOOGLE_TRANSLATE_API_KEY=${GOOGLE_TRANSLATE_API_KEY}" \
  --set-env-vars "GOOGLE_PROJECT_ID=${GOOGLE_PROJECT_ID}" \
  --set-env-vars "DATABASE_CLIENT=${DATABASE_CLIENT}" \
  --set-env-vars "DATABASE_HOST=${DATABASE_HOST}" \
  --set-env-vars "DATABASE_PORT=${DATABASE_PORT}" \
  --set-env-vars "DATABASE_SSL=${DATABASE_SSL}" \
  --set-env-vars "PGPASSWORD=${PGPASSWORD}" \
  --set-env-vars "WORDS_PER_VOCAPAGE=${WORDS_PER_VOCAPAGE}" \
  --set-env-vars "LANGGO_STRAPI4_VERSION=${LANGGO_STRAPI4_VERSION}" \
  --set-env-vars "TARGET_LOCALE=${TARGET_LOCALE}" \
  --set-env-vars "SHORT_TIME_FOR_REVIEW=flase" \
  --revision-suffix "v${VERSION//./-}"

echo "--- Deployment of ${SERVICE_NAME} version ${VERSION} complete! ---"

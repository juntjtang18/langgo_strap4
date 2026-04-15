#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <backup-directory>"
  exit 1
fi

BACKUP_DIR="$1"
if [[ ! -d "${BACKUP_DIR}" ]]; then
  echo "Backup directory not found: ${BACKUP_DIR}"
  exit 1
fi

if [[ ! -f "${ROOT_DIR}/.env" ]]; then
  echo "Missing ${ROOT_DIR}/.env"
  exit 1
fi

set -a
source "${ROOT_DIR}/.env"
set +a

DB_HOST="${DATABASE_HOST:?DATABASE_HOST is required}"
DB_PORT="${DATABASE_PORT:-5432}"
DB_NAME="${DATABASE_NAME:?DATABASE_NAME is required}"
DB_USER="${DATABASE_USERNAME:?DATABASE_USERNAME is required}"
DB_PASSWORD="${DATABASE_PASSWORD:?DATABASE_PASSWORD is required}"

DUMP_FILE="${BACKUP_DIR}/word-definition.dump"
SCHEMA_FILE="${BACKUP_DIR}/schema.word-definition.json"
TARGET_SCHEMA_FILE="${ROOT_DIR}/src/api/word-definition/content-types/word-definition/schema.json"

if [[ ! -f "${DUMP_FILE}" ]]; then
  echo "Dump file not found: ${DUMP_FILE}"
  exit 1
fi

export PGPASSWORD="${DB_PASSWORD}"

pg_restore \
  -h "${DB_HOST}" \
  -p "${DB_PORT}" \
  -U "${DB_USER}" \
  -d "${DB_NAME}" \
  --clean \
  --if-exists \
  --no-owner \
  --no-privileges \
  "${DUMP_FILE}"

unset PGPASSWORD

if [[ -f "${SCHEMA_FILE}" ]]; then
  cp "${SCHEMA_FILE}" "${TARGET_SCHEMA_FILE}"
  echo "Restored Strapi schema file: ${TARGET_SCHEMA_FILE}"
fi

echo "Restore completed from: ${BACKUP_DIR}"

#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCHEMA_FILE="${ROOT_DIR}/src/api/word-definition/content-types/word-definition/schema.json"

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
DB_SCHEMA="${DATABASE_SCHEMA:-public}"

BACKUP_BASE_DIR="${ROOT_DIR}/database/backup/word-definition"
TIMESTAMP="$(date +"%Y%m%d-%H%M%S")"
BACKUP_DIR="${BACKUP_BASE_DIR}/${DB_NAME}-${TIMESTAMP}"
TABLE_LIST_FILE="${BACKUP_DIR}/tables.txt"
DUMP_FILE="${BACKUP_DIR}/word-definition.dump"
SCHEMA_SQL_FILE="${BACKUP_DIR}/word-definition-schema.sql"
MANIFEST_FILE="${BACKUP_DIR}/manifest.txt"

mkdir -p "${BACKUP_DIR}"
cp "${SCHEMA_FILE}" "${BACKUP_DIR}/schema.word-definition.json"

export PGPASSWORD="${DB_PASSWORD}"

psql -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" -d "${DB_NAME}" -At -F $'\t' -c "
WITH base_tables AS (
  SELECT tablename
  FROM pg_tables
  WHERE schemaname = '${DB_SCHEMA}'
    AND (
      tablename = 'word_definitions'
      OR tablename LIKE 'word_definitions%'
      OR tablename LIKE '%word_definition%'
      OR tablename IN ('components_a_taglists', 'components_a_verb_metas')
    )
),
fk_tables AS (
  SELECT DISTINCT tc.table_name AS tablename
  FROM information_schema.table_constraints tc
  JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
   AND tc.constraint_schema = ccu.constraint_schema
  WHERE tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema = '${DB_SCHEMA}'
    AND ccu.table_schema = '${DB_SCHEMA}'
    AND ccu.table_name = 'word_definitions'
)
SELECT DISTINCT tablename
FROM (
  SELECT tablename FROM base_tables
  UNION
  SELECT tablename FROM fk_tables
) all_tables
ORDER BY tablename;
" > "${TABLE_LIST_FILE}"

if [[ ! -s "${TABLE_LIST_FILE}" ]]; then
  echo "No tables found for word_definition backup in schema ${DB_SCHEMA}"
  unset PGPASSWORD
  exit 1
fi

TABLE_ARGS=()
while IFS= read -r table_name; do
  [[ -n "${table_name}" ]] || continue
  TABLE_ARGS+=("-t" "${DB_SCHEMA}.${table_name}")
done < "${TABLE_LIST_FILE}"

pg_dump \
  -h "${DB_HOST}" \
  -p "${DB_PORT}" \
  -U "${DB_USER}" \
  -d "${DB_NAME}" \
  -F c \
  -b \
  -f "${DUMP_FILE}" \
  "${TABLE_ARGS[@]}"

pg_dump \
  -h "${DB_HOST}" \
  -p "${DB_PORT}" \
  -U "${DB_USER}" \
  -d "${DB_NAME}" \
  --schema-only \
  -f "${SCHEMA_SQL_FILE}" \
  "${TABLE_ARGS[@]}"

{
  echo "backup_dir=${BACKUP_DIR}"
  echo "database=${DB_NAME}"
  echo "schema=${DB_SCHEMA}"
  echo "created_at=${TIMESTAMP}"
  echo "schema_file=schema.word-definition.json"
  echo "dump_file=$(basename "${DUMP_FILE}")"
  echo "schema_sql_file=$(basename "${SCHEMA_SQL_FILE}")"
  echo "tables_file=$(basename "${TABLE_LIST_FILE}")"
} > "${MANIFEST_FILE}"

unset PGPASSWORD

echo "Backup completed: ${BACKUP_DIR}"
echo "Tables included:"
cat "${TABLE_LIST_FILE}"

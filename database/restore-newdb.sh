#!/bin/bash
set -e
[ $# -lt 2 ] && { echo "Usage: $0 <newdbname> <backup_file> [--verbose]"; exit 1; }
NEW_DBNAME="$1"
BACKUP_FILE="$2"
VERBOSE_FLAG=$3
DB_ADMIN_USER="postgres"
DB_ADMIN_PASSWORD="Passw0rd@P0stgres"
DB_APP_USER="strapi"
DB_HOST="/cloudsql/lucid-arch-451211-b0:us-west1:cloud-sql-server"

[ ! -f "$BACKUP_FILE" ] && { echo "❌ Backup file '$BACKUP_FILE' not found"; exit 1; }
echo "✔️ Starting database '$NEW_DBNAME' creation and restore..."

export PGPASSWORD="$DB_ADMIN_PASSWORD"
psql -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "postgres" -tAc "SELECT 1 FROM pg_database WHERE datname='$NEW_DBNAME'" | grep -q 1 && \
  psql -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "postgres" -c "DROP DATABASE \"$NEW_DBNAME\";" || echo "✔️ No existing database '$NEW_DBNAME'."
psql -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "postgres" -c "CREATE DATABASE \"$NEW_DBNAME\";"
psql -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "postgres" -c "GRANT ALL PRIVILEGES ON DATABASE \"$NEW_DBNAME\" TO \"$DB_APP_USER\";"
pg_restore -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "$NEW_DBNAME" ${VERBOSE_FLAG:+-v} "$BACKUP_FILE"
psql -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "$NEW_DBNAME" -c "REASSIGN OWNED BY \"$DB_ADMIN_USER\" TO \"$DB_APP_USER\";"
psql -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "postgres" -c "ALTER DATABASE \"$NEW_DBNAME\" OWNER TO \"$DB_APP_USER\";"
psql -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "$NEW_DBNAME" -tAc "SELECT 1 FROM information_schema.tables WHERE table_name='user_words'" | grep -q 1 || \
  { echo "❌ Table 'user_words' not found in '$NEW_DBNAME'"; exit 1; }
echo "✔️ Table 'user_words' confirmed in '$NEW_DBNAME'."
unset PGPASSWORD
echo "✅ Database '$NEW_DBNAME' created and restored successfully!"
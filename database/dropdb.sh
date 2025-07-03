#!/bin/bash
set -e
[ $# -ne 1 ] && { echo "Usage: $0 <dbname>"; exit 1; }
DB_NAME="$1"
DB_ADMIN_USER="postgres"
DB_ADMIN_PASSWORD="Passw0rd@P0stgres"
DB_HOST="/cloudsql/lucid-arch-451211-b0:us-west1:cloud-sql-server"

echo "✔️ Checking and dropping database '$DB_NAME'..."
export PGPASSWORD="$DB_ADMIN_PASSWORD"
psql -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "postgres" -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'" | grep -q 1 && \
  psql -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "postgres" -c "DROP DATABASE \"$DB_NAME\";" || echo "✔️ Database '$DB_NAME' does not exist."
unset PGPASSWORD
echo "✅ Database '$DB_NAME' dropped successfully!"
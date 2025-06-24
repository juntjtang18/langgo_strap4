#!/bin/bash

# --- Configuration ---
# Exit immediately if a command exits with a non-zero status.
set -e
# Treat unset variables as an error when substituting.
set -u
# Pipelines return the exit status of the last command to exit with a non-zero status.
set -o pipefail

DB_ADMIN_USER="postgres"
DB_APP_USER="strapi"
DB_NAME="langgo-en-dev1"
DB_HOST_SOCKET="/cloudsql/lucid-arch-451211-b0:us-west1:cloud-sql-server"
DB_ADMIN_PASSWORD="Passw0rd@P0stgres"


echo "Connecting as admin user '$DB_ADMIN_USER' to drop and recreate database '$DB_NAME'..."
PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "$DB_HOST_SOCKET" -U "$DB_ADMIN_USER" -d "postgres" -c "DROP DATABASE IF EXISTS \"$DB_NAME\";"
PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "$DB_HOST_SOCKET" -U "$DB_ADMIN_USER" -d "postgres" -c "CREATE DATABASE \"$DB_NAME\";"
echo "Database '$DB_NAME' created."

echo "Setting owner and granting privileges for '$DB_NAME' to user '$DB_APP_USER'..."
PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "$DB_HOST_SOCKET" -U "$DB_ADMIN_USER" -d "postgres" -c "GRANT dbadmin TO \"$DB_ADMIN_USER\";"

PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "$DB_HOST_SOCKET" -U "$DB_ADMIN_USER" -d "postgres" -c "GRANT \"$DB_APP_USER\" TO \"$DB_ADMIN_USER\";"

PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "$DB_HOST_SOCKET" -U "$DB_ADMIN_USER" -d "postgres" -c "ALTER DATABASE \"$DB_NAME\" OWNER TO \"$DB_APP_USER\";"
PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "$DB_HOST_SOCKET" -U "$DB_ADMIN_USER" -d "$DB_NAME" -c "GRANT ALL PRIVILEGES ON DATABASE \"$DB_NAME\" TO \"$DB_APP_USER\";"
echo "Ownership and privileges granted to '$DB_APP_USER'."

unset PGPASSWORD

echo "--------------------------------------------------"
echo "Process finished successfully."
echo "Database '$DB_NAME' is ready for use by user '$DB_APP_USER'."
echo "--------------------------------------------------"

#!/bin/bash

# --- Configuration ---
# Exit immediately if a command exits with a non-zero status.
set -e
# Treat unset variables as an error when substituting.
set -u
# Pipelines return the exit status of the last command to exit with a non-zero status.
set -o pipefail

# --- Database Connection Details ---
DB_ADMIN_USER="postgres"
DB_APP_USER="strapi"
DB_NAME="langgo-en-dev1"
DB_HOST_SOCKET="/cloudsql/lucid-arch-451211-b0:us-west1:cloud-sql-server"
DB_ADMIN_PASSWORD="Passw0rd@P0stgres"

# --- Backup Configuration ---
BACKUP_BASE_DIR="/Users/James/develop/apple/strapi-backup/backup/langgo-trapi4/database"
DATETIME=$(date +"%Y%m%d-%H%M%S")
BACKUP_FILE="${BACKUP_BASE_DIR}/${DB_NAME}-${DATETIME}.sql"

# --- Main Script Logic ---

# Create the backup directory if it doesn't exist
echo "Ensuring backup directory exists: ${BACKUP_BASE_DIR}"
mkdir -p "${BACKUP_BASE_DIR}"

echo "Checking for database: ${DB_NAME} on Google Cloud SQL instance..."

# Use the admin user to check if the database exists.
# On Cloud SQL, we connect to the 'postgres' maintenance database to check.
if PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "${DB_HOST_SOCKET}" -U "${DB_ADMIN_USER}" -d postgres -lqt | cut -d \| -f 1 | grep -qw "${DB_NAME}"; then
    
    echo "Database '${DB_NAME}' found. Proceeding with backup."

    # 1. Backup the database
    echo "Backing up '${DB_NAME}' to '${BACKUP_FILE}'..."
    PGPASSWORD=$DB_ADMIN_PASSWORD pg_dump -h "${DB_HOST_SOCKET}" -U "${DB_ADMIN_USER}" -d "${DB_NAME}" -F c -b -v -f "${BACKUP_FILE}"
    echo "Backup completed successfully."

else
    echo "Database '${DB_NAME}' not found. It will be created."
fi

# 2. Drop and Recreate Database using psql for Google Cloud SQL compatibility
echo "Connecting as admin user '$DB_ADMIN_USER' to drop and recreate database '$DB_NAME'..."

# Connect to the default 'postgres' database to perform administrative tasks.
# The "IF EXISTS" clause prevents an error if the DB was not found initially.
PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "$DB_HOST_SOCKET" -U "$DB_ADMIN_USER" -d "postgres" -c "DROP DATABASE IF EXISTS \"$DB_NAME\";"
PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "$DB_HOST_SOCKET" -U "$DB_ADMIN_USER" -d "postgres" -c "CREATE DATABASE \"$DB_NAME\";"
echo "Database '$DB_NAME' created."

# 3. Grant Ownership and Privileges
echo "Setting owner and granting privileges for '$DB_NAME' to user '$DB_APP_USER'..."

# In Google Cloud SQL, the admin user must first become a member of the target role
# before it can assign ownership of objects to that role.
PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "$DB_HOST_SOCKET" -U "$DB_ADMIN_USER" -d "postgres" -c "GRANT \"$DB_APP_USER\" TO \"$DB_ADMIN_USER\";"

# Now that the admin user is a member of the role, it can assign ownership.
PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "$DB_HOST_SOCKET" -U "$DB_ADMIN_USER" -d "postgres" -c "ALTER DATABASE \"$DB_NAME\" OWNER TO \"$DB_APP_USER\";"

# Grant all standard database privileges to the application user.
PGPASSWORD=$DB_ADMIN_PASSWORD psql -h "$DB_HOST_SOCKET" -U "$DB_ADMIN_USER" -d "$DB_NAME" -c "GRANT ALL PRIVILEGES ON DATABASE \"$DB_NAME\" TO \"$DB_APP_USER\";"

echo "Ownership and privileges granted to '$DB_APP_USER'."

# Unset the password from the environment for security
unset PGPASSWORD

echo "--------------------------------------------------"
echo "Process finished successfully."
if [ -f "$BACKUP_FILE" ]; then
    echo "Backup is located at: ${BACKUP_FILE}"
fi
echo "Database '$DB_NAME' is ready for use by user '$DB_APP_USER'."
echo "--------------------------------------------------"

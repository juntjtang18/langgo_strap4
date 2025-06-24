#!/bin/bash

# --- Configuration ---
# Exit immediately if a command exits with a non-zero status.
set -e
# Treat unset variables as an error when substituting.
set -u
# Pipelines return the exit status of the last command to exit with a non-zero status.
set -o pipefail

# --- Database Connection Details ---
# Details from your original script.
DB_USER="postgres"
DB_NAME="langgo-en-dev1"
DB_HOST="/cloudsql/lucid-arch-451211-b0:us-west1:cloud-sql-server"
# WARNING: Hardcoding passwords is not secure. Consider using a .pgpass file.
DB_PASSWORD="Passw0rd@P0stgres"

# --- Backup Configuration ---
BACKUP_BASE_DIR="./backup"
DATETIME=$(date +"%Y%m%d-%H%M%S")
BACKUP_FILE="${BACKUP_BASE_DIR}/${DB_NAME}-${DATETIME}.sql"

# --- Main Script Logic ---

# 1. Create the backup directory if it doesn't exist
echo "Ensuring backup directory exists: ${BACKUP_BASE_DIR}"
mkdir -p "${BACKUP_BASE_DIR}"

# 2. Backup the database
echo "Backing up database '${DB_NAME}' from host socket '${DB_HOST}'..."

# Use PGPASSWORD to provide the password to the command.
# This avoids it being visible in the process list.
export PGPASSWORD=$DB_PASSWORD

# Using the custom format (-F c), blobs (-b), and verbose (-v) flags from your original script.
pg_dump -h "${DB_HOST}" -U "${DB_USER}" -d "${DB_NAME}" -F c -b -v -f "${BACKUP_FILE}"

# Unset the password from the environment for security
unset PGPASSWORD

echo "--------------------------------------------------"
echo "Backup completed successfully!"
echo "Backup file is located at: ${BACKUP_FILE}"
echo "--------------------------------------------------"

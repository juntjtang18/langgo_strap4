#!/bin/bash
set -e
DB_ADMIN_USER="postgres"
DB_ADMIN_PASSWORD="Passw0rd@P0stgres"
DB_HOST="/cloudsql/lucid-arch-451211-b0:us-west1:cloud-sql-server"
SOURCE_DB="newlanggodb"
TARGET_DB="langgo-en-dev1"

echo "✔️ Starting user_words update from $SOURCE_DB to $TARGET_DB..."

export PGPASSWORD="$DB_ADMIN_PASSWORD"
# Export id and word from source database
psql -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "$SOURCE_DB" -t -A -F"," -c "SELECT id, word FROM user_words" > /tmp/user_words.csv
[ ! -s /tmp/user_words.csv ] && { echo "❌ No data found in $SOURCE_DB.user_words"; exit 1; }

# Update target_text in target database using CSV data
while IFS=, read -r id word; do
  psql -h "$DB_HOST" -U "$DB_ADMIN_USER" -d "$TARGET_DB" -c "UPDATE user_words SET target_text = '$word' WHERE id = $id;"
done < /tmp/user_words.csv

#rm -f /tmp/user_words.csv
unset PGPASSWORD
echo "✅ Updated target_text in $TARGET_DB.user_words successfully!"
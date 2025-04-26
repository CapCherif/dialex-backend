#!/bin/sh

echo "⏳ Attente de MySQL sur $DB_HOST:$DB_PORT..."

until nc -z "$DB_HOST" "$DB_PORT"; do
  sleep 1
done

echo "✅ MySQL est prêt, lancement du backend..."
exec "$@"

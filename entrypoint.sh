#!/bin/sh
set -eu

echo "==> Boot PocketBase on Render"

# 1) Optionnel : forcer un premier démarrage (si RESET_DB=1)
if [ "${RESET_DB:-0}" = "1" ]; then
  echo "==> RESET_DB=1: wiping /app/pb_data"
  rm -rf /app/pb_data
fi

# 2) Créer/mettre à jour le superuser si email+mdp fournis
if [ -n "${ADMIN_EMAIL:-}" ] && [ -n "${ADMIN_PASSWORD:-}" ]; then
  echo "==> Upserting superuser ${ADMIN_EMAIL}"
  /app/pocketbase superuser upsert "${ADMIN_EMAIL}" "${ADMIN_PASSWORD}"
fi

# 3) Démarrer PocketBase
echo "==> Starting PocketBase"
exec /app/pocketbase serve --http=0.0.0.0:8080

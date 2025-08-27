#!/bin/sh
set -eu

echo "==> Boot PocketBase on Render"

# ----- (1) Empêche les wipes accidentels -----
if [ "${RESET_DB:-0}" = "1" ]; then
  echo "==> RESET_DB=1: wiping /app/pb_data"
  rm -rf /app/pb_data
fi

# Assure l'existence du dossier data (et droits)
mkdir -p /app/pb_data
chmod -R 755 /app/pb_data

# ----- (2) Crée/MAJ un superadmin si fourni -----
# -> configure ADMIN_EMAIL et ADMIN_PASSWORD dans Render > Environment
if [ -n "${ADMIN_EMAIL:-}" ] && [ -n "${ADMIN_PASSWORD:-}" ]; then
  echo "==> Upserting superuser ${ADMIN_EMAIL}"
  /app/pocketbase superuser upsert "${ADMIN_EMAIL}" "${ADMIN_PASSWORD}"
fi

# ----- (3) Démarre PocketBase sur le port imposé par Render -----
PORT="${PORT:-10000}"     # Render fournit $PORT; fallback 10000
echo "==> Starting PocketBase on 0.0.0.0:${PORT}"
/app/pocketbase set settings.allowOrigins '["http://localhost:19006","exp://*","https://pocketbasecoliperforma.onrender.com"]'
exec /app/pocketbase serve --http="0.0.0.0:${PORT}" --dir="/app/pb_data"

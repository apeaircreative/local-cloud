#!/bin/bash
#
# MinIO Client Setup Script for local instance only

set -e

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

MC_ALIAS=${MC_ALIAS:-localminio}
MINIO_HOST=${MINIO_HOST:-http://localhost:9000}
MINIO_USER=${MINIO_USER:-admin}
MINIO_PASS=${MINIO_PASS:-adminpassword}

if [ -z "$MINIO_USER" ] || [ -z "$MINIO_PASS" ]; then
  echo "ERROR: MINIO_USER and MINIO_PASS must be set in environment or .env file."
  exit 1
fi

echo "Setting up mc alias for local MinIO..."

mc alias set "$MC_ALIAS" "$MINIO_HOST" "$MINIO_USER" "$MINIO_PASS" --insecure

echo "MinIO client alias configured."

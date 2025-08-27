#!/bin/bash
#
# MinIO Key Rotation Pipeline Script for local environment

set -e

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

echo "Starting MinIO Key Rotation Pipeline..."

if [ ! -f scripts/minio-key-rotation.sh ]; then
  echo "ERROR: Key rotation script not found at scripts/minio-key-rotation.sh"
  exit 1
fi

# Run key rotation script
bash scripts/minio-key-rotation.sh

# Additional steps (e.g., backups, notifications) can be added here

echo "MinIO Key Rotation Pipeline completed successfully."

#!/bin/bash
#
# MinIO Server KMS (Key Management Service) Setup Script for local environment

set -e

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

MINIO_KMS_KES_ENDPOINT=${MINIO_KMS_KES_ENDPOINT:-http://localhost:7373}
MINIO_KMS_KES_KEY_FILE=${MINIO_KMS_KES_KEY_FILE:-/path/to/local/kms/key}

echo "Configuring MinIO Server with KMS..."

export MINIO_KMS_KES_ENDPOINT
export MINIO_KMS_KES_KEY_FILE

# Start MinIO server with KMS enabled (adjust path as needed)
minio server /data --kms-kes-endpoint "$MINIO_KMS_KES_ENDPOINT" --kms-kes-key-file "$MINIO_KMS_KES_KEY_FILE"

echo "MinIO Server KMS setup complete."

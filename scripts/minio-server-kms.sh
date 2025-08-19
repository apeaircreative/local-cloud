#!/bin/bash
#
# MinIO Server KMS (Key Management Service) Setup Script for local environment

set -e

echo "Configuring MinIO Server with KMS..."

# Example local environment variables for KMS
export MINIO_KMS_KES_ENDPOINT="http://localhost:7373"
export MINIO_KMS_KES_KEY_FILE="/path/to/local/kms/key"

# Start MinIO server with KMS enabled (adjust paths for your setup)
minio server /data --kms-kes-endpoint "$MINIO_KMS_KES_ENDPOINT" --kms-kes-key-file "$MINIO_KMS_KES_KEY_FILE"

echo "MinIO Server KMS setup complete."

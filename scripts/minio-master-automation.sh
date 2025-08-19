#!/bin/bash
#
# MinIO Master Automation Script for local setup only

set -e

echo "Starting MinIO Master Automation (local environment)..."

bash scripts/minio-mc-setup.sh
bash scripts/minio-mkcert-setup.sh

# Adjust bucket name to your local bucket
bash scripts/minio-bucket-policy.sh mybucket

bash scripts/minio-user-policy-setup.sh
bash scripts/minio-service-account.sh

bash scripts/minio-key-rotation.sh

# Encrypted upload with full path and environment variable key
export MINIO_ENCRYPTION_KEY="your-very-secure-encryption-key"  # Set this securely in production

echo "Encrypting and uploading testfile.txt from Desktop..."
bash scripts/minio-mc-encrypt-upload.sh /Users/aaliyah/Desktop/backend-server/examples/testfile.txt mybucket

echo "MinIO Master Automation completed successfully."

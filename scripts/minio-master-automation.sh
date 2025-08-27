#!/bin/bash
#
# MinIO Master Automation Script for local setup only

set -e

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

echo "Starting MinIO Master Automation (local environment)..."

# Check and run dependent scripts
for script in minio-mc-setup.sh minio-mkcert-setup.sh minio-bucket-policy.sh minio-user-policy-setup.sh minio-service-account.sh minio-key-rotation.sh minio-mc-encrypt-upload.sh; do
  if [ ! -f scripts/$script ]; then
    echo "ERROR: Required script scripts/$script not found."
    exit 1
  fi
done

bash scripts/minio-mc-setup.sh
bash scripts/minio-mkcert-setup.sh

# Adjust bucket name from env or fallback
TARGET_BUCKET=${BUCKET_NAME:-mybucket}
bash scripts/minio-bucket-policy.sh "$TARGET_BUCKET"

bash scripts/minio-user-policy-setup.sh
bash scripts/minio-service-account.sh

bash scripts/minio-key-rotation.sh

# Export encryption key securely
if [ -z "$MINIO_ENCRYPTION_KEY" ]; then
  echo "WARNING: MINIO_ENCRYPTION_KEY not set in environment, using default weak key!"
  export MINIO_ENCRYPTION_KEY="your-very-secure-encryption-key"
else
  export MINIO_ENCRYPTION_KEY
fi

echo "Encrypting and uploading testfile.txt from Desktop..."
bash scripts/minio-mc-encrypt-upload.sh /Users/aaliyah/Desktop/backend-server/examples/testfile.txt "$TARGET_BUCKET"

echo "MinIO Master Automation completed successfully."

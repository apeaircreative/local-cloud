#!/bin/bash
#
# MinIO Master Automation Script
# Orchestrates all automation scripts end-to-end

set -e

echo "Starting MinIO Master Automation..."

bash scripts/minio-mc-setup.sh

bash scripts/minio-mkcert-setup.sh

bash scripts/minio-bucket-policy.sh mybucket

bash scripts/minio-user-policy-setup.sh

bash scripts/minio-service-account.sh

bash scripts/minio-key-rotation-pipeline.sh

echo "MinIO Master Automation completed successfully."

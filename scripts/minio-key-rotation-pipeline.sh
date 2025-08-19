#!/bin/bash
#
# MinIO Key Rotation Pipeline Script
# Runs scheduled key rotation tasks in a pipeline fashion

set -e

echo "Starting MinIO Key Rotation Pipeline..."

# Run key rotation script
bash scripts/minio-key-rotation.sh

# (Optional) Add other pipeline steps here like notifications, backups, etc.

echo "MinIO Key Rotation Pipeline completed successfully."

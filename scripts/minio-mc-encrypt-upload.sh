#!/bin/bash
#
# MinIO Client Encrypt and Upload Script (local environment)

set -e

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

MC_ALIAS=${MC_ALIAS:-localminio}
ENCRYPTION_KEY=${MINIO_ENCRYPTION_KEY:-}
FILE_TO_UPLOAD=$1
BUCKET_NAME=$2

if [ -z "$FILE_TO_UPLOAD" ] || [ -z "$BUCKET_NAME" ]; then
  echo "Usage: $0 <file-to-upload> <bucket-name>"
  exit 1
fi

if [ -z "$ENCRYPTION_KEY" ]; then
  echo "ERROR: Encryption key (MINIO_ENCRYPTION_KEY) is not set!"
  exit 1
fi

echo "Encrypting and uploading $FILE_TO_UPLOAD to bucket $BUCKET_NAME..."

# Encrypt the file locally using openssl AES-256-CBC
openssl enc -aes-256-cbc -salt -in "$FILE_TO_UPLOAD" -out "$FILE_TO_UPLOAD.enc" -k "$ENCRYPTION_KEY"

# Upload encrypted file to MinIO bucket
mc cp "$FILE_TO_UPLOAD.enc" "$MC_ALIAS/$BUCKET_NAME/"

echo "Upload complete. Removing local encrypted file."
rm "$FILE_TO_UPLOAD.enc"

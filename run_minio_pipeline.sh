#!/bin/bash
#
# Full MinIO Local Pipeline - Complete setup including master automation and upload.

set -e

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo ".env file not found. Exiting."
  exit 1
fi

echo "Stopping and removing existing MinIO container (if any)..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "Starting new MinIO Docker container..."
docker run -p 9000:9000 -p 9001:9001 \
  -e MINIO_ROOT_USER=$MINIO_USER \
  -e MINIO_ROOT_PASSWORD=$MINIO_PASS \
  -v $DATA_DIR:/data \
  --name $CONTAINER_NAME \
  -d minio/minio server /data --console-address ":9001"

echo "Waiting 10 seconds for MinIO server to initialize..."
sleep 10

echo "Creating MinIO client alias..."
mc alias set $MC_ALIAS $MINIO_HOST $MINIO_USER $MINIO_PASS --insecure

echo "Running MinIO Master Automation script..."
chmod +x scripts/minio-master-automation.sh
./scripts/minio-master-automation.sh

# Use consistent env var names for bucket and test file
: "${BUCKET_NAME:?Need to set BUCKET_NAME non-empty in .env}"
: "${TEST_FILE:?Need to set TEST_FILE non-empty in .env}"

if ! mc ls $MC_ALIAS/$BUCKET_NAME > /dev/null 2>&1; then
  echo "Creating bucket: $BUCKET_NAME"
  mc mb $MC_ALIAS/$BUCKET_NAME
else
  echo "Bucket $BUCKET_NAME already exists."
fi

# Ensure TEST_FILE is a full absolute path or relative to current dir
if [ ! -f "$TEST_FILE" ]; then
  echo "Creating test file: $TEST_FILE"
  echo "Hello, this is a test object for MinIO upload." > "$TEST_FILE"
fi

echo "Uploading $TEST_FILE to $BUCKET_NAME"
mc cp "$TEST_FILE" "$MC_ALIAS/$BUCKET_NAME/"

echo "Removing test file $TEST_FILE"
rm "$TEST_FILE"

echo "Full MinIO pipeline completed successfully."
echo "Access MinIO Web Console at http://localhost:9001 with user '$MINIO_USER'"

#!/bin/bash
#
# Full MinIO Local Pipeline - Complete setup including master automation and upload.

set -e

DATA_DIR="/Users/aaliyah/Desktop/backend-server/data"
MINIO_USER="admin"
MINIO_PASS="adminpassword"
CONTAINER_NAME="localminio"
MC_ALIAS="localminio"
TEST_BUCKET="mybucket"
TEST_FILE="testfile.txt"

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
mc alias set $MC_ALIAS http://localhost:9000 $MINIO_USER $MINIO_PASS --insecure

echo "Running MinIO Master Automation script..."
chmod +x scripts/minio-master-automation.sh
./scripts/minio-master-automation.sh

if ! mc ls $MC_ALIAS/$TEST_BUCKET > /dev/null 2>&1; then
  echo "Creating bucket: $TEST_BUCKET"
  mc mb $MC_ALIAS/$TEST_BUCKET
else
  echo "Bucket $TEST_BUCKET already exists."
fi

echo "Creating test file: $TEST_FILE"
echo "Hello, this is a test object for MinIO upload." > $TEST_FILE

echo "Uploading $TEST_FILE to $TEST_BUCKET"
mc cp $TEST_FILE $MC_ALIAS/$TEST_BUCKET/

rm $TEST_FILE

echo "Full MinIO pipeline completed successfully."
echo "Access MinIO Web Console at http://localhost:9001 with user '$MINIO_USER'"

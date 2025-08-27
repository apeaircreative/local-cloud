#!/bin/bash
#
# MinIO Replication Setup Script for local-to-local replication

set -e

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

MC_ALIAS=${MC_ALIAS:-localminio}
SOURCE_BUCKET=${SOURCE_BUCKET:-sourcebucket}
TARGET_ALIAS=${TARGET_ALIAS:-localminio}
TARGET_BUCKET=${TARGET_BUCKET:-targetbucket}

echo "Setting up replication from $MC_ALIAS/$SOURCE_BUCKET to $TARGET_ALIAS/$TARGET_BUCKET"

mc replicate add "$MC_ALIAS/$SOURCE_BUCKET" "http://localhost:9000/$TARGET_BUCKET" --replicate "delete"

echo "Replication configured successfully."

#!/bin/bash
#
# MinIO Replication Setup Script for local-to-local replication

set -e

MC_ALIAS="localminio"
SOURCE_BUCKET="sourcebucket"
TARGET_ALIAS="localminio"  # Assuming replication to same local instance; adjust as needed
TARGET_BUCKET="targetbucket"

echo "Setting up replication from $MC_ALIAS/$SOURCE_BUCKET to $TARGET_ALIAS/$TARGET_BUCKET"

# Enable bucket replication locally (command parameters depend on your MinIO version)
mc replicate add "$MC_ALIAS/$SOURCE_BUCKET" "http://localhost:9000/$TARGET_BUCKET" --replicate "delete"

echo "Replication configured successfully."

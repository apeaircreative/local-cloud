#!/bin/bash
#
# MinIO Replication Setup Script
# Configures replication between MinIO buckets/endpoints

set -e

MC_ALIAS="localminio"
SOURCE_BUCKET="sourcebucket"
TARGET_ALIAS="remoteminio"
TARGET_BUCKET="targetbucket"

echo "Setting up replication from $MC_ALIAS/$SOURCE_BUCKET to $TARGET_ALIAS/$TARGET_BUCKET"

# Enable bucket replication (example command, adjust as per your setup)
mc replicate add $MC_ALIAS/$SOURCE_BUCKET https://$TARGET_ALIAS/$TARGET_BUCKET --replicate "delete"

echo "Replication configured successfully."

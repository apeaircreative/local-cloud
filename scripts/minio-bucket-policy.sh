#!/bin/bash
#
# MinIO Bucket Policy Setup Script for local environment
# Usage: ./minio-bucket-policy.sh <bucket_name>

set -e

# Load environment variables from .env if exists
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Defaults
MC_ALIAS=${MC_ALIAS:-localminio}

if [ -z "$1" ]; then
  echo "ERROR: Bucket name must be provided as an argument"
  exit 1
fi

BUCKET_NAME=$1

# Verify mc CLI availability
if ! command -v mc &> /dev/null; then
  echo "ERROR: mc (MinIO client) not installed or not in PATH"
  exit 1
fi

echo "Setting read-only policy on bucket: $BUCKET_NAME"

read_only_policy=$(cat <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Principal": "*",
      "Resource": ["arn:aws:s3:::$BUCKET_NAME"]
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject"],
      "Principal": "*",
      "Resource": ["arn:aws:s3:::$BUCKET_NAME/*"]
    }
  ]
}
EOF
)

POLICY_FILE=$(mktemp)
echo "$read_only_policy" > "$POLICY_FILE"

mc anonymous set-json "$POLICY_FILE" $MC_ALIAS/$BUCKET_NAME

rm "$POLICY_FILE"

echo "Bucket policy applied successfully to $BUCKET_NAME"

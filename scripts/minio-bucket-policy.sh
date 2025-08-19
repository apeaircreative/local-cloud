#!/bin/bash
#
# MinIO Bucket Policy Setup Script
# Usage: ./minio-bucket-policy.sh <bucket_name>

set -e

if [ -z "$1" ]; then
  echo "ERROR: Bucket name must be provided as an argument"
  exit 1
fi

BUCKET_NAME=$1
MC_ALIAS="localminio"

echo "Setting public read-only policy on bucket: $BUCKET_NAME"

# Create a JSON policy granting read-only public access to the bucket
read_only_policy=$(cat <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Principal": {"AWS": ["*"]},
      "Resource": ["arn:aws:s3:::$BUCKET_NAME"]
    },
    {
      "Action": ["s3:GetObject"],
      "Effect": "Allow",
      "Principal": {"AWS": ["*"]},
      "Resource": ["arn:aws:s3:::$BUCKET_NAME/*"]
    }
  ]
}
EOF
)

# Write policy to a temporary file
POLICY_FILE=$(mktemp)
echo "$read_only_policy" > "$POLICY_FILE"

# Apply the bucket policy using mc
mc anonymous set download "$POLICY_FILE" $MC_ALIAS/$BUCKET_NAME

# Remove temporary file
rm "$POLICY_FILE"

echo "Bucket policy applied successfully to $BUCKET_NAME"

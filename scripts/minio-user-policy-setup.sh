#!/bin/bash
#
# MinIO User and Policy Setup Script

set -e

MC_ALIAS="localminio"

# Define users and their passwords (modify as needed)
declare -A users
users=( ["alice"]="alicepassword" ["bob"]="bobpassword" )

# Define policy to attach to users
POLICY_NAME="readonlypolicy"

echo "Creating policy: $POLICY_NAME"

# Create a simple read-only policy JSON
read_only_policy=$(cat <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["s3:GetBucketLocation", "s3:ListBucket", "s3:GetObject"],
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::*", "arn:aws:s3:::*/*"]
    }
  ]
}
EOF
)

# Write policy to a temporary file
POLICY_FILE=$(mktemp)
echo "$read_only_policy" > "$POLICY_FILE"

# Add the policy to MinIO
mc admin policy add $MC_ALIAS $POLICY_NAME "$POLICY_FILE"
rm "$POLICY_FILE"

# Create users and attach policy
for username in "${!users[@]}"; do
  password=${users[$username]}
  echo "Creating user: $username"
  mc admin user add $MC_ALIAS $username $password

  echo "Setting policy $POLICY_NAME for user $username"
  mc admin policy set $MC_ALIAS $POLICY_NAME user=$username
done

echo "User and policy setup complete."

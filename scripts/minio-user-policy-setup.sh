#!/usr/bin/env bash
#
# MinIO User and Policy Setup Script (macOS compatible, clean version)

set -e

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

MC_ALIAS=${MC_ALIAS:-localminio}

# Define users and passwords as two parallel arrays
usernames=("alice" "bob")
passwords=("alicepassword" "bobpassword")

POLICY_NAME="readonlypolicy"

read_only_policy=$(cat <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:GetObject"
      ],
      "Resource": ["arn:aws:s3:::*", "arn:aws:s3:::*/*"]
    }
  ]
}
EOF
)

POLICY_FILE=$(mktemp)
echo "$read_only_policy" > "$POLICY_FILE"
mc admin policy create $MC_ALIAS $POLICY_NAME "$POLICY_FILE"
rm "$POLICY_FILE"

for i in "${!usernames[@]}"; do
  username=${usernames[$i]}
  password=${passwords[$i]}

  mc admin user add $MC_ALIAS $username $password
  mc admin policy attach $MC_ALIAS $POLICY_NAME --user $username
done

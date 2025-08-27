#!/usr/bin/env bash
#
# MinIO Service Account Creation Script for local MinIO (macOS bash compatible)

set -e

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

MC_ALIAS=${MC_ALIAS:-localminio}

# Define service accounts and their policies as parallel arrays
service_accounts=("service1" "service2")
policies=("readonlypolicy" "writepolicy")

echo "Creating local-only read-only policy: readonlypolicy"
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

READ_POLICY_FILE=$(mktemp)
echo "$read_only_policy" > "$READ_POLICY_FILE"
mc admin policy create $MC_ALIAS readonlypolicy "$READ_POLICY_FILE"
rm "$READ_POLICY_FILE"

echo "Creating local write policy: writepolicy"
write_policy=$(cat <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": ["arn:aws:s3:::*", "arn:aws:s3:::*/*"]
    }
  ]
}
EOF
)

WRITE_POLICY_FILE=$(mktemp)
echo "$write_policy" > "$WRITE_POLICY_FILE"
mc admin policy create $MC_ALIAS writepolicy "$WRITE_POLICY_FILE"
rm "$WRITE_POLICY_FILE"

echo "Creating service accounts with local policies..."

for i in "${!service_accounts[@]}"; do
  sa=${service_accounts[$i]}
  policy=${policies[$i]}
  echo "Creating service account: $sa"

  # Generate a random strong password
  password=$(openssl rand -base64 20)

  mc admin user add $MC_ALIAS $sa $password
  echo "Attaching policy $policy to $sa"
  mc admin policy attach $MC_ALIAS $policy --user $sa
done

echo "Service accounts created successfully."

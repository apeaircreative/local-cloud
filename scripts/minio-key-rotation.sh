#!/bin/bash
#
# MinIO Key Rotation Script
# Rotates access and secret keys for users securely.

set -e

MC_ALIAS="localminio"

# List of users to rotate keys for — update as needed
users=("alice" "bob" "service1" "service2")

echo "Starting key rotation for users: ${users[*]}"

for user in "${users[@]}"; do
  echo "Rotating keys for user: $user"

  # Generate new credentials (use secure generator)
  new_access_key=$(openssl rand -hex 10)
  new_secret_key=$(openssl rand -hex 20)

  # Update user password/secret key
  mc admin user disable $MC_ALIAS $user
  mc admin user add $MC_ALIAS $user $new_secret_key

  # Note: Adjust as per your MinIO user setup (keys or passwords)
  echo "New keys generated for user $user."
done

echo "Key rotation process completed."

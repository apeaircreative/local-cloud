#!/bin/bash
#
# MinIO Key Rotation Script for local environment users

set -e

MC_ALIAS="localminio"

# List of users for key rotation (local users only)
users=("alice" "bob" "service1" "service2")

echo "Starting key rotation for users: ${users[*]}"

for user in "${users[@]}"; do
  echo "Rotating keys for user: $user"

  # Generate a new strong password locally
  new_secret_key=$(openssl rand -hex 20)

  # Disable current user temporarily
  mc admin user disable $MC_ALIAS $user

  # Add user with new credentials (password rotation)
  mc admin user add $MC_ALIAS $user $new_secret_key

  echo "Keys rotated for user $user."
done

echo "Key rotation process completed."

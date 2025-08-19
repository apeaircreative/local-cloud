#!/bin/bash
#
# MinIO Service Account Creation Script

set -e

MC_ALIAS="localminio"

# Define service accounts and their policies (modify as needed)
declare -A service_accounts
service_accounts=( ["service1"]="readonlypolicy" ["service2"]="writepolicy" )

echo "Creating service accounts and attaching policies..."

# Create service accounts and set policies
for sa in "${!service_accounts[@]}"; do
  policy=${service_accounts[$sa]}
  echo "Creating service account: $sa"
  mc admin user add $MC_ALIAS $sa $(openssl rand -base64 20)  # random password

  echo "Attaching policy: $policy to $sa"
  mc admin policy set $MC_ALIAS $policy user=$sa
done

echo "Service account setup completed."

#!/bin/bash
#
# MinIO Client Setup Script
# Installs or configures mc (Minio Client)

set -e

echo "Setting up MinIO client..."

# Example of installing mc if not installed (Linux/Darwin)
if ! command -v mc &> /dev/null; then
  echo "mc not found. Installing..."
  curl -O https://dl.min.io/client/mc/release/darwin-amd64/mc
  chmod +x mc
  mv mc /usr/local/bin/
fi

# Configure alias for local MinIO server
mc alias set localminio http://localhost:9000 admin adminpassword

echo "MinIO client setup is complete."

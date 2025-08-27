#!/bin/bash
#
# MinIO mkcert Setup Script for locally-trusted certificates

set -e

# Load environment variables if needed
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

echo "Setting up mkcert and generating local certificates..."

if ! command -v mkcert &> /dev/null; then
  echo "mkcert not found. Installing..."
  brew install mkcert
  brew install nss  # For Firefox compatibility
fi

mkcert -install

# Generate certs for localhost and loopback IPs
mkcert localhost 127.0.0.1 ::1

echo "Certificates generated: localhost.pem, localhost-key.pem"

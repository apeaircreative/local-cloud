#!/bin/bash
#
# MinIO mkcert Setup Script
# Generates locally-trusted SSL certificates using mkcert

set -e

echo "Setting up mkcert and generating certificates..."

if ! command -v mkcert &> /dev/null; then
  echo "mkcert not found. Installing..."
  brew install mkcert
  brew install nss # for Firefox compatibility if needed
fi

mkcert -install
mkcert localhost 127.0.0.1 ::1

echo "Certificates generated: localhost.pem, localhost-key.pem"

#!/bin/bash
#
# MinIO Client Setup Script for local instance only

set -e

echo "Setting up mc alias for local MinIO..."

mc alias set localminio http://localhost:9000 admin adminpassword --insecure

echo "MinIO client alias configured."

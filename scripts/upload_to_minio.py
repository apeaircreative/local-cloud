#!/usr/bin/env python3
"""
Python script to upload files to MinIO bucket
"""

import sys
from minio import Minio
from minio.error import S3Error

def main():
    if len(sys.argv) != 3:
        print("Usage: upload_to_minio.py <file_path> <bucket_name>")
        sys.exit(1)

    file_path = sys.argv[1]
    bucket_name = sys.argv[2]

    client = Minio(
        "localhost:9000",
        access_key="admin",
        secret_key="adminpassword",
        secure=False
    )

    try:
        if not client.bucket_exists(bucket_name):
            client.make_bucket(bucket_name)
            print(f"Bucket {bucket_name} created.")
        client.fput_object(bucket_name, file_path.split('/')[-1], file_path)
        print(f"Uploaded {file_path} to bucket {bucket_name}.")
    except S3Error as err:
        print(f"Failed to upload: {err}")

if __name__ == "__main__":
    main()

# MinIO Dockerfile using official image

FROM minio/minio:latest

# Set environment variables (adjust as needed)
ENV MINIO_ACCESS_KEY=admin
ENV MINIO_SECRET_KEY=adminpassword

# Expose MinIO default port
EXPOSE 9000

# Start MinIO server with data directory
CMD ["server", "/data"]

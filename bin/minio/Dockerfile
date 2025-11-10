FROM quay.io/minio/minio:latest

COPY init-minio.sh /usr/local/bin/init-minio.sh
RUN chmod +x /usr/local/bin/init-minio.sh

# Usa o script como entrypoint
ENTRYPOINT ["/usr/local/bin/init-minio.sh"]
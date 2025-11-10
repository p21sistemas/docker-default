#!/bin/sh
set -e

echo "🚀 Iniciando MinIO..."
/usr/bin/minio server /data --console-address ":9001" &
MINIO_PID=$!

# Aguarda o MinIO responder na porta 9000
echo "⏳ Aguardando MinIO ficar pronto..."
until curl -sf http://localhost:9000/minio/health/ready > /dev/null; do
  sleep 2
done
echo "✅ MinIO está pronto."

# Configura o cliente MinIO
mc alias set local http://localhost:9000 "$MINIO_ROOT_USER" "$MINIO_ROOT_PASSWORD" >/dev/null 2>&1

# Cria bucket
BUCKET_NAME="${MINIO_BUCKET_NAME:-default-bucket}"
if mc ls local | grep -q "$BUCKET_NAME"; then
  echo "ℹ️  Bucket '$BUCKET_NAME' já existe."
else
  echo "🪣 Criando bucket '$BUCKET_NAME'..."
  mc mb -p "local/$BUCKET_NAME"
  mc anonymous set public "local/$BUCKET_NAME" >/dev/null 2>&1 || true
  echo "✅ Bucket '$BUCKET_NAME' criado."
fi

# Mantém o processo principal rodando
wait $MINIO_PID
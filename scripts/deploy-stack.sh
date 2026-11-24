#!/usr/bin/env bash

set -euo pipefail

IMAGE="$1"
RELEASE_URL="$2"
DEPLOY_DIR="/opt/devops-pipeline"
TEMP_DIR="/tmp/devops-release"
ARCHIVE="/tmp/devops-release.tar.gz"
PASSWORD_FILE="${DEPLOY_DIR}/.grafana_admin_password"
ENV_FILE="${DEPLOY_DIR}/.env"

echo "Waiting for EC2 bootstrap to complete..."
cloud-init status --wait

test -f /var/log/devops-bootstrap-complete
command -v docker
docker compose version
systemctl is-active --quiet docker

echo "Downloading deployment configuration..."
rm -rf "$TEMP_DIR" "$ARCHIVE"
mkdir -p "$TEMP_DIR"

curl --fail --location \
  "$RELEASE_URL" \
  --output "$ARCHIVE"

tar -xzf "$ARCHIVE" \
  --directory "$TEMP_DIR" \
  --strip-components=1

echo "Installing monitoring configuration..."
mkdir -p "$DEPLOY_DIR"
rm -rf "${DEPLOY_DIR}/monitoring"

cp "${TEMP_DIR}/compose.yaml" "${DEPLOY_DIR}/compose.yaml"
cp -r "${TEMP_DIR}/monitoring" "${DEPLOY_DIR}/monitoring"

echo "Preparing Grafana credentials..."
if [ ! -f "$PASSWORD_FILE" ]; then
    openssl rand -hex 16 > "$PASSWORD_FILE"
fi

chmod 600 "$PASSWORD_FILE"
# supply image and grafana password without storing in repo
{
    printf 'APP_IMAGE=%s\n' "$IMAGE"
    printf 'GRAFANA_ADMIN_PASSWORD='
    cat "$PASSWORD_FILE"
    printf '\n'
} > "$ENV_FILE"

chmod 600 "$ENV_FILE"

echo "Validating Compose configuration..."
cd "$DEPLOY_DIR"
docker compose config --quiet

echo "Pulling container images..."
docker compose pull

echo "Starting monitored application stack..."
docker compose up -d --remove-orphans

echo "Waiting for services..."
sleep 15

echo "Checking Flask..."
curl --fail --silent --show-error \
  http://localhost/health

echo "Checking Prometheus..."
curl --fail --silent --show-error \
  http://localhost:9090/-/ready

echo "Checking Grafana..."
curl --fail --silent --show-error \
  http://localhost:3000/api/health

echo "Deployed containers:"
docker compose ps

rm -rf "$TEMP_DIR" "$ARCHIVE"

echo "Monitoring stack deployed successfully."
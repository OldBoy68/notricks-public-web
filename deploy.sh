#!/usr/bin/env bash
set -euo pipefail

# NOTRICKS public site deploy
# Usage:
#   ./deploy.sh /path/to/key.pem
# Example:
#   ./deploy.sh ~/.ssh/notricks-aws.pem

KEY_PATH="${1:-}"
EC2_USER="ubuntu"
EC2_HOST="51.118.75.4"
REMOTE_DIR="/opt/notricks/notricks-public-web"

if [[ -z "${KEY_PATH}" ]]; then
  echo "ERROR: missing SSH key path."
  echo "Usage: $0 /path/to/key.pem"
  exit 1
fi

if [[ ! -f "${KEY_PATH}" ]]; then
  echo "ERROR: key not found: ${KEY_PATH}"
  exit 1
fi

# Best practice for OpenSSH: private key must not be group/world-readable
chmod 600 "${KEY_PATH}" 2>/dev/null || true

echo "Deploying to ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR} ..."
rsync -av --delete \
  --exclude ".git/" \
  -e "ssh -i ${KEY_PATH} -o IdentitiesOnly=yes" \
  ./ "${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}/"

echo
echo "Done."

echo
echo "Quick checks:"
echo "  curl -I https://notricks.app/"
echo "  curl -I https://notricks.app/assets/site.v1.css"


#!/usr/bin/env bash
set -euo pipefail

HOSTNAME="${1:-flexlng-models-service.foundation-models.svc.cluster.local}"

ANCHOR_NAME="dev_redirect"
ANCHOR_PATH="/etc/pf.anchors/${ANCHOR_NAME}"
PFCONF="/etc/pf.conf"

BEGIN_MARK="# BEGIN ${ANCHOR_NAME} (managed by pf-forward scripts)"
END_MARK="# END ${ANCHOR_NAME} (managed by pf-forward scripts)"

echo "Tearing down redirect for: ${HOSTNAME}"

sudo cp "${PFCONF}" "${PFCONF}.bak.$(date +%Y%m%d%H%M%S)"

# Remove /etc/hosts entry
sudo sed -i '' "/[[:space:]]${HOSTNAME}\b/d" /etc/hosts

# Remove managed block from pf.conf
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
sudo perl -0777 -pe "s/\n?\Q${BEGIN_MARK}\E.*?\Q${END_MARK}\E\n?/\n/s" "${PFCONF}" > "$tmp"
sudo cp "$tmp" "${PFCONF}"

# Remove anchor file
sudo rm -f "${ANCHOR_PATH}" || true

# Reload pf
sudo pfctl -f "${PFCONF}"

echo "Done."

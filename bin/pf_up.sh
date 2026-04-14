#!/usr/bin/env bash
set -euo pipefail

# Usage:
# ./pf-forward-up.sh <hostname> <loopback_ip> <src_port> <dst_ip> <dst_port>
HOSTNAME="${1:-flexlng-models-service.foundation-models.svc.cluster.local}"
SRC_IP="${2:-127.0.0.2}"
SRC_PORT="${3:-3000}"
DST_IP="${4:-127.0.0.1}"
DST_PORT="${5:-13004}"

ANCHOR_NAME="dev_redirect"
ANCHOR_PATH="/etc/pf.anchors/${ANCHOR_NAME}"
PFCONF="/etc/pf.conf"

BEGIN_MARK="# BEGIN ${ANCHOR_NAME} (managed by pf-forward scripts)"
END_MARK="# END ${ANCHOR_NAME} (managed by pf-forward scripts)"

echo "Setting up redirect: ${HOSTNAME}:${SRC_PORT} -> ${DST_IP}:${DST_PORT}"
echo "Hosts: ${HOSTNAME} -> ${SRC_IP}"

# Backup pf.conf
sudo cp "${PFCONF}" "${PFCONF}.bak.$(date +%Y%m%d%H%M%S)"

# 1) /etc/hosts: replace any existing line for HOSTNAME, then add ours
sudo sed -i '' "/[[:space:]]${HOSTNAME}\b/d" /etc/hosts
printf "%s\t%s\n" "$SRC_IP" "$HOSTNAME" | sudo tee -a /etc/hosts >/dev/null

# 2) Write anchor rules (translation rule)
sudo tee "${ANCHOR_PATH}" >/dev/null <<PF
rdr pass on lo0 inet proto tcp from any to ${SRC_IP} port ${SRC_PORT} -> ${DST_IP} port ${DST_PORT}
PF

# 3) Patch pf.conf:
#    - remove old managed block
#    - insert new managed block BEFORE FIRST FILTERING RULE:
#      filtering starts at: block/pass/anchor  (macOS often has anchor lines before any block/pass)
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

sudo perl -0777 -pe "s/\n?\Q${BEGIN_MARK}\E.*?\Q${END_MARK}\E\n?/\n/s" "${PFCONF}" > "$tmp"

BLOCK_CONTENT="$(cat <<PF
${BEGIN_MARK}
# dev loopback redirect (translation)
rdr-anchor "${ANCHOR_NAME}"
load anchor "${ANCHOR_NAME}" from "${ANCHOR_PATH}"
${END_MARK}

PF
)"

python3 - "$tmp" "$BLOCK_CONTENT" <<'PY'
import re, sys
path = sys.argv[1]
block = sys.argv[2]
txt = open(path, "r", encoding="utf-8").read()

# First filtering directive (not commented):
# - block / pass / anchor
m = re.search(r'(?m)^(?!\s*#)\s*(block|pass|anchor)\b', txt)

if m:
    out = txt[:m.start()] + block + txt[m.start():]
else:
    # If no explicit filtering directives exist, append (rare)
    out = txt.rstrip() + "\n\n" + block

open(path, "w", encoding="utf-8").write(out)
PY

sudo cp "$tmp" "${PFCONF}"

# 4) Reload pf and enable
sudo pfctl -f "${PFCONF}"
sudo pfctl -E 2>/dev/null || true

echo "Verify NAT rules include redirect:"
sudo pfctl -sn | egrep "rdr|${SRC_IP}|${DST_PORT}|${SRC_PORT}" || true

echo "Done. Test:"
echo "  curl -v http://${HOSTNAME}:${SRC_PORT}/"

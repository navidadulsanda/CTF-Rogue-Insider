#!/usr/bin/env bash
# Stage 2 solver - Cryptography (MD5 dictionary crack with John)
# Usage: ./stage2_crypto.sh [md5hash]
HASH="${1:-5fcfd41e547a12215b173ff47fdd3739}"
TMP="$(mktemp)"
echo "$HASH" > "$TMP"
john --format=raw-md5 --wordlist=/usr/share/wordlists/rockyou.txt "$TMP"
john --show --format=raw-md5 "$TMP"
rm -f "$TMP"
# -> trustno1  => ROGUE{trustno1}

#!/usr/bin/env bash
# Stage 3 solver - Forensics (recover FTP details from the capture)
# Usage: ./stage3_forensics.sh [stage3.pcap]
PCAP="${1:-stage3.pcap}"
echo "[*] FTP commands + arguments (server IP in the conversation, login, RETR file):"
tshark -r "$PCAP" -Y ftp -T fields -e ftp.request.command -e ftp.request.arg
# assemble -> ROGUE{10.10.50.15_ml_model_v3.enc}

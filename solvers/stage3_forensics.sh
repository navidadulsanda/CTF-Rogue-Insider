#!/usr/bin/env bash
# Stage 3 solver - Forensics (recover FTP exfiltration details from the capture)
# The flag is: ROGUE{<server-ip>_<exfiltrated .enc filename>}
# Usage: ./stage3_forensics.sh [stage3.pcap]
PCAP="${1:-stage3.pcap}"

echo "[*] FTP commands + arguments (login, server, exfiltrated files):"
tshark -r "$PCAP" -Y ftp -T fields -e ftp.request.command -e ftp.request.arg

HOST=$(tshark -r "$PCAP" -Y ftp -T fields -e ip.dst 2>/dev/null | sort -u | tail -n1)
FILE=$(tshark -r "$PCAP" -Y 'ftp.request.command==STOR' -T fields -e ftp.request.arg 2>/dev/null | grep '\.enc' | head -n1)

echo
echo "[+] Flag: ROGUE{${HOST}_${FILE}}"

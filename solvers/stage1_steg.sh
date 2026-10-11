#!/usr/bin/env bash
# Stage 1 solver - Steganography
# The EXIF Comment holds a backup note ending in a Base64 credential.
# Grab the last whitespace-separated token (the Base64 part) and decode it.
# Usage: ./stage1_steg.sh [avatar.jpg]
IMG="${1:-avatar.jpg}"
exiftool -b -Comment "$IMG" | awk '{print $NF}' | base64 -d
echo
# -> Backup123!   => ROGUE{Backup123!}

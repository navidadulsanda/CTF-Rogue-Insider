#!/usr/bin/env bash
# Stage 1 solver - Steganography
# Reads the hidden Base64 note from the image's EXIF Comment and decodes it.
# Usage: ./stage1_steg.sh [avatar.jpg]
IMG="${1:-avatar.jpg}"
exiftool -b -Comment "$IMG" | base64 -d
echo
# -> ROGUE{Backup123!}

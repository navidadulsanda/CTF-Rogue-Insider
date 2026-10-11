# How each challenge was built (flag placement)

This documents how the challenge artifacts and flags were generated, for
reproducibility. See tools/generate_challenges.sh for the runnable version.

- **Stage 1 (Steganography):** the password `Backup123!` was Base64-encoded and
  written into the JPEG `Comment` EXIF field of `avatar.jpg`.
- **Stage 2 (Cryptography):** the password `trustno1` was hashed with MD5 and the
  resulting 32-char hash dropped into `bash_history.txt`.
- **Stage 3 (Forensics):** a cleartext FTP session carrying the exfiltrated
  filename was captured into `stage3.pcap`.
- **Stage 4 (Web):** a Flask + SQLite app builds its search query by string
  concatenation (no parameterisation) and seeds the flag as a row in a separate
  table, reachable only via UNION-based SQL injection.
- **Stage 5 (Linux):** an Ubuntu+OpenSSH container with user `backupsvc`, a
  `NOPASSWD` sudo rule on `/usr/bin/vim`, and the flag written to
  `/root/vault_access.flag` (chmod 600).
- **Stage 6 (Reverse Engineering):** `vault_decryptor.py` XOR-decrypts `vault.enc`
  with a hardcoded key; it was compiled with PyInstaller, and `vault.enc` is the
  flag XOR-ed with `AegisRogueRE2026`.

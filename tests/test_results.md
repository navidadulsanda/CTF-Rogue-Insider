# Test Log — Operation Rogue Insider (Group 75)
Tester: Member 4 · Environment: host-only Ubuntu VM · Date: __________

Every stage was solved via its intended path; the flag was confirmed against the
value registered in CTFd; and an unintended-shortcut check confirms the flag is
not obtainable by a trivial bypass.

| # | Stage | Intended path (tool) | Expected flag | Actual flag | Result | Unintended-shortcut check |
|---|-------|----------------------|---------------|-------------|--------|---------------------------|
| 1 | Steganography | EXIF comment -> base64 (exiftool) | ROGUE{Backup123!} | ROGUE{Backup123!} | PASS | flag only in EXIF; plain view shows nothing |
| 2 | Cryptography | crack MD5 (John/hashcat + rockyou) | ROGUE{trustno1} | ROGUE{trustno1} | PASS | hash useless without cracking |
| 3 | Forensics | follow FTP stream (Wireshark/tshark) | ROGUE{10.10.50.15_ml_model_v3.enc} | (same) | PASS | details only inside the pcap |
| 4 | Web / SQLi | UNION injection (browser) | ROGUE{sess_8f3a1c9e2b7d4f60} | (same) | PASS | flag NOT in page source (curl \| grep rogue -> none) |
| 5 | Linux PrivEsc | SSH + sudo vim (GTFOBins) | ROGUE{s0_th4ts_h0w_h3_did_it} | (same) | PASS | /root flag is chmod 600; backupsvc cat -> Permission denied |
| 6 | Reverse Eng. | pyinstxtractor-ng + XOR | ROGUE{byt3c0d3_n3v3r_l13s} | (same) | PASS | binary refuses without the recovered key |

## Defects found and fixed
- (example) Stage 4 originally leaked the full table name in its error output; toned the error down so the column count must still be inferred. FIXED.
- Add your real defects here: __________________________________________

## Reset / recovery test
- [ ] Solved Stage 4 (DB touched) -> ran reset.sh -> Stage 4 back to clean seeded state.
- [ ] CTFd scoreboard data intact after reset (separate container).

## Isolation verification (run on the Linux VM)
- [ ] docker network inspect platform_ctf_internal  ->  "Internal": true
- [ ] egress test prints NO-EGRESS
- [ ] ss -tlnp shows only 8000 / 5000 / 2222

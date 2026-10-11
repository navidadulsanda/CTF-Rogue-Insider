#!/usr/bin/env bash
# tests/run_all.sh — Integration test runner for the Rogue Insider CTF box.
set -u
pass=0; fail=0
report() {
  if [ "$3" = "$2" ]; then
    printf '[PASS] %-7s %s\n' "$1" "$3"; pass=$((pass+1))
  else
    printf '[FAIL] %-7s got="%s" expected="%s"\n' "$1" "$3" "$2"; fail=$((fail+1))
  fi
}
echo "=== Rogue Insider — integration test run ==="

s1=$(exiftool -b -Comment stages/stage1/avatar.jpg 2>/dev/null | awk '{print $NF}' | base64 -d 2>/dev/null)
report "Stage1" "ROGUE{Backup123!}" "ROGUE{${s1}}"

hash=$(grep -oE '[0-9a-f]{32}' stages/stage2/bash_history.txt | head -n1)
echo "$hash" > /tmp/_s2.txt
john --format=raw-md5 --wordlist=/usr/share/wordlists/rockyou.txt /tmp/_s2.txt >/dev/null 2>&1
s2=$(john --show --format=raw-md5 /tmp/_s2.txt 2>/dev/null | head -n1 | cut -d: -f2)
report "Stage2" "ROGUE{trustno1}" "ROGUE{${s2}}"

host=$(tshark -r stages/stage3/stage3.pcap -Y ftp -T fields -e ip.dst 2>/dev/null | sort -u | tail -n1)
file=$(tshark -r stages/stage3/stage3.pcap -Y 'ftp.request.command==STOR' -T fields -e ftp.request.arg 2>/dev/null | grep '\.enc' | head -n1)
report "Stage3" "ROGUE{10.10.50.15_ml_model_v3.enc}" "ROGUE{${host}_${file}}"

s4=$(python3 solvers/stage4_web.py http://localhost:5000 2>/dev/null | grep -oE 'ROGUE\{[^}]+\}' | head -n1)
report "Stage4" "ROGUE{sess_8f3a1c9e2b7d4f60}" "${s4:-<no-flag>}"

s5=$(bash solvers/stage5_linux.sh localhost 2222 2>/dev/null | grep -oE 'ROGUE\{[^}]+\}' | head -n1)
report "Stage5" "ROGUE{s0_th4ts_h0w_h3_did_it}" "${s5:-<no-flag>}"

s6=$(python3 solvers/stage6_re.py stages/stage6/vault.enc 2>/dev/null | grep -oE 'ROGUE\{[^}]+\}' | head -n1)
report "Stage6" "ROGUE{byt3c0d3_n3v3r_l13s}" "${s6:-<no-flag>}"

echo "============================================"
echo "PASS=$pass  FAIL=$fail"
[ "$fail" -eq 0 ] && echo "ALL STAGES OK" || { echo "SOME STAGES FAILED"; exit 1; }

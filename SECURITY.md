# Security & Isolation - Operation Rogue Insider (Group 75)

## 1. Scope & authorised use
This CTF Play Box is built so it cannot affect institutional or public systems.
Every target is an intentionally vulnerable asset created by the group for this
CTF (the avatar image, the packet capture, the Flask app, the Dockerfiles and
seeded data). No real, third-party or institutional system is involved. Public
datasets/tools (e.g. the rockyou.txt wordlist) are used only against our own
challenge data, and are acknowledged in the README.

## 2. Threat model
The main risk is a participant who solves a challenge (e.g. gains a shell in
Stage 4 or Stage 5) and uses it to pivot to the internet, the campus LAN, or the
host. The controls below prevent that.

## 3. Isolation layers (defence in depth)
1. **Host-only VM** — the box runs in a VM on a host-only network adapter with
   no route to the internet or the campus LAN. This is the outer boundary.
2. **Internal Docker network** — the challenge containers sit on an
   `internal: true` bridge network (`ctf_internal`), so a container cannot make
   outbound connections even if the VM had connectivity.
3. **Least privilege** — Stage 4 runs with `cap_drop: ALL`; the Stage 5 flag is
   `chmod 600`, root-only, so it is reachable only through the intended
   privilege escalation.
4. **Minimal attack surface** — only three ports are published:
   `8000` (CTFd), `5000` (Stage 4), `2222` (Stage 5).

## 4. Flag validation mechanism
Flags are registered in CTFd as static, case-sensitive values in the format
`ROGUE{...}`. A correct submission is marked solved; an incorrect one is
rejected. All submissions are logged under Admin → Submissions.

## 5. Reset / recovery
`platform/reset.sh` rebuilds and re-seeds Stage 4 and recreates Stage 5; the
static stages (1, 2, 3, 6) are stateless. CTFd runs in a separate container
that the reset does not touch, so scoreboard data survives a reset.

## 6. Verifying the controls (run on the host-only Linux VM)

```bash
# (a) the challenge network is isolated
docker network inspect platform_ctf_internal | grep '"Internal"'
#   expected:  "Internal": true,

# (b) a container genuinely cannot reach the internet
docker exec platform-stage4_web-1 python -c \
  "import socket; socket.setdefaulttimeout(5); socket.create_connection(('8.8.8.8',53))" \
  || echo NO-EGRESS
#   expected:  NO-EGRESS

# (c) only the three intended ports are listening
sudo ss -tlnp | grep -E '8000|5000|2222'
#   expected:  only 8000, 5000 and 2222
```

## 7. Docker Desktop note
On Docker Desktop (macOS/Windows) `internal: true` and published ports cannot
coexist — a Docker Desktop VM limitation, not a configuration error — so the
graded isolation proof is performed on the host-only Linux VM, where the
ports publish *and* egress stays blocked. The `docker-compose.mac.yml` override
(which sets `internal: false`) is for local testing only on Docker Desktop.

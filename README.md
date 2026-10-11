# Operation Rogue Insider: The Vault Breach - CTF Play Box

**Group 75** · IE3132 Penetration Testing — Assignment 02
Index numbers: IT24103385 · IT24103019 · IT24103020 · IT24102889

A corporate-espionage CTF: 6 progressive challenges across 5 cybersecurity
domains plus a reverse-engineering capstone. All flags use the format
`ROGUE{...}` (static, case-sensitive).

---

## 1. Requirements

- A host (or VM) with ~4–6 vCPU, 6–8 GB RAM, 15–20 GB disk.
- Docker Engine + Docker Compose plugin (`docker --version`, `docker compose version`).
- For the isolated demo: an Ubuntu Server 22.04 VM on a host-only adapter
  (no internet route). The box needs no internet access at run time.

## 2. Repository layout

```
rogue-insider/
├─ README.md                      <- this file (deploy / run / reset guide)
├─ SECURITY.md                    <- isolation & security controls
├─ CHALLENGE_BUILD.md             <- how each flag was planted (reproducible)
├─ platform/
│  ├─ docker-compose.ctf.yml      <- the stack (stage 4 + stage 5, internal net)
│  ├─ docker-compose.mac.yml      <- Docker Desktop override (publishes ports)
│  ├─ deploy.sh                   <- one-command bring-up
│  └─ reset.sh                    <- reset the stages to a clean state
├─ stages/                        <- per-stage build files & artifacts
│  ├─ stage1/ ... stage6/
├─ solvers/                       <- self-developed solver scripts (one per stage)
└─ tools/
   └─ generate_challenges.sh      <- regenerates the challenge artifacts
```

## 3. Setup & run

From the `platform/` folder:

```bash
./deploy.sh
```

This builds and starts the challenge containers and CTFd.

> Docker Desktop (macOS / Windows): the `internal: true` network blocks
> published ports on Docker Desktop (a Docker Desktop VM limitation). To reach
> the services locally, bring the box up with the override instead:
>
> ```bash
> docker compose -f docker-compose.ctf.yml -f docker-compose.mac.yml up -d --build
> docker start ctfd
> ```
>
> On the host-only Linux VM, `deploy.sh` publishes the ports and keeps
> egress blocked at the same time — use that for the graded run.

## 4. CTFd first-time setup

1. Open `http://<host-ip>:8000` and complete the setup wizard (create the admin
   account; name the event "Operation Rogue Insider").
2. Either Import the config export at `platform/ctfd-export.zip`
   (Admin → Config → Backup → Import), or register the 6 challenges by hand
   as static, case-sensitive flags with the two hints each.
3. Attach the downloadable file to challenges 1, 2, 3 and 6.

## 5. Access

| Component        | Address                                   |
|------------------|-------------------------------------------|
| CTFd scoreboard  | `http://<host-ip>:8000`                   |
| Stage 4 (web)    | `http://<host-ip>:5000`                   |
| Stage 5 (ssh)    | `ssh backupsvc@<host-ip> -p 2222`         |
| Stages 1/2/3/6   | download the file attached in CTFd        |

**Credentials (for the lecturer):** Stage 5 SSH `backupsvc` / `Backup123!`

## 6. Flags (instructor reference)

| # | Challenge                 | Domain                | Flag |
|---|---------------------------|-----------------------|------|
| 1 | A photograph of the departed employee | Steganography | `ROGUE{Backup123!}` |
| 2 | Terminal Traces           | Cryptography          | `ROGUE{trustno1}` |
| 3 | A Digital Trail           | Forensics / Networking| `ROGUE{10.10.50.15_ml_model_v3.enc}` |
| 4 | The Employee Portal       | Web Security          | `ROGUE{sess_8f3a1c9e2b7d4f60}` |
| 5 | Into the Backup Node      | Linux System Security | `ROGUE{s0_th4ts_h0w_h3_did_it}` |
| 6 | The Vault                 | Reverse Engineering   | `ROGUE{byt3c0d3_n3v3r_l13s}` |

## 7. Reset

```bash
./reset.sh
```

Rebuilds and re-seeds Stage 4 and recreates Stage 5; the static stages are
stateless. CTFd runs in a separate container, so scoreboard data survives a reset.

## 8. Isolation

The box runs on a host-only VM with no route to the internet or the campus LAN.
The challenge containers sit on an `internal: true` Docker network (no egress),
and only ports 8000, 5000 and 2222 are published. See `SECURITY.md`.

## 9. Acknowledgements

External tools, frameworks and datasets used: **CTFd**, **ExifTool**,
**Hashcat** / **John the Ripper** with the **rockyou.txt** wordlist,
**Wireshark/tshark**, **Flask**, **SQLite**, **OpenSSH**, **PyInstaller**,
**pyinstxtractor-ng**, and **Docker** / **Docker Compose**.

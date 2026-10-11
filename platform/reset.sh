#!/bin/bash
cd "$(dirname "$0")"
docker compose -f docker-compose.ctf.yml down
docker compose -f docker-compose.ctf.yml up -d --build --force-recreate
echo "Stage 4 & 5 rebuilt from scratch."
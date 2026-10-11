#!/bin/bash
cd "$(dirname "$0")"
docker start ctfd 2>/dev/null || docker run -d --name ctfd -p 8000:8000 ctfd/ctfd:latest
docker compose -f docker-compose.ctf.yml up -d --build
echo "Box is up — CTFd :8000, Stage 4 :5000, Stage 5 :2222"

#!/usr/bin/env bash
set -euo pipefail

echo "## Shell syntax check"
bash -n scripts/health-check.sh
bash -n scripts/system-check.sh
bash -n scripts/backup.sh
bash -n scripts/nginx-log-analyzer.sh

echo
echo "## Python syntax check"
python3 -m py_compile docker/day14/app/server.py

echo
echo "## Docker build"
docker build -t devops-python-api:ci docker/day14/app

echo
echo "## Compose config check"
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env config > /tmp/devops-compose-config.yaml

echo
echo "[OK] local CI checks passed"

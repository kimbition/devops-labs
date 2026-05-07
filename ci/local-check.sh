#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="${REPORT_DIR:-ci/reports}"
mkdir -p "$REPORT_DIR"

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
docker build -t devops-python-api:ci docker/day14/app | tee "$REPORT_DIR/docker-build.log"

echo
echo "## Compose config check"
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env config | tee "$REPORT_DIR/compose-config.yaml" > /dev/null

echo
echo "## Git tracked cache check"
if git ls-files | grep -E '__pycache__|\.pyc$'; then
  echo "[ERROR] Python cache files are tracked by Git"
  exit 1
fi

echo "[OK] local CI checks passed" | tee "$REPORT_DIR/summary.txt"

#!/usr/bin/env bash
set -euo pipefail

URLS=(
  "http://127.0.0.1:18080"
  "http://127.0.0.1:8088/"
  "http://127.0.0.1:8089"
  "http://127.0.0.1:18081"
)

failed=0

for url in "${URLS[@]}"; do
  result=$(curl -sS -o /dev/null -w "%{http_code} %{time_total}" --connect-timeout 3 "$url" 2>/dev/null || true)
  code=$(echo "$result" | awk '{print $1}')
  time=$(echo "$result" | awk '{print $2}')

#  if [[ "$code" =~ ^2|3 ]]; then
   if [[ "$code" =~ ^[23] ]]; then
    echo "[OK]   $url code=$code time=${time}s"
  else
    echo "[FAIL] $url code=$code time=${time}s"
    failed=1
  fi
done

exit "$failed"

#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="${1:-}"

if [[ -z "$LOG_FILE" ]]; then
  echo "Usage: $0 <nginx_access_log>"
  exit 2
fi

if [[ ! -f "$LOG_FILE" ]]; then
  echo "[ERROR] log file does not exist: $LOG_FILE"
  exit 1
fi

echo "## Log file"
echo "$LOG_FILE"

echo
echo "## Total requests"
wc -l "$LOG_FILE"

echo
echo "## Status codes"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr

echo
echo "## Top client IPs"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 10

echo
echo "## Top paths"
awk -F'"' '{print $2}' "$LOG_FILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 10

echo
echo "## 4xx/5xx requests"
awk '$9 ~ /^[45]/ {print}' "$LOG_FILE" | tail -n 20

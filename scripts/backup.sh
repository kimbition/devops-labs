#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-}"
BACKUP_DIR="${2:-$HOME/devops-labs/backups}"
KEEP="${KEEP:-7}"

if [[ -z "$SOURCE_DIR" ]]; then
  echo "Usage: $0 <source_dir> [backup_dir]"
  exit 2
fi

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "[ERROR] source dir does not exist: $SOURCE_DIR"
  exit 1
fi

mkdir -p "$BACKUP_DIR"

timestamp=$(date +"%Y%m%d-%H%M%S")
name=$(basename "$SOURCE_DIR")
archive="$BACKUP_DIR/${name}-${timestamp}.tar.gz"

echo "[INFO] backup source: $SOURCE_DIR"
echo "[INFO] backup target: $archive"

tar -czf "$archive" -C "$(dirname "$SOURCE_DIR")" "$name"

echo "[INFO] cleanup old backups, keep latest $KEEP"
find "$BACKUP_DIR" -name "${name}-*.tar.gz" -type f -printf "%T@ %p\n" \
  | sort -nr \
  | awk "NR>$KEEP {print \$2}" \
  | xargs -r rm -f

echo "[OK] backup completed"

#!/usr/bin/env bash
set -euo pipefail

echo "## Basic"
hostname
date
uptime

echo
echo "## Memory"
free -h

echo
echo "## Disk"
df -h

echo
echo "## Top CPU"
ps aux --sort=-%cpu | head -n 6

echo
echo "## Top Memory"
ps aux --sort=-%mem | head -n 6

echo
echo "## Listening Ports"
ss -lntp || true

echo
echo "## Services"
systemctl is-active nginx || true
systemctl is-active devops-demo || true#!/usr/bin/env bash
set -euo pipefail

echo "## Basic"
hostname
date
uptime

echo
echo "## Memory"
free -h

echo
echo "## Disk"
df -h

echo
echo "## Top CPU"
ps aux --sort=-%cpu | head -n 6

echo
echo "## Top Memory"
ps aux --sort=-%mem | head -n 6

echo
echo "## Listening Ports"
ss -lntp || true

echo
echo "## Services"
systemctl is-active nginx || true
systemctl is-active devops-demo || true

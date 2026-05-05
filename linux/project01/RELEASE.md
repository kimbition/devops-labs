# Project 01 Release Notes

## v0.1.0

发布日期：2026-05-06

## 内容

- 完成 systemd 后端服务配置。
- 完成 Nginx 反向代理配置。
- 完成健康检查、系统巡检、日志分析和备份脚本。
- 完成 502 Bad Gateway 故障复盘。

## 验收命令

~~~bash
systemctl status devops-demo --no-pager
systemctl status nginx --no-pager
curl http://127.0.0.1:18080
curl http://127.0.0.1:8089
./scripts/health-check.sh
~~~

## 已知问题

- `scripts/health-check.sh` 保留 `127.0.0.1:18081` 作为失败用例。

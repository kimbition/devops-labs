# Day 04 systemd 和 systemctl 服务管理

## 今天学到的概念

- systemd：
- unit：
- service：
- daemon-reload：
- start：
- stop：
- restart：
- enable：
- status：
- journalctl：

## devops-demo.service 关键配置

```ini
[Unit]
Description=DevOps Demo HTTP Service
After=network.target

[Service]
Type=simple
User=yj
WorkingDirectory=/home/yj/devops-labs/linux/day04/site
ExecStart=/usr/bin/python3 -m http.server 9090 --bind 127.0.0.1
Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target
服务排查流程
看服务状态：systemctl status <service> --no-pager
看最近日志：journalctl -u <service> --no-pager -n 50
检查端口：ss -lntp
检查配置文件路径、用户权限、启动命令
修改 service 后执行：sudo systemctl daemon-reload
重启服务：sudo systemctl restart <service>
今天制造的故障
我把 WorkingDirectory 改成了不存在的路径，服务启动失败。

修复方法
恢复正确路径，执行 daemon-reload，然后 restart 服务。

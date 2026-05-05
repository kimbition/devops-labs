# 故障复盘：Nginx 反向代理返回 502

## 时间线

- 发现时间：2026-05-05
- 影响范围：本地 Nginx 反向代理 `127.0.0.1:8089`
- 恢复方式：重新启动后端 `devops-demo.service`

## 现象

访问 Nginx 代理时返回：

~~~text
HTTP/1.1 502 Bad Gateway
~~~

Nginx access log 中出现：

~~~text
"HEAD / HTTP/1.1" 502
~~~

## 根因

后端服务 `devops-demo.service` 被停止，Nginx 无法连接上游 `127.0.0.1:18080`。

## 处理过程

1. 使用 `curl -I http://127.0.0.1:8089` 确认返回 502。
2. 使用 `systemctl status nginx --no-pager` 确认 Nginx 正常。
3. 使用 `systemctl status devops-demo --no-pager` 检查后端服务。
4. 使用 `ss -lntp | grep 18080` 检查后端端口是否监听。
5. 使用 `sudo systemctl start devops-demo` 恢复后端服务。
6. 再次 `curl http://127.0.0.1:8089` 验证恢复。

## 预防措施

- 健康检查脚本定期检查后端和代理地址。
- 对 Nginx 502 日志做告警。
- 对 systemd 服务启用失败自动重启。
- 发布或维护后执行检查清单。

## 后续任务

- 接入 Prometheus 或其他监控工具。
- 把健康检查脚本接入 cron。
- 增加告警通知。

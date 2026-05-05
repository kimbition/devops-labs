# Project 01 Linux 运维闭环小项目

## 项目目标

本项目演示一个基础 Linux 运维闭环：

~~~text
client -> nginx:8089 -> devops-demo systemd service:18080
~~~

覆盖能力：

- 使用 systemd 管理后端服务
- 使用 Nginx 做反向代理
- 使用 Shell 脚本做健康检查和系统巡检
- 使用 Shell 脚本分析 Nginx access log
- 使用 Shell 脚本备份站点目录
- 记录一次 502 故障排查过程

## 架构

~~~text
127.0.0.1:8089
    |
    v
Nginx reverse proxy
    |
    v
127.0.0.1:18080
devops-demo.service
python3 -m http.server
~~~

## 服务信息

### 后端服务

- systemd unit：`devops-demo.service`
- 监听地址：`127.0.0.1:18080`
- 工作目录：`/home/yj/devops-labs/linux/day04/site`
- 启动命令：`/usr/bin/python3 -m http.server 18080 --bind 127.0.0.1`

### Nginx 反向代理

- 配置文件：`/etc/nginx/sites-available/devops-proxy`
- 监听地址：`127.0.0.1:8089`
- 后端地址：`http://127.0.0.1:18080`

## 常用操作

### 查看服务状态

~~~bash
systemctl status devops-demo --no-pager
systemctl status nginx --no-pager
~~~

### 重启服务

~~~bash
sudo systemctl restart devops-demo
sudo systemctl reload nginx
~~~

### 访问验证

~~~bash
curl http://127.0.0.1:18080
curl http://127.0.0.1:8089
~~~

### 健康检查

~~~bash
./scripts/health-check.sh
~~~

### 日志分析

~~~bash
./scripts/nginx-log-analyzer.sh /var/log/nginx/devops-proxy.access.log
~~~

### 备份

~~~bash
./scripts/backup.sh linux/day07
~~~

## 故障案例：502 Bad Gateway

### 现象

访问 Nginx 代理时返回：

~~~text
HTTP/1.1 502 Bad Gateway
~~~

### 原因

Nginx 正常运行，但后端 `devops-demo.service` 停止或不可访问。

### 排查命令

~~~bash
systemctl status nginx --no-pager
systemctl status devops-demo --no-pager
ss -lntp | grep 18080
sudo tail -n 20 /var/log/nginx/devops-proxy.error.log
journalctl -u devops-demo --no-pager -n 30
~~~

### 修复方法

~~~bash
sudo systemctl start devops-demo
curl http://127.0.0.1:8089
~~~

## 项目产出

- `reports/system-check.txt`：系统巡检报告
- `reports/health-check.txt`：健康检查报告
- `reports/proxy-log-analysis.txt`：Nginx 代理访问日志分析
- `reports/backup.log`：备份日志
- `configs/`：关键配置和脚本副本

## 我掌握的能力

- 能用 systemd 管理服务
- 能用 Nginx 暴露和代理服务
- 能用 curl、ss、journalctl、tail 排查服务访问问题
- 能写 Shell 脚本做健康检查、巡检、日志分析和备份
- 能把故障现象、原因、排查和修复写成文档

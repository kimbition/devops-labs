# Day 07 Nginx 部署和反向代理

## 今天学到的概念

- Nginx：
- 静态站点：
- server block：
- listen：
- root：
- access_log：
- error_log：
- reverse proxy：
- proxy_pass：
- 502 Bad Gateway：

## 静态站点

Nginx 监听 8088，读取 `/var/www/devops-demo/index.html`。

测试命令：

```bash
curl -I http://127.0.0.1:8088
curl http://127.0.0.1:8088
反向代理
Nginx 监听 8089，把请求转发到后端服务：

client -> nginx:8089 -> devops-demo:18080
关键配置：

location / {
    proxy_pass http://127.0.0.1:18080;
    proxy_set_header Host ;
    proxy_set_header X-Real-IP ;
    proxy_set_header X-Forwarded-For ;
}
502 故障
现象：

HTTP/1.1 502 Bad Gateway
含义：

Nginx 正常工作，但无法连接后端服务。

排查：

systemctl status nginx --no-pager
systemctl status devops-demo --no-pager
ss -lntp | grep 18080
sudo tail -n 20 /var/log/nginx/devops-proxy.error.log
修复：

sudo systemctl start devops-demo
sudo systemctl reload nginx
今天遇到的问题
暂无

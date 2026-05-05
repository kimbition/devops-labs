# Day 06 Linux 网络排查
## 今天学到的命令
ss -lntp
curl -v http://127.0.0.1:18080
curl -I https://github.com
dig github.com
dig +short github.com
curl -v 重点观察
Trying：开始连接目标 IP 和端口
Connected：TCP 连接成功
GET：发出 HTTP 请求
HTTP 状态码：服务返回结果
常见失败类型
Connection refused
含义：

目标主机可达，但目标端口没有服务监听，或者连接被拒绝。

排查：

ss -lntp | grep <port>
systemctl status <service>
Could not resolve host
含义：

DNS 解析失败，域名没有解析成 IP。

排查：

dig <domain>
cat /etc/resolv.conf
Connection timed out
含义：

连接超时，可能是网络不可达、防火墙丢包、安全组未放通、目标服务无响应。

排查：

ping <ip>
traceroute <ip>
curl -v --connect-timeout 3 <url>
常见 HTTP 状态码
200：成功
301/302：重定向
400：客户端请求错误
401：未认证
403：无权限
404：资源不存在
500：服务内部错误
502：网关收到上游错误
503：服务不可用
504：网关等待上游超时
服务访问不了的排查顺序
DNS 是否能解析
IP 是否能连通
端口是否监听
HTTP 状态码是什么
服务日志是否报错
最近是否有发布或配置变更
今天遇到的问题
暂无

# Day 10 Nginx 日志分析

## 今天学到的命令

```bash
awk
sort
uniq -c
head
tail
wc -l
access log 常见字段
典型 Nginx access log：

127.0.0.1 - - [06/May/2026:01:20:00 +0800] "GET / HTTP/1.1" 200 26 "-" "curl/8.x"
常见字段：

$1：客户端 IP
$9：HTTP 状态码
双引号里的第一段：请求行，例如 GET / HTTP/1.1
我能回答的问题
总请求量是多少
各状态码数量是多少
Top IP 是谁
Top 路径是什么
最近 4xx / 5xx 错误是什么
常用分析命令
awk '{print $9}' access.log | sort | uniq -c | sort -nr
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head
awk -F'"' '{print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -nr | head
awk '$9 ~ /^[45]/ {print}' access.log | tail -n 20
今天遇到的问题
暂无

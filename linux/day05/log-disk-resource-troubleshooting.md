# Day 05 Linux 日志、磁盘和资源排查

## 今天学到的命令

uptime
free -h
df -h
du -sh .
ps aux --sort=-%cpu | head
ps aux --sort=-%mem | head
find . -type f -size +10M -ls
journalctl -u devops-demo --no-pager -n 20
journalctl -p err --no-pager -n 20

排查 CPU 高
用 uptime 看系统负载
用 ps aux --sort=-%cpu | head 找高 CPU 进程
用 ps -f -p <PID> 看进程详情
确认进程用途后再决定是否重启或 kill

排查内存高
用 free -h 看整体内存
用 ps aux --sort=-%mem | head 找高内存进程
判断是否是正常缓存、应用泄漏或异常进程

排查磁盘满
用 df -h 看哪个分区满
用 du -sh <目录> 找大目录
用 find 找大文件
确认文件用途后再清理
清理后再次用 df -h 和 du -sh 验证

排查服务日志
systemctl status <service> --no-pager
journalctl -u <service> --no-pager -n 50
journalctl -u <service> --since 10
结合时间线判断错误是否仍然有效

今天遇到的问题
暂无

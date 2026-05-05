# Day 08 Shell 脚本自动化

## 今天学到的概念

- shebang：
- set -euo pipefail：
- 退出码：
- for 循环：
- curl 健康检查：
- 巡检脚本：

## 健康检查脚本

脚本路径：

scripts/health-check.sh
功能：

检查多个 URL 是否可访问，并输出 HTTP 状态码和耗时。

系统巡检脚本
脚本路径：

scripts/system-check.sh
功能：

输出主机名、时间、负载、内存、磁盘、CPU Top、内存 Top、监听端口、服务状态。

退出码
0 表示成功
非 0 表示失败
CI/CD 和 systemd 会根据退出码判断任务是否成功。

今天遇到的问题
暂无

# Day 09 Shell 参数、日志、备份和 cron

## 今天学到的概念

- `$1`：第一个参数
- `${VAR:-default}`：变量为空时使用默认值
- 退出码：
  - 0：成功
  - 1：一般错误
  - 2：参数错误
- `tar -czf`：创建 gzip 压缩包
- `stdout`：标准输出
- `stderr`：标准错误
- `2>&1`：把错误输出合并到标准输出
- cron：定时任务

## 备份脚本

脚本路径：

scripts/backup.sh
用法：

./scripts/backup.sh <source_dir> [backup_dir]
示例：

./scripts/backup.sh linux/day07
./scripts/backup.sh linux/day08 /tmp/devops-backups
排查要点
如果 cron 里脚本失败，优先检查：

是否使用绝对路径
环境变量是否缺失
脚本是否有执行权限
日志是否重定向保存
当前用户是否有目录读写权限
今天遇到的问题
暂无

# Day 02 Linux 文件权限

## 权限结构

`-rw-r--r--` 可以拆成：

- 第 1 位：文件类型
- 第 2-4 位：owner 权限
- 第 5-7 位：group 权限
- 第 8-10 位：others 权限

## chmod

常见权限：

- 600：私密文件
- 644：普通文件
- 755：可执行脚本或目录

## chown

`chown` 用来修改文件 owner 和 group。

示例：

```bash
sudo chown root:root root-owned.txt
sudo chown yj:yj root-owned.txt
我的理解
r 是：
w 是：
x 是：
文件的 x 权限表示：
目录的 x 权限表示：
chmod 600 适合：
chmod 755 适合：
今天遇到的问题
暂无

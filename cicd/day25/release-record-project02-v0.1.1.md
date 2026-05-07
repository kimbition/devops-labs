# 发布记录：project02-v0.1.1

## 版本

~~~text
project02-v0.1.1
~~~

## 镜像

~~~text
ghcr.io/kimbition/devops-python-api:project02-v0.1.1
~~~

## 发布内容

- 修正 Project 02 dev 健康检查报告。
- 使用 Git tag 触发 Docker Publish workflow。
- 发布版本镜像到 GHCR。

## 验证命令

~~~bash
docker pull ghcr.io/kimbition/devops-python-api:project02-v0.1.1
docker run --rm -p 8097:8000 ghcr.io/kimbition/devops-python-api:project02-v0.1.1
curl http://127.0.0.1:8097/health
~~~

## 验证结果

- [x] 镜像可以拉取
- [x] Docker Publish workflow 成功
- [x] `/health` 可用

## 回滚目标

如果 `project02-v0.1.1` 不可用，回滚到：

~~~text
project02-v0.1.1
~~~

## 经验

- 旧 tag 不随意移动。
- 小修复使用补丁版本。
- 发布版本镜像优先使用不可变 tag。

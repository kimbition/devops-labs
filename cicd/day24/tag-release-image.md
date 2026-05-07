# Day 24 使用 Git tag 发布版本镜像

## 今天学到的概念

- Git tag：
- annotated tag：
- patch release：
- immutable image tag：
- release image：
- tag-triggered workflow：

## 为什么不移动旧 tag

`project02-v0.1.0` 已经发布后，如果发现报告或小问题，优先发布补丁版本：

~~~text
project02-v0.1.1
~~~

不要随便移动旧 tag，因为其他人或系统可能已经依赖旧 tag。

## 创建版本 tag

~~~bash
git tag -a project02-v0.1.1 -m "Project 02 Docker Compose release v0.1.1"
git push origin project02-v0.1.1
~~~

## workflow 触发条件

~~~yaml
on:
  push:
    tags:
      - "project02-v*"
~~~

含义：

只要推送 `project02-v` 开头的 tag，就触发 Docker Publish workflow。

## 镜像地址

~~~text
ghcr.io/kimbition/devops-python-api:project02-v0.1.1
~~~

## 验证版本镜像

~~~bash
docker pull ghcr.io/kimbition/devops-python-api:project02-v0.1.1
docker run --rm -p 8097:8000 ghcr.io/kimbition/devops-python-api:project02-v0.1.1
curl http://127.0.0.1:8097/health
~~~

## 发布原则

- `master` 镜像代表主分支最新状态。
- `sha-*` 镜像代表某次具体提交。
- `project02-v*` 镜像代表发布版本。
- 生产部署优先使用版本 tag 或 sha tag，不建议直接使用 `master`。

## 今天遇到的问题

暂无

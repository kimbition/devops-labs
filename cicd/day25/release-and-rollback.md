# Day 25 CI/CD 发布检查清单和回滚策略

## 今天学到的概念

- release checklist：
- release record：
- rollback strategy：
- immutable image tag：
- patch version：
- production verification：
- post-release validation：

## 发布流程

~~~text
local check -> CI green -> create tag -> push tag -> Docker Publish -> pull image -> run verification
~~~

## 为什么使用不可变版本镜像

`master` 会变化，不适合作为生产部署的唯一依据。

版本镜像更适合作为发布目标：

~~~text
ghcr.io/kimbition/devops-python-api:project02-v0.1.1
~~~

## 回滚思路

如果新版本失败，不要临时修生产环境。优先回到上一个已验证版本：

~~~bash
docker run -d --name devops-release -p 8098:8000 ghcr.io/kimbition/devops-python-api:project02-v0.1.0
~~~

## 文档产出

- `cicd/runbooks/release-checklist.md`
- `cicd/runbooks/rollback-strategy.md`
- `cicd/day25/release-record-project02-v0.1.1.md`
- `cicd/day25/reports/`

## 今天遇到的问题

暂无

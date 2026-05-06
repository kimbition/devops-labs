# Day 20 GitHub Actions CI 入门

## 今天学到的概念

- CI：
- workflow：
- job：
- step：
- runner：
- trigger：
- checkout：
- workflow_dispatch：
- GitHub-hosted runner：

## CI 流程

~~~text
push / pull_request
    |
    v
GitHub Actions runner
    |
    v
checkout code
    |
    v
shell syntax check
    |
    v
python syntax check
    |
    v
docker build
    |
    v
docker compose config
~~~

## workflow 文件位置

GitHub Actions workflow 文件必须放在：

~~~text
.github/workflows/
~~~

本项目文件：

~~~text
.github/workflows/ci.yml
~~~

## 触发方式

~~~yaml
on:
  push:
    branches:
      - master
  pull_request:
    branches:
      - master
  workflow_dispatch:
~~~

## jobs 和 steps

- `jobs`：一次 workflow 里的一组任务。
- `steps`：一个 job 里的具体步骤。
- 每个 step 可以使用 action，也可以执行 shell 命令。

## 本项目 CI 检查内容

~~~bash
bash -n scripts/health-check.sh
bash -n scripts/system-check.sh
bash -n scripts/backup.sh
bash -n scripts/nginx-log-analyzer.sh
python -m py_compile docker/day14/app/server.py
docker build -t devops-python-api:ci docker/day14/app
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env config
~~~

## 本地 CI 脚本

为了在推送前先本地验证，创建了：

~~~text
ci/local-check.sh
~~~

运行：

~~~bash
./ci/local-check.sh
~~~

## 今天遇到的问题

暂无

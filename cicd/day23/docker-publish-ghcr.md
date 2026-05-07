# Day 23 GitHub Actions 发布 Docker 镜像到 GHCR

## 今天学到的概念

- GHCR：
- package：
- image tag：
- GITHUB_TOKEN：
- packages: write：
- docker/login-action：
- docker/metadata-action：
- docker/build-push-action：
- Buildx：

## 镜像地址

~~~text
ghcr.io/kimbition/devops-python-api
~~~

## workflow 关键权限

~~~yaml
permissions:
  contents: read
  packages: write
~~~

`packages: write` 允许 GitHub Actions 把镜像推送到 GitHub Container Registry。

## 登录 GHCR

~~~yaml
- name: Log in to GitHub Container Registry
  uses: docker/login-action@v3
  with:
    registry: ghcr.io
    username: ${{ github.actor }}
    password: ${{ secrets.GITHUB_TOKEN }}
~~~

## 构建并推送

~~~yaml
- name: Build and push Docker image
  uses: docker/build-push-action@v7
  with:
    context: docker/day14/app
    push: true
    tags: ${{ steps.meta.outputs.tags }}
    labels: ${{ steps.meta.outputs.labels }}
~~~

## tag 策略

- `master`：主分支最新镜像
- `sha-xxxxxxx`：按提交生成的不可变镜像
- `project02-v*`：发布版本镜像

## 今天遇到的问题

暂无

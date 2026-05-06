# Project 02 Docker Compose 容器化应用小项目

## 项目目标

本项目演示一个基础容器化部署闭环：

~~~text
client -> nginx container -> api container -> named volume
~~~

覆盖能力：

- 使用 Dockerfile 构建自定义 Python API 镜像
- 使用 `.dockerignore` 控制 build context
- 使用 Docker Compose 编排 API 和 Nginx
- 使用 Compose 服务名 DNS 做容器间访问
- 使用 healthcheck 判断服务健康
- 使用 restart policy 提升容器自恢复能力
- 使用 named volume 持久化数据
- 使用 override 文件区分 dev 和 prod 配置
- 记录 Nginx 502 故障排查方法

## 架构

~~~text
localhost:8094
    |
    v
nginx:80
    |
    v
api:8000
    |
    v
api-data:/data
~~~

开发环境 override 额外暴露：

~~~text
localhost:8095 -> nginx:80 -> api:8000
~~~

## 关键文件

- `configs/server.py`：Python API 源码
- `configs/Dockerfile`：镜像构建文件
- `configs/dockerignore.example`：构建忽略示例
- `configs/compose.yaml`：基础 Compose 配置
- `configs/compose.dev.yaml`：开发环境覆盖配置
- `configs/compose.prod.yaml`：生产环境覆盖示例
- `configs/nginx-default.conf`：Nginx 反向代理配置
- `reports/`：运行状态和验证报告

## 构建镜像

~~~bash
docker build -t devops-python-api:0.2.0 docker/day14/app
~~~

## 启动基础环境

~~~bash
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env up -d --build
~~~

## 启动开发环境

~~~bash
docker compose \
  -f docker/day16/compose.yaml \
  -f docker/day16/compose.dev.yaml \
  --env-file docker/day16/.env \
  up -d
~~~

## 健康检查

~~~bash
curl http://127.0.0.1:8094/health
curl http://127.0.0.1:8095/health
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env ps
~~~

## 数据卷验证

~~~bash
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env exec api sh -c 'echo "persistent data" > /data/test.txt'
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env down
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env up -d
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env exec api cat /data/test.txt
~~~

## 常见排查命令

~~~bash
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env ps
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env logs api --tail 50
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env logs nginx --tail 50
docker inspect --format='{{json .State.Health}}' day16-api-1
docker volume ls
curl -i http://127.0.0.1:8094/health
~~~

## 502 故障处理

### 现象

~~~text
HTTP/1.1 502 Bad Gateway
~~~

### 常见原因

Nginx 容器正常运行，但无法连接后端 api 容器。

### 排查步骤

1. 查看 Compose 状态。
2. 查看 api 是否 healthy。
3. 查看 Nginx 日志。
4. 查看 api 日志。
5. 确认 Nginx 配置里的 `proxy_pass http://api:8000` 是否正确。
6. 确认 api 服务环境变量 `PORT=8000` 是否正确。

### 修复命令

~~~bash
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env up -d api
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env restart nginx
curl http://127.0.0.1:8094/health
~~~

## dev 和 prod 配置差异

- dev：允许 bind mount 源码，方便调试；可以暴露调试端口。
- prod：使用固定镜像 tag；不挂载本地源码；更严格的 restart、资源限制、日志和密钥管理。
- prod：`.env` 中不能包含明文密钥，应该使用 Secret 管理方案。

## 已知注意点

当前 base compose 和 dev override 同时使用时，Nginx 可能同时暴露 `8094` 和 `8095`。生产中建议把宿主机端口只放在环境专用 override 文件里，避免端口混乱。

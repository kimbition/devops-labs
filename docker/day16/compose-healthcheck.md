# Day 17 Compose 环境变量、健康检查和重启策略

## 今天学到的概念

- .env：
- environment：
- restart policy：
- unless-stopped：
- healthcheck：
- service_healthy：
- depends_on condition：
- docker inspect：

## .env 文件

~~~text
APP_PORT=8000
HOST_PORT=8094
APP_NAME=devops-python-api-compose
~~~

## restart 策略

~~~yaml
restart: unless-stopped
~~~

含义：

容器异常退出时自动重启；如果是人为 `docker compose stop` 停止，则不会自动启动。

## healthcheck

~~~yaml
healthcheck:
  test: ["CMD", "python", "-c", "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8000/health')"]
  interval: 10s
  timeout: 3s
  retries: 3
  start_period: 5s
~~~

含义：

Docker 定期在容器内部访问 `/health`，判断服务是否健康。

## depends_on condition

~~~yaml
depends_on:
  api:
    condition: service_healthy
~~~

含义：

Nginx 等到 api 健康后再启动。

注意：

这只影响启动顺序，不等于运行期间自动处理所有故障。

## 常用命令

~~~bash
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env ps
docker inspect --format='{{json .State.Health}}' day16-api-1
docker kill day16-api-1
curl http://127.0.0.1:8094/health
~~~

## 今天遇到的问题

暂无

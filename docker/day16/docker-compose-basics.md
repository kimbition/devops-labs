# Day 16 Docker Compose 基础

## 今天学到的概念

- Docker Compose：
- service：
- compose.yaml：
- build context：
- image：
- ports：
- expose：
- volumes：
- depends_on：
- Compose network：
- 服务名 DNS：

## 架构

~~~text
client -> localhost:8093 -> nginx:80 -> api:8000
~~~

## 启动

~~~bash
docker compose -f docker/day16/compose.yaml up -d --build
~~~

## 查看状态

~~~bash
docker compose -f docker/day16/compose.yaml ps
docker ps
~~~

## 访问验证

~~~bash
curl http://127.0.0.1:8093
curl http://127.0.0.1:8093/health
~~~

## 查看日志

~~~bash
docker compose -f docker/day16/compose.yaml logs api
docker compose -f docker/day16/compose.yaml logs nginx
~~~

## ports 和 expose 的区别

- `ports`：把容器端口发布到宿主机。
- `expose`：只声明容器在 Compose 网络内部可访问，不发布到宿主机。

## depends_on 注意点

`depends_on` 只控制启动顺序，不等于等待服务健康可用。

## 502 故障

停止 api 后，Nginx 仍然运行，但无法连接后端，所以返回 502。

排查命令：

~~~bash
docker compose -f docker/day16/compose.yaml ps
docker compose -f docker/day16/compose.yaml logs nginx --tail 20
docker compose -f docker/day16/compose.yaml logs api --tail 20
~~~

## 今天遇到的问题

暂无

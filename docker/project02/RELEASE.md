# Project 02 Release Notes

## v0.1.0

发布日期：2026-05-06

## 内容

- Python API 容器化。
- Nginx 容器反向代理 API。
- Docker Compose 编排多服务。
- 增加 healthcheck 和 restart policy。
- 增加 named volume 数据持久化。
- 增加 dev/prod override 示例。
- 增加运行报告和排障文档。

## 验收命令

~~~bash
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env ps
curl http://127.0.0.1:8094/health
curl http://127.0.0.1:8095/health
docker inspect --format='{{json .State.Health}}' day16-api-1
~~~

## 已知问题

- base compose 与 dev override 叠加时，Nginx 会同时暴露 8094 和 8095。

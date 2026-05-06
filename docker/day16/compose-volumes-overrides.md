# Day 18 Compose 数据卷、配置文件和多环境覆盖

## 今天学到的概念

- named volume：
- bind mount：
- volume persistence：
- compose override：
- dev environment：
- prod environment：
- docker compose down：
- docker compose down -v：

## named volume

~~~yaml
services:
  api:
    volumes:
      - api-data:/data

volumes:
  api-data:
~~~

含义：

`api-data` 是 Docker 管理的 named volume，挂载到 api 容器内的 `/data`。

## 验证数据持久化

~~~bash
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env exec api sh -c 'echo "persistent data" > /data/test.txt'
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env down
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env up -d
docker compose -f docker/day16/compose.yaml --env-file docker/day16/.env exec api cat /data/test.txt
~~~

如果容器重建后仍能看到数据，说明 named volume 生效。

## down 和 down -v 的区别

- `docker compose down`：删除容器和网络，但保留 named volume。
- `docker compose down -v`：同时删除 named volume，数据会丢失。

## bind mount

~~~yaml
volumes:
  - ../day14/app/server.py:/app/server.py:ro
~~~

含义：

把宿主机文件挂进容器。适合开发环境调试，不适合直接作为生产发布方式。

## 多环境覆盖

开发环境：

~~~bash
docker compose \
  -f docker/day16/compose.yaml \
  -f docker/day16/compose.dev.yaml \
  --env-file docker/day16/.env \
  up -d
~~~

生产环境示例：

~~~bash
docker compose \
  -f docker/day16/compose.yaml \
  -f docker/day16/compose.prod.yaml \
  --env-file docker/day16/.env \
  up -d
~~~

## dev 和 prod 的差异

- dev：可以 bind mount 代码，方便快速修改。
- prod：使用固定镜像 tag，不挂载本地代码。
- prod：更严格的 restart policy、日志策略、资源限制和密钥管理。

## 今天遇到的问题

相对路径会受当前目录影响。建议在仓库根目录运行命令，或在当前目录使用对应的相对路径。

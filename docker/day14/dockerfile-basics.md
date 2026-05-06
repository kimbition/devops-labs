# Day 14 Dockerfile 基础

## 今天学到的概念

- Dockerfile：
- build context：
- image tag：
- FROM：
- WORKDIR：
- COPY：
- ENV：
- EXPOSE：
- CMD：
- docker build：
- docker run：
- 环境变量：
- 端口映射：

## 构建镜像

~~~bash
docker build -t devops-python-api:0.1.0 docker/day14/app
~~~

## 运行容器

~~~bash
docker run -d --name devops-python-api -p 8091:8000 devops-python-api:0.1.0
~~~

## API 验证

~~~bash
curl http://127.0.0.1:8091
curl http://127.0.0.1:8091/health
curl -i http://127.0.0.1:8091/not-found
~~~

## 环境变量改变监听端口

~~~bash
docker run -d --name devops-python-api -p 8092:9000 -e PORT=9000 devops-python-api:0.1.0
~~~

含义：

~~~text
宿主机 8092 -> 容器 9000
应用通过 PORT=9000 监听容器内 9000
~~~

## Dockerfile 指令理解

- `FROM`：选择基础镜像
- `WORKDIR`：设置后续命令的工作目录
- `COPY`：复制文件到镜像
- `ENV`：设置环境变量
- `EXPOSE`：声明容器端口，不等于自动发布端口
- `CMD`：容器启动时默认执行的命令

## 常用排查命令

~~~bash
docker ps
docker logs devops-python-api
docker exec devops-python-api env
docker inspect devops-python-api
curl -i http://127.0.0.1:8092/health
~~~

## 今天遇到的问题

暂无

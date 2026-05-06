# Day 15 Docker 镜像层、缓存和 .dockerignore

## 今天学到的概念

- image layer：
- build cache：
- build context：
- .dockerignore：
- COPY 精确文件：
- COPY . . 的风险：
- image size：

## 查看镜像大小

~~~bash
docker images devops-python-api
~~~

## 查看镜像层

~~~bash
docker history devops-python-api:0.1.0
~~~

## .dockerignore

`.dockerignore` 用来排除不应该发送到 build context 或进入镜像的文件。

示例：

~~~text
.cache/
*.tmp
dev-notes.txt
__pycache__/
*.pyc
.git/
~~~

## COPY . . 的风险

`COPY . .` 会把 build context 里的大量文件复制进镜像。如果没有 `.dockerignore`，可能把缓存、日志、密钥、开发笔记、构建产物放进镜像。

更安全的方式是只复制运行需要的文件，例如：

~~~dockerfile
COPY server.py .
~~~

## EXPOSE 注意点

`EXPOSE 8000` 只是镜像元数据，不会自动发布端口。

真正的端口映射由 `docker run -p` 决定：

~~~bash
docker run -p 8092:8000 devops-python-api:0.2.0
~~~

## 构建缓存

Docker 会复用未变化的镜像层。Dockerfile 中越稳定的步骤越应该放前面，变化频繁的代码复制通常放后面。

## 今天遇到的问题

暂无

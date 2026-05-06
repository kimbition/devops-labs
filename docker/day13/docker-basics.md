# Day 13 Docker 基础

## 今天学到的概念

- image：
- container：
- tag：
- docker run：
- detached mode：
- port mapping：
- bind mount：
- docker logs：
- docker exec：
- docker inspect：

## 运行 hello-world

~~~bash
docker run --rm hello-world
~~~

## 运行 Nginx 容器

~~~bash
docker run -d --name devops-nginx -p 8090:80 nginx:stable
~~~

## 端口映射

~~~text
宿主机 8090 -> 容器 80
~~~

访问：

~~~bash
curl http://127.0.0.1:8090
~~~

## 挂载静态页面

~~~bash
docker run -d --name devops-nginx -p 8090:80 \
  -v "$PWD/docker/day13/html:/usr/share/nginx/html:ro" \
  nginx:stable
~~~

## 常用排查命令

~~~bash
docker ps
docker ps -a
docker logs <container>
docker inspect <container>
docker exec -it <container> sh
curl -I http://127.0.0.1:8090
~~~

## 停止和删除容器

~~~bash
docker stop devops-nginx
docker rm devops-nginx
~~~

## 今天遇到的问题

暂无

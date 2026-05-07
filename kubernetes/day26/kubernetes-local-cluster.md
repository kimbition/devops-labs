# Day 26 Kubernetes 本地集群与 kubectl 基础

## 今天学到的概念

- Kubernetes：
- cluster：
- node：
- control plane：
- kubectl：
- kubeconfig：
- context：
- namespace：
- Pod：
- manifest：
- apply：
- describe：
- logs：
- port-forward：

## Docker 和 Kubernetes 的区别

Docker 直接运行容器：

~~~bash
docker run nginx
~~~

Kubernetes 通过声明式 manifest 告诉集群期望状态：

~~~bash
kubectl apply -f nginx-pod.yaml
~~~

Kubernetes 会通过 API、调度器、节点组件来创建和维护 Pod。

## 当前集群

~~~bash
kind create cluster --name devops-lab --wait 120s
kubectl get nodes -o wide
kubectl get pods -A
~~~

## 第一个 Pod

~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  namespace: devops-lab
spec:
  containers:
    - name: nginx
      image: nginx:stable
      imagePullPolicy: IfNotPresent
      ports:
        - containerPort: 80
~~~

## 常用排查命令

~~~bash
kubectl get pods -n devops-lab -o wide
kubectl describe pod nginx-pod -n devops-lab
kubectl logs nginx-pod -n devops-lab --tail=20
kubectl get events -n devops-lab --sort-by=.lastTimestamp
~~~

## 临时访问 Pod

~~~bash
kubectl port-forward -n devops-lab pod/nginx-pod 18090:80
curl -I http://127.0.0.1:18090
~~~

## 今天遇到的问题

暂无

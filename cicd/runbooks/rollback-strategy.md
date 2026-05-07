# CI/CD 回滚策略

## 回滚原则

生产环境优先使用不可变版本镜像，例如：

~~~text
ghcr.io/kimbition/devops-python-api:project02-v0.1.1
~~~

不要把生产部署直接绑定到 `master`，因为 `master` 会随每次 push 变化。

## 常见回滚场景

### 新版本镜像构建失败

处理：

1. 不更新部署环境。
2. 保持旧版本运行。
3. 查看 GitHub Actions 失败 step。
4. 修复后发布新的补丁版本。

### 新版本启动失败

处理：

1. 查看容器日志。
2. 停止新版本容器。
3. 重新运行旧版本镜像。

示例：

~~~bash
docker stop devops-release || true
docker rm devops-release || true
docker run -d --name devops-release -p 8098:8000 ghcr.io/kimbition/devops-python-api:project02-v0.1.1
curl http://127.0.0.1:8098/health
~~~

### Git 提交错误

如果错误已经推送到远程，优先使用 `git revert`：

~~~bash
git revert <bad_commit>
git push
~~~

不要随意改写共享分支历史。

### tag 打错

如果 tag 已推送并可能被使用，优先发补丁版本：

~~~bash
git tag -a project02-v0.1.3 -m "Project 02 Docker Compose release v0.1.3"
git push origin project02-v0.1.3
~~~

不要轻易删除并重打已发布 tag。

## 回滚验证

~~~bash
docker pull ghcr.io/kimbition/devops-python-api:project02-v0.1.1
docker run --rm -p 8098:8000 ghcr.io/kimbition/devops-python-api:project02-v0.1.1
curl http://127.0.0.1:8098/health
~~~

验收：

- [ ] 旧版本镜像可拉取
- [ ] 旧版本容器可启动
- [ ] `/health` 正常
- [ ] 日志无启动错误

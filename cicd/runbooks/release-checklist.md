# CI/CD 发布检查清单

## 发布前

- [ ] `git status` 是 clean
- [ ] 本地 CI 通过：`./ci/local-check.sh`
- [ ] GitHub Actions `CI` workflow 通过
- [ ] Docker Publish workflow 通过
- [ ] 目标版本 tag 已确认
- [ ] 变更内容已写入 release notes
- [ ] 没有提交密钥、token、`.env` 敏感配置
- [ ] 镜像 tag 符合版本规范
- [ ] 回滚目标版本已确认

## 发布命令

~~~bash
git tag -a project02-v0.1.2 -m "Project 02 Docker Compose release v0.1.2"
git push origin project02-v0.1.2
~~~

## 发布后验证

~~~bash
docker pull ghcr.io/kimbition/devops-python-api:project02-v0.1.2
docker run --rm -p 8098:8000 ghcr.io/kimbition/devops-python-api:project02-v0.1.2
curl http://127.0.0.1:8098/health
~~~

## 验收标准

- [ ] 镜像可以成功拉取
- [ ] 容器可以启动
- [ ] `/health` 返回 `status: ok`
- [ ] 应用日志没有启动错误
- [ ] GitHub Actions run 是绿色
- [ ] GHCR 中能看到新版本 tag

## 发布失败处理

- [ ] 停止继续发布
- [ ] 保留失败日志
- [ ] 确认失败 step
- [ ] 判断是否需要回滚
- [ ] 记录故障复盘

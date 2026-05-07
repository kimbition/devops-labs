# Day 21 推送到 GitHub 并触发 Actions

## 今天学到的概念

- remote：
- origin：
- upstream branch：
- push：
- tag push：
- GitHub Actions run：
- CI status：

## 推送流程

~~~bash
git remote add origin https://github.com/YOUR_NAME/devops-labs.git
git push -u origin master
git push origin --tags
~~~

## 检查远程仓库

~~~bash
git remote -v
git branch -vv
~~~

## 查看 Actions

在 GitHub 仓库页面查看：

~~~text
Actions -> CI
~~~

如果使用 GitHub CLI：

~~~bash
gh run list --limit 5
gh run view --log
~~~

## 常见问题

### 认证失败

HTTPS 推送需要 GitHub token，SSH 推送需要配置 SSH key。

### 远程仓库不是空的

如果远程仓库创建时勾选了 README，第一次 push 可能冲突。建议重新建空仓库，或先学习 pull/rebase 后再推。

### CI 没有运行

检查：

1. workflow 文件是否在 `.github/workflows/ci.yml`
2. 是否 push 到 `master`
3. GitHub 仓库 Actions 是否启用
4. YAML 语法是否正确

## 今天遇到的问题

暂无

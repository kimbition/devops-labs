# Git 发布、Tag 和回滚流程

## 分支

创建发布分支：

~~~bash
git switch -c release/project01
~~~

合并回主分支：

~~~bash
git switch master
git merge --no-ff release/project01 -m "release project01 v0.1.0"
~~~

## Tag

创建带说明的 tag：

~~~bash
git tag -a project01-v0.1.0 -m "Project 01 Linux ops release v0.1.0"
~~~

查看 tag：

~~~bash
git tag
git log --oneline --decorate
~~~

## 回滚

生产协作中优先使用 `git revert`，因为它不会改写历史，而是创建一个新的回滚提交。

~~~bash
git revert HEAD --no-edit
~~~

## reset 和 revert 的区别

- `git revert`：新增一条提交来撤销旧提交，适合已经推送或多人协作的分支。
- `git reset`：移动分支指针，可能改写历史，适合本地未推送的临时修改。

## 我的发布流程

1. 从 `master` 创建发布分支。
2. 在发布分支补充 release notes。
3. 合并回 `master`。
4. 打 tag。
5. 如果发布后发现问题，用 `git revert` 回滚。

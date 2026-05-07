# Day 22 GitHub Actions 排查和报告 artifact

## 今天学到的概念

- workflow run：
- job log：
- failed step：
- artifact：
- retention-days：
- if: always()：
- CI report：

## 查看 CI 结果

GitHub 页面：

~~~text
Repository -> Actions -> CI -> workflow run -> check job -> failed step
~~~

GitHub CLI：

~~~bash
gh run list --limit 5
gh run view --log
~~~

## 排查 CI 失败的顺序

1. 看 workflow 是否触发。
2. 看失败的 job。
3. 看失败的 step。
4. 看失败命令的退出码和日志。
5. 在本地复现同一条命令。
6. 修复后重新提交并 push。

## artifact

artifact 用来保存 CI 运行中生成的文件，例如：

- Docker build log
- Compose config 输出
- 测试报告
- 覆盖率报告

workflow 示例：

~~~yaml
- name: Upload CI reports
  uses: actions/upload-artifact@v4
  if: always()
  with:
    name: ci-reports
    path: ci/reports/
    retention-days: 7
~~~

## Python 缓存文件

`__pycache__/` 和 `*.pyc` 不应该提交到 Git。

`.gitignore` 应包含：

~~~text
__pycache__/
*.pyc
~~~

CI 中可以检查：

~~~bash
if git ls-files | grep -E '__pycache__|\.pyc$'; then
  echo "Python cache files are tracked by Git"
  exit 1
fi
~~~

## 今天遇到的问题

暂无

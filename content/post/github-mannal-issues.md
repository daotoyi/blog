---
title: "Git FAQ"
date: "2022-02-05 08:25:00"
lastmod: "2023-10-06 19:39:40"
tags: ["git"]
categories: ["Github"]
draft: false
---

## fatal: in unpopulated submodule XXX {#fatal-in-unpopulated-submodule-xxx}

若是直接从 github 中下载到对应的项目，直接放到自己的版本控制中，在提交就会报此错误 fatal: in unpopulated submodule.

**即使删除了.git 文件也是没用的。**

解决办法:

```sh
git rm -rf --cached
git add .
```


## GitHub Actions Workflow {#github-actions-workflow}


### refusing to allow an OAuth App to create or update workflow {0} without workflow scope {#refusing-to-allow-an-oauth-app-to-create-or-update-workflow-0-without-workflow-scope}

因为 OAuth 的应用没有指定 workflow 范围，所以无法推送带有更新 workflow 的分支。


### refusing to allow a Personal Access Token to create or update workflow {#refusing-to-allow-a-personal-access-token-to-create-or-update-workflow}

GitHub Personal Access Tokens 页面,生成一个新的 Token。特别注意在生成的时候要 `勾选 workflow`.

在 Windows 凭据管理器(控制面板\\所有控制面板项\\凭据管理器)中，找到 GitHub 的几个凭据，然后编辑：

-   git:<https://github.com>
-   git:<https://usernaem.com>

推送的时候如果要求你输入账号密码，输入那个 Token 作为密码即可。

-   [包含 GitHub Actions Workflow 的分支无法推送](https://blog.walterlv.com/post/github-push-failed-without-workflow-scope.html)


## error: server certificate verification failed. {#error-server-certificate-verification-failed-dot}

CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none

证书校验有问题,解决方法是加一个环境变量;

-   linux
    `export GIT_SSL_NO_VERIFY=1`
-   windows
    `set GIT_SSL_NO_VERIFY 1`

之后 `git config --global http.sslVerify false`


## git show: Chinese show {#git-show-chinese-show}

git show 中文显示八进制


### git window {#git-window}

Options−&gt;Text−&gt;local(本地): zh\\_CN

Options−&gt;Text−&gt;Charector set(字符集): UTF-8


### Git Bash {#git-bash}

git config --[global](<https://so.csdn.net/so/search?q=global&spm=1001.2101.3001.7020>) i18n.commitencoding utf-8

注释：该命令表示提交命令的时候使用 utf-8 编码集提交

git config --global i18n.logoutputencoding utf-8

注释：该命令表示日志输出时使用 utf-8 编码集显示

export LESSCHARSET=utf-8

注释：设置 LESS 字符集为 utf-8


### Refer {#refer}

[GIT 使用 log 命令显示中文乱码](<https://www.cnblogs.com/yanzige/p/9810333.html>)
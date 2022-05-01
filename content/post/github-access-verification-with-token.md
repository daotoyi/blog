---
title: "Github 推送验证"
date: "2022-03-19 13:00:00"
lastmod: "2022-04-30 12:32:38"
categories: ["Github"]
draft: false
---

## 采用 token 进行认证访问 {#采用-token-进行认证访问}


### 重新设置远程仓库 {#重新设置远程仓库}

```shell
git remote rm origin
git remote add origin https://hao203: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@github.com/hao203/Demo.git
```


### 修改远程仓库（recommend） {#修改远程仓库-recommend}

```shell
git remote set-url origin https://userName:token@github.com/userName/reponame.git
# or
git remote set-url origin https://token@github.com/userName/reponame.git

git remote set-url origin https://hao203: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@github.com/hao203/Demo.git
```


## 将 token 当作密码 {#将-token-当作密码}

```shell
git push
Username: 用户名
Password: token
# 记住token
git config credential.helper store

# 输入用户名，token后，使用cache缓存
# git config --global credential.helper cache

# 解除认证
git config --global --unset credential.helper
```


## credential 使用 {#credential-使用}

Git 可以指定辅助工具（mananger、wincred 和 store 通过配置 credential.helper），用来存储本地凭证。


### 1 manager {#1-manager}

若安装 Git 时安装了 GitGUI，自动会在 system 级别中设置 credential.helper 为 manager。并且不配置所处级别（system、global 或者 local）如何，一旦设置了 manager，都优先使用该方式。
查看不同级别的 credential.helper


### 2 wincred {#2-wincred}

设置 credential.helper，如 wincred


### 3 store {#3-store}

将当前 local 级别的 credential.helper 设置成 store（过程和前面类似），此时的存储方式变成了 store。如果本地没有存储账号信息，当 push 时输入正确信息，将此保存至 home 目录下的 `.git-credentials` 文件，并且以明文存储，内容如： `https://userName:pwd(token)@github.com`

配置好 credentials 服务和密钥后，在其它使用 git 命令需要认证的时候，就会自动从这里读取用户认证信息完成认证了。


## 使用 windows 凭据管理器 {#使用-windows-凭据管理器}

凭据管理器 -&gt; windows 凭据 ==&gt; 找到“git:<https://github.com>”  ==&gt; 用 token 替换以前的密码.

{{< figure src="https://img-blog.csdnimg.cn/1a494eb9a6ff4a0c98fd16e2556cd5da.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0NTQ4MDc1,size_16,color_FFFFFF,t_70#pic_center" >}}


## Reference {#reference}

-   [配置git-credentials完成git身份认证](https://blog.sbw.so/u/use-git-credentials-auth-system.html)
-   [GitHub使用Personal access token](https://www.cnblogs.com/chenyablog/p/15397548.html)
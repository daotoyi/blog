---
title: "Packages Manager"
date: "2022-04-02 12:30:00"
lastmod: "2022-04-30 12:48:31"
tags: ["managePackage"]
categories: ["Tools"]
draft: false
---

## Scoop {#scoop}


### 安装 {#安装}

Scoop 依赖于 Powershell 3+ 和 .NET Framework 4.5+，因此，安装 Scoop 前请确保已经正确安装了它们。

```shell
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
# 如果出现“权限”错误，请根据错误提示执行以下命令
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
```

scoop install 命令默认情况下仅为当前用户安装应用，除非指定 -g 选项将应用安装为全局的。


#### 用户安装位置 {#用户安装位置}

Scoop 安装用户应用的默认位置是：~/scoop，如下命令可自定义该位置。

```shell
# 设置用户环境变量 SCOOP
[environment]::setEnvironmentVariable('SCOOP', 'D:\program\scoop', 'User')
# 使 SCOOP 在当前命令行生效
$env:SCOOP='D:\program\scoop'
# 安装用户应用
scoop install <APP-NAME>
```


#### 全局安装位置 {#全局安装位置}

Scoop 安装全局应用的默认位置是：C:\ProgramData\scoop，如下命令可自定义该位置。

```shell
# 设置全局环境变量
[environment]::setEnvironmentVariable('SCOOP_GLOBAL','D:\program\scoop-apps','Machine')
# 使 SCOOP_GLOBAL 在当前命令行生效
$env:SCOOP_GLOBAL='D:\program\scoop-apps'
# 安装全局应用
scoop install -g <APP-NAME>
```


### 更换 scoop 源 {#更换-scoop-源}

```shell
scoop config SCOOP_REPO https://gitee.com/squallliu/scoop
scoop update
```


### 更换 bucket 源 {#更换-bucket-源}

```shell
scoop install git
# 注意：引号里面换成自己的路径，如果是默认路径则为${Env:USERPROFILE}\scoop\buckets\<bucket_name>

git -C "D:\Scoop\buckets\main" remote set-url origin https://hub.fastgit.org/ScoopInstaller/Main.git
git -C "D:\Scoop\buckets\extras" remote set-url origin https://hub.fastgit.org/lukesampson/scoop-extras.git
```


### 添加 bucket 库 {#添加-bucket-库}

-   镜像 1: <https://hub.fastgit.org/>
-   镜像 2: <https://github.com.cnpmjs.org/>
-   镜像 3: <https://ghproxy.com/>

<!--listend-->

```shell
scoop bucket add main 'https://hub.fastgit.org/ScoopInstaller/Main'
scoop bucket add extras 'https://hub.fastgit.org/lukesampson/scoop-extras'
scoop bucket add versions 'https://hub.fastgit.org/ScoopInstaller/Versions'
scoop bucket add jetbrains 'https://hub.fastgit.org/Ash258/Scoop-JetBrains'
scoop bucket add dorado 'https://hub.fastgit.org/h404bi/dorado'

# scoop bucket add main 'https://github.com.cnpmjs.org/ScoopInstaller/Main'
# scoop bucket add extras 'https://github.com.cnpmjs.org/lukesampson/scoop-extras'
# scoop bucket add versions 'https://github.com.cnpmjs.org/ScoopInstaller/Versions'
# scoop bucket add jetbrains 'https://github.com.cnpmjs.org/Ash258/Scoop-JetBrains'
# scoop bucket add dorado 'https://github.com.cnpmjs.org/h404bi/dorado'
```


### 常用命令 {#常用命令}

```shell
# 查看某软件执行命令位置
scoop which {{name}}

# 打开某软件官网
scoop home {{name}}

# 检查潜在的问题
scoop checkup

# 查找指定应用，可仅提供部分应用名
scoop search <QUERY>

# 安装应用
scoop install <APP-NAME>
# 卸载应用
scoop uninstall <APP-NAME>
# 查看状态，列出可更新应用

scoop status
# 更新指定应用
scoop update <APP-NAME>

# 更新所有可更新应用
scoop update *

# 查看已安装的应用
scoop list

# scoop reset
# 先添加 versions bucket
scoop bucket add versions
# 同时安装 Python 2.7 和最新版本
scoop install python27 python
# 切换到 Python 2.7.x
scoop reset python27
# 切换到 Python 3.x
scoop reset python

# 删除已安装软件的旧版本，如删除所有软件旧版本
scoop cleanup *

# 清理软件缓存，通常是下载的软件安装包。
scoop cache rm *
```


### 配置 {#配置}

需要设置的一般也就是两个：

-   aria2
    -   `scoop config aria2-enabled true`
    -   `scoop config aria2-enabled false`
    -   不建议开启，经常有各种奇奇怪怪的问题

-   proxy 设置
    -   `coop config proxy 127.0.0.1:1080`

        ```shell
        scoop config proxy [username:password@]host:port
        scoop config rm proxy

        scoop config proxy currentuser@default
        scoop config proxy user:password@default
        scoop config proxy none # 绕过代理直连
        ```
    -   `scoop config rm proxy`


### git 代理 {#git-代理}

scoop 很多更新操作是基于 GitHub 的，因此，通常也会为 git 配置代理。

```shell
git config --global http.proxy http://host:port
git config --global https.proxy https://host:port
```


### Note {#note}


#### 下载不成功 {#下载不成功}

-   github 访问有问题
-   git 仓库不干净,update 最新的版的 scoop 不能 pull 成功


## Chocolatey {#chocolatey}


### chocolateygui {#chocolateygui}

```shell
choco install chocolateygui
chocolateygui #即可进入软件界面
```


## Pacman {#pacman}


### pacman {#pacman}


#### parameter {#parameter}

-   -S : synchronization, 在安装之前先与软件库进行同步
-   -y : 更新本地存储库
-   -u : 系统更新

-   -Q : 查询本地包数据库
-   -S : 查询同步数据库
-   -F : 查询文件数据库
    -   -s : search
    -   -i : information
    -   -l : list
        -   package_name


#### CMD {#cmd}

```bash
pacman -Syu xxx
pacman -Qs xxx
pacman -Ss xxx
pacman -F xxx

# 卸载一个包，并且删除它的所有依赖
pacman -R xxx
# 删除当前未安装的所有缓存包和未使用的同步数据库
pacman -Sc
# 从缓存中删除所有文件，请使用清除选项两次
pacman -Scc

# 安装不是来自远程存储库的“本地”包
pacman -U local/path.pkg.tar.xz
# 安装官方存储库中未包含的“远程”软件包：
pacman -U http://www.example.com/repo/example.pkg.tar.xz
```


### featture {#featture}


#### soft version {#soft-version}

pacman 将其下载的包存储在 `/var/cache/Pacman/pkg/` 中，并且不会自动删除旧版本或卸载的版本。

1.  它允许 降级 一个包，而不需要通过其他来源检索以前的版本。
2.  已卸载的软件包可以轻松地直接从缓存文件夹重新安装。


#### db.lc {#db-dot-lc}

当 pacman 要修改包数据库时，例如安装包时，它会在 /var/lib/pacman/db.lck 处创建一个锁文件。这可以防止 pacman 的另一个实例同时尝试更改包数据库。

如果 pacman 在更改数据库时被中断，这个过时的锁文件可能仍然保留。如果你确定没有 pacman 实例正在运行，那么请删除锁文件。

lsof /var/lib/pacman/db.lck


### pactree {#pactree}

查看一个包的依赖树

```bash

pactree <package_name>
```


### paccache {#paccache}

pacman contrib 包中提供的 paccache(8) 脚本默认情况下会删除已安装和未安装包的所有缓存版本，但最近 3 个版本除外

```bash
paccache -r
```


### downgrade {#downgrade}


#### downgrade {#downgrade}

使用 downgrade 命令的前提是你之前已经安装过该软件包

```bash
sudo pacman -S downgrade
downgrade package_name
# 弹出可选的本地包供选择
```


#### [Aur-Repo](https://aur.archlinux.org/packages?_blank) {#aur-repo}

从 AUR 仓库[Sources]下载历史源码,解压后生成安装包.

```bash
tar -zxvf xxx.tar.gz
cd xxx
makepkg -s
pacman -U xxx.pkg.tar.xz
```


## Yarn {#yarn}

Yarn 对你的代码来说是一个包管理器。它可以让你使用并分享 全世界开发者的（例如 JavaScript）代码。 Yarn 能够快速、安全、 并可靠地完成这些工作，所以你不用有任何担心。

代码通过 包（package） (或者称为 模块（module）) 的方式来共享。 一个包里包含所有需要共享的代码，以及描述包信息的文件，称为 package.json 。


### Install {#install}

npm install --global yarn

-   Windows

    ```shell
    scoop install yarn
    # scoop install nodejs
    yarn --version
    ```
-   Linux

<!--listend-->

```shell
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update && sudo apt install yarn
```


### Manual {#manual}

```shell
# 初始化一个新项目
yarn init

# 添加依赖包
yarn add [package]
yarn add [package]@[version]
yarn add [package]@[tag]

# 将依赖项添加到不同依赖项类别中
# 分别添加到 devDependencies、peerDependencies 和 optionalDependencies 类别中：
yarn add [package] --dev
yarn add [package] --peer
yarn add [package] --optional

# 升级依赖包
yarn upgrade [package]
yarn upgrade [package]@[version]
yarn upgrade [package]@[tag]

# 移除依赖包
yarn remove [package]

# 安装项目的全部依赖
yarn
# 或者
yarn install
```


## Ref {#ref}

-   [Windows 系统缺失的包管理器：Chocolatey、WinGet 和 Scoop](https://sspai.com/post/65933#!)
-   [Scoop 不完全上手指南](https://www.iamzs.top/archives/scoop-guidebook.html)
---
title: "Mac OS 新手配置"
author: ["SHI WENHUA"]
date: "2024-03-28 17:55:00"
lastmod: "2024-04-07 14:39:38"
categories: ["Mac"]
draft: false
---

### Homebrew {#homebrew}


#### instruction {#instruction}

Homebrew 是 MacOS（或 Linux）的软件包管理器。Homebrew 是一款包管理工具，目前支持 macOS 和 Linux 系统。主要有四个部分组成：

-   brew： 源代码仓库
-   homebrew-core： 核心源
-   homebrew-cask： macOS 应用及大型二进制文件安装
-   homebrew-bottles： 预编译二进制安装包

brew 下载安装目录

-   brew 下载的安装包位于： ~/Library/Caches/Homebrew
-   brew install 命令安装的应用程序会默认放在/usr/local/Cellar/目录下


#### install {#install}

```bash
# 官方
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 国内
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/HomebrewUninstall.sh)"

# homebrew的安装路径为："/opt/Homebrew/"
# 安装时需要先安装git

# 更换brew.git
git -C "$(brew --repo)" remote set-url origin https://mirrors.ustc.edu.cn/brew.git # 中科大
git -C "$(brew --repo)" remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git # 阿里巴巴
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git # 清华大学
# 更换xxx
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git # 中科大
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git # 中科大
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles' >> ~/.bash_profile # 中科大
source ~/.zshrc
# source ~/.bash_profile

# 恢复默认源
git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew.git
git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://github.com/Homebrew/homebrew-cask.git
# 删除环境变量 HOMEBREW_BOTTLE_DOMAIN
source ~/.zshrc
# source ~/.bash_profile
brew update
```


#### brew usage {#brew-usage}

```bash
brew -v
brew --repo  # install path /opt/homebrew

# 查看 brew 当前源
git -C "$(brew --repo)" remote -v
# 查看 homebrew-core 当前源
git -C "$(brew --repo homebrew/core)" remote -v
# 查看 homebrew-cask 当前源
git -C "$(brew --repo homebrew/cask)" remote -v


Brew install node         # 默认安装最新版
brew install node@14.16.8 # 安装指定版本
brew switch node 16.0.0   # 切换版本

brew upgrade name
brew uninstall name

# 常用
brew config          # 查看brew配置
brew info node       # 查看node安装信息
brew list            # 查看已安装软件
brew list --versions # 查看已安装软件版本号
brew search node     # 搜索可用node相关软件
brew update brew     # 自身更新
brew cleanup         # 清除下载的缓存
brew doctor          # 诊断brew，并给出修复命令

# 服务相关
brew services list          # 获取services列表
brew services info
brew services start/stop/restart serverName
brew services start mysql   # 启动mysql服务
brew services restart mysql # 重启mysql服务
brew services stop mysql    # 停止mysql服务
brew services cleanup
```


#### brew doctor {#brew-doctor}

```bash
brew doctor # 查看问题，按照指示对问题进行修复
brew update-reset # 将homebrew还原到稳定版
brew update # 更新软件包
```


#### brew install 和 brew cask install {#brew-install-和-brew-cask-install}

Homebrew 是一款 Mac OS 平台下的软件包管理工具，拥有安装、卸载、更新、查看、搜索等很多实用的功能。

Homebrew 通过简单的一条指令，就可以实现包管理，不需要关心各种依赖和文件路径的情况。

Homebrew 的两个术语：

-   Formulae：软件包，包括了这个软件的依赖、源码位置及编译方法等；
-   Casks：已经编译好的应用包，如图形界面程序等。

Homebrw 相关的几个文件夹用途：

-   bin：用于存放所安装程序的启动链接（相当于快捷方式）
-   etc：brew 安装程序的配置文件默认存放路径
-   Library：Homebrew 系统自身文件夹
-   Cellar：通过 brew 安装的程序将以 [程序名/版本号] 存放于本目录下

区别：

-   brew 是下载源码解压，然后 ./configure &amp;&amp; make install ，同时会包含相关依存库，并自动配置好各种环境变量。
-   brew cask 是针对已经编译好了的应用包（.dmg/.pkg）下载解压，然后放在统一的目录中（Caskroom），省掉了自己下载、解压、安装等步骤。

-   brew install 用来安装一些不带界面的命令行工具和第三方库。
-   brew cask install 用来安装一些带界面的应用软件。


#### brew tap {#brew-tap}

除了自带的两个仓库「Formulae」与「Casks」，使用 tap 指令可以添加更多的仓库。这些仓库默认从 Homebrew 自己的 Github 仓库添加，但也可以是第三方的仓库「甚至可以是你自己的仓库」。

[https://github.com/Homebrew](https://github.com/Homebrew)


### 必备软件 {#必备软件}


#### brew {#brew}

-   install

<!--listend-->

```bash
brew install fish
# fish_add_path /opt/homebrew/bin # 否则安装完fish后brew识别不到

brew install hunspell # emacs required
brew install global   # required by emacs ggtags
brew install ctags    # required by vim ctags
brew install htop
brew install cheat
brew install aria2
brew install tig
brew install fd
brew install fzf
brew install bat      # dependenies: libssh2, libgit2, oniguruma
# brew install exa.   # exa has been disabled because it is not maintained upstream
brew install zoxide
brew install ripgrep
brew install hugo

# services
brew install nginx
brew services start nginx
```

-   exa

MANUAL INSTALLATION: download, put bin.link to /usr/local/bin


#### brew cask {#brew-cask}

```bash

# 输入法
brew install --cask squirrel # 需要设置页面点击添加

# brew install --cask microsoft-office
brew install --cask microsoft-word
brew install --cask microsoft-excel
brew install --cask microsoft-outlook
brew install --cask microsoft-powerpoint
brew install --cask microsoft-remote-deskto
brew install --cask onedrive
brew install --cask wpsoffice-cn

# vpn
brew install --cask shadowsocksx-ng-r
brew install --cask v2rayu
brew install --cask qv2ray # deprecated.

brew install --cask dozer # deprecated.

brew install --cask docker
brew install --cask visual-studio-code

# soft-tool
brew install --cask iterm2
brew install --cask alfred
brew install --cask parallels # RMB600+/y
brew install --cask the-unarchiver # rar.zip.tar.

brew install --cask wechat
brew install --cask google-chrome
brew install --cask commander-one
# brew install --cask double-commander

brew install --cask sublime-text
brew install --cask obsidian
brew install --cask tabby
brew install --cask todesk
# brew install --cask dwihn0r-keepassx # not well
brew install --cask keepassxc
```


#### brew tap {#brew-tap}

```bash
brew tap homebrew/cask-fonts
# brew install homebrew/cask-fonts/font-mona-sans

brew tap d12frosted/emacs-plus
brew tap railwaycat/emacsmacport # emacs-mac. Port
brew install d12frosted/emacs-plus/emacs-plus@30
```


#### brew bundle {#brew-bundle}

Homebrew 不仅仅是一个包管理器，还具有软件依赖管理能力。通过 Homebrew Bundle 可以解决所有软件依赖，包括官方和第三方的 formula 以及 cask，甚至还包括 Mac App Store（简称 mas）中的应用。

```bash
# 生成Brewfile安装文件
brew bundle dump

# 安装
brew bundle
```


#### mas-cli {#mas-cli}

Homebrew 并不能管理 MAS 上的应用软件。 mas-cli 官方用「A simple command line interface for the Mac App Store. Designed for scripting and automation.」这样简洁的话说明了它的用途。

MAS 中每一个应用都有自己的应用识别码 (Product Identifier)，MAS 就是根据 Product Identifier 安装与更新应用的。

官方地址：<https://github.com/mas-cli/mas>

-   基本用法

<!--listend-->

```bash
brew install mas

mas list
mas search app-name

# $ mas search 1Password
# 443987910 1Password
# $ mas install 443987910
mas install A-id B-id n-id # install multi-app

mas upgrade # 更新所有 MAS 中已安装的应用
mas upgrade A-id B-id
mas outdated

# 安装macOS
mas install 1246284741（对应的macos识别码）

# 查询账号
mas account
# 退出当前帐号
$ mas signout
# 登陆新的账号
$ mas signin mas@example.com "mypassword"
# 使用图形登录
$ mas signin --dialog mas@example.com
```

-   shell alias

<!--listend-->

```bash
vim ~/.zshrc

alias masus='mas signout && mas signin myusappleid "mypassword"'
alias mascn='mas signout && mas signin mycnappleid "mypassword"'
alias mas?='mas account'
```

注意:

-   安装的应用软件必须是在 MAS 商店登陆账号的已购列表中存在的，因为 mas-cli 命令行无法在 MAS 中完成「购买」这个操作。否则安装时就会报类似：无法使用此 Apple ID 重新下载的错误。
-   对于 MAS 中新上架的应用，可能无法查询到其应用识别码。因为 mas-cli 的查询列表在其缓存文件中，可能暂时未更新。如若由其他途径（如应用链接）得知新上架应用识别码，仍可正常安装。


#### brew 正常安装 {#brew-正常安装}

```bash
brew install --cask \
     atom、datagrip、deno、discord、docker、emacs、golang、chrome、idea、\
     网易邮箱大师（mailmaster）、网易云音乐( neteasemusic)、有道词典(youdaodict)、腾讯会议（tencent-meeting）、\
     micro、mos、mumble、nginx、node、openjdk8、openjdk11、postman、wechat、qq、qqmusic、rust-up、\
     sogouinput、ssr、telegram、telnet、terminus、tree、unrar、vscode、wget、aliwangwang
```


#### brew 安装异常 {#brew-安装异常}

-   百度网盘，brew 安装的是一个很老的叫百度同步盘的东西
-   zoom 会议，brew 没有


#### 下载安装 {#下载安装}

-   Neat Download Manager
    -   官网下载，双击后在访达位置处将 app 文件拷贝到 Application 中。
-   TotalFinder


### 工具软件 {#工具软件}


#### Spacemacs {#spacemacs}

<!--list-separator-->

-  terminal

    -   emacs

    <!--listend-->

    ```bash
    brew install emacs
    # dependencies:
    # gmp, libunistring, libidn2, libtasn1, nettle, p11-kit, libevent, libnghttp2, unbound, gnutls and jansso
    ```

    -   emacs-plus(also GUI）

    <!--listend-->

    ```bash
    brew tap d12frosted/emacs-plus
    brew install emacs-plus --with-native-comp

    brew install d12frosted/emacs-plus/emacs-plus@30
    ```

<!--list-separator-->

-  GUI

    -   Emacs For Mac OSX(官方 complele)
    -   Emacs Mac Port
    -   相较于 Emacs For Mac OS X ，Emacs Mac Port 界面效果更好，裸 Emacs 的图标更加美观。

    主要特性：

    -   Core Text for text rendering. 增强文本显示及 Unicode 支持，已并入官方 24.4   - 平滑滚动。用触控板时可以像素级平滑滚动，官方版是按行滚动。   - 手势。可以用触控板手势调整字体大小等   - 支持 Apple 的事件。   - 支持字典服务，三指查看字典   - 服务集成。可以在 Finder 中用 Emacs 打开指定文件   - 用 Webkit 替代 librsvg 来显示 SVG

    -   emacs mac port (官方基础上优化后编译）

    <!--listend-->

    ```bash
    brew tap railwaycat/emacsmacport
    brew install --cask emacs-mac
    ```

<!--list-separator-->

-  spacemacs configure

    ```bash
    cd ~
    mv .emacs.d .emacs.d.bak
    mv .emacs .emacs.bak

    brew install --cask emacs-mac
    emacs --version

    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    ```

<!--list-separator-->

-  dylayer/configure key

    -   Spacemacs 的主要配置位于 `~/.spacemacs` 文件中。
        -   可以单独使用编辑器对此文件进行编辑，也可以在 Spacemacs 中对其进行编辑。
        -   在 Spacemacs 状态下进行编辑 `SPC f e d` ，刷新配置 `SPC f e R` 。
    -   dylayer 的主要配置位于 `~/.spacemacs.d/` 目录中。
        ```bash
        mkdir ~/.spacemacs.d
        git clone https://github.com/daotoyi/spacemacs.d.git ~/.spacemacs.d
        ```


#### MacTex {#mactex}

MacTex 提供了几个版本，完整版的 Mactex 超过一个 G，而基本版的话只有 90MBs 左右.

BasicTex 轻量化的版本在使用中发现一些工具不存在，命令行报错“multirow.sty not found”，可以直接安装这个缺失的模块。例如： =sudo tlmgr install multirow=，这个 tlmgr 是 BasicTex 自带的。

```bash
# brew install --cask mactex
brew install --cask basictex

# 生成pdf文件需要的模块。
sudo tlmgr update --self
sudo tlmgr install wrapfig
sudo tlmgr install capt-of
sudo tlmgr install ctex
sudo tlmgr install framed
sudo tlmgr install lipsum
sudo tlmgr install tcolorbox
sudo tlmgr install environ
```


#### Proxy {#proxy}

```bash
# 当前终端走代理
export http_proxy=http://proxyAddress:port
# 前终端运行以下命令，wget/curl这类网络命令都会经过ss代理
export ALL_PROXY=socks5://127.0.0.1:1080
```


### 办公软件 {#办公软件}


#### Outlook {#outlook}

<!--list-separator-->

-  263 登录

    -   POP
    -   电子邮箱地址
        -   xxx@xxx.com
    -   POP 用户名
        -   xxx@xxx.com
    -   POP 密码
        -   （邮箱密码）
    -   POP 接收服务器
        -   popcom.263xmail.com
        -   (使用 ssl 连接）
            -   无
    -   SMTP 用户名
        -   空
    -   SMTP 密码
        -   空
    -   SMTP 发送服务器
        -   smtpcom.263xmail.com
        -   (使用 ssl 连接）
            -   无


#### AppMail {#appmail}

-   IMAP
-   收服务器
    -   imap.263.net
-   发服务器
    -   smtp.263.net


#### 网易邮箱 {#网易邮箱}

```nil
brew install --cask mailmaster
```


### 投资软件 {#投资软件}


## D {#d}

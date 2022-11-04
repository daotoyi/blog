---
title: "Manjaro/Linux 使用"
date: "2022-03-31 22:53:00"
lastmod: "2022-10-31 19:20:38"
categories: ["Linux"]
draft: false
---

## basic opreration {#basic-opreration}

`/etc/pacman.conf`


### 更新系统 {#更新系统}

```bash
pacman -Syy					#本地的包数据库和远程的软件仓库同步
pacman -Syu

pacman -Su # 如果你已经使用 pacman -Sy 将本地的包数据库与远程的仓库进行了同步，也可以只执行：
```


### 安装包 {#安装包}

```bash
pacman -S 包名    # 例如，执行 pacman -S firefox ,也可以同时安装多个包，以空格分隔包名即可。
pacman -Sy 包名   # 与上面命令不同的是，该命令将在同步包数据库后再执行安装。
pacman -Sv 包名   # 在显示一些操作信息后执行安装。
pacman -U 安装本地包 # 其扩展名为 pkg.tar.gz。
```


### 删除包 {#删除包}

```bash
pacman -R 包名   # 该命令将只删除包，不包含该包的依赖。
pacman -Rs 包名  # 在删除包的同时，也将删除其依赖。
pacman -Rd 包名  # 在删除包时不检查依赖。
pacman -Rsc 包名 # 删除一个包,所有依赖
```


### 搜索包 {#搜索包}

```bash
pacman -Ss 关键字 # 这将搜索含关键字的包。
pacman -Qi 包名   # 查看有关包的信息。
pacman -Ql 包名   # 列出该包的文件。
pacman -Qo 包名   # 列出该包被哪个包包含
```


### 清理系统 {#清理系统}

```bash
sudo pacman -Rsn $(pacman -Qdtq)
sudo pacman -Scc
sudo rm /var/lib/systemd/coredump/.
sudo journalctl --vacuum-size=50M

pacman -R $(pacman -Qdtq) #
```


### 其他用法 {#其他用法}

```bash
pacman -Sw 包名 #只下载包，不安装。
pacman -Sc Pacman # 下载的包文件位于 /var/cache/pacman/pkg/ 目录。该命令将清理未安装的包文件
pacman -Scc # 清理所有的缓存文件。
```


## FAQ {#faq}


### update systecm {#update-systecm}


#### <span class="org-todo done DONE">DONE</span> - python-pip:xxx files exists. {#python-pip-xxx-files-exists-dot}

```bash
pacman -R python-pip
pacman -Syu
```


#### Errors occurred, no packages were upgraded. {#errors-occurred-no-packages-were-upgraded-dot}

-   error: failed to commit transaction (invalid or corrupted package)

[Manjaro软件更新失败：无效或已损坏的软件包](https://juejin.cn/post/7091962125660192798)


## pacman-gpg {#pacman-gpg}


### 说明 {#说明}

加密的过程是：如果 A 君要发送信息给 B 君，首先 B 君得把自己的公钥扔出来，A君得获取 B 君的公钥后加密信息并发送过去，B君收到（加过密的）信息使用自己的私钥解密就可以还原信息了。

而数字签名的过程稍微不同，信息是通过普通未加密方式发送信息给对方的，只是在每条信息后面都会附加一坨字符（名曰：签名）， 这个签名是由程序根据发送者的私钥以及信息内容计算得出，接收者使用发送者的公钥就可以核对信息有无被篡改。


### 操作 {#操作}


#### 生成查看 {#生成查看}

```bash
$ gpg --gen-key
$ gpg --full-generate-key
$ gpg --list-keys   查看本机钥匙信息
$ gpg -k 生成钥匙对
$ gpg -a --output key.public --export UID<用户 ID>   导出公钥

$ gpg --keyserver keys.gnupg.net --send-key ID    把公钥发布到公钥服务器
```


#### 生成撤销证书 {#生成撤销证书}

```bash
$ gpg --gen-revoke ID  制作一张撤销证书，用于密钥作废，请求外部公钥服务器撤销你的公钥

# 二进制证书 revocation-gmail.cert； 但会提示 "已强行使用 ASCII 封装过的输出"
$ gpg --output revocation-gmail.cert --gen-revoke MASTERKEYID

# -a (--armor)输出文件为 revocation-gmail-cert.txt 文本文件
$ gpg -a -o revocation-gmail-cert.txt --gen-revoke MASTERKEYID
```


#### 下载导入证书 {#下载导入证书}

```bash
$ gpg --send-keys <key-id>   分发
$ gpg --search-keys <key-id>    查询
$ gpg --recv-keys <key-id>    导入

$ gpg --keyserver keys.gnupg.net --search-key ivarptr<示例作者名>    # –search-key 用于指定搜索关键字，可以是 uid 的名字或者 email 地址部分
$ gpg --keyserver keys.gnupg.net --recv-key 72E75B05   知道要导入的公钥的 id，也可以跳过搜索而直接导入：
$ gpg --keyserver p80.pool.sks-keyservers.net --recv-keys ID
$ gpg --keyserver subkeys.pgp.net --recv-keys
# --keyserver hkp://keyserver.ubuntu.com:80
    GnuPG 默认的公钥服务器是 keys.gnupg.net
    keys.gnupg.net 背后是一组服务器，它们之间的信息同步需要一定的时间，如果刚刚提交了自己的公钥,要过一段时间（大概 1 小时）就可以查到了。
    如果你用的是普通公钥服务器，比如 pgp.mit.edu 则不会有这个问题。
$ gpg --import key.public   直接导入对方公钥文件 key.public
```


#### 导出密钥 {#导出密钥}

```bash
gpg --armor --output public-key-gmail.txt --export MASTERKEYID    # 导出公钥
gpg --armor --output secret-key-gmail.txt --export-secret-keys MASTERKEYID    # 导出私钥
gpg --edit-key MASTERKEYID    # 编辑密钥

gpg --export -armor -o filename      (文件目录如  F:\file.txt)
gpg --export -a > filename
```


#### 签名 {#签名}

```bash
# 需要进一步跟我核对公钥是否正确，然后签收（sign key）它
$ gpg --fingerprint  # 因为公钥有可能出现冒牌货，所以每个公钥里都加入了指纹值，使用下面命令可以查看指纹值
$ gpg --sign-key ivarptr
$ gpg --delete-keys ivarptr
```


### 加密文件 {#加密文件}

```bash
给 ivarptr--用 ivarptr 的公钥
$ gpg -a --output message-ciper.txt -r ivarptr@126.com -e message.txt
    -a 表示输出文本文件格式。
    –output 指定输出（即加密后）的文件名。
    -r 指定信息的接收者（recipient）公钥的 uid，可以是名字也可以是 email 地址。
    -e 表示这次要执行的是加密（encrypt）操作。

    ivarptr 解密一个文件
$ gpg --output message-plain.txt -d message-ciper.txt
```


### 数字签名 {#数字签名}

```bash
$ gpg -a -b message.txt   #  在当前文件夹里产生一个 message.txt.asc 的文件
    -a 表示输出文本文件格式。
    -b 表示以生成独立的签名文件的方式进行签名。
$ gpg --verify message.txt.asc  # 把原信息文件 message.txt 连同签名文件 message.txt.asc 一起
```


### github {#github}

git commit -S -m "提交信息" # -S 选项表示对此次提交使用 gpg 进行签名

GitHub 中，使用 SSH 连接到 GitHub 时可以使用 ssh key 来进行加密连接；而 gpg key 用于认证每次提交.


## pacman-keys {#pacman-keys}


### pacman.conf {#pacman-dot-conf}

```bash
[mingw32]
SigLevel = Optional TrustAll
Include = /etc/pacman.d/mirrorlist.mingw32

[mingw64]
SigLevel = Optional TrustAll
Include = /etc/pacman.d/mirrorlist.mingw64

[msys]
SigLevel = Optional TrustAll
Include = /etc/pacman.d/mirrorlist.msys

[archlinuxcn]
SigLevel = Optional TrustAll
Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
#Server = http://repo.archlinuxcn.org/$arch
#Server = rsync://sync.repo.archlinuxcn.org
```


### keys {#keys}

```bash
出现 Keys 错误，签名失败。。之类的依次运行以下命令

1)移除旧的 keys
  sudo rm -rf /etc/pacman.d/gnupg
2)初始化 pacman 的 keys
  sudo pacman-key --init
3)加载签名的 keys
  sudo pacman-key --populate archlinux
4)刷新升级已经签名的 keys
  sudo pacman-key -refresh-keys
5)清空并且下载新数据
  sudo pacman -Sc
```


## ntpdate {#ntpdate}


### 同步网络时间 {#同步网络时间}

ntpdate 0.rhel.pool.ntp.org


### 双系统时间不一致 {#双系统时间不一致}

sudo timedatectl set-local-rtc 1


## libreoffice-Chinese {#libreoffice-chinese}

pacman -S libreoffice-zh-CN


## gen-MirrorList + update system {#gen-mirrorlist-plus-update-system}


### 生成镜像列表 {#生成镜像列表}

```bash
sudo pacman-mirrors -i -c China -m rank


  0.161 China          : https://mirrors.pku.edu.cn/manjaro/
  0.160 China          : http://mirrors.pku.edu.cn/manjaro/
  0.329 China          : https://mirrors.aliyun.com/manjaro/
  0.240 China          : https://mirrors.ustc.edu.cn/manjaro/
  0.155 China          : https://mirrors.tuna.tsinghua.edu.cn/manjaro/
  0.156 China          : https://mirrors.tuna.tsinghua.edu.cn/manjaro/
  0.363 China          : https://mirrors.sjtug.sjtu.edu.cn/manjaro/
```


### /etc/pacman.conf: {#etc-pacman-dot-conf}

```bash
[archlinuxcn]
SigLevel = Optional TrustedOnly
#清华源
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch

#更新源列表
sudo pacman-mirrors -g

#更新 pacman 数据库并全面更新系统
sudo pacman -Syyu

#防止 PGP 签名错误
sudo pacman -S archlinuxcn-keyring
sudo pacman -S antergos-keyring
```


## HotKey {#hotkey}

```bash
Alt + f10 最大化窗口或原大小
Alt + f9 隐藏窗口
Alt + f8 跟随鼠标调整窗口大小
Alt + f7 跟随鼠标调整窗口位置
ctrl + alt + right / left 下一个工作区/上一个工作区

# 终端下
ctrl + shift + s 设置终端标题
xfce4-popup-whiskermenu 显示 super 菜单
```


## social-Tool {#social-tool}

```bash
# TIM:
yaourt -S deepin-wine-tim
yaourt -Sy deepin.com.qq.office  (这个在效

# Wechat
yaourt -S deepin-wechat  (sudo 会报错 )

# Netease-cloud
pacman -S netease-cloud-music
```


## shell {#shell}

chsh -s /bin/zsh （重启生效)


## install-deb {#install-deb}

```bash
# 查看电脑上是否安装过
sudo pacman -Q debtap

# 安装 yay 工具，记得配置 arch
sudo pacman -S yay

# 安装解包打包工具 debtap
yay -S debtap

# 升级 debtap
sudo debtap -u

sudo debtap  xxxx.deb
sudo pacman -U x.tar.xz
```


## RIME {#rime}

```bash
# 1、源文件目录
/usr/share/rime-data/

# 2、用户目录
~/.config/ibus/rime/
~/.config/fcitx/rime/
```


## scan {#scan}

yauourt  -S  xsane	#后台服务端


## XX-net {#xx-net}

```bash
  supervisor
  # 手动启动
  /usr/bin/supervisord -c /etc/supervisor.conf
  # 手动关闭
  /usr/bin/supervisorctl stop all
  kill pid
  # 添加自启动服务
  systemctl enable supervisord.service
  or
  systemctl start/restart/stop supervisord.service

  supervisorctl start/stop zhoujyAADADWRAZCQ
  supervisorctl start/stop all

  # 在/etc/supervisor/conf.d 文件夹新建文件 shadowsocks.conf :
  :<<EOF
  [program:shadowsocks]
command = ssserver -c /var/shadowsocks/shadowsocks.json
user = root
autostart = true
autoresart = true
stderr_logfile = /var/shadowsocks/shadowsocks.stderr.log
stdout_logfile = /var/shadowsocks/shadowsocks.stdout.log
EOF

  # 后台运行：
  sudo supervisorctl reread
  sudo supervisorctl update
  sudo supervisorctl start shadowsocks
```


## theme {#theme}

```bash
# 图标
yaourt -S numix-circle-icon-theme
pacman -S papirus-icon-theme

# 主题
yaourt -S gtk-theme-arc-git

# 字体:
xfce4-appearance-settings
style:
  vertex-maia-light
Font:
  cantarell
```


## WPS-font {#wps-font}

```bash
 sudo cp * /usr/share/fonts
 # 生成字体索引：
 sudo mkfontscale
 sudo mkfontdir

 # 更新字体缓存：
 sudo fc-cache -fv

 PKGBUILD
# 编译安装 PKGBUILD
 makepkg -i  #安装
 makepkg   #不立即安装  makepkg -fi  重新编译再安装

 若文件存在：
 makepkg，然后 pacman -U --force file.pkg.tar.xz 强制覆盖安装（file.pkg.tar.xz 就是 makepkg 生成的本地安装包

 asciiquarium
 cmatrix

 Manjaro
  ████████  ████████  ████████     WM Theme: X-Arc-White
  ████████  ████████  ████████     GTK Theme: Arc [GTK2]
  ████████  ████████  ████████     Icon Theme: Enlightenment-X

 cairo-dock
 dockbarx
```


## conky {#conky}

```bash
API:a2f877a8682f22d1da079a5617de304e
ID:1809104 haidian
ID:1796236 shanghai
kill $(ps aux | grep conky | awk '{print $2}')

conky -c /home/wenhuas/Harmattan/.harmattan-themes/Transparent/God-Mode/.conkyrc  #透明 黑白
conky -c /home/wenhuas/Harmattan/.harmattan-themes/Glass/God-Mode/.conkyrc  #透明 黑白 较黑

conky -c /home/wenhuas/Harmattan/.harmattan-themes/Flatts/God-Mode/normal-mode/.conkyrc #多彩
conky -c /home/wenhuas/Harmattan/.harmattan-themes/Elementary/God-Mode/normal-mode/.conkyrc
conky -c /home/wenhuas/Harmattan/.harmattan-themes/Nord/God-Mode/normal-mode/.conkyrc
```


## virbox {#virbox}

> 共享文件
> net use e：\\\vboxsvr
> net use e: /del


## docker {#docker}

```bash
pacman -Syu # update system first
pacman -S docker

# 默认只有root用户可以管理Docker，可运行下列命令将当前用户赋予管理权限
sudo usermod -aG docker $USER
```

默认的镜像下载站点是在海外，切换到国内镜像站点可以提高下载速度。

打开或新建/etc/docker/daemon.json 文件，将镜像地址添加到 registry-mirrors 数组里即可。

```bash
  {
    "registry-mirrors": [
        "https://registry.docker-cn.com"
    ]
}
```


## selinux {#selinux}

Manjaro 防火墙默认关闭的，并且没有安装 selinux.

```bash
systemctl stop iptables #关闭防火墙
setenforce 0 #关闭 selinux
```

关闭 selinux 开机启动:

`vim /etc/selinux/config`, 将 `SELINUX=enforcing` 改为 `SELINUX=disabled`


## bt_panel {#bt-panel}


### install {#install}

```bash
curl -sSO http://download.bt.cn/install/install_panel.sh &&sudo bash ./install_panel.sh
```


### systemctl {#systemctl}

/etc/systemd/system/bt-local.service

```toml
[Unit]
Description="bt.local Compatibility"

[Service]
RestartSec=30s
Type=simple
ExecStart=/etc/bt.local start
#Restart=always
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
```


## ag {#ag}

```bash
pacman -S the_silver_searcher
```


## certbox {#certbox}

```bash
pacman -S certbot
pip install certbot-nginx
```


## tools {#tools}


###  {#d41d8c}
+++
title = "Jianguoyun"
date = 2022-04-01T10:29:00+08:00
lastmod = 2022-04-01T10:32:04+08:00
categories = ["Tools"]
draft = false
+++

坚果云中设置，倒是可以在坚果云的同步文件夹右键中选择“选择性同步”，但是只能设置到单个文件夹。

可通过以下方式设置单个文件不同步。

-   Windows 系统

    打开您电脑上的 %APPDATA%\Nutstore\db 目录, 下载该规则文件放入此文件夹

-   Linux 和 Mac 系统

    打开您电脑上的~/.nutstore/db 目录, 下载该规则文件放入此文件夹

启用该功能时，默认的忽略规则并不受到影响。

.../db/customExtRules.cfg

```bash
# 坚果云自定义忽略同步规则
#
# 警告:
# 该文件用来自定义坚果云的忽略同步规则, 文件编码必须为 UTF-8.
# 由于用户修改了自定义忽略规则导致坚果云无法正常工作的问题由用户自己负责.
#
# 说明:
# 每行一条规则. 以 # 开头的行将被忽略.
# 每条规则必须以英文半角句号开头, 否则会忽略
# 无效的规则会被忽略, 并在坚果云日志文件中提示.
#
# 注意事项:
# 忽略规则仅影响文件, 不影响文件夹
# 忽略规则会且仅会在 *上传* 时生效
# 每次修改需要重启客户端才能生效.
# 该规则文件不会自动同步到其他设备.
#
# 例子:
# 忽略所有扩展名为 *.bak 的文件, 规则为 .bak

# disabLED/blacklist/whitelist 三选一
# disabled 禁用该功能
# blacklist 黑名单模式, 列出的文件类型都不会被上传
# whitelist 白名单模式, 只上传列出的文件类型
mode=blacklist


# 规则开始
.d
.hex
```


## Ref {#ref}

-   [坚果云文件名的限制](https://help.jianguoyun.com/?p=1904)
-   [坚果云忽略同步文件的设置](https://www.cnblogs.com/jetz/p/5517040.html)
-   [爱上坚果云](https://bbs.elecfans.com/jishu_1144251_1_1.html)
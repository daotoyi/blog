---
title: "Microsoft 账号无法登陆"
date: "2022-05-09 17:45:00"
lastmod: "2022-07-17 17:29:24"
categories: ["Internet"]
draft: false
---

## DNS 修改配置 {#dns-修改配置}

-   WLAN 属性
-   Internet 协议版本 4
-   DNS 修改为 4.2.2.2
-   备选 DNS 修改为 4.2.2.1


## 官方方案 {#官方方案}

1.  点击「此处」下载 “调整 HOST 文件” 工具。请您解压文件，右击 Hosts-Modify.bat 文件，点击 “以管理员身份运行” 按钮，稍等片刻，关闭黑色 CMD 窗口，再次启动 Office 应用并登录 Microsoft 账户。
2.  启动开始菜单，输入 CMD，右击搜索结果，选择 ”以管理员身份运行“。请您依次执行下方 5 个命令，手动重置 TCP / IP 堆栈、释放并续订 IP 地址、刷新并重置 DNS 客户端解析程序缓存：

<!--listend-->

```cmd
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns
```

全部执行成功后，请您重启电脑，继续执行步骤 3。

1.  右击任务栏 ”网络“ 图标，打开 ”网络和 Internet“ 设置。请您点击 “网络和共享中心”，继续点击当前网络名称，打开网络状态窗口。点击 “属性”，双击 “Internet 协议版本 4 (TCP / IPv4)”，将 DNS 服务器手动设置为 4.2.2.1 和 4.2.2.2，确定。请您再次测试 Office 应用 “登录” 功能是否已经恢复正常。


## Ref {#ref}

-   [Office不能登录微软账户了](https://answers.microsoft.com/zh-hans/msoffice/forum/all/office%e4%b8%8d%e8%83%bd%e7%99%bb%e5%bd%95/0c53f42b-2ffc-4e06-bbb9-503d98c4e0b7)
+++
title = "Huginn"
lastmod = 2022-02-27T08:18:31+08:00
categories = ["RSS"]
draft = false
+++

Huginn is a system for building agents that perform automated tasks for you online.

[中文社区](https://huginn.cn/home/) [英文官网](http://huginn.com/)


## heroku deploy {#heroku-deploy}

-   [利用 Huginn 打造一站式信息阅读平台](https://huginn.cn/blog/huginn/%e5%88%a9%e7%94%a8-huginn-%e6%89%93%e9%80%a0%e4%b8%80%e7%ab%99%e5%bc%8f%e4%bf%a1%e6%81%af%e9%98%85%e8%af%bb%e5%b9%b3%e5%8f%b0)

heroku 空间几点说明：

-   heroku 免费账户的网站在 30 分钟内无人访问后会自动关闭（休眠），可以使用网站监控服务来防止其休眠，例如：uptimerobot：<https://uptimerobot.com>。
-   heroku 免费用户的所有 app 运行总时长为每个月 550 小时，也就是说你的 APP 无法保证 30X24X7 小时全天候运行，建议让网站每天只运行 18 小时。当然添加信用卡之后，会再赠送 450 小时。
-   heroku 免费账户只有 5M 的 Postgres 数据库，只允许在数据库中记录 10000 行，因此，作者建议设置 heroku config:set AGENT_LOG_LENGTH=20。
-   Huginn 安装在 heroku 的过程中默认使用的是 SendGrid 的邮箱服务器，但是 heroku 非信用卡用户无法使用 SendGrid 的邮箱服务器，建议添加其它邮箱服务器，比如，gmail 邮箱服务器，具体设置如下：

    ```org
    heroku config:set SMTP_DOMAIN=google.com
    heroku config:set SMTP_USER_NAME=<你的 gmail 邮箱地址>
    heroku config:set SMTP_PASSWORD=<邮箱密码>
    heroku config:set SMTP_SERVER=smtp.gmail.com
    heroku config:set EMAIL_FROM_ADDRESS=<你的 gmail 邮箱地址>
    ```


## linux deploy {#linux-deploy}

-   [Huginn及环境搭建](https://blog.wangjiegulu.com/2018/04/02/build_the_environment_for_huginn/)
-   [在Linux上手动安装教程Huginn抓取全文RSS和微信公众号](https://huginn.cn/blog/huginn/%e5%9c%a8linux%e4%b8%8a%e6%89%8b%e5%8a%a8%e5%ae%89%e8%a3%85%e6%95%99%e7%a8%8bhuginn%e6%8a%93%e5%8f%96%e5%85%a8%e6%96%87rss%e5%92%8c%e5%be%ae%e4%bf%a1%e5%85%ac%e4%bc%97%e5%8f%b7)


## docker deploy(recommend) {#docker-deploy--recommend}


### recommend reason {#recommend-reason}

-   安装快，而且这本身就是 docker 的主要应用场景和优势所在。
-   如果是常规安装方式，需要安装依赖包、ruby 环境、数据库、nginx、huginn 及各种配置；
-   docker 就只需要下载 docker 镜像，运行 huginn 容器就可以了。


### docker operate {#docker-operate}

```shell
yum install -y docker
apt install docker

systemctl start docker.service
systemctl enable docker.service

# 查看所有已设置开机启动的服务
systemctl list-unit-files | grep enable
# 查看已启动的服务
systemctl list-units --type=service


docker run -it -p 3000:3000 huginn/huginn

docker ps [-a]
docker port [ID] # 查看容器端口映射情况
docker stop [ID]
docker kill [ID] # close
docker rm [ID]   # remove
docker rmi [ID]  # uninstall
docker run [ID]

docker images # 查看已安装镜像

# 设置Docker中的容器自启动：
docker update --restart=always [ID]
```

```shell
# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
398327b7a97a        huginn/huginn       "/scripts/init"     2 hours ago         Up 2 hours          0.0.0.0:3000->3000/tcp   busy_driscoll
```


### huginn startup {#huginn-startup}

[基于 Docker 搭建 Huginn](https://miaotony.xyz/2020/02/03/Server_Huginn/)

`docker run -it -p 3000:3000 huginn/huginn` 部署成功后访问 IP+3000 端口，出现界面点击登录，默认账号密码是 `admin/password` .

-   <http://0.0.0.0:3000/>
-   <http://127.0.0.1:3000>
-   <http://localhost:3000>


### huginn configure {#huginn-configure}

-   [使用 Huginn 批量订阅微信公众号](https://www.jianshu.com/p/582ad1400d6e)
-   [如何高效地订阅微信公众号](https://www.jianshu.com/p/582ad1400d6e)
-   [Huginn 中文指南：搭建自己的 iFTTT](https://www.jianshu.com/p/d3407cc3df5c)
-   [RSS 进阶篇：Huginn - 真·为任意网页定制 RSS 源（PhantomJs 抓取）](https://zhuanlan.zhihu.com/p/46216545)

在 Scenarios 下创建 Agent 组合:

Scenarios -&gt; New Scenarios -&gt; Name(?) -&gt;Save Scenarios


#### 获取订阅号标题 {#获取订阅号标题}

在新创建的 Scenarios，点击 New Agent，开始创建:

```js
  {
  "expected_update_period_in_days": "2",
  "url": [
    "http://weixin.sogou.com/weixin?query=aicjnews",
    "http://weixin.sogou.com/weixin?query=sansioption",
    "http://weixin.sogou.com/weixin?query=optionworld",
    "http://weixin.sogou.com/weixin?query=optionstudio_yuli",
    "http://weixin.sogou.com/weixin?query=Future_finance"
  ],
  "type": "html",
  "mode": "on_change",
  "extract": {
    "url": {
      "xpath": "//*[@id=\"sogou_vr_11002301_box_0\"]/dl[3]/dd/a",
      "value": "@href"
    },
    "title": {
      "xpath": "//*[@id=\"sogou_vr_11002301_box_0\"]/dl[3]/dd/a",
      "value": "normalize-space()"
    }
  }
}
```

-   Type: Website Agent
-   url：<http://weixin.sogou.com/weixin?query=%E5%BE%AE%E4%BF%A1%E5%8F%B7ID>
-   type: 可以有 html, xml, json, text 多种格式
-   mode:
    -   “on_change”表示仅输出下面的内容
    -   ”merge”表示新内容和输入的 agent 内容合并
-   extract 要提取的信息,标题、链接、内容和时间等
    -   链接 value: @href
    -   标题 value: normalize-space(.)


#### 去除重复 {#去除重复}

为了节省时间和减少 VPS 资源的占用，需要剔除重复的文章。

```js
{
    "property": "{{title}}",
    "lookback": "0",
    "expected_update_period_in_days": "20"
}
```

-   Type: De Duplication Agent


#### 获取全文 {#获取全文}

```js
{
  "expected_update_period_in_days": "2",
  "url_from_event": "{{url}}",
  "type": "html",
  "mode": "merge",
  "extract": {
    "title": {
      "css": "#activity-name",
      "value": "."
    },
    "fulltext": {
      "css": "#js_content",
      "value": "."
    }
  }
}
```

-   Type: Website Agent
-   URL：{{url}}，即抓取刚刚获取 RSS 的链接地址
-   mode: “merge”
-   value: “.”，即原样输出全文并合并原先的输出


#### 输出 RSS {#输出-rss}

```js
{
    "secrets": [
        "weixin-xxx"
    ],
    "expected_receive_period_in_days": 2,
    "template": {
        "title": "xxx",
        "description": "xxx输出RSS",
        "item": {
            "title": "{{title}}",
            "description": "{{fulltext|regex_replace:'data-src','src'}}",
            "link": "{{url}}"
        }
    }
}
```

`公众号全文中的Html并非标准的Html，要将其中的data-src 全部替换成src，否则输出的RSS中图片无法正常显示`


### note {#note}

因为搜狗上有反爬虫机制，所以 Agent 的触发间隔最好长一点. 如果想将触发间隔设置短一些，又不会触发到反爬虫机制，可以使用 Phantomjscloud 提供的 API，借助云端模拟浏览器进行爬取.
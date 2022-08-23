---
title: "SiYuan_note"
date: "2022-08-21 10:10:00"
lastmod: "2022-08-21 10:10:49"
categories: ["Tools"]
draft: false
---

## 简介 {#简介}

开源免费且“本地优先”的下一代个人知识管理系统 (笔记软件)，它支持离线使用，同时也支持端到端加密同步。

使用官方的云端服务来同步数据, 或通过 Docker 简单快速地部署在自己私有的 VPS 服务器或 NAS、PC、树莓派等设备上

支持

-   类似 Typora
-   所见即所得的 Markdown 可视化编辑
-   类似 Notion 的“内容块”编辑
-   大纲、块级双向链接、全文搜索、标签分类、数学公式、思维导图 / 流程图、代码片段、跨平台同步等众多特性


## Docker 部署 {#docker-部署}

```bash
if [ -d ${CURRENT_PATH}/siyuan/workspace ];then
  :
else
  mkdir -p ${CURRENT_PATH}/siyuan/workspace
fi

chown -R 1000:1000 ./siyuan/workspace

docker run -d \
  --name siyuan_note \
  --restart=always \
  -v ${CURRENT_PATH}/siyuan/workspace:/siyuan/workspace \
  -p 6806:6806 \
  -u 1000:1000 \
  b3log/siyuan \
  --workspace=/siyuan/workspace/

# -u 1000:1000
# In the image, the normal user siyuan (uid 1000/gid 1000) created
# by default is used to start the kernel process.
```


## 同步 {#同步}

**Docker 部署只支持 PC/移动端 网页访问**
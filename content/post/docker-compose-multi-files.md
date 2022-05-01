---
title: "Docker compose multi-files"
lastmod: "2022-04-30 12:25:03"
categories: ["Docker"]
draft: true
---

## two mode {#two-mode}

1.  通过使用多个 compose 文件扩展整个 compose 文件
2.  使用 extends 字段扩展单个服务


## multi files {#multi-files}

使用多个 compose 文件可以为不同的环境或不同的工作流自定义 compose 应用程序.

默认下，compose 读取两个文件，一个 docker-compose.yml 和一个可选的 docker-compose.override.yml 文件。通常来说，docker-compose.yml 包含基本的配置。而 override 文件包含覆盖已存在服务或整个新服务的配置。

当使用多个配置文件时，必须确保文件中所有的路径是相对于 base compose 文件的(-f 指定的第一个 compose 文件)。这样要求是因此 override 文件不需要是一个有效的 compose 文件。override 文件可以只包含配置中的小片段。跟踪一个服务的片段是相对于哪个路径的是很困难的且令人困惑的，所以要保持路径容易理解，所以的路径必须定义为相对于 base 文件的路径。

docker compose 的 extends 关键词能够在不同的文件或甚至完全不同的项目之间共享通用的配置。

> 注意：不能使用 extends 来共享 links, volumes_from 和 depends_on 配置。这是为了避免隐式依赖 – 始终在本地定义 links 和 volumes_fromm。这确保了当读取当前文件时服务之间的依赖是清晰可见的。在本地定义这些还确保对引用文件的更改不会导致破坏。


### docker-compose.yml {#docker-compose-dot-yml}

```cfg
web:
  extends:
    file: common-services.yml
    service: webapp
```


### common-services.yml {#common-services-dot-yml}

```cfg
webapp:
  build: .
  ports:
    - "8000:8000"
  volumes:
    - "/data"
```

`docker-compose -f docker-compose.yml -f docker-compose.a.yml up -d` 将会使用 docker-compose.yml 和 docker-compose.a.yml(没有用到 docker-compose.b.yml)来部署这三个服务。


## Ref {#ref}

-   [扩展Compose服务-extend](https://www.bookstack.cn/read/dockerdocs/Compose-extends.md#%E6%89%A9%E5%B1%95Compose%E6%9C%8D%E5%8A%A1)
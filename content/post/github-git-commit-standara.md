---
title: "Git commit 规范"
date: "2023-11-18 12:10:00"
lastmod: "2023-11-18 12:10:12"
categories: ["Github"]
draft: false
---

type 为必填项，用于指定 commit 的类型，约定了 feat、fix 两个主要 type，以及 docs、style、build、perf、refactor、revert 六个特殊 type

主要 type

-   feat: 增加新功能
-   fix: 修复 bug

特殊 type

-   docs:     只改动了文档相关的内容
-   style:    代码格式修改，例如去掉空格、改变缩进、增删分号
-   build:    构造工具的或者外部依赖的改动，例如 webpack，npm
-   perf:     提高性能的改动
-   refactor: 代码重构时使用
-   revert:   执行 git revert 打印的 message

完整的 commit message 示例：

```bash
git add .
git commit -m "build(package.json):升级vue版本到v3.0.2"
git push origin dev
```
+++
title = "Hugo 主题 even 使用小结"
date = 2022-02-05T08:19:00+08:00
lastmod = 2022-02-12T08:50:00+08:00
draft = false
+++

## config {#config}

hugo --config debugconfig.toml
hugo --config a.toml,b.toml,c.toml


## commmet {#commmet}


### 在 even 主题中加入 utterances {#在-even-主题中加入-utterances}

-   创建 repository
    在 Github 上新建一个 public repo，用于存储评论内容

-   配置 config

为了方便配置，把需要的参数都放在 config.toml 文档中，在该文档中加入：

```toml
[params.utter]
  repo = "{githubName}/{repoName}"
  issueTerm = "title"        #设置每篇文章对应的 issue 的名字，可选 pathname title url，
  theme = "github-light"
```

-   配置 comments

打开 themes/even/layouts/partials/comments.html，在 gitalk 下面加一个 utterances 的控制结构：

```html
{{- if .Site.Params.utter.repo -}}
  <div id="utter-container"></div>
  <script src="https://utteranc.es/client.js"
      repo= '{{ .Site.Params.utter.repo }}'
      issue-term= "{{ .Site.Params.utter.issueTerm }}"
      theme= '{{ .Site.Params.utter.theme }}'
      crossorigin= "anonymous"
      async>
  </script>
{{- end }}
```


## note {#note}


### 主页面 home 显示(post) {#主页面-home-显示--post}

必须在 content 目录下建立 post 目录保存文件,否则 Home 页面识别不到文件.


### 主页面选项(repositories,about) {#主页面选项--repositories-about}

repositories,about 文件需放在 content 目录下.
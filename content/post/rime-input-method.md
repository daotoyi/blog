---
title: "Rime"
lastmod: "2022-05-21 16:05:57"
categories: ["Tools"]
draft: true
---

## 使用说明 {#使用说明}


#### 同步 {#同步}

打开 installation.yaml 文件，在最下方添加如下代码:
C:\Users\\\`USER\`\AppData\Roaming\Rime\installation.yaml

```nil
sync_dir: 'D:\path\to\RimeSync'
```

在开始菜单找到点击\*【小狼毫】用户资料同步\*.

**NOTE** :Rime 的同步功能，在个人词典是双向同步，在个人配置是单项同步。


#### 使用 {#使用}

从 gitee 下载后，将内容全部拷入到用户资料夹：

用戶資料夾

-   【中州韻】 ~/.config/ibus/rime/
-   【小狼毫】 %APPDATA%\Rime
-   【鼠鬚管】 ~/Library/Rime/


## 用戶資料夾 {#用戶資料夾}

包含爲用戶準備的內容，如：

-   〔全局設定〕 default.yaml
-   〔發行版設定〕 weasel.yaml
-   〔預設輸入方案副本〕 &lt;方案標識&gt;.schema.yaml


#### 編譯輸入方案所產出的二進制文件： {#編譯輸入方案所產出的二進制文件}

-   〔Rime 棱鏡〕 &lt;方案標識&gt;.prism.bin
-   〔Rime 固態詞典〕 &lt;詞典名&gt;.table.bin
-   〔Rime 反查詞典〕 &lt;詞典名&gt;.reverse.bin


#### 記錄用戶寫作習慣的文件： {#記錄用戶寫作習慣的文件}

-   ※〔用戶詞典〕 &lt;詞典名&gt;.userdb/ 或 &lt;詞典名&gt;.userdb.kct
-   ※〔用戶詞典快照〕 &lt;詞典名&gt;.userdb.txt、&lt;詞典名&gt;.userdb.kct.snapshot 見於同步文件夾


#### 以及用戶自己設定的： {#以及用戶自己設定的}

-   ※〔用戶對全局設定的定製信息〕 default.custom.yaml
-   ※〔用戶對預設輸入方案的定製信息〕 &lt;方案標識&gt;.custom.yaml
-   ※〔用戶自製輸入方案〕及配套的詞典源文件


#### 日誌： {#日誌}

-   【中州韻】 /tmp/rime.ibus.\*
-   【小狼毫】 %TEMP%\rime.weasel.\*
-   【鼠鬚管】 $TMPDIR/rime.squirrel.\*

**註:** 以上標有 ※ 號的文件，包含用戶資料，您在清理文件時要注意備份！


## Note {#note}


### default.custom.yaml {#default-dot-custom-dot-yaml}

```cfg
patch:
  schema_list:
    - {schema: wubi_pinyin}
    - {schema: emoji}
    - {schema: luna_pinyin}
  "switcher/hotkeys":
    - "Control+grave"
    - "Control+Alt+0"
```


### wubi_pinyin.custom.yaml {#wubi-pinyin-dot-custom-dot-yaml}

```cfg
# https://github.com/rime/rime-emoji
switches/@next:
  name: emoji_suggestion
  reset: 1
  states: [ "🈚️️\uFE0E", "🈶️️\uFE0F" ]
'engine/filters/@before 0':
  simplifier@emoji_suggestion
emoji_suggestion:
  opencc_config: emoji.json
  option_name: emoji_suggestion
  tips: all
```


### Ref {#ref}

-   [EMOJIALL](https://www.emojiall.com/zh-hans/)
-   [rime/rime-emoji](https://github.com/rime/rime-emoji)
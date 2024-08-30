---
title: "Rime"
author: ["SHI WENHUA"]
date: "2022-07-16 20:43:00"
lastmod: "2024-06-11 22:43:29"
categories: ["Tools"]
draft: false
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


#### 定制文档 {#定制文档}

```yaml
Patch:
 "一级设定项/二级设定项/三级设定项": 新的设定值
 "另一个设定项": 新的设定值
 "再一个设定项": 新的设定值
 "含列表的设定项/@0": 列表第一个元素新的设定值
 "含列表的设定项/@last": 列表最后一个元素新的设定值
 "含列表的设定项/@before 0": 在列表第一个元素之前插入新的设定值（不建议在补丁中使用）
 "含列表的设定项/@after last": 在列表最后一个元素之后插入新的设定值（不建议在补丁中使用）
 "含列表的设定项/@next": 在列表最后一个元素之后插入新的设定值（不建议在补丁中使用）
```


## 用戶資料夾 {#用戶資料夾}

包含爲用戶準備的內容，如：

-   〔全局設定〕 default.yaml
    -   用于设置输入法方案、切换输入法快捷键、中英文切换、翻页等等。
-   〔發行版設定〕 weasel.yaml
    -   用于设置托盘图标、指定软件默认英文输入、候选词横竖排列、界面布局、配色方案等等。
-   〔預設輸入方案副本〕 &lt;方案標識&gt;.schema.yaml
    -   &lt;方案标识&gt;.custom.yaml 用于设置具体的输入方案。


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


## 显示简繁体 {#显示简繁体}

在 RIME 輸入法的基础上，将简体词库进行擴充：.dict.yaml 的文件为字典文件，输入的字母与相应的文字符号进行映射


### 词库扩充\* {#词库扩充}

采用 OpneCC （Open Chinese Convert（OpenCC））自动实现，将字典文件(见附件链接）生成一个新的文件，替换原有文件，最终在 RIME 中进行重新部署

转换代码如下：

```python
from opencc import OpenCC
import time

def transText(file, newFile):
    index = 0
    covT = OpenCC('s2t')  # 转繁体
    covTW = OpenCC('s2tw')  # 转台湾繁体
    covHK = OpenCC('s2hk')  # 转香港繁体

    with open(file, "r", encoding="utf-8") as f1, open(newFile, "w", encoding="utf-8") as f2:
        for line in f1:
            index += 1
            if index % 200 == 0:
                print(f'Line{index}')

            f2.write(line)

            t = covT.convert(line)
            if t != line:
                f2.write(t)

            tw = covTW.convert(line)
            if t != tw:
                f2.write(t)

            hk = covHK.convert(line)
            if hk != tw:
                f2.write(hk)


if __name__ == '__main__':
    time_start = time.time()

    filename = 'THUOCL_car.dict.yaml'
    filenameN = 'THUOCL_car.dict.yaml_'

    transText(filename, filenameN)

    time_end = time.time()
    print(f'End ,time cost {time_end-time_start} s')
```


### Ref {#ref}

-   [RIME输入法 实现简体中文输入，简体繁体多个提示](https://blog.csdn.net/yulinxx/article/details/124006694)


## 配置说明 {#配置说明}

```yaml
# 输入方案配置
patch:
  # 载入自定义词库表
  translator:
    dictionary: daoyi
    enable_sentence: false
    # 把preedit里的 ' 删除
    preedit_format:
      - "xform/'//"
  # preedit分隔符改成 '
  "speller/delimiter": "'"
  # 默认英文
  "switches/@0/reset": 1  #表示将 switcher 列表中的第一个元素（即 ascii_mode 开关）的初始值重设为状态1（即“英文”）。

   # 20k_en设置（这里下载了easy_en.schema.yaml 和 easy_en.dict.yaml以后，可以换成easy_en）
  "schema/dependencies/@next": 20k_en
  # 載入翻譯英文的碼表翻譯器，取名爲 english
  "engine/translators/@next": [email protected]
  # english 翻譯器的設定項
  english:
    dictionary: 20k_en
    spelling_hints: 9
    # 自动完成
    enable_completion: true
    enable_sentence: false
    # 候选词排名优先级，还是不太满意
    initial_quality: 0
    # 删除候选字里的自动完成提示（没有用，因为效果是输入eng以后，提示:english ~lish）
    comment_format:
      - "xform/[~a-z]*//"

  # Emoji支持
  # 切换Emoji
  "switches/@next":
    name: emoji_suggestion
    reset: 1
    states: [ "🈚️️uFE0E", "🈶️️uFE0F" ]
  # 增加Emoji过滤器
  "engine/filters/@before 0":
    [email protected]_suggestion
  # 使用opencc（即简繁转换）的方式实现emoji输入，可以理解为简-emoji转换。
  emoji_suggestion:
    opencc_config: emoji.json
    option_name: emoji_suggestion
    # 设置为all会显示tips，其他任何值都不会显示。
    tips: none

  simplifier:
    option_name: zh_simp

  # 不懂，也许有啥用。
  recognizer:
    patterns:
      email: "^[A-Za-z][-_.0-9A-Za-z]*@.*$"
      uppercase: "[A-Z][-_+.'0-9A-Za-z]*$"
      url: "^(www[.]|https?:|ftp[.:]|mailto:|file:).*$|^[a-z]+[.].+$"
      # 简写用
      punct: "^/([a-z]+|[0-9]0?)$"

  # 改寫拼寫運算，使得含西文的詞彙（位於 luna_pinyin.cn_en.dict.yaml 中）不影響簡拼功能（注意，此功能只適用於朙月拼音系列方案，不適用於各類雙拼方案）
  # 本條補靪只在「小狼毫 0.9.30」、「鼠鬚管 0.9.25 」、「Rime-1.2」及更高的版本中起作用。
  # "speller/algebra/@before 0": xform/^([b-df-hj-np-tv-z])$/$1_/

  punctuator:
    # 载入默认symbols.yaml，可以替换成mysymbols.yaml
    import_preset: symbols
    half_shape:
      "#": "#"
      "`": "`"
      "~": "~"
      "@": "@"
      "=": "="
      "/": ["/", "÷"]
      '': ["、", '']
      "'": {pair: ["「", "」"]}
      "[": ["【", "["]
      "]": ["】", "]"]
      "$": ["¥", "$", "€", "£", "¢", "¤"]
      "<": ["《", "〈", "«", "<"]
      ">": ["》", "〉", "»", ">"]
    symbols:
      "/fs": [½,‰,¼,⅓,⅔,¾,⅒]
      "/dq": [🌍,🌎,🌏,🌐,🌑,🌒,🌓,🌔,🌕,🌖,🌗,🌘,🌙,🌚,🌛,🌜,🌝,🌞,⭐,🌟,🌠,⛅,⚡,❄,🔥,💧,🌊]
      "/jt": [⬆,↗,➡,↘,⬇,↙,⬅,↖,↕,↔,↩,↪,⤴,⤵,🔃,🔄,🔙,🔚,🔛,🔜,🔝]
      "/sg": [🍇,🍈,🍉,🍊,🍋,🍌,🍍,🍎,🍏,🍐,🍑,🍒,🍓,🍅,🍆,🌽,🍄,🌰,🍞,🍖,🍗,🍔,🍟,🍕,🍳,🍲,🍱,🍘,🍙,🍚,🍛,🍜,🍝,🍠,🍢,🍣,🍤,🍥,🍡,🍦,🍧,🍨,🍩,🍪,🎂,🍰,🍫,🍬,🍭,🍮,🍯,🍼,🍵,🍶,🍷,🍸,🍹,🍺,🍻,🍴]
      "/dw": [🙈,🙉,🙊,🐵,🐒,🐶,🐕,🐩,🐺,🐱,😺,😸,😹,😻,😼,😽,🙀,😿,😾,🐈,🐯,🐅,🐆,🐴,🐎,🐮,🐂,🐃,🐄,🐷,🐖,🐗,🐽,🐏,🐑,🐐,🐪,🐫,🐘,🐭,🐁,🐀,🐹,🐰,🐇,🐻,🐨,🐼,🐾,🐔,🐓,🐣,🐤,🐥,🐦,🐧,🐸,🐊,🐢,🐍,🐲,🐉,🐳,🐋,🐬,🐟,🐠,🐡,🐙,🐚,🐌,🐛,🐜,🐝,🐞,🦋]
      "/bq": [😀,😁,😂,😃,😄,😅,😆,😉,😊,😋,😎,😍,😘,😗,😙,😚,😇,😐,😑,😶,😏,😣,😥,😮,😯,😪,😫,😴,😌,😛,😜,😝,😒,😓,😔,😕,😲,😷,😖,😞,😟,😤,😢,😭,😦,😧,😨,😬,😰,😱,😳,😵,😡,😠]
      "/ss": [💪,👈,👉,👆,👇,✋,👌,👍,👎,✊,👊,👋,👏,👐]
      "/dn": [⌘, ⌥, ⇧, ⌃, ⎋, ⇪, , ⌫, ⌦, ↩︎, ⏎, ↑, ↓, ←, →, ↖, ↘, ⇟, ⇞]
      "/fh": [©,®,℗,ⓘ,℠,™,℡,␡,♂,♀,☉,☊,☋,☌,☍,☑︎,☒,☜,☝,☞,☟,✎,✄,♻,⚐,⚑,⚠]
      "/xh": [＊,×,✱,★,☆,✩,✧,❋,❊,❉,❈,❅,✿,✲]
  "/man": [ 符號：/fh, 單位：/dw, 標點：/bd, 數學：/sx, 拼音：/py, 星號：/xh, 方塊：/fk, 幾何：/jh, 箭頭：/jt, 電腦：/dn, 羅馬數字：/lm, 大写羅馬數字：/lmd, 拉丁：/ld, 上標：/sb, 下標：/xb, 希臘字母：/xl, 大写希臘字母：/xld, 數字：/0到/9, 分數：/fs, いろは順：/iro, 假名：/jm或/pjm或/jmk到/jmo, 假名+圈：/jmq, 假名+半角：/jmbj, 俄語：/ey, 大写俄語：/eyd, 韓文：/hw, 韓文+圈：/hwq, 韓文+弧：/hwh, 結構：/jg, 偏旁：/pp, 康熙（部首）：/kx, 筆畫：/bh, 註音：/zy, 聲調：/sd, 漢字+圈：/hzq, 漢字+弧：/hzh, 數字+圈：/szq, 數字+弧：/szh, 數字+點：/szd, 字母+圈：/zmq, 字母+弧：/zmh, 表情：/bq, 音樂：/yy, 月份：/yf, 日期：/rq, 曜日：/yr, 時間：/sj, 天干：/tg, 地支：/dz, 干支：/gz, 節氣：/jq, 象棋：/xq, 麻將：/mj, 色子：/sz, 撲克：/pk, 八卦：/bg, 八卦名：/bgm, 六十四卦：/lssg, 六十四卦名：/lssgm, 太玄經：/txj, 天體：/tt, 星座：/xz, 星座名：/xzm, 十二宮：/seg, 蘇州碼：/szm ]⏎
```


## 东风破工具 {#东风破工具}

_plum_ 提供了一个基于配方（Recipe）的概念，使得用户可以根据需求选择安装特定的配置或功能.

```bash
curl -fsSL https://git.io/rime-install | bash
```


## Emoji 输入方案 {#emoji-输入方案}

使用东风破 rime-plum 安装 emoji

```bash
bash rime-install emoji
# 给输入方案打 patch
bash rime-install emoji:customize:schema=luna_pinyin_simp
```

-   参考
    -   [自由输入法 RIME 简明配置指南](https://sspai.com/post/84373#!)
    -   [最新版 Rime 输入法使用 (2022 更新)](https://jdhao.github.io/2019/02/18/rime_configuration_intro/)


## 快捷键 {#快捷键}

```cfg
control + ~: 切换输入方式
control + a: 在输入状态下将光标移动到开始
control + e: 在输入状态下将光标移动到结尾
control + b: 在输入状态下将光标向左移动一个单词
control + f: 在输入状态下将光标向右移动一个单词
control + h: 在输入状态下向左删除一个字符
=/.: 向下翻页
-/,: 向上翻页
shift + backspace: 在输入状态下删除一个单词
```


## 自定义词库 {#自定义词库}

我们可以通过建立自定义词典文件(如 ~/Library/Rime/.dict.yaml), 并在其中按照 文字 编码 频次(可省略) 的顺序定义单词. 示例如下:

```yaml
yaml

---
name: daoyi.dict
version: "2024.06.09"
sort: by_weight
use_preset_vocabulary: true
...

# 有码表的词库, 格式
# (注意是用制表符分割):
# 文字  编码    频次(可省略)

🆘  sos   10000
```

最后需要在 ~/Library/Rime/daoyi.dict.yaml 中增加此词典，进行部署, 我们就可以看到我们定义的 sos 了


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

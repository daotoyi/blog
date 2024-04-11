---
title: "Linux shell 自解压文件"
lastmod: "2024-02-03 12:42:37"
categories: ["Linux"]
draft: true
---

## tar {#tar}

```bash
# 准备脚本和文件（/压缩包）
cat install_script.sh <(tar -cf - my_program.tar.gz) > my_self_extracting_file
chmod +x my_self_extracting_file
./my_self_extracting_file
```


## shar {#shar}

```bash
apt-get install sharutils
shar - < file1 file2 file3 > my_archive.sh
```
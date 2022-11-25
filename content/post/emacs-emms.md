---
title: "EMMS"
date: "2022-11-25 22:37:00"
lastmod: "2022-11-25 23:09:04"
tags: ["music"]
categories: ["emacs"]
draft: false
---

## eg.1 {#eg-dot-1}

```lisp
(add-to-list 'load-path "~/.emacs.d/emms/lisp")
(require 'emms-setup)
(require 'emms-player-vlc)
(emms-standard)
(emms-default-players)
(setq emms-player-vlc-command-name
      "/Applications/VLC.app/Contents/MacOS/VLC")
```


## eg.2 {#eg-dot-2}

```lisp
(setq exec-path (append exec-path '("/usr/local/bin")))
(add-to-list 'load-path "~/.emacs.d/site-lisp/emms/lisp")
(require 'emms-setup)
(require 'emms-player-mplayer)
(emms-standard)
(emms-default-players)
(define-emms-simple-player mplayer '(file url)
     (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
        ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
        ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
     "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")
```


## eg.3 {#eg-dot-3}

```lisp
(require 'general)
(require 'pretty-hydra)
(use-package emms
  :general
  (z-spc-leader-def "e" 'z-music-hydra/body)
  (ranger-mode-map "C-c m" 'emms-play-dired)
  :config
  (require 'emms-setup)
  (emms-standard)
  (emms-history-load)
  (emms-mode-line-disable)
  :pretty-hydra
  (z-music-hydra
   (:color red :quit-key "q")
   ("Playlists"
    (("e" emms)
     ("g" emms-play-directory "open dir")
     ("v" emms-playlist-mode-go "go to current")
     ("m" emms-metaplaylist-mode-go "metaplaylist"))
    "Controls"
    (("n" emms-next "next")
     ("p" emms-previous "previous")
     ("s" emms-shuffle "shuffle"))
    ""
    (("i" emms-mode-line-toggle "song info")
     ;; ("w" emms-pause "pause")
     (define-key emms-playlist-mode-map (kbd "SPC") 'emms-pause)
     ("x" emms-stop "stop"))
    ))
  :custom
  (emms-seek-seconds 5)
  (emms-player-list '(emms-player-mpv))
  (emms-source-file-default-directory "/e:/Recreation/Music/")
  (emms-playlist-buffer-name "*Emms*")
  (emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find)
  (emms-browser-covers 'emms-browser-cache-thumbnail)
  )
```
---
title: "Bongo"
date: "2022-11-25 22:36:00"
lastmod: "2022-11-25 23:09:18"
tags: ["music"]
categories: ["emacs"]
draft: false
---

## configure {#configure}

```lisp
(use-package bongo
  :commands bongo-playlist
  :general
  (:states 'normal
   :keymaps 'bongo-playlist-mode-map
     "<return>" 'bongo-dwim
     "i" 'bongo-insert-file
     "p" 'bongo-play-previous
     "n" 'bongo-play-next
     "w" 'bongo-pause/resume
     "d" 'bongo-dired-line
     "a" 'bongo-append-enqueue
     "s" 'bongo-seek
     "r" 'bongo-rename-line
     "v" 'volume)
  :custom
  (bongo-enabled-backends '(mplayer.exe))
  (bongo-default-directory "e:/Recreation/Music/")
  (bongo-insert-album-covers t)
  (bongo-album-cover-size 100)
  (bongo-mode-line-indicator-mode nil))
```


## note {#note}


### [githut/bongo](https://github.com/dbrock/bongo) {#githut-bongo}

```md
To start Bongo, run `M-x bongo RET'.  To insert a file or a whole
directory of files, type `i'.  Then hit `RET' to play one of them.
To see a list of available commands, run `M-x describe-mode RET'.
Here are some common ones for your convenience:
 `i'         Insert a track (or a directory tree full of tracks).
  `RET'       Start playing the track at point (and then continue).
  `SPC'       Pause playback (if supported by the backend).
  `C-c C-s'   Stop playback (or start, if already stopped).
  `C-c C-n'   Start playing the next track.
  `C-c C-r'   Start playing a random track.
  `s'         Seek backward or forward (if supported by the backend).
  `l'         Move point to the current track and recenter.
  `q'         Quit Bongo (bury Bongo buffers and delete windows).

  `c'         Copy the track or section under point.
  `k'         Kill the track or section under point.
  `C-w'       Kill all tracks and sections in the region.
  `y'         Reinsert the last copied or killed stuff.
  `I u'       Insert a URI (can be used to play podcasts and radio).
  `I TAB'     List other kinds of tracks that can be inserted.

  `2 C-c C-n' Skip the next track and start playing the one after that.
  `3 C-c C-s' Stop playback after the next three tracks finish playing.
  `3 RET'     Start playing the track under point, and continue playing
              tracks, but stop after playing the third track.
  `C-u C-c C-s'
              Stop playback after each track finishes playing (this is
              good when playing movies, for example).
  `C-u C-u C-c C-s'
              Stop playback after the track at point finishes playing.
  `C-u C-c C-n'
              Play the next track after each track finishes playing
              (this undoes the effect of `C-u C-c C-s').
  `C-u C-c C-r'
              Play tracks in random order.

Here are some commands that are nice if you use library buffers:

  `h'         Switch from playlist to library (or vice versa).
  `C-u h'     Switch from playlist to library (or vice versa), leaving
              the original buffer visible in another window.
  `e'         Append the track under point or the region (if active)
              to the end of the playlist buffer.
  `3 e'       Append the track at point and the two after that to the
              end of the playlist buffer.
  `E'         Insert the track under point or the region (if active)
              into the playlist buffer, directly below the track
              that's currently playing.
  `C-x C-s'   Save the current buffer (library buffers are stored
              using the `.bongo-library' file extension).

Finally, since you've read this far, here are a few bonus commands:

  `d'         Open a Dired buffer containing the track under point.
  `r'         Rename the file corresponding to the track under point.
  `v'         Change audio volume (requires the `volume-el' package).
```


### playlist {#playlist}

-   h
    -   sitch between  playlist and libray
    -   `I` -&gt; Directory append all musics to playlist
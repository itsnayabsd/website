---
layout: post
category: linux-tools
title: Tmux
excerpt: Tmux shortcuts
google_adsense: false
---
tmux new -s sessionName
tmux a -t sessionName
tmux ls

Enter `tmux` command in terminal. And then use following shortcuts.
~~~
* Ctrl+b d - Detach session
* Ctrl+b " - split pane horizontally.
* Ctrl+b % - split pane vertically.
* Ctrl+b arrow key - switch pane.
* Hold Ctrl+b, don't release it and hold one of the arrow keys - resize pane.
* Ctrl+b c - (c)reate a new window.
* Ctrl+b n - move to the (n)ext window.
* Ctrl+b p - move to the (p)revious window.
* Ctrl+b PgUp/PgDown - Scrolling.
~~~

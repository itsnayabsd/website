---
layout: post
title: LS Colors
excerpt: Customizing colors of ls command output. It uses the configuration file ~/.dircolors.
category: linux
comments: false
google_adsense: false
---
* Create ~/.dirnames files by using following command.
```bash
dircolors -p > ~/.dircolors
```
Search for following string or similar string in .bashrc.  
`enable color support of ls and also add handy aliases`.  
Now replace the next few lines with following code.
```bash
if [ "$TERM" != "dumb" ]; then
    [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
    [ -e "$DIR_COLORS" ] || DIR_COLORS=""
    eval "`dircolors -b $DIR_COLORS`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi
```
The file `~/.dircolors` has color information for all types of files.

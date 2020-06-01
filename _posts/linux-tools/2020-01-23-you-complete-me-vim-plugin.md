---
layout: post
title: YouCompleteMe code completion engine for Vim
category: linux-tools
comments: true
google_adsense: true
excerpt: >-
  YouCompleteMe code completion engine installation instructions in
  Debian/Ubuntu, configuration, customization for languages like C/C++,
  Objective C/C++, Rust, C#, Javascript/Typescript.
keywords: >-
  YouCompleteMe Vim plugin for C, YouCompleteMe Vim plugin for JavaScript,
  YouCompleteMe Vim plugin for Ubuntu Installation, YouCompleteMe Vundle plugin
  install, Vim code completion plugin, Vim code completion javascript, Vim code
  completion C, Vim CPP code complete
date: 2020-01-22T18:49:30.000Z
image: /assets/img/youcompleteme-code-completion-engine.png
toc: true
rating: 5
---
## Introduction

**YouCompleteMe** is a code completion engine that displays code complete suggestions as you type. It supports various languages: C family languages (C/C++, Objective C/C++), Python, C#, Go, JavaScript/TypeScript, Java, Ruby etc.

Some of the useful features listed below:

* Fast identifier completion
* File and path suggestions
* Detecting common coding errors like missing semi colons, typos etc.
* Code formatting
* Display documentation for functions/methods etc..

Press <kbd>TAb</kbd> repeatedly to navigate through suggestions and <kbd>Enter</kbd> to select.

{% include image.html url="youcompleteme-code-completion-engine.png" description="YouComplete code completion for JavaScript" %}

## Installation

### Installing YouCompleteMe

YouCompleteMe can be installed with `Vundle`. Vundle is a Vim plugin manager. First install the required packages, download the Vundle and then install the plugin using Vundle.

#### Install required packages

```shell
sudo apt install build-essential cmake python3-dev git vim
```

#### Download Vundle

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

#### Add configuration to vimrc file

Add the following lines to `~/.vimrc` file

```
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugin on GitHub repo
Plugin 'ycm-core/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
```

#### Install YouCompleMe Plugin

Run the following command in terminal

```
vim +PluginInstall +qall
```

The installation might take upto a few minutes. 

### Installing language support for code completion

In this section, the instructions are given for C-family languages and TypeScript/JavaScript. For other languages, visit [this](https://github.com/ycm-core/YouCompleteMe#linux-64-bit).

#### Add support for C-family languages

Run the following commands in terminal.

```
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clangd-completer
```

{% include image.html url="youcompleteme-c-code-complete.png" description="Code compeltion for C language" %}

#### Add support for JavaScript/TypeScript

Install [Nodejs and npm](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04) and then run the following commands.

```
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --ts-completer
```

## Miscellaneous

### Disabling the preview window

Sometimes I feel annoying when a preview windlow opens displaying the documentation for the C in-built functions or methods for JS. To disable the preview window, add the following line to `~/.vimrc` file.

```
set completeopt-=preview
```

For complete documentation regarding YouCompleteMe plugin, visit the [official source](https://github.com/ycm-core/YouCompleteMe)

\------x--**Happy Coding**--x------

<!--
git submodule sync --recursive
git submodule update --init --recursive
python3 install.py --ts-completer
-->

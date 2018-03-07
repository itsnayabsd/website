---
layout: post
title: My Vim Editor Notes
excerpt: Installing and Updating VIM plugins
category: linux-tools
comments: false
google_adsense: false
---
## Installing/Updating VIM Plugins

* Create required directories
```bash
mkdir -p ~/.vim/plugin
mkdir -p ~/.vim/GetLatest
touch ~/.vim/GetLatest/GetLatestVimScripts.dat
```
* Add following content to `~/.vim/GetLatest/GetLatestVimScripts.dat` file.
```
ScriptID SourceID Filename
--------------------------
```
* Find the required plugin from the official [Vim website](https://vim.sourceforge.io/scripts/index.php).  
Get the `ScriptID` from the URL of plugin page. It looks something like this:  
[https://vim.sourceforge.io/scripts/script.php?script_id=51](https://vim.sourceforge.io/scripts/script.php?script_id=51)  
In the above URL `ScriptID` for the plugin `cscope_macros.vim` is `51`.

* Now update `GetLatestVimScripts.dat` file with above details. Put `SourceID` value to `1`. The content of the file looks like this:
```
ScriptID SourceID Filename
--------------------------
51 1 :AutoInstall: cscope_macros.vim
```
The `:AutoInstall:` tells vim to install the plugin after downloading it.

* Add the following line to `~/.vimrc` file to give permission to `Vim` to install plugins.
```
let g:GetLatestVimScripts_allowautoinstall=1
```
* Now type `:GLVS` in vim to download and install the plugin.

* Now Check that `cscope_macros.vim` file is installed in `~/.vim/plugin/` directory.

## My GetLatestVimScripts.dat File

```
ScriptID SourceID Filename
--------------------------
51 1 :AutoInstall: cscope_macros.vim
1173 1 :AutoInstall: tcomment.vim
273 1 :AutoInstall: taglist.vim
```

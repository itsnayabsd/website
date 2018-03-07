---
layout: post
title: Useful Vim or Vimdiff Commands
excerpt: Useful Vi Vim or Vimdiff Editor Commands for Faster Programming
category: linux-tools
comments: false
google_adsense: false
---
## Vim

* Setting mark in a file to jump to that position when that file opened agian.
	* Use `mx` to mark certain position in a file.  
	* Use `` `x`` to jump to that position.  

* Using registers to copy and paste
	* Use `"ay` to store selected text in buffer `a`.
	* Use `"ap` to paste stored text.  

* Tabs also can be used to edit files
```
:tabedit file.c
```
Use `gt` to move between tabs.

* Try to use `a` instead of `i`.

* User `:%s/\s\+$//` to delete trailing white spaces.

* Use upper case `ZZ` to save and exit together.

* To find total no of lines of a file within vim:
    * :w wc -l

* Move cursor to the beginning of the line and keep in command mode
	* Press <kbd>0</kbd>

* Move cursor to the end of line and keep in command mode
	* Press <kbd>$</kbd>

* Navigation around words
	* Use <kbd>e</kbd> to naviate to right direction. Cursor will be at the last character of word.
	* Use <kbd>ge</kbd> to navigate to left direction. Cursor will be at the last character of word.

* Navigation around words
	* Use <kbd>w</kbd> to naviate to right direction. Cursor will be at the first character of word.
	* Use <kbd>b</kbd> to navigate to left direction. Cursor will be at the first character of word.

* Use <kbd>H</kbd>, <kbd>M</kbd>, <kbd>L</kbd> to navigate `top`, `middle` and `bottom` of viewport.
 
* To delete word from cursor position to beginning of the line
	* Press <kbd>d</kbd> + <kbd>b</kbd>.

* Pressing upper case <kbd>J</kbd>, concatenates current line and next line.

* For `redo`, user <kbd>Ctrl</kbd> + <kbd>R</kbd>

* To repeat last change, use **<kbd>.</kbd>**.

* To delete a whole word, use `daw`. `delete` `A word`.

* Accessing `system clipboard` in Vim.
Install necessary packages
```bash
$ sudo apt install libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev
```
Configure again from the source
```bash
$ make distclean
$ ./configure --with-features=huge
$ make && sudo make install
```
Check `+clipboard` available in the following command output.
```bash
$ vim --version | grep clipboard
```
Now we can use `"+y` to copy selected text to clipboard

* To unfold all lines in a file, press `zR`. To fold selected text, press `zf`. To unfold press `zs`.

* To resize split window <kbd>Ctrl</kbd>-<kbd>w</kbd> and then <kbd><</kbd> or <kbd>></kbd>.
For moving 5 columns width to left, use <kbd>Ctrl</kbd>-<kbd>w</kbd> and then <kbd>5<</kbd>.
Or `set mouse=a` to resize using mouse.


---
title : Usage of Wildcards
layout : linux-cli-post
category : linux-cli
date : 2020-11-25 14:35:17 +5:30
comments : true
google_adsense: true
excerpt : Usage of wildcards and wildcards patterns in Linux shell explained with examples. 
keywords : Linux shell wildcards, wildcard patters, wildcards in Linux shell, Linux shell wildcards examples, Linxu shell wildcard asterisk (*), Linux shell wildcard braces ({}), Linux shell wildcard brackets ([]), Linux shell wildcard not (!), Linux shell wildcards [[:alnum:]], [[:alpha:]], [[:digit:]], [[:lower:]], [[:upper:]]
image : /assets/img/linux-cli-wildcards.png
toc : true
---
## Introduction
Shell has a fantastic feature called *Wildcards*, which makes bash operations more powerful when used with commands. Wildcards can be used with any commands that takes files and directories as their arguments. Such as cp, mv, rm, mkdir etc.

{% include image.html url="linux-cli-wildcards.png" description="Linux shell wildcards" %}

## Wildcards

| Wildcard    | Command Applies on Files and Directories                     |
| ----------- | ------------------------------------------------------------ |
| {}          | With Specified Range                                         |
| ?           | Matching a Single Character                                  |
| *           | All                                                          |
| []          | Matching Any Character in a Set of Characters                |
| [!]         | Matching Any Character That is Not Part of Set of Characters |
| [[:alnum:]] | Matching Any Alphanumeric Character                          |
| [[:alpha:]] | Matching Any Alphabetic Character                            |
| [[:digit:]] | Matching Any Numeric Character                               |
| [[:lower:]] | Matching Any Lowercase Letter                                |
| [[:upper:]] | Matching any Uppercase Letter                                |

We are using a simple command called *echo* to explore wildcards functionality. This command just displays text. It doesn't alter any files and folders. So it is good to check wildcard functionality with echo command before proceeding.

## Examples
### Example 1
```bash
me@linux ~ $ echo sample text
sample text
```
*sample text* is not the command. So it is displayed as it is. Mistyping of wildcards also displayed as it is.

```bash
me@linux ~ $ echo 2014-{01,02,03}
2014-01 2014-02 2014-03
```
### Example 2
The ***{}*** wildcard expands *2014-{01,02,03}* into *2014-01 2014-02 2014-03*. Lets use this with mkdir command.

```bash
me@linux ~ $ mkdir album
me@linux ~ $ cd album
me@linux ~/album $ mkdir 2014-{01,02,03}
me@linux ~/album $ ls
2014-01  2014-02  2014-03
```
```bash
me@linux ~/album $ mkdir 2014-{04..12}
me@linux ~/album $ ls
2014-01  2014-03  2014-05  2014-07  2014-09  2014-11
2014-02  2014-04  2014-06  2014-08  2014-10  2014-12
```
Above command creates directories with given range. Here is one more command.

```bash
me@linux ~/album $ echo a{b{c,d},e{f,g}}h
abch abdh aefh aegh
```
### Example 3
```bash
me@linux ~/album $ cd ~
me@linux ~ $ echo *
album Desktop Documents Downloads Music Pictures Public Templates Videos
```
Wildcard <strong>*</strong> is expanded into all files and directories in current working directory.

### Example 4
To show hidden files in current working directory:

```bash
me@linux ~ $ echo .*
. .. .adobe .bash_history .bash_logout .cache .cinnamon .config
 .dbus .dmrc .gconf .gksu.lock .gnome2 .gnome2_private .ICEauthority
 .linuxmint .local .macromedia .mozilla .profile .thunderbird
 .Xauthority .xsession-errors
```
### Example 5
For files and folders start with a particular character - 

```bash
me@linux ~ $ echo D*
Desktop Documents Downloads
```
Above command shows files and directories starts with letter D.

To show files and directories ends with particular character:

```bash
me@linux ~ $ echo *s
Documents Downloads Pictures Templates Videos
```
### Example 6
```bash
me@linux ~ $ echo /usr/*/share
/usr/local/share
```
Above command shows directory list in /usr directory which has another directory called share.

### Example 7

```bash
me@linux ~ $ echo /u??
/usr
```
Above command shows files and directories with exactly three letters length that starts with the letter u in root directory.

### Example 8

```bash
me@linux ~ $ echo /???
/bin /dev /etc /lib /mnt /opt /run /srv /sys /tmp /usr /var
```
Above command searches for files and directories with exactly three letters length in root directory

### Example 9

```bash
me@linux ~ $ echo [DV]*
Desktop Documents Downloads Videos
```
This command displays all files and directories that starts with either D or V.
### Example 10

```bash
me@linux ~ $ echo [[:upper:]]*
Desktop Documents Downloads Music Pictures Public Templates Videos
```
This command displays all files and folders that starts with Uppercase letters.

### Few more patters

Here are some more patterns:

* d*.txt - Operation occurs on any text file that begins with d character
* [![:digit:]]* - Operation occurs on any file not beginning with numeral.
* *[[:lower:][:digit:]] - Operation occurs on any file that ending with either lowercase letter or numeral


---
title : Command Line Options and Arguments Briefly
layout : linux-cli-post
category : linux-cli
date : 2020-11-22 21:13:11 +5:30
comments : true
google_adsense: true
excerpt : Usage of Linux commands options and arguments explained with examples.
keywords : Linux commands, Linux commands options, Linux commands arguments with examples
image : /assets/img/linux-cli-options.png
toc : true
---
## Introduction

Commands are generally followed by one or more options, followed by arguments. Options describes the command behaviour and arguments are generally files and folders. Every command associates with its own options. The general format for commands looks like this.

```bash
$ command options arguments
```

## Linux commands options and arguments examples

{% include image.html url="linux-cli-options.png" description="Linux Command Line Options and Arguments" %}

Let us consider the ***ls*** command. Most commonly used options that comes with *ls* command are

|Option|Description|
|------|-----------|
|-a or --all	| Lists all files and directories including hidden.|
|-l | Display result in detailed/long format.|
| -h or --human-readable | Display file sizes in human readable format rather than in bytes.|
|-S (Capital Letter)| Sort results by file size.|
|-t | Sort results by modification date.|
|-r or --reverse| Sort results in reverse order.|

Now Let's use those options. Don't forget that default working directory is your home directory when you open the terminal. When using ls command, it shows files and folders of current working directory.

```bash
me@linux ~ $ ls
Desktop    Downloads  Pictures  Templates
Documents  Music      Public    Videos
```
### ls with -a option

Using ls command with *-a* option shows following result. It is same for both *-a* and *--all*. *--all* is called long option of *-a*.
```bash
me@linux ~ $ ls -a
.             .config      .gconf           .mozilla     Videos
..            .dbus        .gnome2           Music       .Xauthority
.bash_history  Desktop     .gnome2_private   Pictures    .xsession-errors
.bash_logout  .dmrc        .ICEauthority    .profile
.cache         Documents   .linux            Public
.cinnamon      Downloads   .local            Templates
```
Files or directories that starts with period *(.)* are hidden. You can't see these through file manager. Take another example for which we list the contents in /usr directory.

```bash
me@linux ~ $ ls -a /usr
.  ..  bin  games  include  lib  local  sbin  share  src
```
Multiple arguments can be used with options like the command *ls -a ~ /usr*. Here arguments are home directory *~* and */usr* directory.

### ls with -l option

Let's get to another option ***-l***. Using -l with ls command shows long description of listing.

```bash
me@linux ~ $ ls -l /usr
total 120
drwxr-xr-x   2 root root 49152 Apr 11 22:56 bin
drwxr-xr-x   2 root root  4096 Nov 27 03:15 games
drwxr-xr-x  19 root root  4096 Apr  8 09:52 include
drwxr-xr-x 178 root root 32768 Apr  8 10:41 lib
drwxr-xr-x  10 root root  4096 Nov 27 02:59 local
drwxr-xr-x   2 root root 12288 Apr  8 09:53 sbin
drwxr-xr-x 293 root root 12288 Apr  8 21:10 share
drwxr-xr-x   5 root root  4096 Nov 27 03:15 src
```
Long format has nine fields. The first field/column *drwxr-xr-x* is the indication of file permissions by different users. First character (d) indicates file type (d means directory). Next three characters indicate file permissions for owner. Next three characters are access rights for group users and the last three characters for other users permissions existed on your computer. *rwx* stands for read, write and execute. About file permissions comes in later chapters.

The second field/column (2) indicates no. of hard links that file/folder consists of. The concept of hard links comes later.

The third field/column (root) is file owners name.

The fourth field (root) is group name to which this file associates.

The fifth field indicates (49152 bytes) size of file/folder.

Next three fields indicates modified time for file/directory.

Last column is file/directory name.

### ls with -h option
The third option is ***-h*** or ***--human-readable***. It is often used in conjunction with other options. Using it with -l option gives result in human readable format.

```bash
me@linux ~ $ ls -lh /usr
total 120K
drwxr-xr-x   2 root root  48K Apr 11 22:56 bin
drwxr-xr-x   2 root root 4.0K Nov 27 03:15 games
drwxr-xr-x  19 root root 4.0K Apr  8 09:52 include
drwxr-xr-x 178 root root  32K Apr  8 10:41 lib
drwxr-xr-x  10 root root 4.0K Nov 27 02:59 local
drwxr-xr-x   2 root root  12K Apr  8 09:53 sbin
drwxr-xr-x 293 root root  12K Apr  8 21:10 share
drwxr-xr-x   5 root root 4.0K Nov 27 03:15 src
```
Notice that the fifth field is expressed in Kilo Bytes rather than in bytes.

### ls with -S option
The next option ***-S*** sorts result by size. Let's use this command in conjunction with *-lh* for better understand.

```bash
me@linux ~ $ ls -lhS /usr
total 120K
drwxr-xr-x   2 root root  48K Apr 11 22:56 bin
drwxr-xr-x 178 root root  32K Apr  8 10:41 lib
drwxr-xr-x   2 root root  12K Apr  8 09:53 sbin
drwxr-xr-x 293 root root  12K Apr  8 21:10 share
drwxr-xr-x   2 root root 4.0K Nov 27 03:15 games
drwxr-xr-x  19 root root 4.0K Apr  8 09:52 include
drwxr-xr-x  10 root root 4.0K Nov 27 02:59 local
drwxr-xr-x   5 root root 4.0K Nov 27 03:15 src
```
Notice that files/folders are sorted by size.

### ls with -t option
The ***-t*** option is used to show result by modification date.

```bash
me@linux ~ $ ls -lht /usr
total 120K
drwxr-xr-x   2 root root  48K Apr 11 22:56 bin
drwxr-xr-x 293 root root  12K Apr  8 21:10 share
drwxr-xr-x 178 root root  32K Apr  8 10:41 lib
drwxr-xr-x   2 root root  12K Apr  8 09:53 sbin
drwxr-xr-x  19 root root 4.0K Apr  8 09:52 include
drwxr-xr-x   5 root root 4.0K Nov 27 03:15 src
drwxr-xr-x   2 root root 4.0K Nov 27 03:15 games
drwxr-xr-x  10 root root 4.0K Nov 27 02:59 local
```
To show result in reverse order -r or --reverse option is used. Here -r is used in conjunction with the above command. The result must be in reverse order.

```bash
me@linux ~ $ ls -lhtr /usr
total 120K
drwxr-xr-x  10 root root 4.0K Nov 27 02:59 local
drwxr-xr-x   2 root root 4.0K Nov 27 03:15 games
drwxr-xr-x   5 root root 4.0K Nov 27 03:15 src
drwxr-xr-x  19 root root 4.0K Apr  8 09:52 include
drwxr-xr-x   2 root root  12K Apr  8 09:53 sbin
drwxr-xr-x 178 root root  32K Apr  8 10:41 lib
drwxr-xr-x 293 root root  12K Apr  8 21:10 share
drwxr-xr-x   2 root root  48K Apr 11 22:56 bin
```
To know full list of options available, there is one command called man. Using man with respective command displays all available options and their usage. The command man is short for manual. Linux comes pre-installed with necessary manual and can be accessed by man command.

```bash
me@linux ~ $ man ls
```

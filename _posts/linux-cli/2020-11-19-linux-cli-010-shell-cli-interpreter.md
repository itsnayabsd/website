---
title : Shell - A Command Line Interpreter
layout : linux-cli-post
category : linux-cli
date : 2020-11-20 00:15:44 +5:30
comments : true
google_adsense: true
excerpt : Simple Linux commands to get used to shell - command line interpreter explained with examples.
keywords : Linux commands, Linux shell, Linux command line, date Linux command, clear Linux command, cal Linux command, df Linux command, free Linux command, lscpu Linux command, exit Linux command.
image : /assets/img/linux-cli-shell.png
toc : true
---
## Introduction
*Command Line* or *Shell* or *bash* refers to the same. Bash stands for 'Bourne Again Shell'. Shell is an intermediate program which translates and transmits the keyboard commands to the operating system so that it can understand.

Open terminal emulator to access shell program. To open Terminal emulator, press `Alt`+`F2`. In the field shown, type the command *gnome-terminal* if you are using GNOME desktop environment or type *konsole* if you are using KDE desktop environment and then press Enter. Something like the following appears in the emulator window.

```bash
me@linux ~ $
```
This is called shell prompt. Whenever it appears, the shell is ready to take commands. Here *me* is the username of computer user and *linux* is the computer name. Together *me@linux*. Format may be little bit different for some linux distributions. If you see '#' instead of '$' as last character in command prompt, then the user has root or super user privileges. In some Linux distributions root account locked by default.

Let's enter some simple commands to get used to shell.

{% include image.html url="linux-cli-shell.png" description="Shell - CLI Interpreter" %}
## Simple Linux Commands
**date** - Displays current day, date and time. Enter the command date and press Enter. Following result will display on command line.

```bash
me@linux ~ $ date
Tue Sep 30 11:42:04 EDT 2014
```
**clear** - clears the terminal window. Type clear in terminal window and press Enter.

```bash
me@linux ~ $ clear
```
**cal** - Displays calender. Enter the cal command in terminal and press Enter.

```bash
me@linux ~ $ cal
   September 2014     
Su Mo Tu We Th Fr Sa  
    1  2  3  4  5  6  
 7  8  9 10 11 12 13  
14 15 16 17 18 19 20  
21 22 23 24 25 26 27  
28 29 30
```
**df** - Displays amount of free space (in KB) on your disk drives. In the following information /dev/sda5 is the disk drive and out of 16492404 kilo bytes (~15.72 GB), 10034044 kilo bytes (~9.56 GB) are used. Total 65% of space is consumed.

```bash
me@linux ~ $ df
Filesystem     1K-blocks     Used Available Use% Mounted on
/dev/sda5       16492404 10034044   5597536  65% /
none                   4        0         4   0% /sys/fs/cgroup
udev             1274356        4   1274352   1% /dev
tmpfs             257452     1164    256288   1% /run
none                5120        0      5120   0% /run/lock
none             1287252      676   1286576   1% /run/shm
none              102400       16    102384   1% /run/user
```
**free** - Displays free memory (RAM in KB). Out of 2 and a half GB of RAM, 470MB is used in the following.

```bash
me@linux ~ $ free
             total       used       free     shared    buffers     cached
Mem:       2574508     482048    2092460          0      54944     269392
-/+ buffers/cache:     157712    2416796
Swap:      2610172          0    2610172
```
**lscpu** - Displays CPU/Hardware information. Below shows a system with Intel i686 32 bit dual core (2 CPUs) processor.

```bash
me@linux ~ $ lscpu
Architecture:          i686
CPU op-mode(s):        32-bit
Byte Order:            Little Endian
CPU(s):                2
On-line CPU(s) list:   0,1
Thread(s) per core:    1
Core(s) per socket:    2
Socket(s):             1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 14
Stepping:              8
CPU MHz:               1000.000
BogoMIPS:              3325.23
L1d cache:             32K
L1i cache:             32K
L2 cache:              2048K
```
**exit** - Exits the terminal emulator.

```bash
me@linux ~ $ exit
```

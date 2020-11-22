---
title : Navigation around directories
layout : linux-cli-post
category : linux-cli
date : 2020-11-20 23:31:44 +5:30
comments : true
google_adsense: true
excerpt : Linux commands to navigate around filesystem directories explained with examples.
keywords : Linux pwd command, Linux ls command, Linux cd command, Linux navigation commands
image : /assets/img/linux-cli-navigation.png
toc : true
---
## Introduction

Directories/Folders in a Linux based OS are organized in hierarchical (tree) manner.

The first directory in the file system is known as root directory. Root privileges are required to create, modify or even delete data in this directory.

{% include image.html url="linux-fs-hierarchy.png" description="Linux Filesystem Hierarchy" %}

Home directory is where you can do all the things. User can copy, create, modify or even delete data in this directory.

## Navigation commands

Here are the three commands to navigate directories through command line.

 * pwd - Prints Current Working Directory Location.
 * ls - List Contents of Directories.
 * cd - Change Directory.

{% include image.html url="linux-cli-navigation.png" description="Linux Navigation Commands" %}

Open Terminal emulator. Enter first command ***pwd*** and press Enter. It looks like this.

```bash
me@linux:~$ pwd
/home/me
```
The second command ***ls*** lists the contents of present working directory. Let's try this in a Terminal. It looks like this.

```bash
me@linux:~$ ls
Desktop    Downloads  Pictures  Templates
Documents  Music      Public    Videos
```
*ls* can be used with multiple arguments i.e we can find the contents of more than one directories using ls command. Let's try with home directory *(~)* and */usr* directory. *~* is the simplified form of */home/me*

```bash
me@linux:~$ ls /usr ~
/home/me:
Desktop    Downloads  Pictures  Templates
Documents  Music      Public    Videos
/usr:
bin  games  include  lib  local  sbin  share  src
```
The third command ***cd*** is used to change the present working directory. Let's change our present working directory from home (~) to one of the directories it consists of (Let's say Documents). Press Enter after typing *cd Documents*. Check the directory with *pwd* command. Directory or file names are case sensitive. *Documents* and *documents* are not the same.

```bash
me@linux:~$ cd Documents
me@linux:~/Documents$ pwd
/home/me/Documents
```
To change current working directory to its parent directory, type *cd ..* and press Enter.

```bash
me@linux:~/Documents$ cd ..
me@linux:~$ pwd
/home/me
```
To change current working directory to previously used directory, type *cd -* and press Enter.

```bash
me@linux:~$ cd -
/home/me/Documents
me@linux:~/Documents$
```
Another example. This time we will change our working directory to root directory. And then we check its location with pwd. And then we check contents of root directory with ls. The location of root directory is simply ***/***.

```bash
me@linux:~$ cd /
me@linux:/$ pwd
/
me@linux:/$ ls
bin   etc         lib         mnt   root  selinux  tmp  vmlinuz
boot  home        lost+found  opt   run   srv      usr
dev   initrd.img  media       proc  sbin  sys      var
```
Let's take another example. Now we change our working directory to the directory */usr/bin*. This means from root directory (/) there is a directory called *usr*, which contains directory *bin*. This can be done in three ways.

Through the absolute path (full path)

```bash
me@linux:~/$ cd /usr/bin
me@linux:/usr/bin$ pwd
/usr/bin
```
Or
```bash
me@linux:~$ cd /usr
me@linux:/usr$ cd bin
me@linux:/usr/bin$ pwd
/usr/bin
```
Or a relative path name
```bash
me@linux:~$ cd /usr
me@linux:/usr$ cd ./bin
me@linux:/usr/bin$ pwd
/usr/bin
```
Dot (**.**) represents present working directory and dot dot (**..**) represents parent working directory. Now, Let's get back to home directory.

```bash
me@linux:/usr/bin$ cd ~
me@linux:~$ pwd
/home/me
```
To change the working directory to the home directory of another user, try this.

```bash
me@linux:~$ cd ~otherusername
me@linux:/home/otherusername$ pwd
/home/otherusername
```
Here *otherusername* is user name of another user in the computer.

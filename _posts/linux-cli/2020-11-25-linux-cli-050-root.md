---
title : Accessing Root Privileges
layout : linux-cli-post
category : linux-cli
date : 2020-11-25 12:18:26 +5:30
comments : true
google_adsense: true
excerpt : This tutorial explains how to access the administrative or root privileges in the Linux based system along withe examples.
keywords : Linux root privileges, Linux administrative privileges, Linux sudo command examples, Linux su command examples, login as root, root directory, root account
image : /assets/img/linux-cli-root.png
toc : true
---
## Introduction
***root directory*** - First directory in the file system. The location of the root directory is simply represented by ***/***.

***root account*** - Account with super user or administrative privileges.

Super user/Root privileges can be accessed in two ways.

* By using *su* command or
* By using *sudo* command.

{% include image.html url="linux-cli-root.png" description="Accessing root privileges" %}
## su command

*su* command is generally used to access other user's account. Assume *you* is another user's login/user name, then *su - you* loads you's shell environment.

### Example 1
```bash
me@linux ~ $ su - you
Password:
you@linux ~ $
```
Notice that `me@linux` is changed to `you@linux`. When it asks for password, enter you account's password. Password is invisible. Just enter.

### Example 2
To access super user privileges, enter `su -` with no username.

```bash
me@linux ~ $ su -
Password:
linux ~ # 
```
This time enter me's account (first useraccount created on system) password when prompted.

### Few more examples

#### Changing directory to root directory:

```bash
linux ~ # cd /
linux / # ls
bin    dev   initrd.img      lost+found  opt   run   sys  var
boot   etc   initrd.img.old  media       proc  sbin  tmp  vmlinuz
cdrom  home  lib             mnt         root  srv   usr
```
#### Making directories

```bash
linux / # mkdir dir1 dir2
linux / # ls
bin    dev   etc         initrd.img.old  media  proc  sbin  tmp  vmlinuz
boot   dir1  home        lib             mnt    root  srv   usr
cdrom  dir2  initrd.img  lost+found      opt    run   sys   var
```
#### Copying files

```bash
linux / # cp etc/hosts dir1
linux / # ls dir1
hosts
```
#### Moving files

```bash
linux / # mv dir1/hosts dir2
linux / # ls dir2
hosts
```
#### Removing/Deleting directories

```bash
linux / # rm -r dir1 dir2
linux / # ls
```
#### Exiting from super user account

```bash
linux / # exit
logout
me@linux ~ $
```
## sudo command

Use *sudo* along with the command that required super user privileges. When prompted for the password, enter it.

### Creating directories

First change current working directory to root (/) directory using cd command. To create directories dir3 and dir4 in root directory use sudo mkdir dir3 dir4.

```bash
me@linux ~ $ cd /
me@linux / $ sudo mkdir dir3 dir4
[sudo] password for me:
me@linux / $ ls
bin    dev   etc         initrd.img.old  media  proc  sbin  tmp  vmlinuz
boot   dir3  home        lib             mnt    root  srv   usr
cdrom  dir4  initrd.img  lost+found      opt    run   sys   var
```
### Copying files

```bash
me@linux / $ sudo cp etc/hosts dir3
me@linux / $ ls dir3
hosts
```
### Moving files

```bash
me@linux / $ sudo mv dir3/hosts dir4
me@linux / $ ls dir4
hosts
```
### Deleting directories

```bash
me@linux / $ sudo rm -r dir3 dir4
me@linux / $ ls
bin    dev   initrd.img      lost+found  opt   run   sys  var
boot   etc   initrd.img.old  media       proc  sbin  tmp  vmlinuz
cdrom  home  lib             mnt         root  srv   usr
```

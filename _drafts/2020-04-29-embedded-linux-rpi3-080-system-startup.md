---
title : System configuration and startup for Raspberry Pi 3 Model B
layout : post
category : rpi3b-elinux
date : 2020-04-29 22:15:28 +5:30
comments : true
google_adsense: true
excerpt : 
keywords : 
image : /assets/img/rpi3b-elinux-toolchain.png
toc : true
---
## Introduction
In the [earlier articles](/book/embedded-linux-rpi3-000-intro.html#learning-path), we cross-compiled the basic software packages, successfully boot the Raspberry Pi 3B over the network and able to execute some basic commands.

In this article we will find out how to mount virtual filesystems and add/modify/delete the init scripts.

## Mounting virtual filesystems
If you try to execute the commands like `ps` or any other process related command, you will encounter an error saying,
```
write error here
```
It's because the `proc` virtual file system is not mounted. Similarly there is a `sysfs` virtual filesystem which exposes hardware and device driver information from kernel space to user space.

Let's create mount points before mounting those virtual filesystems. Crate *proc*, *sys* directories in the busybox filesystem using the following command.
```bash
mkdir -p ~/rpi3/nfs/{proc,sys}
```
Now we can mount these virtual filesystems using the following commands.
```bash
mount -t proc nodev /proc
mount -t sysfs nodev /sys
```
Now try to execute the command `ps`. It should work.

The above process of mounting can be automated every time the board boots by using the *init* scripts. Let's see the next section about */etc/inittab*.

## The init scripts
When Linux boots the filesystem, the first program it executes is the */sbin/init*. And the configuration file for that program is the */etc/inittab*. Let's create that by running the following command.
```bash
mkdir -p ~/rpi3/nfs/etc
```

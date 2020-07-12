---
title : System configuration and startup for Raspberry Pi 3 Model B
layout : rpi3b-elinux-post
category : rpi3b-elinux
date : 2020-05-02 18:59:28 +5:30
comments : true
google_adsense: true
excerpt : Creating and editing the configuration file for the first user space program, /sbin/int, executed by Linux kernel. Add or modify the init scirpts to be executed at the system startup for Raspberry Pi 3B.
keywords : The init scripts for Raspberry Pi 3B, /etc/inittab for Raspberry Pi 3 Model B, init Raspberry Pi 3, Raspberry Pi init scripts, Raspberry Pi 3 inittab, Raspberry Pi init.d, Raspberry Pi initial start up, Raspberry Pi initial setup, Raspberry Pi 3 initial config
image : /assets/img/rpi3b-elinux-system-init.png
toc : true
---
## Introduction
In the [earlier articles](/book/embedded-linux-rpi3-000-intro.html#learning-path), we cross-compiled the basic software packages, successfully boot the Raspberry Pi 3B over the network and able to execute some basic commands.

In this article we will find out how to mount virtual filesystems and add/modify/delete the init scripts.

{% include image.html url="rpi3b-elinux-system-init.png" description="System configuration and init script for Raspberry Pi 3B" %}
## Mounting virtual filesystems
If you try to execute the commands like `ps` or any other process related command, you will encounter an error saying,
```
PID	USER	TIME	COMMAND
ps: can't open '/proc': No such file or directory
```
It's because the `proc` virtual file system is not mounted. Similarly there is a `sysfs` virtual filesystem which exposes hardware and device driver information from kernel space to user space.

Let's create mount points in the root filesystem before mounting those virtual filesystems. Create *proc*, *sys* directories in the busybox filesystem using the following command.
```bash
mkdir -p ~/rpi3/nfs/{proc,sys}
```
Now power up the board and mount these virtual filesystems using the following commands.
```bash
mount -t proc nodev /proc
mount -t sysfs nodev /sys
```
Run the `ps` command. It should work fine now.

The above process of mounting can be automated every time the board boots by using the *init* scripts. Let's see the next section about */etc/inittab*.

## The init program
When Linux boots the filesystem, the first program it executes is the */sbin/init*. This *Busybox init* program checks, if present, the configuration file */etc/inittab* for the system configuration and init scripts. If the configuration file is not found, the default configuration will be applied.
### The configuration file for init program
For more information about *inittab* configuration file, please read *~/rpi3/busybox/examples/inittab* after [busybox compilation](/rpi3b-elinux/embedded-linux-rpi3-060-busybox.html) tutorial.

Let's create */etc/inittab* file with the following configuration.
```bash
mkdir -p ~/rpi3/nfs/etc
```
```bash
cat << EOF >> ~/rpi3/nfs/etc/inittab
::sysinit:/etc/init.d/rcS
tty1::askfirst:/bin/sh
::ctrlaltdel:/sbin/reboot
::shutdown:/sbin/swapoff -a
::shutdown:/bin/umount -a -r
::restart:/sbin/init
tty2::askfirst:/bin/sh
tty3::askfirst:/bin/sh
tty4::askfirst:/bin/sh
EOF
```
### The init scripts
The first line int the *inittab* file, *::sysinit:/etc/init.d/rcS* tells the init program to execute */etc/init.d/rcS* script.

We can add our *proc* and *sysfs* mounting commands in this file. Every time the board boots up, the *proc* and *sysfs* filesystems will be mounted automatically by the */etc/init.d/rcS* script.
```bash
mkdir -p ~/rpi3/nfs/etc/init.d/
```
```bash
cat << EOF >> ~/rpi3/nfs/etc/init.d/rcS
#!/bin/sh

mount -t proc nodev /proc
mount -t sysfs nodev /sys
LD_LIBRARY_PATH=/lib:/$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
EOF
```
Make the file executable by running following command
```bash
chmod +x ~/rpi3/nfs/etc/init.d/rcS
```

Now let's boot the raspberry pi and see if we were able to see any output for the following commands -
 
```bash
ps
pidof init
ls /sys
# and
ls /proc
```

We can call as many scripts as possible by including those scripts path in the */etc/init.d/rcS* script.

In the next article, we will compile a sample binary for Raspberry Pi on host system and try to execute it on the target.

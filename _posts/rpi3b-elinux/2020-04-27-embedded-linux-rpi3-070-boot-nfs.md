---
title : Network boot your Raspberry Pi 3B
layout : post
category : rpi3b-elinux
date : 2020-04-27 21:15:28 +5:30
comments : true
google_adsense: true
excerpt : Let's make the Raspberry Pi 3B boot all essential software over network including Linux kernel, device tree binary, filesystem. Ubuntu system acts as server to host all these software.
keywords : network boot raspberry pi 3b, boot rapberryp pi 3b over ethernet, Raspberry Pi network boot Ubuntu, RPI network boot
image : /assets/img/rpi3b-elinux-network-boot.png
toc : true
---
## Introduction
In the [earlier articles](/book/embedded-linux-rpi3-000-intro.html#learning-path), we have seen how to cross compile Linux kernel, load it from the tftp server and how to generate the root filesystem using busybox.

In this article, we will make Linux kernel boots that root filesystem over network. The root filesystem which we generated through busybox on a development system can be accessed by Raspberry Pi 3B through the network using NFS.

The reason behind booting the Raspberry Pi 3B over NFS is to eliminate the process of copying the modified files or kernel to the SD card for every single change we made.

{% include image.html url="rpi3b-elinux-network-boot.png" description="Network boot your Raspberry Pi 3B" %}
<!--
### Install kernel modules to NFS directory.

Go to kenel source and install kernel modules to the NFS directory using the following command.
```
make INSTALL_MOD_PATH=<NFS_directory> modules_install
``
ex: make INSTALL_MOD_PATH=/home/nayab/rpi/fs/nfs/ modules_install
-->
## Setting NFS server on host system
Install the `nfs-kernel-server` package on you Ubuntu development system by running following command.
```bash
sudo apt install nfs-kernel-server
```
Once installation is completed, add the following line to `/etc/exports` file.
```bash
<path_to_busybox_install_directory> <ip_address_of_board>(rw,no_root_squash,no_subtree_check)
```
If you follow the [root filesystem generation using busybox](/rpi3b-elinux/embedded-linux-rpi3-060-busybox.html), we have installed the root filesystem in the path `~/rpi3/nfs`. Replace `<path_to_busybox_install_directory>` with the *absolute path* of the root filesystem and replace `<ip_address_of_board>` with the IP address of the Raspberry Pi 3B which we set during [tftp communication establishment](/rpi3b-elinux/embedded-linux-rpi3-040-tftp-comm.html). An example is given below.

`/home/nayab/rpi3/nfs 192.168.1.115(rw,no_root_squash,no_subtree_check)`

## Restart the NFS server
Run the following command to restart NFS server on your host system.
```bash
sudo service nfs-kernel-server restart
```
## Set bootargs env in the board U-boot console
Power up the board, stop in U-boot console and set the `bootargs` env using following command. The bootargs value is what will be passed as command line arguments to Linux kernel while booting.
<!--
**Note** : You may need to change the device tree from `bcm2710-rpi-3-b.dtb` to `bcm2837-rpi-3-b.dtb` in the config.txt file to stop in the U-boot console.
setenv bootargs # Reset bootargs
setenv bootargs root=/dev/nfs console=ttyAMA0,115200 console=tty1 ip=<board_ip>:::::eth0 nfsroot=<host_ip>:<path_to_busybox_on_host>,nfsvers=3 rw
-->
```bash
setenv bootargs # Reset bootargs
setenv bootargs root=/dev/nfs ip=<board_ip>:::::eth0 nfsroot=<host_ip>:<path_to_busybox_on_host>,nfsvers=3 rw
saveenv
```
An example is given below -
```
setenv bootargs # Reset bootargs
setenv bootargs root=/dev/nfs ip=192.168.1.115:::::eth0 nfsroot=192.168.1.15:/home/nayab/rpi3/nfs,nfsvers=3 rw
saveenv
```
<!--
**Note** : Don't forget to revert back device tree.
-->
## Booting the RPI through NFS
Make sure the Raspberry Pi is connected through Ethernet to the system in which the `nfs-kernel-server` is running.

Power on the board or run `reset` command in the U-boot console. The board must be downloading Linux kernel and dtb file from tftp server and then Linux kernel should boot the root filesystem over NFS.

If you see the following logs flooding your screen, create a `dev` directory in the NFS path. Run `mkdir -p ~/rpi3/nfs/dev` command and reboot your board.
```
can't open /dev/tty2: No such file or directory
can't open /dev/tty3: No such file or directory
can't open /dev/tty4: No such file or directory
can't open /dev/tty2: No such file or directory
can't open /dev/tty3: No such file or directory
can't open /dev/tty4: No such file or directory
can't open /dev/tty2: No such file or directory
can't open /dev/tty3: No such file or directory
can't open /dev/tty4: No such file or directory
.
.
.
```

At this stage, you should be able to execute commands like `ls`, `mkdir` etc..

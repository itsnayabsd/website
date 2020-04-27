---
title : Network boot your Raspberry Pi 3B
layout : post
category : rpi3b-elinux
date : 2020-04-27 21:15:28 +5:30
comments : true
google_adsense: true
excerpt : 
keywords : 
image : /assets/img/rpi3b-elinux-toolchain.png
toc : true
---
## Introduction
In the [earlier articles](/book/embedded-linux-rpi3-000-intro.html#learning-path), we have seen how to cross compile Linux kernel, load it from the tftp server and how to generate the root filesystem using busybox.

In this article, we will make Linux kernel boots that root filesystem over network. The root filesystem which we generated through busybox on a development system can be accessed by Raspberry Pi 3B through the network using NFS.

The reason behind booting the Raspberry Pi 3B over NFS is to eliminate the process of copying the modified files or kernel to the SD card for every single change we made.

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
## Set bootargs env in the baord U-boot console
**Note** : You may need to change the device tree from `bcm2710-rpi-3-b.dtb` to `bcm2837-rpi-3-b.dtb` in the config.txt file to stop in the U-boot console.

Set the `bootargs` env using following command
```
setenv bootargs # Reset bootargs
setenv bootargs root=/dev/nfs console=ttyAMA0,115200 console=tty1 ip=<board_ip>:::::eth0 nfsroot=<host_ip>:<path_to_busybox_on_host>,nfsvers=3 rw
```
ex: `setenv bootargs root=/dev/nfs console=ttyAMA0,115200 console=tty1 ip=192.168.1.115:::::eth0 nfsroot=192.168.1.15:/home/nayab/rpi/fs/nfs,nfsvers=3 rw`
```
saveenv
```
**Note** : Don't forget to revert back device tree.
## Booting the RPI through NFS

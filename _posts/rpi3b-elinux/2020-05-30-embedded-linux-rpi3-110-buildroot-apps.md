---
title : Install the apps using Buildroot for Raspberry Pi 3 Model B
layout : rpi3b-elinux-post
category : rpi3b-elinux
date: 2020-05-31 12:28:56 +5:30
comments : true
google_adsense: true
excerpt : In this tutorial, we generate ext4 root filesystem from the Buildroot build system, install the additional programs required, write the filesystem to SD card and boot the board using this root filesystem.
keywords : Raspberry pi buildroot, buildroot root filesystem, buildroot Raspberry Pi 3b, buildroot custom toolchain, buildroot external toolchain.
image : /assets/img/rpi3b-elinux-buildroot-install-apps.png
toc : true
---
## Introduction

In the [earlier article](/rpi3b-elinux/embedded-linux-rpi3-100-elinux-on-sdcard.html), we have successfully booted the Embedded Linux system we created by compiling toolchain, U-boot, Linux and root filesystem individually. But there are so many useful applications missing, like the *ssh* server and client programs.

In this tutorial we will use a build system called *Buildroot* to see how to install other useful applications to the root filesystem. The Buildroot itself is a tool to generate toolchain, Linux kernel and root filesystem combiningly. But we are going to use it to generate the root filesystem with the other useful apps. Here I am going to take *dropbear* which is very small ssh server and client program. We are going to install dropbear into the root filesystem, copy the files to the SD card and boot the board.

{% include image.html url="rpi3b-elinux-buildroot-install-apps.png" description="Buildroot for RPI 3B to install apps" %}

## Download the Buildroot
Download the build system from the official website.
```bash
cd ~/rpi3/
wget -c https://buildroot.org/downloads/buildroot-2020.02.2.tar.gz
tar xvf buildroot-2020.02.2.tar.gz
```
## Configure the Buildroot system

Go to the extracted Buildroot directory and configure the following options by running *make menuconfig*

```bash
cd ~/rpi3/buildroot-2020.02.2/
make menuconfig
```

 - Select *Target options* -> *Target Architecture* -> *Aarch64 (Little endian)*
 - Select *Toolchain* -> *Toolchain type* -> *External toolchain*. The overall build time will be reduced as we are not going to compile the toolchain again.
 - Select *Toolchain* -> *Toolchain* -> *Custom toolchain*
 - Select *Toolchain* -> *Toolchain path*. And enter the path to the toolchain. Ex: /home/USERNAME/x-tools/aarch64-rpi3-linux-gnu
 - Select *Toolchain* -> *Toolchain has SSP support*
 - Select *Toolchain* -> *Toolchain has RPC support*
 - Select *Toolchain* -> *Toolchain prefix* -> *$(ARCH)-rpi3-linux-gnu*
 - Select *Toolchain* -> *External toolchain kernel headers series* -> *4.19.x or later*.
 - Select *Toolchain* -> *External toolchain C library* -> *glibc/eglibc*
 - Select *Target packages* -> *Networking applications* -> *dropbear*
 - Select *System configuration* -> *Root password*. Enter the new password. We will use this password to login to the board console later.

## Download the patch to fix the compilation issue
You might see the following compile time error during compilation.
```
date.c:(.text.date_main+0x21c): undefined reference to `stime'
collect2: error: ld returned 1 exit status
Note: if build needs additional libraries, put them in CONFIG_EXTRA_LDLIBS.
```
Download the patch to fix the above compile time error.
```bash
curl https://www.nayab.xyz/patches/0003-compile-error-fix-stime.patch --output ~/rpi3/buildroot-2020.02.2/package/busybox/0003-compile-error-fix-stime.patch
```
## Generate the root filesystem
Generate the root filesystem using the following command.
```bash
make -j`nproc`
```
The generated new filesystem is present as a tar file in the path `~/rpi3/buildroot-2020.02.2/output/images`

## Extract the root filesystem
Extract the root filesystem tar file in some other directory.
```bash
mkdir -p ~/rpi3/nfs_tmp
tar -C ~/rpi3/nfs_tmp/ -xvf ~/rpi3/buildroot-2020.02.2/output/images/rootfs.tar
```
## Install Linux kernel modules
Install the already compiled Linux modules into newly created root filesystem by running below commands.

```bash
cd ~/rpi3/linux
export ARCH=arm64
export CROSS_COMPILE=aarch64-rpi3-linux-gnu-
export PATH=$PATH:~/x-tools/aarch64-rpi3-linux-gnu/bin/
make modules_install INSTALL_MOD_PATH=~/rpi3/nfs_tmp/
```
## Copy root filesystem to SD card
Insert the SD card into the system and copy the newly generated filesystem into */dev/mmcblk0p2* partition. Unmount the partition if it is mounted already and then format the partition using the following command.
```bash
sudo mkfs.ext4 /dev/mmcblk0p2 -L rootfs
```
Remove and insert again in the system so that the mount point is */media/USERNAME/rootfs*. Otherwise it would be different if you manually mount it. *lsblk* command will help you to find mount point of partition.

### Copy rootfs files to SD card.
```bash
# Copy from rootfs directory to SD card
sudo cp -r ~/rpi3/nfs_tmp/. /media/<USERNAME>/rootfs/
```
Replase *UERENAME* with yours. The copied root filesystem files have binaries and init scripts to start ssh server automatically.

If you want to add any additional packages, do `make menuconfig` in the buildroot directory, select the required packages and follow the same steps mentioned in this post.
## Change U-boot env values
Power up the board. Stop at the U-boot console and add the following env variables to load RPI from SD card.
```bash
setenv bootargs earlyprintk root=/dev/mmcblk0p2 rootfs=ext4 rootwait noinitrd
setenv bootcmd 'mmc dev 0; fatload mmc 0:1 0x2000000 kernel.img; fatload mmc 0:1 0x200000 bcm2710-rpi-3-b.dtb; booti 0x2000000 - 0x200000;'
saveenv
```
## Reboot the board
Insert the SD card into Raspberry Pi card slot and reboot the board. You should be able to login to the Raspberry Pi using SSH from your system.

If you are unable to login, it's likely that the Ethernet interface is not up in the board. You can make link up and assign some static IP using following commands in the baord.
```bash
ifup -a
ifconfig eth0 192.168.1.120
```
Now you should be able to login using the following command from your system. Enter your Root password when prompted.
```bash
ssh root@192.168.1.120
```

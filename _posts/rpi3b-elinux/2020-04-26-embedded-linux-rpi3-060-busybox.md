---
title : Generating minimal file system with busybox for Raspberry Pi 3 Model B
layout : rpi3b-elinux-post
category : rpi3b-elinux
date: 2020-04-27 00:18:43 +5:30
comments : true
google_adsense: true
excerpt : Generating minimal root filesystem with busybox for Raspberry Pi 3 Modle B. Busybox install basic Linux utilities, an init program and a shell required to make Linux system usable.
keywords : Busybox raspberry pi 3 Model B, root filesystem busybox Raspberry pi 3 Modle B, compile busybox Linux, compile busybox for arm 64 bit.
image : /assets/img/rpi3b-elinux-busybox.png
toc : true
---
## Introduction
In the [earlier articles](/book/embedded-linux-rpi3-000-intro.html#learning-path), we compiled toolchain, U-boot, Linux kernel for the Raspberry Pi 3 Model B.

In order for a Linux system to function fully, a few applications are required. When the Linux kernel boots, it tries to mount the filesystem and then looks for an `init` program to execute. If the *init* program is not found, the kernel panicks and boot process will be stopped.

A shell to execute the commands and some basic utilities are also required to make the Linux system usable.

**Busybox** is a software suite, that generates a minimal root file system with an *init* program, the *shell* and *basic Linux utilities*.

{% include image.html url="rpi3b-elinux-busybox.png" description="Generating minimal root filesystem for RPI3 Model B" %}

## Get the busybox source code
```bash
cd ~/rpi3/
git clone git://busybox.net/busybox.git
cd busybox
# Checkout to latest stable version. Can be found with `git tag --sort=v:refname`
git checkout 1_31_1
```
## Change configuration
```bash
make menuconfig
```
 - Build busybox statically (without shared liraries) by enabling *Settings -> Build static binary (no shared libraries)*
 - Add cross compiler prefix (*aarch64-rpi3-linux-uclibc-*) by going into *Settings -> Cross compiler prefix*
 - Add installation directory by going into *Settings -> Destination path for 'make install'*. Give the full path. Ex: `/home/USERNAME/rpi/nfs`. Replace USERNAME with you Ubuntu system username.
 - Disable IPV6 support for busybox by going into *Networking Utilities -> Enable IPV6 support*.

<div class="isa_warning"><strong>Note</strong>: We can not enable IPV6 support for uClibc library. Either build toolchain for glibc or build busybox by disabling IPV6.</div>

## Compile the busybox
```bash
export PATH=$PATH:~/x-tools/aarch64-rpi3-linux-uclibc/bin/
make
```
## Install the minimal filesystem
```bash
make install
```
This will install the minimal root filesystem to the path `~/rpi3/nfs`. Verify the content with following command.
```bash
ls ~/rpi3/nfs/
```
The list should be similar to the following.
```
bin  linuxrc  sbin  usr
```
<!--Add `dev` directory in the busybox installation path as Linux boots over NFS looks for this directory to mount `devtmpfs`.-->

In the next section, we will make the Linux kernel mount the root file system over network.

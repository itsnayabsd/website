---
title : Cross-compile and load Linux kernel for Raspberry Pi 3 Model B
layout : rpi3b-elinux-post
category : rpi3b-elinux
date : 2020-04-25 22:15:28 +5:30
comments : true
google_adsense: true
excerpt : This article shows how to cross compile Linux kernel for Raspberry Pi 3 Model B, load the kernel and device tree from tftp server every time the board boots up.
keywords : Raspberry pi 3 cross compile linux kernel, boot raspberry pi 3 tftp server, Raspberry Pi 3 U-boot starting kernel
image : /assets/img/rpi3b-elinux-compile-linux.png
toc : true
---
## Introduction
In the [earlier articles](/book/embedded-linux-rpi3-000-intro.html#learning-path), we compiled toolchain, U-boot for Raspberry Pi 3 Model B and established TFTP communication to transfer files from host system to target (RPI3 Model B).

In this article, we are going to compile Linux kernel for the Raspberry Pi 3 Model B, load kernel and device tree from  the U-Boot. Make sure the [tftp communicaiton](/rpi3b-elinux/embedded-linux-rpi3-040-tftp-comm.html) is working fine before proceeding with the following.

{% include image.html url="rpi3b-elinux-compile-linux.png" description="Cross compile and load Linux kernel for Raspbery Pi 3 Model B" %}
## Download the kernel

Raspberry Pi organization maintains it's own fork of Linux kernel to support all Raspberry Pi variants. Let's download the Linux kernel from offical Raspberry Pi repository.
```bash
cd ~/rpi3
git clone https://github.com/raspberrypi/linux.git
cd linux
```
Create a branch for your local development.
```bash
git checkout -b <new_branch_name>
```
ex: `git checkout -b 4.19.y-local`

## Compile kernel for RPI
Let's use the cross-toolchain we compiled [here](/rpi3b-elinux/embedded-linux-rpi3-010-toolchain.html). Let's compile Linux kerenl for `arm64`. Run the following commands to set `ARCH` and `CROSS_COMPILE` environment variables.

```bash
export ARCH=arm64 # This should match one of the directories in `arch` folder.
export CROSS_COMPILE=aarch64-rpi3-linux-uclibc-
export PATH=$PATH:~/x-tools/aarch64-rpi3-linux-uclibc/bin/
```
This kenel does have a pre defined configuration file for Raspberry Pi 3 Model B called `bcmrpi3_defconfig` present in `arch/arm64/configs` directory. Let's generate `.config` file.

```bash
make bcmrpi3_defconfig
```
Compile the Linux kernel by running following command. The `make -j` option will compile Linux kernel with the available `nproc` CPU cores.
```bash
make -j`nproc`
```
## Load Linux kernel and device tree
As we will be changing the Linux kernel and driver source frequently in the later articles, it will be cumbersome to copy the Linux kernel to SD card every time we change something. So we are going to automate the process of loading the kernel and device tree in the following sections. This eliminates the need of removal and insertion of SD cards from/to RPI.

After completion of cross compilation for Linux kernel, let's copy the kernel and device tree binary to the tftp server directory.

```bash
cp arch/arm64/boot/Image <tftp server directory>/kernel.img
cp arch/arm64/boot/dts/broadcom/bcm2710-rpi-3-b.dtb <tftp server directory>
```
**Example**:
```
cp arch/arm64/boot/Image /srv/tftp/kernel.img
cp arch/arm64/boot/dts/broadcom/bcm2710-rpi-3-b.dtb /srv/tftp/
```
<!--
Copy `overlays` directory from compiled kernel source to SD card. Path: `arch/arm/boot/dts/overlays`
Copy `bcm2710-rpi-3-b.dtb` file too to the SD card. Path: `arch/arm64/boot/dts/broadcom/bcm2710-rpi-3-b.dtb`
-->
### Load Linux kernel and dtb file from U-boot console
Now powerup the board, enter into U-boot console and run the following commands.

```bash
tftp 0x2000000 kernel.img
tftp 0x200000 bcm2710-rpi-3-b.dtb
booi 0x2000000 - 0x200000
```

 - The **tftp 0x2000000 kernel.img** command will load *kernel.img* file from tftp server directory to the RAM address of *0x2000000*.
 - The **tftp 0x200000 bcm2710-rpi-3-b.dtb** command will load *bcm2710-rpi-3-b.dtb* device tree binary file from tftp server to the RAM address of *0x200000*.
 - The **booi** command is used to boot arm64 Linux image from the memory. It has 3 arguments. The first argument is the *kernel load address* - *0x2000000*. The second argument is *the initramfs load address*. We are not using any initramfs. So passing *-* (hyphen). The third argument is the *device tree binary load address* - *0x200000*.


<div class="isa_info"><strong>Note</strong>: The kernel crash is expected here as there is no proper filesystem or init program passed to the kernel.</div><br>

We can automate the above process of kernel and device tree booting every time the board boots up by setting the `bootcmd` env in the U-boot console.
```bash
setenv bootcmd 'tftp 0x2000000 kernel.img; tftp 0x200000 bcm2710-rpi-3-b.dtb; booti 0x2000000 - 0x200000'
saveenv
```

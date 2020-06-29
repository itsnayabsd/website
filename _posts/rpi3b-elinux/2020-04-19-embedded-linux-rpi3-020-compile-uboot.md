---
title : Cross compiling U-boot bootloader for Raspberry Pi 3 Model B
layout : rpi3b-elinux-post
category : rpi3b-elinux
date: 2020-04-02 21:53:12 +5:30
comments : true
google_adsense: true
excerpt : The cross compilation steps to compile U-boot for the Raspberry Pi 3 Model B.
keywords : U-boot cross compile 64bit, aarch64 U-boot cross compile, U-boot cross compile steps for Raspberry Pi 3 Model B, Uboot cross compile tutorial for Raspberry Pi 3 Model B.
image : /assets/img/rpi3b-elinux-compile-uboot.png
toc : true
---
## Introduction
Every time we made some changes to the Linux kernel, drivers or the file system, it's very cumbersome to copy the files to SD card and then inserting the card into Raspberry Pi. We automate this process using U-boot.

We use U-boot to do the following -
 - Initialized basic hardware
 - Load kernel, device tree from non volatile storage or network (through tptp).
 - Make Linux kernel to load network file system and pass other important command line parameters.

{% include image.html url="rpi3b-elinux-compile-uboot.png" description="Cross compile U-boot for Rapsberry Pi 3 Model B" %}

<!--
Generic Embedded Devices Boot sequence
 - The on chip ROM has boot code which will be executed on power up.
 - The boot code loads the primary or first stage bootloader into SRAM. The first stage bootloader is stored generally on non volatile memory like NAND flash. The first stage bootloader generally provided by the CPU vendor. U-Boot SPL is first stage bootloader. File name MLO.
 - The first stage bootloader initializes the hardware, DRAM and loads second stage bootloader into RAM. U-boot is second stage bootloader.
 - The second stage bootloader initializes hardware, loads kernel into RAM and starts it.
 - Kernel runs from RAM.
-->

## Download the U-boot
The U-Boot
```bash
cd ~/rpi3
git clone git://git.denx.de/u-boot.git
cd u-boot
```
The `configs` directory contains configuration file for the Raspberry Pi 3 Model B and other popular boards.

<!--
## Setting up usb to serial cable

Connect the Gnd, Tx and Rx pins of usb to serial cable to the Gnd, Rx and Tx pins of RPI 3 model b GPIO pins as per schematics.

[Schematics](https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_3b_1p2_reduced.pdf)
-->

## Compile U-boot for Raspberry Pi 3 Model B
RPI 3 model b has already a predefined configuration in the u-boot configs directory. Let's compiel the u-boot for this platform.

```bash
make clean; make mrproper; make distclean
export CROSS_COMPILE=aarch64-rpi3-linux-uclibc-
make rpi_3_defconfig
make -j4
```

Make sure that the U-boot is compiled for `ARM aarch64` architecture with the following command.
```bash
file u-boot
```

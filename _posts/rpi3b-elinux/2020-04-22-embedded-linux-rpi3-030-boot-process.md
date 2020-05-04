---
title : The boot sequence of Raspberry Pi 3 Model B
layout : post
category : rpi3b-elinux
date: 2020-04-22 00:02:49 +5:30
comments : true
google_adsense: true
excerpt : The boot process is the different stages the system goes through from the powering up the device to start the operating system. This article explains the boot process of the Raspberry Pi 3 Model B.
keywords : boot process raspberry pi 3 model b, boot sequence rpi 3 model b, raspberry pi boot SD card.
image : /assets/img/rpi3b-boot-sequence.png
toc : true
---
## Introduction

The boot process is the different stages the system goes through from the powering up the device to start the operating system. This article explains the boot process of the Raspberry Pi 3 Model B. Let's verify the boot process practically too.

{% include image.html url="rpi3b-boot-sequence.png" description="Boot process of Rapsberry Pi 3 Model B" %}

## RPI3 model B boot sequence

Here are the various stages of RPI3 Model B boot sequence involves -
 - The boot ROM (the first stage bootloader) is programmed into SoC during manufacturing of the RPI. This code looks for the file `bootcode.bin` (second stage bootloader) in one of the partitions of SD card and executes it.
 - The bootcode.bin code looks for the file `config.txt` for any third stage bootloader info. If nothing found, it loads the default bootloader `start.elf` from the SD card and runs it.
 - The `start.elf` code reads `config.txt` multiple times to initialize basic hardware, load dtb and kernel into RAM.

The official page to configure `config.txt` file can be found [here](https://www.raspberrypi.org/documentation/configuration/config-txt/README.md).

Let's boot the RPI practically.

## Download bootloader files
Download `bootcode.bin` and `start.elf` files from [Official rpi firmware repo](https://github.com/raspberrypi/firmware/tree/master/boot). These files are proprietary GPU firmware files and are necessary to start RPI3 model B.

Copy downloaded files to `~/rpi3/sdCardFiles/` directory.
```bash
mkdir -p ~/rpi3/sdCardFiles
cd ~/rpi3/sdCardFiles
cp ~/Downloads/bootcode.bin ~/Downloads/start.elf ./
```
Copy the `u-boot.bin` file compiled from [earlier article](/rpi3b-elinux/embedded-linux-rpi3-020-compile-uboot.html) also to the `~/rpi3/sdCardFiles/` folder.
```bash
cp ~/rpi3/u-boot/u-boot.bin ./
```

<!--
Enable the early boot stage logging using the following command. It will be useful to debug early boot problems.
```bash
cd ~/rpi3/sdCardFiles
sed -i -e "s/BOOT_UART=0/BOOT_UART=1/" bootcode.bin
```
-->
## Add basic configuration in the config.txt
Create a minimal `config.txt` configuration file in the `~/rpi3/sdCardFiles/` directory with the following lines.

```bash
cat << EOF >> config.txt
arm_64bit=1
kernel=u-boot.bin
EOF
```
<!--
```bash
arm_64bit=1
# Uncomment below line if you work with Linux kernel, without U-boot as intermediatary.
kernel=kernel.img
# Uncomment below line if you work only with U-boot, without Linux kernel
# kernel=u-boot.bin
enable_uart=1
core_freq=250
overlay_prefix=overlays/
dtoverlay=pi3-miniuart-bt
# Uncomment the following line if you work with U-boot, without Linux kernel.
# device_tree=bcm2837-rpi-3-b.dtb
# Uncomment the following line if you work with Linux kernel, wihtout U-boot as intermediary.
device_tree=bcm2710-rpi-3-b.dtb
```
-->

 - The `kernel=u-boot.bin` loads u-boot.bin in the place of actual Linux kernel.
 - The `arm_64bit=1` tells the firmware to start ARM cores in 64 bit mode.

<!--
 - The RPI3 model B has two UARTs. A mini UART and other is PL011 UART. The early boot stage of RPI uses mini UART. To enable it, add `enable_uart=1` to the config.txt file. When PL011 is initialized, the mini UART will no longer be a primary UART and won't work as Linux console unless we add `core_freq=250` to the config.txt file.

 - The device tree binary `bcm2837-rpi-3-b.dtb` can be found in the u-boot directory post compilation.
 - `device_tree_address=0x200000` loads the above dtb file into location `0x200000` into RAM.
-->

## Copy the files to sd card
The `~/rpi3/sdCardFiles/` directory must have the following files.

 - bootcode.bin
 - config.txt
 - start.elf
 - u-boot.bin

### Prepare SD card
Create three partitions using [fdisk and mkfs](/linux-tools/partitioning-using-fdisk.html)
 - First partition is of size 1GB, type *fat32* with label *boot*
 - Second partition is of size 512MB, type *Linux* with label *rootfs*
 - The third partition is of remaining of the SD card storage with the type *Linux*

Once the SD card partitioning is done, copy above mentioned files to SD card.
```bash
cp -r ~/rpi3/sdCardFiles/. <path_to_sd_card_mount_point> # Use lsblk command to find the mount point
```
## Power up the board.
Connect the USB keyboard to the Raspberry Pi USB. Attach TV/monitor to the Raspberry Pi with the HDMI cable.

Unmount the SD card from the system. Insert the card into the Raspberry Pi SD card slot and power up the board.

You should see the following logs appearing on your TV/monitor.
```
Net:   No ethernet found.
starting USB...
Bus usb@7e980000: scanning bus usb@7e980000 for devices... 3 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Hit any key to stop autoboot:  0
U-Boot>
U-Boot>
```
<div class="isa_info"><strong>Note</strong>: You need to press any key within 3 seconds after board powered up to enter into U-boot console.</div><br>
<!--
By default `u-boot.bin` load at address `0x80000`. This can be changed with `kernel_address` parameter in the config.txt.
-->

Type `help` in the U-boot console to see available U-boot commands.

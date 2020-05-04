---
title : 
layout : post
category : rpi3b-elinux
date : 2020-05-04 22:59:59 +5:30
comments : true
google_adsense: true
excerpt : 
keywords : 
image : /assets/img/rpi3b-elinux-busybox-sharedlib.png
toc : true
---
## Introduction
Now that we have our [filesystem with necessary libraries ready](), we are going to put bootloader, kernel and the root filesystem into the SD card and boot from it.

## Making a SquashFS image of the root filesystem
The SquashFS is a read only filesystem with high compression and read speed. We are going to create a SquashFS image of our root filesystem and flash that image to the secondary partition of SD card (we [created]() the second partition with 512MB size).

### Install squashfs-tools
Install the *squashfs-tools* package on your Ubuntu development system with the following command
```bash
sudo apt install squashfs-tools
```
### Create squashfs image of root directory
```bash
mksquashfs ~/rpi3/nfs ~/rpi3/sdCardFiles/rootfs.sqsh
```
The squashfs image, *rootfs.sqsh* is ready for the busybox root filesystem.

## Enabling SquashFS support in kernel

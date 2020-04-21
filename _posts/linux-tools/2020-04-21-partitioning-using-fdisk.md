---
title : SD card or USB drive partitioning using fdisk
layout : post
category : linux-tools
date: 2020-04-21 22:00:21 +5:30
comments: true
google_adsense: true
excerpt : Create partitions using fdisk tool for any SD card or USB drive. Build a file system in those partitions. In this tutorial we create two partitions, the first one with fat32 filesystem and the second one with ext4 filesystem.
kerwords : fdisk, fdisk linux, fdisk resize partition, fdisk delete partition, fdisk command in Linux, fdisk create partition, fdisk change system type, fdisk format drive, how to use fdisk tutorial, create boot partition using fdisk, create partitions for SD card using fdisk, create partitions for USB flash drive using fdisk, mkfs vfat fat32 file system build.
image : /assets/img/partitioning-using-fdisk.png
toc : true
---
## Introduction
In this tutorial we will learn how to create partitions for any hard disk drive (HDD), USB drive or micro SD card using the Linux tool called `fdisk`. We are going to build a file system in those partitions with another tool called `mkfs`.

Let's create two partitions, the first one with `fat32` filesystem and the second one with `ext4` filesystem. This kind of partition combination generally used to create complete bootable operating system. The `fat32` partition is used to store bootloader related files and the `ext4` filesystem is used to store Linux files.

{% include image.html url="partitioning-using-fdisk.png" description="Partitioning SD card or USB drive using fdisk" %}

## Insert the USB drive / SD card reader

When you insert an USB drive/USB card reader into the system USB port, the devices are created with names in the format `sdX`. Ex: `sda`, `sdb` etc. And the partitions are created in the format `sdXY`. Ex: `sdb1`, `sdc1` etc. You can check the device name with the command `lsblk` after inserting the USB flash drive/ USB card reader.

```bash
lsblk
```
The output looks like following for the USB based device
```
sda      8:0    0 223.6G  0 disk 
├─sda1   8:1    0   512M  0 part /boot/efi
├─sda2   8:2    0  93.1G  0 part /
├─sda3   8:3    0   7.5G  0 part [SWAP]
└─sda4   8:4    0 122.5G  0 part 
sdb      8:16   1   7.2G  0 disk 
└─sdb1   8:17   1   7.2G  0 part /media/nayab/B414-8534
sr0     11:0    1  1024M  0 rom  
```

For SD card inserted through SD card slot, the output looks like following. `mmcblk0` is the SD card and `mmcblk0p1` is the SD card partition.
```
sda           8:0    0 223.6G  0 disk 
├─sda1        8:1    0   512M  0 part /boot/efi
├─sda2        8:2    0  93.1G  0 part /
├─sda3        8:3    0   7.5G  0 part [SWAP]
└─sda4        8:4    0 122.5G  0 part 
sr0          11:0    1  1024M  0 rom  
mmcblk0     179:0    0    29G  0 disk 
└─mmcblk0p1 179:1    0    29G  0 part /media/nayab/8D39-59F7
```
Usually `sda` will be your system internal hard drive. `sdb` or `sdc` will be your USB device (USB flash drive or USB card reader). `mmcblk0` will be the SD card inserted through SD card slot. Cross check the device name with the `lsblk` command just after removing and again after inserting the device.
## Unmount the partitions
Unmount the partition using the following command. This step is necessary to alter the partitions using `fdisk`.
```bash
sudo umount /dev/sdb1 # For USB based devices
```
or
```bash
sudo umount /dev/mmcblk0p1  # For Micro SD card
```
## Partitioning with fdisk

Now run the fdisk command with the device path.
```bash
sudo fdisk /dev/mmcblk0      # Replace /dev/mmcblk0 with USB device name (ex: /dev/sdb or /dev/sdc) if you are using USB based device
```
### Delete partitions
Type `d` multiple times until all partitions are deleted and type `p` to make sure the same.
```
Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): d
Selected partition 1
Partition 1 has been deleted.

Command (m for help): d
No partition is defined yet!

Command (m for help): p

Disk /dev/mmcblk0: 28.99 GiB, 31104958464 bytes, 60751872 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x6c586e13
```
### Create FAT32 partition
Now let's create a primary partition of 1GB to store bootloader files
```
Command (m for help): p

Disk /dev/mmcblk0: 28.99 GiB, 31104958464 bytes, 60751872 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x6c586e13

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-60751871, default 2048): 2048
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-60751871, default 60751871): +1G

Created a new partition 1 of type 'Linux' and of size 1 GiB.
```

Change the partition type to `FAT32`. Type `t` and then `b`.
```
Command (m for help): t
Selected partition 1
Hex code (type L to list all codes): b
Changed type of partition 'Linux' to 'W95 FAT32'.

Command (m for help): p
Disk /dev/mmcblk0: 28.99 GiB, 31104958464 bytes, 60751872 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x6c586e13

Device         Boot Start     End Sectors Size Id Type
/dev/mmcblk0p1       2048 2099199 2097152   1G  b W95 FAT32
```
### Create Linux partition
Create one more partition with the remaining size. Type `n` and keep pressing `Enter` until the prompt repeates. Type `t` to change the partition type and write `83` to change it to `Linux` type.
```
Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): 

Using default response p.
Partition number (2-4, default 2): 
First sector (2099200-60751871, default 2099200): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2099200-60751871, default 60751871): 

Created a new partition 2 of type 'Linux' and of size 28 GiB.

Command (m for help): 


Command (m for help): 


Command (m for help): t
Partition number (1,2, default 2): 2
Hex code (type L to list all codes): 83

Changed type of partition 'Linux' to 'Linux'.

Command (m for help): p
Disk /dev/mmcblk0: 28.99 GiB, 31104958464 bytes, 60751872 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x6c586e13

Device         Boot   Start      End  Sectors Size Id Type
/dev/mmcblk0p1         2048  2099199  2097152   1G  b W95 FAT32
/dev/mmcblk0p2      2099200 60751871 58652672  28G 83 Linux
```
### Write changes to device
Type `w` to write partition changes to disks.
```
Command (m for help): w

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```
## Build file system with mkfs tool
Build fat32 filesystem for partition 1.
```
sudo mkfs.vfat /dev/mmcblk0p1 -n boot
```
Build Linux filesystem for partition 2.
```
sudo mkfs.ext4 /dev/mmcblk0p2
```
## Check the partitions
Remove the USB/Card reader device and then reinsert to verify the partitions using the lsblk command.
```
sda           8:0    0 223.6G  0 disk 
├─sda1        8:1    0   512M  0 part /boot/efi
├─sda2        8:2    0  93.1G  0 part /
├─sda3        8:3    0   7.5G  0 part [SWAP]
└─sda4        8:4    0 122.5G  0 part 
sr0          11:0    1  1024M  0 rom  
mmcblk0     179:0    0    29G  0 disk 
├─mmcblk0p1 179:1    0     1G  0 part /media/nayab/boot
└─mmcblk0p2 179:2    0    28G  0 part /media/nayab/f7117e79-9502-49aa-829b-75ec070eddda
```

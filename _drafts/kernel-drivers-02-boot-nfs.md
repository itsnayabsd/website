---
layout : post
---
## Install toolchain

sudo apt install gcc-arm-linux-gnueabi

Add the following in the `~/.bashrc`
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabi-

## Compile linux
make omap2plus_defconfig

omap2plus_defconfig supports Texas intruments SOCs such as OMAP5, AM33XX, AM43XX etc.

Add the following fields as inbuilt modules to .config file to support Networking over USB.
CONFIG_USB_GADGET=y
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_GADGET=y
CONFIG_USB_MUSB_DSPS=y
CONFIG_AM335X_PHY_USB=y
CONFIG_USB_ETH=y
CONFIG_ROOT_NFS=y
and
USB Gadget precomposed configurations as static rather than as module (m). Change any dependencies to y.

Check .config file if CONFIG_AM335X_PHY_USB=y

Copy zImage and dtb file to tftpboot directory

cp ./arch/arm/boot/zImage ./arch/arm/boot/dts/am335x-boneblack.dtb /tftpboot/

## Setting up NFS server
sudo apt install nfs-kernel-server

Add the following line to /etc/exports file

/home/nayab/bootlin/linux-kernel-labs/modules/nfsroot/ 192.168.1.5(rw,no_root_squash,no_subtree_check)

192.168.1.5 is IP address of the board. `nfsroot` is the filesystem downloaded from bootlin linux kernel docs.

sudo /etc/init.d/nfs-kernel-server restart

## Boot the board
In the u-boot console,

setenv bootargs root=/dev/nfs rw ip=192.168.1.5:::::usb0 console=ttyS0,115200n8 g_ether.dev_addr=f8:dc:7a:00:00:02 g_ether.host_addr=f8:dc:7a:00:00:01 nfsroot=192.168.1.15:/home/nayab/bootlin/linux-kernel-labs/modules/nfsroot,v3

saveenv

tftp 0x81000000 zImage
tftp 0x82000000 am335x-boneblack.dtb

bootz 0x81000000 - 0x82000000

Note : Make sure that board is not connected through ethernet cable. This works when board is connected to the system over mini usb.

Save the bootcmd to avoid loading zImage and dtb every time the board is powered up.

setenv bootcmd 'tftp 0x81000000 zImage; tftp 0x82000000 am335x-boneblack.dtb; bootz 0x81000000 - 0x82000000'
saveenv

---
layout : post
---
## Download the kernel

Download kernel from offical rpi repository.

Note down the latest stable tag. Create a local branch for your development.
```bash
git tag -l
git checkout -b <local_branch_name> <stable_tag>
```
ex: `git checkout -b 5.6.y v5.6`

## Compile kernel for RPI
```bash
export ARCH=arm64 # This should match one of the directories in `arch` folder.
export CROSS_COMPILE=aarch64-rpi3-linux-uclibc-
export PATH=$PATH:~/x-tools/aarch64-rpi3-linux-uclibc/bin/
```
The Linux kenel does have a generic `defconfig` for arm64 in the `arch/arm64/configs` directory.
```bash
make bcmrpi3_defconfig
```
Compile the linux
```bash
make
```
```
cp arch/arm64/boot/Image /tftpboot/kernel.img
cp arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb /tftpboot/
```
Copy `overlays` directory from compiled kernel source to SD card. Path: `arch/arm/boot/dts/overlays`
Copy `bcm2710-rpi-3-b.dtb` file too to the SD card. Path: `arch/arm64/boot/dts/broadcom/bcm2710-rpi-3-b.dtb`

In the U-boot console,
```
tftp 0x2000000 kernel.img
tftp 0x200000 bcm2710-rpi-3-b.dtb
booi 0x2000000 - 0x200000
```
```
setenv bootcmd 'tftp 0x2000000 kernel_ubuntu_config.img; tftp 0x200000 bcm2837-rpi-3-b.dtb; booti 0x2000000 - 0x200000'
```

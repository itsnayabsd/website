---
layout : post
---
## Download the kernel

git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Note down the latest stable tag. Create a local branch for your development.
```bash
git tag -l
git checkout -b <local_branch_name> <stable_tag>
```
ex: `git checkout -b 5.6.y v5.6`

## Compile kernel for RPI
```bash
export ARCH=arm # This should match one of the directories in `arch` folder.
export CROSS_COMPILE=arm-linux-rpi3-
```
The broadcom chip in the RPI3 model B is BCM2837 whose underlying architecture is identical to BCM2836/35 according to [offical source](https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2837/README.md)

The Linux kenel has default config `bcm2835_defconfig` in the `arm/arch/configs` directory. Configuration files in the `configs` directory are having minimal configurations only.
```bash
make bcm2835_defconfig
```
For kernel :

export ARCH=arm; export CROSS_COMPILE=arm-linux-gnueabi-

For U-boot :
```
sudo apt-get install gcc-aarch64-linux-gnu
export ARCH=arm; export CROSS_COMPILE=aarch64-linux-
```

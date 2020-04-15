---
title : Building a toolchain for cross-compilation
layout : post
category : rpi3b-elinux
date: 2020-04-15 22:15:28 +5:30
---
## Introduction

A toolchain is the combination of following -
 - Binutils - as, ld, ar, ranlib, objdump, readelf, size, nm, strings, objcopy and strip. Official page : [http://www.gnu.org/software/binutils/](http://www.gnu.org/software/binutils/).
 - Kernel headers - Can be extracted from kernel sources using `make headers_install` target.
 - C/C++ libraries - Several C libraries available. glibc, uClibc, musl, klibc, newlib ...
 - C/C++ compiler - GCC : GNU compiler collection.
 - GDB debugger 

We are going to use a development PC (called host sytem) like our laptop or desktop to create the embedded system (target system).

Toolchain building utilities
 - Crosstool-ng - Dedicated to generate toolchain.
 - Buildroot - Root filesystem buildsystem. Can build glibc, uClibc and musl based toolchains.
 - OpenEmbedded - Root filesystem build system. Also used to generate toolchain. Complicated but featureful.

Generating cross toolchain using crosstool-ng for uClibc C library

Downloading and installing crosstool-ng:

```bash
sudo rm -rf ~/x-tools/
mkdir -p ~/rpi && cd ~/rpi
git clone https://github.com/crosstool-ng/crosstool-ng.git
cd crosstool-ng/
git checkout 75d7525a		## Tested until this commit id. Newer commit ids need to be checked later.
```
```bash
./bootstrap
./configure --enable-local
make
```
Above will install crosstool-ng locally.

Configure the toolchain to generate
`./ct-ng list-samples` comes with pre defined configurations for different setups (architecture, library).

## Generate toolchain for rpi3 model b
Raspberry Pi 3 model b has BCM2837 chip. This chip has four ARM cortex A53 cores of ARMv8 architecture.

Let's generate toolchain (64bit) for ARMv8 architecture and uClibc library. `ct-ng` has pre defined configuration for rpi3.
```
./ct-ng aarch64-rpi3-linux-gnu
```
But above configuration is for `glibc`. Let's change the configuration.
```
./ct-ng menuconfig
```
 - In `Paths and misc options`, change *Maximum log level to see* to DEBUG.
 - In `C library`, change *C library* to uClibc.
 - In `Debug facilites`, disable all options for now as it takes forever to compile.

**Note** We can not enable IPV6 support for uClibc library. Either build toolchain for glibc or build busybox (which expects IPV6 support) by disabling IPV6.

Build toolchain
```bash
./ct-ng build
```

If the above step failed at some package downloading, download the package manually from the internet and copy to `~/src` directory and use the above step again.

Resolve any patch apply conflicts happening.

Now the toolchain is installed in `~/x-tools` directory. Add this *$HOME/x-tools/arm-training-linux-uclibcgnueabihf/bin/* to PATH env varibale in .bashrc so that it can be detected.

Test the toolchain

```
arm-linux-gcc hello.c && file a.out
```

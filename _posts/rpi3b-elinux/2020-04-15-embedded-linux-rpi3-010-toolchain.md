---
title : Building a cross toolchain for Raspberry Pi 3 Model B
layout : rpi3b-elinux-post
category : rpi3b-elinux
date : 2020-04-15 22:15:28 +5:30
comments : true
google_adsense: true
excerpt : Configure and build a cross toolchain using the crosstool-ng build tool for raspberry pi 3 model b. The cross toolchain is built for aarch64 architecture and uClibc library.
keywords : toolchain download, arm toolchain linux, arm 64bit toolchain linux, arm toolchain ubuntu 18.04 and 20.04, aarch64 toolchain linux, crosstool-ng download, crosstool-ng build arm 64bit toolchain, cross toolchain for rapsberry pi 3 model b, cross toolchain gcc, rpi gcc cross compile toolchain, raspberry pi toolchain ubuntu, raspberry pi toolchain download
image : /assets/img/rpi3b-elinux-toolchain.png
toc : true
---
## Introduction

A toolchain is a set of software development tools which are used at various stages of software development process. It's a combination of following -

 - Binutils - Binary utilities to create and manage the binaries. *as, ld, ar, ranlib, objdump, readelf, size, nm, strings, objcopy* and *strip*. More information can be found [here](http://www.gnu.org/software/binutils/).
 - C/C++ libraries - Several C libraries available. glibc, uClibc, musl, klibc, newlib etc. A toolchain has one of the these libraries.
 - C/C++ compiler - GCC : GNU compiler collection.
 - GDB debugger - Not necessarily part of toolchain.

A cross toolchain is what used to create binaries for the target system. We are going to use a development PC (called host system) to build *Embedded Linux* using cross toolchain for the target system. Here the host system is a laptop or desktop with **Ubuntu 18.04** or later. The targe system obviously **the Raspberry Pi 3 Model B**.

{% include image.html url="rpi3b-elinux-toolchain.png" description="Cross Toolchain for Rapsberry Pi 3 Model B" %}

## Cross toolchain building utilities
Building a cross toolchain from scratch is difficult. Either we use the already available toolchain from vendor or we use toolchain build utilities like below to generate cross toolchian.
 - Crosstool-ng - Dedicated to generate toolchain.
 - Buildroot - Can build glibc, uClibc and musl based toolchains as well as compelte root filesystem.
 - OpenEmbedded - Used to generate a complete root filesystem build system. Also used to generate toolchain.

## Generating cross toolchain using crosstool-ng for uClibc C library

Let's create a folder called `rpi3` in the home directory. We are going to develop complete Embedded Linux for RPI3 Model B in this directory.
```bash
mkdir -p ~/rpi3 && cd ~/rpi3
```
### Download crosstool-ng
Run the following commands to download and install crosstool-ng build tool.

```bash
git clone https://github.com/crosstool-ng/crosstool-ng.git
cd crosstool-ng/
## Tested until the following commit id.
git checkout 75d7525a
```
### Configure and compile the build tool
```bash
./bootstrap
./configure --enable-local
make
```
Above will install crosstool-ng locally.

### Configure the build tool
`./ct-ng list-samples` command shows the pre defined configurations for different setups (arch: armv7, armv8, aarch64 etc., library : uClibc, libc etc.) for different platforms.

Let's generate toolchain (64bit) for ARMv8 architecture and uClibc library. `ct-ng` has pre defined configuration for RPI3 Model B.
```bash
./ct-ng aarch64-rpi3-linux-gnu
```
But above configuration is for `glibc`. Let's change the configuration.
```bash
./ct-ng menuconfig
```
 - In **Paths and misc options**, change *Maximum log level to see* to DEBUG.
 - In **C library**, change *C library* to uClibc.
 - In **Operating system**, select *Version of Linux* as *4.19.105* as we are going to use this version of Linux in the subsequent tutorials.
 - In **Debug facilites**, disable all options for now as it takes forever to compile.

**Note** We can NOT enable IPV6 support for uClibc library. It's fine for now as we are going to use IPV4 for Embedded Linux networking.

### Build toolchain
```bash
./ct-ng build
```

<!--If the above step failed at some package downloading, download the package manually from the internet and copy to `~/src` directory and use the above step again. Resolve any patch apply conflicts happening.-->

Now the toolchain is installed in `~/x-tools` directory. Add this `$HOME/x-tools/aarch64-rpi3-linux-uclibc/bin/` to PATH env varibale in **.bashrc** so that it can be detected for compiling the binaries.

```bash
echo 'export PATH=$PATH:$HOME/x-tools/aarch64-rpi3-linux-uclibc/bin/' >> ~/.bashrc
source ~/.bashrc
```
## Test the toolchain

Write a sample C program to cross compile with toolchain

**file** : dummy.c
```C
int main(void)
{       
        return 0;
}       
```
### Compile the program with cross toolchain
```bash
aarch64-rpi3-linux-uclibc-gcc dummy.c -o dummy
```
You shouldn't see any error or warnings.
### Check the binary architecture
```bash
file dummy
```
You should see output similar to the following. The output must have words `ARM aarch64` and `/lib/ld-uClibc.so.0`.
```
dummy: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-uClibc.so.0, not stripped
```

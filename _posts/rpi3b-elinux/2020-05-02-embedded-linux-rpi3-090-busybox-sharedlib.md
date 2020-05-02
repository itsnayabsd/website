---
title : Busybox filesystem with shared libraries
layout : post
category : rpi3b-elinux
date : 2020-05-03 22:34:28 +5:30
comments : true
google_adsense: true
excerpt : 
keywords : 
image : /assets/img/rpi3b-elinux-toolchain.png
toc : true
---
## Introduction
Earlier in the [Embedded Linux with Raspberry Pi 3B]() series, we have [generated minimal root filesystem]() statically for the Raspberry Pi using busybox build system. The filesystem thus generated doesn't have any shared libraries.

If we keep cross compiling statically for each and every program we have written, we will end up with the binaries and the final Embedded Linux system of size a lot more.

The goal of this article is to generate the filesystem with shared libraries in place.

## Finding the necessary shared libraries
Even if we cross-compile the buysbox filesystem by *disabling* the *Build static binary (no shared libraries)* option in *make menuconfig*, the filesystem won't have any shared libraries. We need to copy the necessary shared libraries from our toolchain directory to the busybox filesystem directory.

Let's find the necessary shared libraries required to execute a simple *Hello World!* program.

```bash
cd ~/rpi3/nfs/

cat << EOF >> helloworld.c
#include <stdio.h>

int main(void)
{
	printf("Hello World!\n");
	return 0;
}
```
Compile the program using cross-toolchain gcc.
```bash
export PATH=$PATH:~/x-tools/aarch64-rpi3-linux-uclibc/bin/
aarch64-rpi3-linux-uclibc-gcc helloworld.c -o helloworld
```
Now try to execute *helloworld* program on the Raspberry Pi by running the following command.
```bash
/helloworld
```
You will face the following error
```
Writie error here
```
The shared library which is actually missing in this case is the *linker library (ld-uClibc.so.0)*. Let's copy the library from the toolchain path to the filesystem */lib* directory.
```bash
cp ~/x-tools/aarch64-rpi3-linux-uclibc/aarch64-rpi3-linux-uclibc/sysroot/lib/ld-uClibc* ~/rpi3/nfs/lib
```
Try to execute the *helloworld* binary again. Let's see if any other shared libaries missing. Copy the shared libraries file from the toolchain diriectory to ~/rpi3/lib directory.

---
title : Busybox filesystem with shared libraries for Raspberry Pi 3 Model B
layout : rpi3b-elinux-post
category : rpi3b-elinux
date : 2020-05-03 18:34:28 +5:30
comments : true
google_adsense: true
excerpt : Compile busybox without static building enabled and copy all the necessary shared libraries to run a binary from the toolchain directory to busybox filesystem.
keywords : Busybox raspberryPi 3, build busybox for raspberrypi, busybox mount nfs share, busybox shared libraries
image : /assets/img/rpi3b-elinux-busybox-sharedlib.png
toc : true
---
## Introduction
Earlier in the [Embedded Linux with Raspberry Pi 3B](/book/embedded-linux-rpi3-000-intro.html#learning-path) series, we have [generated minimal root filesystem](/rpi3b-elinux/embedded-linux-rpi3-060-busybox.html) statically for the Raspberry Pi using busybox build system. The filesystem thus generated doesn't have any shared libraries.

If we keep cross compiling statically for each and every program we have written, we will end up with the binaries and the final Embedded Linux system of size a lot more.

The goal of this article is to generate the filesystem with shared libraries in place, make binaries size smaller.

{% include image.html url="rpi3b-elinux-busybox-sharedlib.png" description="Busybox filesystem with shared libraries" %}
## Finding the necessary shared libraries
Let's write, compile a simple *Hello World!* program for the Raspeberry Pi 3B and execute on the board.

```bash
cd ~/rpi3/nfs/
```
```bash
cat << EOF >> helloworld.c
#include <stdio.h>

int main(void)
{
	printf("Hello World!\n");
	return 0;
}
EOF
```
Compile the program using cross-toolchain gcc.
```bash
export PATH=$PATH:~/x-tools/aarch64-rpi3-linux-gnu/bin/
aarch64-rpi3-linux-gnu-gcc helloworld.c -o helloworld
```
Now try to execute *helloworld* program on the Raspberry Pi by running the following command.
```bash
/helloworld
```
You will face the following error
```
/bin/sh: /helloworld: not found
```
It's not like the file is missing. The file is still present in your root directory. You can confirm with *ls -l /helloworld* command on the board.

It's because the the *linker library (ld-linux-aarch64.so.1)* is missing. Let's copy the library from the toolchain path to the filesystem */lib* directory.
```bash
mkdir -p ~/rpi3/nfs/lib/
cd ~/rpi3/nfs/
ln -s lib lib64
cp ~/x-tools/aarch64-rpi3-linux-gnu/aarch64-rpi3-linux-gnu/sysroot/lib/ld-linux-aarch64.so* ~/rpi3/nfs/lib
```
Try to execute the *helloworld* binary again. You might need to export *LD_LIBRARY_PATH* using the command, `export LD_LIBRARY_PATH=/lib/` in the board. Let's see if any other shared libaries missing. Copy all the shared libraries reported from the toolchain diriectory to ~/rpi3/lib directory.

```bash
cp -f ~/x-tools/aarch64-rpi3-linux-gnu/aarch64-rpi3-linux-gnu/sysroot/lib/libc.so* ~/rpi3/nfs/lib
cp -f ~/x-tools/aarch64-rpi3-linux-gnu/aarch64-rpi3-linux-gnu/sysroot/lib/libm.so* ~/rpi3/nfs/lib
cp -f ~/x-tools/aarch64-rpi3-linux-gnu/aarch64-rpi3-linux-gnu/sysroot/lib/libresolv.so* ~/rpi3/nfs/lib
```
## Cross-compile busybox filesystem again
Let's check the size of the busybox binary before disabling the static building.
```bash
ls -lh ~/rpi3/nfs/bin/busybox
```

It's approximately **1.9M** size when I checked it. Since the shared libraries are in place now, we can cross-compile the busybox filesystem by *disabling* the *Settings -> Build static binary (no shared libraries)* option in *make menuconfig*.
```bash
cd ~/rpi3/busybox/
make menuconfig
```
Save the config file, compile the filesystem and install.
```bash
make -j`nproc`
make install
```
Now check the size of busybox binary again. It's **990K** for me. The size definitely reduced as it is going to use the shared libraries we copied above.

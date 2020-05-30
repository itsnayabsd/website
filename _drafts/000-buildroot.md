---
layout : post
---
Download buildroot

```
cd ~/rpi3/
wget -c https://buildroot.org/downloads/buildroot-2020.02.2.tar.gz
tar xvf buildroot-2020.02.2.tar.gz
```

Enabled IPV6 support in x-tools toolchain C library. Need to re-test with IPV6.

Slect Target options -> Target Architecture -> Aarch64 (Little endian)

Select Toolchain -> Toolchain type -> External toolchain

Select Toolchain -> Toolchain -> Custom toolchain

Select Toolchain -> Toolchain path  and enter the path to the toolchain. In my case it is, /home/nayab/x-tools/aarch64-rpi3-linux-uclibc

Select Toolchain -> Toolchain prefix -> $(ARCH)-rpi3-linux-uclibc

Select Toolchain -> External toolchain kernel headers series -> 4.19.x or later.


Select System configuration -> Root password

Select Filesystem images -> squashfs root filesystem

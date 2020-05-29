---
layout : post
---
Download buildroot

```
cd ~/rpi3/
wget -c https://buildroot.org/downloads/buildroot-2020.02.2.tar.gz
tar xvf buildroot-2020.02.2.tar.gz
```

Slect Target options -> Target Architecture -> Aarch64 (Little endian)

Select Toolchain -> Toolchain type -> External toolchain

Select Toolchain -> Toolchain -> Custom toolchain

Select Toolchain -> Toolchain path  and enter the path to the toolchain. In my case it is, /home/nayab/x-tools/aarch64-rpi3-linux-uclibc

Select Toolchain -> External toolchain kernel headers series -> 5.4.x or later.

Select Filesystem images -> squashfs root filesystem

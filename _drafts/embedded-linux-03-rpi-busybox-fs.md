---
layout : post
---
## Get the busybox source code
```
git clone git://busybox.net/busybox.git
cd busybox
# Checkout to latest stable version
git checkout 1_31_1
```
## Change configuration
```
make menuconfig
```
Build busybox statically (without shared liraries) by enabling Settings -> Build static binary (no shared libraries)
Add cross compiler prefix (aarch64-rpi3-linux-uclibc-) by going into Settings -> Cross compiler prefix
Add installation directory by going into Settings -> Destination path for 'make install'. Give the full path. Ex: /home/USER/rpi/nfs
Disable IPV6 support for busybox by going into Networking Utilities -> Enable IPV6 support.

**Note** We can not enable IPV6 support for uClibc library. Either build toolchain for glibc or build busybox (which expects IPV6 support) by disabling IPV6.

## Compile the busybox
```
export PATH=$PATH:~/x-tools/aarch64-rpi3-linux-uclibc/bin/
make
make install
```
Add `dev` directory in the busybox installation path as Linux boots over NFS looks for this directory to mount `devtmpfs`.

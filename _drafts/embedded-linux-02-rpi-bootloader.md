---
layout : post
---
RPI 3 model b has already a predefined configuration in the u-boot configs directory.

Let's compiel the u-boot for the platform.

```
export CROSS_COMPILE=arm-linux-rpi3-
make rpi_3_defconfig

---
layout : post
---
## Setting up usb to serial cable

Connect the Gnd, Tx and Rx pins of usb to serial cable to the Gnd, Rx and Tx pins of RPI 3 model b GPIO pins as per schematics.

[Schematics](https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_3b_1p2_reduced.pdf)

## Compile u-boot for rpi3 model b
RPI 3 model b has already a predefined configuration in the u-boot configs directory.

Let's compiel the u-boot for the platform.

```
export CROSS_COMPILE=arm-linux-rpi3-
make rpi_3_defconfig
make
```
## RPI3 model b boot sequence
RPI replaces traditional BIOS with simple configuration file called `config.txt`.

The GPU has the boot ROM (may be called first stage bootloader). It reads the file `config.txt` before starts the ARM core. `config.txt` should be present in the SD card first boot partition along with the files `bootcode.bin` and `start.elf`.

Official [config.txt main page](https://www.raspberrypi.org/documentation/configuration/config-txt/README.md)

## Copy first stage bootloader files to sd card

Download bootcode.bin and start.elf files from [Official rpi firmware repo](https://github.com/raspberrypi/firmware/tree/master/boot).

Format the sd card to fat32 using fdisk and mkfs.vfat.

Copy the above downloaded files to sd card. Copy u-boot.bin file also to sd card with name `kernel.img`. Boot the board and test whether uart logs are seen or not.


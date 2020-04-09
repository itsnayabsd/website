---
layout : post
---
## Setting up usb to serial cable

Connect the Gnd, Tx and Rx pins of usb to serial cable to the Gnd, Rx and Tx pins of RPI 3 model b GPIO pins as per schematics.

[Schematics](https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_3b_1p2_reduced.pdf)

## Compile u-boot for rpi3 model b
RPI 3 model b has already a predefined configuration in the u-boot configs directory.

Let's compiel the u-boot for the platform.

```bash
make clean; make mrproper; make distclean
export CROSS_COMPILE=aarch64-rpi3-linux-uclibc-
make rpi_3_defconfig
make
```
## Download bootloader files
Download `bootcode.bin` and `start.elf` files from [Official rpi firmware repo](https://github.com/raspberrypi/firmware/tree/master/boot). These files are proprietary GPU firmware files and are necessary to start RPI3 model B.

Enable the early boot stage logging using the following command. It will be useful to debug early boot problems.
```bash
sed -i -e "s/BOOT_UART=0/BOOT_UART=1/" bootcode.bin
```
## RPI3 model b boot sequence

 - The boot ROM on SoC loads `bootcode.bin` in the sd card into the local cache and jump on it.
 - This code looks for the file `config.txt` for any third stage bootloader info. If nothing found, it loads the default bootloader `start.elf` from the sd card and runs it.
 - The `start.elf` code reads `config.txt` multiple times to initialize basic hardwarei, load dtb and kernel into RAM.

The official page to configure `config.txt` file can be found [here](https://www.raspberrypi.org/documentation/configuration/config-txt/README.md)

Other useful official pages :
 - [Device tree](https://www.raspberrypi.org/documentation/configuration/device-tree.md)
 - [Conditional filters](https://www.raspberrypi.org/documentation/configuration/config-txt/conditional.md)
 - [LED warning flash codes](https://www.raspberrypi.org/documentation/configuration/led_blink_warnings.md)

## Add basic configuration in the config.txt

Here is the basic configuration required to start RPI3 model b and log into u-boot console.
```bash
arm_64bit=1
kernel=u-boot.bin
enable_uart=1
device_tree=bcm2837-rpi-3-b.dtb
core_freq=250
device_tree_address=0x200000
```

 - The RPI3 model B has two UARTs. A mini UART and other is PL011 UART. The early boot stage of RPI uses mini UART. To enable it, add `enable_uart=1` to the config.txt file. When PL011 is initialized and mini UART is not primary UART then to adjust the baud rate, add `core_freq=250` to the config.txt file.
 - The `arm_64bit=1` tells the firmware to start ARM cores in 64 bit mode.
 - The `kernel=u-boot.bin` loads u-boot.bin in the place of actual Linux kernel.
 - The device tree binary `bcm2837-rpi-3-b.dtb` can be found in the u-boot directory post compilation.
 - `device_tree_address=0x200000` loads the above dtb file into location `0x200000` into RAM.

## Copy the files to sd card
Format the sd card to fat32 using fdisk and mkfs.vfat.

Copy the following files to SD card.
 - bootcode.bin
 - config.txt
 - start.elf
 - bcm2837-rpi-3-b.dtb
 - u-boot.bin

## Power up the board.
Insert the sd card into RPI sd card slot and power up the board. The logs similar to the following can be observed.
```
Raspberry Pi Bootcode
Read File: config.txt, 211
Read File: start.elf, 2884708 (bytes)
MESS:00:00:02.044731:0: brfs: File read: /mfs/sd/config.txt
MESS:00:00:02.048972:0: brfs: File read: 211 bytes
MESS:00:00:02.063422:0: HDMI:EDID error reading EDID block 0 attempt 0
MESS:00:00:02.069490:0: HDMI:EDID error reading EDID block 0 attempt 1
MESS:00:00:02.075740:0: HDMI:EDID error reading EDID block 0 attempt 2
MESS:00:00:02.081990:0: HDMI:EDID error reading EDID block 0 attempt 3
MESS:00:00:02.088241:0: HDMI:EDID error reading EDID block 0 attempt 4
MESS:00:00:02.094490:0: HDMI:EDID error reading EDID block 0 attempt 5
MESS:00:00:02.100740:0: HDMI:EDID error reading EDID block 0 attempt 6
MESS:00:00:02.106991:0: HDMI:EDID error reading EDID block 0 attempt 7
MESS:00:00:02.113240:0: HDMI:EDID error reading EDID block 0 attempt 8
MESS:00:00:02.119490:0: HDMI:EDID error reading EDID block 0 attempt 9
MESS:00:00:02.125504:0: HDMI:EDID giving up on reading EDID block 0
MESS:00:00:02.130792:0: HDMI:EDID error reading EDID block 0 attempt 0
MESS:00:00:02.137979:0: HDMI:EDID error reading EDID block 0 attempt 1
MESS:00:00:02.144229:0: HDMI:EDID error reading EDID block 0 attempt 2
MESS:00:00:02.150479:0: HDMI:EDID error reading EDID block 0 attempt 3
MESS:00:00:02.156729:0: HDMI:EDID error reading EDID block 0 attempt 4
MESS:00:00:02.162979:0: HDMI:EDID error reading EDID block 0 attempt 5
MESS:00:00:02.169230:0: HDMI:EDID error reading EDID block 0 attempt 6
MESS:00:00:02.175479:0: HDMI:EDID error reading EDID block 0 attempt 7
MESS:00:00:02.181729:0: HDMI:EDID error reading EDID block 0 attempt 8
MESS:00:00:02.187981:0: HDMI:EDID error reading EDID block 0 attempt 9
MESS:00:00:02.193992:0: HDMI:EDID giving up on reading EDID block 0
MESS:00:00:02.212644:0: brfs: File read: /mfs/sd/config.txt
MESS:00:00:02.216899:0: gpioman: gpioman_get_pin_num: pin LEDS_PWR_OK not defined
MESS:00:00:02.421241:0: gpioman: gpioman_get_pin_num: pin DISPLAY_DSI_PORT not defined
MESS:00:00:02.428677:0: gpioman: gpioman_get_pin_num: pin LEDS_PWR_OK not defined
MESS:00:00:02.434696:0: *** Restart logging
MESS:00:00:02.438583:0: brfs: File read: 211 bytes
MESS:00:00:02.443790:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 0
MESS:00:00:02.451108:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 1
MESS:00:00:02.457874:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 2
MESS:00:00:02.464645:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 3
MESS:00:00:02.471416:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 4
MESS:00:00:02.478187:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 5
MESS:00:00:02.484958:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 6
MESS:00:00:02.491728:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 7
MESS:00:00:02.498499:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 8
MESS:00:00:02.505270:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 9
MESS:00:00:02.511804:0: hdmi: HDMI:EDID giving up on reading EDID block 0
MESS:00:00:02.517612:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 0
MESS:00:00:02.525322:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 1
MESS:00:00:02.532092:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 2
MESS:00:00:02.538864:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 3
MESS:00:00:02.545635:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 4
MESS:00:00:02.552405:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 5
MESS:00:00:02.559176:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 6
MESS:00:00:02.565947:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 7
MESS:00:00:02.572717:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 8
MESS:00:00:02.579489:0: hdmi: HDMI:EDID error reading EDID block 0 attempt 9
MESS:00:00:02.586023:0: hdmi: HDMI:EDID giving up on reading EDID block 0
MESS:00:00:02.591810:0: hdmi: HDMI:hdmi_get_state is deprecated, use hdmi_get_display_state instead
MESS:00:00:02.600302:0: hdmi: HDMI:hdmi_get_state is deprecated, use hdmi_get_display_state instead
MESS:00:00:02.617808:0: brfs: File read: /mfs/sd/bcm2837-rpi-3-b.dtb
MESS:00:00:02.622471:0: Loading 'bcm2837-rpi-3-b.dtb' to 0x100 size 0x3750
MESS:00:00:02.742218:0: brfs: File read: 14160 bytes
MESS:00:00:02.746152:0: brfs: File read: /mfs/sd/config.txt
MESS:00:00:02.757671:0: dterror: No symbols found
MESS:00:00:02.760689:0: brfs: File read: 211 bytes
MESS:00:00:02.765308:0: Failed to open command line file 'cmdline.txt'
MESS:00:00:02.784867:0: dterror: No symbols found
MESS:00:00:02.794447:0: dterror: No symbols found
MESS:00:00:02.804082:0: dterror: No symbols found
MESS:00:00:04.575019:0: dterror: No symbols found
MESS:00:00:04.679646:0: dterror: No symbols found
MESS:00:00:04.696113:0: dterror: No symbols found
MESS:00:00:04.705732:0: gpioman: gpioman_get_pin_num: pin EMMC_ENABLE not defined
MESS:00:00:04.776061:0: brfs: File read: /mfs/sd/u-boot.bin
MESS:00:00:04.780021:0: Loading 'u-boot.bin' to 0x80000 size 0x7d5e8
MESS:00:00:04.786193:0: Device tree loaded to 0x7fec400 (size 0x3b3d)
MESS:00:00:04.793584:0: uart: Set PL011 baud rate to 103448.300000 Hz
MESS:00:00:04.800057:0: uart: Baud rate change done...
MESS:00:00:04.803486:0: uart: Baud rate

U-Boot 2020.04-rc4-00061-ge0718b3ab7 (Apr 05 2020 - 11:10:28 +0530)

DRAM:  128 MiB
RPI 3 Model B (0xa02082)
MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
Loading Environment from FAT... *** Warning - bad CRC, using default environment

In:    serial
Out:   vidconsole
Err:   vidconsole
Net:   No ethernet found.
starting USB...
Bus usb@7e980000: scanning bus usb@7e980000 for devices... 3 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Hit any key to stop autoboot:  0
U-Boot>
U-Boot>
```
By default `u-boot.bin` load at address `0x80000`. This can be changed with `kernel_address` parameter in the config.txt.
## Enable tftp communication with host system

Connect RPI to host system using Ethernet cable. Make sure [tftp server](/linux/install-tftpserver.html) is running on host system. In the RPI U-Boot console, set the `ipaddr` and `serverip` environment variables using following commands

```bash
setenv ipaddr 192.168.1.5
setenv serverip 192.168.1.15 # IP address of host system ethernet interface
```
Copy some small *file* into *tftpboot* directory and check the connection with the following command.
```bash
tftp 0x1000000 file_name
```
Make sure the file is transferred successfully.

## Useful commands
### sdcard related commands
```
U-Boot> mmc
mmc - MMC sub system

Usage:
mmc info - display info of the current MMC device
mmc read addr blk# cnt
mmc write addr blk# cnt
mmc erase blk# cnt
mmc rescan
mmc part - lists available partition on current mmc device
mmc dev [dev] [part] - show or set current mmc device [partition]
mmc list - lists available devices
mmc hwpartition [args...] - does hardware partitioning
  arguments (sizes in 512-byte blocks):
    [user [enh start cnt] [wrrel {on|off}]] - sets user data area attributes
    [gp1|gp2|gp3|gp4 cnt [enh] [wrrel {on|off}]] - general purpose partition
    [check|set|complete] - mode, complete set partitioning completed
  WARNING: Partitioning is a write-once setting once it is set to complete.
  Power cycling is required to initialize partitions after set to complete.
mmc setdsr <value> - set DSR register value
```

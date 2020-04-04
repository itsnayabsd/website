---
layout : post
---
Bootloader
 - Initialized basic hardware
 - Load kernel from non volatile storage or network (through tptp).
 - ex: Grub, syslinux

Generic Embedded Devices Boot sequence
 - The on chip ROM has boot code which will be executed on power up.
 - The boot code loads the primary or first stage bootloader into SRAM. The first stage bootloader is stored generally on non volatile memory like NAND flash. The first stage bootloader generally provided by the CPU vendor. U-Boot SPL is first stage bootloader. File name MLO.
 - The first stage bootloader initializes the hardware, DRAM and loads second stage bootloader into RAM. U-boot is second stage bootloader.
 - The second stage bootloader initializes hardware, loads kernel into RAM and starts it.
 - Kernel runs from RAM.

The U-Boot
```
git clone git://git.denx.de/u-boot.git
```
`configs` directory contains configuration file for the boards.

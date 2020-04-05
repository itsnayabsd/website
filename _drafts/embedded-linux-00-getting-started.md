---
layout : post
---
While choosing the hardware make sure there is Linux and open source boot loader support for SoC.

Embedded Linux development involves
 - Board support package development - Kernel, boot loader and device drivers development.
 - System integration - Kernel, boot loader, system libraries and apps.

Embedded Linux Components
 - Binutils - as, ld, ar, ranlib, objdump, readelf, size, nm, strings, objcopy and strip. Official page : [http://www.gnu.org/software/binutils/](http://www.gnu.org/software/binutils/).
 - Kernel headers - Can be extracted from kernel sources using `make headers_install` target.
 - C/C++ libraries - Several C libraries available. glibc, uClibc, musl, klibc, newlib ...
 - C/C++ compiler - GCC : GNU compiler collection.
 - GDB debugger 

Toolchain building utilities
 - Crosstool-ng - Dedicated to generate toolchain.
 - Buildroot - Root filesystem buildsystem. Can build glibc, uClibc and musl based toolchains.
 - OpenEmbedded - Root filesystem build system. Also used to generate toolchain. Complicated but featureful.

Generating cross toolchain using crosstool-ng for uClibc C library

Downloading and installing crosstool-ng

```bash
sudo rm -rf ~/x-tools/
git clone https://github.com/crosstool-ng/crosstool-ng.git
cd crosstool-ng/
#git checkout eb65ba65       # Tested until this commit id. Newer commit ids need to be checked later.
git checkout 75d7525a
```
```
./bootstrap
./configure --enable-local
make
```
Above will install crosstool-ng locally.

Configure the toolchain to generate
`./ct-ng list-samples` comes with pre defined configurations for different setups (architecture, library).

## Generate toolchain for rpi3 model b
Raspberry Pi 3 model b has BCM2837 chip. This chip has four ARM cortex A53 cores of ARMv8 architecture.

Let's generate toolchain (64bit) for ARMv8 architecture and uClibc library. `ct-ng` has pre defined configuration for rpi3.
```
./ct-ng aarch64-rpi3-linux-gnu
```
But above configuration is for `glibc`. Let's change the configuration.
```
./ct-ng menuconfig
```
 - In `Paths and misc options`, change *Maximum log level to see* to DEBUG.
 - In `Toolchain options`
   - Set *Tuple's alias* to *arm-linux-rpi3*. This generates names such as *arm-linux-rpi3-gcc* etc.
 - In `C library`, change *C library* to uClibc.
 - In `Debug facilites`, disable everything.

Build toolchain
```bash
./ct-ng build
```

## Generate toolchain for cortex a5 and uClibc library
Let's generate configuration to compile toolchain for arm cortex a5 and uClibc library.

```bash
./ct-ng arm-cortexa5-linux-uclibcgnueabihf
```
Challenge : What to do to generate configuration for arm cortex a8 and uClibc?

Modify configuration
```bash
./ct-ng menuconfig
```
 - In `Paths and misc options`, change *Maximum log level to see* to DEBUG.
 - In `Toolchain options`
   - Set *Tuple's vendor* to *training*
   - Set *Tuple's alias* to *arm-linux*. This generates names such as *arm-linux-gcc* etc.
 - In `C library`, enabel IPV6 support
 - In `Debug facilites`, disable everything.

Build toolchain
```bash
./ct-ng build
```
If the above step failed at some package downloading, download the package manually from the internet and copy to `~/src` directory and use the above step again.

Resolve any patch apply conflicts happening.

Now the toolchain is installed in `~/x-tools` directory. Add this *$HOME/x-tools/arm-training-linux-uclibcgnueabihf/bin/* to PATH env varibale in .bashrc so that it can be detected.

Test the toolchain

```
arm-linux-gcc hello.c && file a.out
```

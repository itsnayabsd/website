
layout : post
---
## Install necessary packages for development
```bash
sudo apt install build-essential libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc zip
```
## Download the OpenWRT build system
```bash
cd ~/rpi3/
git clone https://github.com/openwrt/openwrt.git
git checkout 5667ccbf1662a1a9f510637ed3a6718f3350a873
```

### The directories explanation
 - /config : This directory contains configuration files required for menuconfig
 - /include : Contains Makefile configuration files
 - /package : Feeds packages makefile and configuration files
 - /scripts : Various scripts used in the build process
 - /target : Makefile and configuration files for building imagebuilder, kernel, sdk and the toolchain.
 - /toolchain : Toolchain Makefile and configuration files
 - /tools : Various tools used in the build process


## Package feeds

Package feeds are source repositories being maintained somewhere on the web. Each package feed can have more than one packages.

### Useful package feeds commands
All of the following commands parses either the *feeds.conf* file or *feeds.conf.default* file for the package feeds information.

 - To know list of feed names and their respective repository URLs on the web
```bash
cd ~/rpi3/openwrt
./scripts/feeds list -s
```
 - To know list of packages in a particular feed -
```bash
./scripts/feeds list -r <feed name>
```
Ex: *./scripts/feeds list -r luci*. You might encounter an error similar to the following.
```
Ignoring feed 'luci' - index missing
```
If you face the above error, that means the feeds are not updated with the respective packges.

 - To update the all the feeds with *feeds.conf* or *feeds.conf.default* -
```bash
./scripts/feeds update -a
```
The feeds and respective packages Makefiles and patches are stored in *feeds* directory. At this point the *staging_dir* and *tmp* folders are created. The *tmp* folder consists of kernel config files and the *tmp/info* directory consists of the packages information.

 - To prepare all the packages and it's dependencies for compilation
```bash
./scripts/feeds install -a
```
The above command creates `package/feeds` directory and installs all the feeds in this directory. Any package of particular feed can be compiled only if the package feed is present in *package/feeds/* directory. The above command does that.

Local feed also can be created with `src-link`. ex: src-link my_packages /home/$username/src/openwrt/my_packages
### Check prerequisites
```bash
make prereq # Some warning are being generated. Need to see if some libraries need to be installed.
```
When prompted, select *Target System (Broadcom BCM27XX)*, *Subtarget (BCM2710 boards (64 bits))* and *Target Profile (Raspberry Pi 2B-1.2/3B/3B+/3CM)*.

## Select packages
Run the following command to select/unselect the packages and save the *.config* file.
```bash
make menuconfig
```

## Compile a single package
To compile a single package, we need to install necessary tools and toolchain first.
```
make -j4 V=s tools/install
make -j4 V=s toolchain/install
make target/compile
```
<!--
make menuconfig -> check nano and libncurses
make tools/install
make toolchain/install
make target/compile
make package/ncurses/compile
make package/ncurses/install
make package/feeds/packages/nano/compile
make package/feeds/packages/nano/install
make package/index
-->
## Building packages
Let's build toolchain first.
```bash
make V=s -j4 toolchain/download		# Download the toolchain source
make V=s -j4 toolchain/compile		# Compile the toolchain
make V=s -j4 toolchain/install		# Install toolchain in staging_dir/
```
Let's try to compile a random package - ZeroMQ library
```bash
make V=s -j4 package/feeds/packages/zmq/download	# Download ZeroMQ source
make V=s -j4 package/feeds/packages/zmq/compile		# Compile Zero MQ source
```
### Download all packages source files
## change the kernel version
Supported versions can be found from `include/kernel-version.mk` file.


Let's change it to 4.19.

Main folders
```
target/linux/generic/
target/linux/bcm27xx/
```
 - Change KERNEL_PATCHVER to 4.19 in the file target/linux/bcm27xx/Makefile.
 - Copy config file from `generic` folder to `bcm27xx/bcm2710` folder. `cp target/linux/generic/config-4.19 target/linux/bcm27xx/bcm2710/`
 - make download V=s will download kernel

## Download packages
To download all the packages enabled in *.config* file -
```bash
make download V=s
```
All downloaded files are stored in *dl* directory.

## Build the system
```bash
make -j4
```
The above command will compile the toolchain first using system resources and then use that toolchain to compile OpenWRT packages.

Images directory :

The images compiled are present in `bin/targets/bcm27xx/bcm2710/` for Raspberry Pi Model B.

The `*factory.img` files are to flash for the first time. To update exiting openwrt images, use `*sysupgrade.img` files


To compile single package :

ex: `make package/utils/nvram/compile`


To recompile the package :

ex: `make package/utils/nvram/{clean,compile,install}`


To clean the repo
```
make clean
```
The above command only removes the contents of `/bin` and `/build_dir` folders.


`make dirclean` will delete the contents of `/bin`, `/build_dir`, `/staging_dir`, `/toolchain`, `/tmp/` and `/logs`.

`make distclean` will reset to the state when you freshly cloned the repo.


Creating `files` folder in the repo root directory. Add some files to this directory. Compile using `make -n4`. The final image when we flash into RPI, will have the same files into root diretory. Ex: <repo>/files/etc/config/my_config => /etc/config/my_config in the image.

## Important directories
```
target/linux/<arch>/base-files
target/linux/<arch>/image
target/linux/<arch>/<board>
target/linux/<arch>/dts
target/linux/<arch>/modules.mk
```


---
layout : post
---
## Install necessary packages for development
```bash
sudo apt install subversion build-essential libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc zip
```
## Download the OpenWRT build system
```bash
git clone https://git.openwrt.org/openwrt/openwrt.git
```

Check prerequisites
```bash
make prereq # Some warning are being generated. Need to see if some libraries need to be installed.
```

When prompted, select *Target System (Broadcom BCM27XX)*, *Subtarget (BCM2710 boards (64 bits))* and *Target Profile (Raspberry Pi 2B-1.2/3B/3B+/3CM)*.

## Package feeds

Package feeds are source repositories being maintained somewhere on the web. Each package feed can have more than one packages.

### Useful package feeds commands
All of the following commands parses either the *feeds.conf* file or *feeds.conf.default* file for the package feeds information.

 - To know list of feed names and their respective repository URLs on the web
```bash
cd ~/openwrt
./scripts/feeds list -s
```
 - To know list of packages in a particular feed -
```bash
./scripts/feeds list -r <feed name>
```
Ex: *./scripts/feeds list -r luci*.

You might encounter an error similar to the following.
```
Ignoring feed 'luci' - index missing
```

If you face the above error, that means the feeds are not updated with the respective packges.

 - To update the all the feeds with *feeds.conf* or *feeds.conf.default* -
```bash
./scripts/feeds update -a
```
The feeds and respective packages Makefiles and patches are stored in *feeds* directory. At this point the *staging_dir* and *tmp* folders are created. The *tmp* folder consists of kernel config files and the *tmp/info* directory consists of the packages information.

___
Make all the packages available for `make menuconfig` by running the following command.
```
./scripts/feeds install -a		# all or single with ./scripts/feeds install <PACKAGE_NAME>
```

Local feed also can be created with `src-link`. ex: src-link my_packages /home/$username/src/openwrt/my_packages


```
make defconfig
```

To create and change configuration - 
```
make menuconfig
```
Select the target system, sub target system, target profile


Download files
```
make download V=s
```
Above command downloads the config files, Makefiles and patches for tools (m4, libtool, autoconf ...), toolchain, packages (libs, firmware, kernel etc.).
The above command creates `staging_dir/toolchain*`, `staging_dir/target*`, `dl` and then downloads tar files into `dl` directory. And created `build_dir` also.
```
 make[1] tools/flock/compile
 make[2] -C tools/flock compile
 make[1] tools/download
 make[2] -C tools/gmp download
 make[2] -C tools/mpfr download
 make[2] -C tools/mpc download
 make[2] -C tools/libelf download
 make[2] -C tools/expat download
 make[2] -C tools/m4 download
 make[2] -C tools/libtool download
 make[2] -C tools/autoconf download
 make[2] -C tools/automake download
 make[2] -C tools/flex download
 make[2] -C tools/bison download
 make[2] -C tools/pkgconf download
 make[2] -C tools/mklibs download
 make[2] -C tools/zlib download
 make[2] -C tools/sstrip download
 make[2] -C tools/make-ext4fs download
 make[2] -C tools/e2fsprogs download
 make[2] -C tools/mtd-utils download
 make[2] -C tools/mkimage download
 make[2] -C tools/firmware-utils download
 make[2] -C tools/patch-image download
 make[2] -C tools/quilt download
 make[2] -C tools/padjffs2 download
 make[2] -C tools/mm-macros download
 make[2] -C tools/missing-macros download
 make[2] -C tools/cmake download
 make[2] -C tools/bc download
 make[2] -C tools/findutils download
 make[2] -C tools/gengetopt download
 make[2] -C tools/patchelf download
 make[2] -C tools/mtools download
 make[2] -C tools/dosfstools download
 make[2] -C tools/libressl download
 make[2] -C tools/lzma download
 make[2] -C tools/squashfskit4 download
 make[2] -C tools/zip download
 make[2] -C tools/tar download
 make[2] -C tools/xz download
 make[2] -C tools/patch download
 make[2] -C tools/flock download
 make[2] -C tools/sed download
 make[1] toolchain/download
 make[2] -C toolchain/gdb download
 make[2] -C toolchain/kernel-headers download
 make[2] -C toolchain/binutils download
 make[2] -C toolchain/gcc/initial download
 make[2] -C toolchain/gcc/final download
 make[2] -C toolchain/musl download
 make[2] -C toolchain/fortify-headers download
 make[1] package/download
 make[2] -C package/base-files download
 make[2] -C package/firmware/cypress-firmware download
 make[2] -C package/firmware/cypress-nvram download
 make[2] -C package/firmware/linux-firmware download
 make[2] -C package/firmware/wireless-regdb download
 make[2] -C package/kernel/bcm27xx-gpu-fw download
 make[2] -C package/kernel/linux download
 make[2] -C package/kernel/mac80211 download
 make[2] -C package/libs/libjson-c download
 make[2] -C package/libs/libnl-tiny download
 make[2] -C package/libs/libubox download
 make[2] -C package/libs/toolchain download
 make[2] -C package/libs/uclient download
 make[2] -C package/network/config/firewall download
 make[2] -C package/network/config/netifd download
 make[2] -C package/network/ipv6/odhcp6c download
 make[2] -C package/network/services/dnsmasq download
 make[2] -C package/network/services/dropbear download
 make[2] -C package/network/services/hostapd download
 make[2] -C package/network/services/odhcpd download
 make[2] -C package/network/services/ppp download
 make[2] -C package/network/utils/iptables download
 make[2] -C package/network/utils/iw download
 make[2] -C package/network/utils/iwinfo download
 make[2] -C package/system/fstools download
 make[2] -C package/system/fwtool download
 make[2] -C package/system/mtd download
 make[2] -C package/system/openwrt-keyring download
 make[2] -C package/system/opkg download
 make[2] -C package/system/procd download
 make[2] -C package/system/ubox download
 make[2] -C package/system/ubus download
 make[2] -C package/system/uci download
 make[2] -C package/system/urandom-seed download
 make[2] -C package/system/urngd download
 make[2] -C package/system/usign download
 make[2] -C package/utils/bcm27xx-userland download
 make[2] -C package/utils/busybox download
 make[2] -C package/utils/e2fsprogs download
 make[2] -C package/utils/f2fs-tools download
 make[2] -C package/utils/jsonfilter download
 make[2] -C package/utils/util-linux download
 make[1] target/download
 make[2] -C target/linux download
```


Build the system:
```
make
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

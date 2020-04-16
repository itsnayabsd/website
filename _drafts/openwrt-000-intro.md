---
layout : post
---
sudo apt install subversion build-essential libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc zip

git clone https://git.openwrt.org/openwrt/openwrt.git

Check prerequisites
make prereq # Some warning are being generated. Need to see if some libraries need to be installed.

OpenWRT tree when cloned.
```
.
├── BSDmakefile
├── config
├── Config.in
├── feeds.conf.default
├── include
├── LICENSE
├── Makefile
├── package
├── README
├── rules.mk
├── scripts
├── target
├── toolchain
└── tools
```

```
4.0K	BSDmakefile
64K	config
4.0K	Config.in
4.0K	feeds.conf.default
372K	include
20K	LICENSE
4.0K	Makefile
19M	package
4.0K	README
16K	rules.mk
1.2M	scripts
62M	target
1.1M	toolchain
3.1M	tools
```

Update feeds from other places. Either from a different URL or different path. Refers `feeds.conf.default` to update the feeds.

./scripts/feeds update -a

New folders will be created. `staging_dir`, `feeds` by using above command. `feeds` folder will be updated with the Makefiles, Config files, scripts and patches for the packages. `staging_dir` is created with symbolic links to host binutils.
```
$ ls feeds/packages/net/bridge-utils/
Makefile  patches
```


```
4.0K	BSDmakefile
64K	config
4.0K	Config.in
137M	feeds
4.0K	feeds.conf.default
372K	include
20K	LICENSE
4.0K	Makefile
19M	package
4.0K	README
16K	rules.mk
1.2M	scripts
40K	staging_dir
62M	target
24K	tmp
1.1M	toolchain
3.1M	tools
```
```
$ du -sh feeds/packages/*
456K	feeds/packages/admin
12K	feeds/packages/CONTRIBUTING.md
376K	feeds/packages/devel
12K	feeds/packages/fonts
72K	feeds/packages/ipv6
72K	feeds/packages/kernel
3.5M	feeds/packages/lang
4.2M	feeds/packages/libs
20K	feeds/packages/LICENSE
488K	feeds/packages/mail
760K	feeds/packages/multimedia
12M	feeds/packages/net
4.0K	feeds/packages/README.md
4.3M	feeds/packages/sound
5.0M	feeds/packages/utils
```
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

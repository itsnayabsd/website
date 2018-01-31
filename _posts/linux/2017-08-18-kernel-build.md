---
date: 2017-08-18 14:06:21 +5:30
layout: post
category: linux
title: Linux kernel build and install steps
excerpt: Steps to download, compile, build linux kernel and it's modules in a linux based operating system
comments: false
google_adsense: false
---
```bash
git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
cd linux
sudo make clean
sudo make mrproper
sudo make localmodconfig
sudo make
sudo make modules
sudo make modules_install
sudo make install
sudo vi /etc/default/grub
# Comment the line GRUB_HIDDEN_TIMEOUT_QUIET=true
# Comment the line GRUB_HIDDEN_TIMEOUT=0
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

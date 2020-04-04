#!/bin/sh

# Latest packages update
sudo apt update
sudo apt -y dist-upgrade

sudo apt install git gitk git-email cscope libssl-dev bison flex gcc-arm-linux-gnueabi picocom gcc-arm-linux-gnueabi nfs-kernel-server build-essential autoconf texinfo help2man gawk libtool-bin libncurses5-dev device-tree-compiler

git config --global user.name "Nayab Basha Sayed"
git config --global user.email "basha@nayab.xyz"

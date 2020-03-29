#!/bin/sh

# Latest packages update
sudo apt update
sudo apt -y dist-upgrade

sudo apt install git gitk git-email cscope libssl-dev bison flex gcc-arm-linux-gnueabi picocom gcc-arm-linux-gnueabi nfs-kernel-server

git config --global user.name "Nayab Basha Sayed"
git config --global user.email "basha@nayab.xyz"

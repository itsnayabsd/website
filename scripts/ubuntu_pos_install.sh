#!/bin/sh

# Latest packages update
sudo apt update
sudo apt -y dist-upgrade

sudo apt install git gitk git-email cscope

git config --global user.name "Nayab Basha Sayed"
git config --global user.email "basha@nayab.xyz"

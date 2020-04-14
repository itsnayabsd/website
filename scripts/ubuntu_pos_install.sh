#!/bin/bash

# Latest packages update
sudo apt update
sudo apt -y dist-upgrade

sudo apt install -y vim gnome-shell-extensions gnome-tweaks git gitk git-email ruby-full cscope libssl-dev bison flex gcc-arm-linux-gnueabi picocom gcc-arm-linux-gnueabi nfs-kernel-server build-essential autoconf texinfo help2man gawk libtool-bin libncurses5-dev device-tree-compiler zlib1g-dev locate

git config --global user.name "Nayab Basha Sayed"
git config --global user.email "basha@nayab.xyz"

echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
echo "export EDITOR=vim" >> ~/.bashrc
echo "alias vi='vim'" >> ~/.bashrc
echo "alias xo='xdg-open '" >> ~/.bashrc
echo "alias gitc='git commit -s '" >> ~/.bashrc

gem install jekyll bundler

echo "sudo updatedb might take a while"
sudo updatedb

#!/bin/sh

## Run this script after installing elementary OS
## Run with the following command
## source elementary_post_install.sh

cd
# Key bindings
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']"

# Third party repositories
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub \
| sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' \
| sudo tee /etc/apt/sources.list.d/google-chrome.list

# Latest packages update
sudo apt update
sudo apt -y dist-upgrade

# Package installations
sudo apt -y purge vim
sudo apt -y install vim git google-chrome-stable software-properties-common \
ruby-full openssh-server build-essential device-tree-compiler libz-dev \
autoconf flex byacc bison sharutils libtool libssl-dev libncurses5-dev \
libncursesw5-dev cmake

# Install gem packages
sudo gem install bundler

#Updating gem packages
sudo gem update --system

# Miscellaneous
sudo rm -r /bin/sh
sudo ln -s /bin/bash /bin/sh

## Cloning repositories
#Personal website
git clone https://github.com/nayabbashasayed/website.git
cd ~/website
bundle install
git config user.email "nayabbashasyed@gmail.com"
git config user.name "Nayab Basha Sayed"

## For office
# Zeromq
wget -c https://github.com/zeromq/libzmq/releases/download/v4.2.5/zeromq-4.2.5.tar.gz
tar xvf zeromq-4.2.5.tar.gz
cd zeromq-4.2.5
./configure --enable-drafts=yes
make
sudo make install

# Drivers
cd
git clone https://github.com/nayabbashasayed/rtl8723de.git
cd rtl8723de
make
sudo make install
sudo modprobe -v 8723de

# Modifying and adding ethernet connections
nmcli connection modify "Wired connection 1" connection.id ethvvdn
nmcli connection add con-name 0domain ifname `ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}'` type ethernet ip4 192.168.0.15/24
nmcli connection add con-name 1domain ifname `ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}'` type ethernet ip4 192.168.1.15/24

# INstalling skype
wget -c https://repo.skype.com/latest/skypeforlinux-64.deb
sudo dpkg -i skypeforlinux-64.deb
sudo apt -y install -f

# Installing zoom
wget -c https://d11yldzmag5yn.cloudfront.net/prod/2.3.128305.0716/zoom_amd64.deb
sudo dpkg -i zoom_amd64.deb
sudo apt -y install -f

# Cleaning software packages
sudo apt -y autoremove
sudo apt -y autoclean


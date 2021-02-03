#!/bin/bash

# Latest packages update
sudo apt update
sudo apt -y dist-upgrade

sudo apt install -y vim cscope libssl-dev bison flex picocom nfs-kernel-server build-essential autoconf texinfo help2man gawk libtool-bin libncurses5-dev device-tree-compiler zlib1g-dev locate python python3-distutils python3-dev ccache gettext libapr1 libaprutil1 libcroco3 libserf-1-1 libsvn1 libutf8proc2 xsltproc tree flatpak libelf-dev ecj fastjar java-propose-classpath libncursesw5-dev libgconf2-dev libcanberra-gtk-module libcanberra-gtk3-module net-tools openvpn dialog python3-pip python3-setuptools universal-ctags squashfs-tools tftp openssh-server curl libreadline-dev akregator

git config --global user.name "Nayab Basha Sayed"
git config --global user.email "basha@nayab.xyz"

echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
---------------------
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.bashrc
source ~/.bashrc
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
rbenv init
eval "$(rbenv init -)"
source ~/.bashrc
rbenv install 2.5.1
gem install bundler -v 1.17.3
gem install jekyll
bundler install
---------------------
echo "export EDITOR=vim" >> ~/.bashrc
echo "alias vi='vim'" >> ~/.bashrc
echo "alias xo='xdg-open '" >> ~/.bashrc
echo "alias gitc='git commit -s '" >> ~/.bashrc

gem install jekyll
gem install bundler -v 1.17.3

sudo pip3 install protonvpn-cli

flatpak install flathub org.gpodder.gpodder

echo "Install ruby manually from https://github.com/rbenv/rbenv-installer"
echo "sudo updatedb might take a while"
sudo updatedb

# System configuration
## Changing hostname
hostnamectl set-hostname linux

# Installing tools
## Installing git
sudo dnf -y install git-all
## Google chrome
cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
sudo dnf -y install google-chrome-stable
## Vim full version
sudo dnf -y remove vim-*
sudo dnf -y install vim
## Cscope and ctags
sudo dnf -y install ctags cscope
## Bookworm reader
flatpak install flathub com.github.babluboy.bookworm

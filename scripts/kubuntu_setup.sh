#!/bin/bash

print_availble_commands() {
	echo "Usage: kubuntu_setup.sh <command>"
	echo "Available commands :"
	echo "	dist_upgrade		- Execute 'apt update' and 'apt dist-upgrade' commands"
	echo "	install_brave	- Install Brave browser"
	echo "	blog_configure	- Clone Blog from Github and configure the system to run blog"
	echo "	cascadia_font	- Procedure to download and install Cascadia fonts"
}

cascadia_font() {
	echo "Download Cascade Code fonts from https://github.com/microsoft/cascadia-code/releases"
	echo "Install the fonts using 'font management' tool in Kubuntu"
}

dist_upgrade() {
	sudo apt update
	sudo apt -y dist-upgrade
}

install_brave() {
	sudo apt install -y vim apt-transport-https curl
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt update
	sudo apt -y install brave-browser
}

blog_configure() {
	echo "Cloning Blog Repository from GitHub ......"
	
	cd && git clone git@github.com:nayabbashasayed/blog.git Blog
	
	if [ $? -ne 0 ]; then
		echo "Git clone blog failed"
		exit
	else
		echo "Git clone Blog success"
	fi
}

case $1 in
	( dist_upgrade )
		dist_upgrade
		;;
	( install_brave )
		install_brave
		;;
	( blog_configure )
		blog_configure
		;;
	( cascadia_font )
		print_availble_commands
		;;
	( * )
		print_availble_commands
		;;
esac

#misc_operations

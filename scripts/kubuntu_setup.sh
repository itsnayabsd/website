#!/bin/bash

print_availble_commands() {
	echo "Usage: kubuntu_setup.sh <command>"
	echo "Available commands :"
	echo "	dist_upgrade	- Execute 'apt update' and 'apt dist-upgrade' commands"
	echo "	install_brave	- Install Brave browser"
	echo "	blog_configure	- Clone Blog from Github and configure the system to run blog"
	echo "	cascadia_font	- Procedure to download and install Cascadia fonts"
	echo "	install_dev	- Install developer packages including compiler, IDE etc."
	echo "	android_tools	- Procedure to download command line only android tools"
	echo "	popcornTime	- Download popcorn time"
	echo "	jekyll_start	- Start Jekyll server when user login to Kubuntu"
	echo "	print_misc	- Other misc packages downloads"
}

print_misc() {
	echo "Download OpenAudible from https://openaudible.org/"
}

jekyll_start() {
	echo '#!/bin/bash' >> ~/.config/autostart-scripts/jekyll-start
	echo '' >> ~/.config/autostart-scripts/jekyll-start
	echo 'export GEM_HOME="$HOME/gems"' >> ~/.config/autostart-scripts/jekyll-start
	echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.config/autostart-scripts/jekyll-start
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.config/autostart-scripts/jekyll-start
	echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.config/autostart-scripts/jekyll-start
	echo 'cd /home/nayab/Blog && killall -9 bundle; bundle exec jekyll serve --host=0.0.0.0 -B' >> ~/.config/autostart-scripts/jekyll-start
}

popcornTime() {
	echo "	Download from https://github.com/popcorn-time-ru/popcorn-desktop/releases"
}
android_tools() {
	sudo apt update
	sudo apt -y install default-jdk
	echo "alias sdkmanager='sdkmanager --sdk_root=/opt/cmdline-tools/'" >> ~/.bashrc
	source ~/.bashrc
	echo "Download command tools only from https://developer.android.com/studio#downloads"
	echo "Unzip and copy the folder in /opt/ directory"
	echo "Create link using 'sudo ln -s /opt/cmdline-tools/bin/sdkmanager /usr/sbin'"
	echo "Use sdkmanager command to download additional android tools"
	echo "Use command 'sdkmanager --install platform-tools' to install adb tool"
	echo "sudo ln -s /opt/cmdline-tools/platform-tools/adb /usr/sbin/"
}

install_dev() {
	sudo apt update
	sudo apt install -y cscope universal-ctags build-essential libssl-dev libreadline-dev zlib1g-dev network-manager-openvpn openssh-server youtube-dl libgconf-2-4 ktorrent gimp
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
	install_dev
	cd $HOME/Blog || exit
	echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
	echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
	echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc

	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
	echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.bashrc
	curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
	source ~/.bashrc
	rbenv init
	echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
	eval "$(rbenv init -)"
	source ~/.bashrc
	rbenv install 2.5.1
	gem install bundler -v 1.17.3
	gem install jekyll
	bundler install
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
		cascadia_font
		;;
	( install_dev )
		install_dev
		;;
	( android_tools )
		android_tools
		;;
	( popcornTime )
		popcornTime
		;;
	( jekyll_start )
		jekyll_start
		;;
	( print_misc )
		print_misc
		;;
	( * )
		print_availble_commands
		;;
esac

#misc_operations

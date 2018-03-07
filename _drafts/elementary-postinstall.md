---
layout: post
title: Elementary OS Post Installtion
excerpt: Some tweaks, software installations required after installing Elementary OS
category: linux
comments: false
google_adsense: false
---
* First step is to update all repositories
{% highlight bash %}
$ sudo apt-get update
{% endhighlight %}

* Click on `App Center`, Check for updates and install it.

* Change terminal transparent background  
For this we need to install <code>dconf-editor</code> package
{% highlight bash %}
$ sudo apt install dconf-editor
{% endhighlight %}
Then go to org -> pantheon -> teminal, there settings can be found to change terminal default configurations  
To change terminal `font-size`, go to org -> gnome -> desktop -> interface -> monospace-font-name.  

*  Update vim package
{% highlight bash %}
$ sudo apt install vim
{% endhighlight %}

* Install dependencies for adding PPAs

```bash
$ sudo apt-get install software-properties-common python-software-properties
```

* Install `Python-pip`

```bash
$ sudo apt install python-pip
```

* Install `psutil`. Required for `Terminator`.

```bash
$ sudo pip install --upgrade psutil
```

*  Install openssh-server
{% highlight bash %}
$ sudo apt install openssh-server
{% endhighlight %}

* Install ctags and cscope

```bash
sudo apt install exuberant-ctags cscope lftp
```

* Go to [download](https://nodejs.org/en/download/) page of nodejs, download the source code, install it.

* Install `git` and `chromium-browser`.
{% highlight bash %}
$ sudo apt install git
$ sudo apt install chromium-browser
{% endhighlight %}

* Install `Terminator` terminal emulator.

```bash
$ sudo add-apt-repository ppa:gnome-terminator
$ sudo apt-get update
$ sudo apt-get install terminator
```

* Install `Claws-mail` email client for accounts other than gmail.
{% highlight bash %}
$ sudo apt install claws-mail
$ sudo apt install claws-mail-fancy-plugin
{% endhighlight %}
After installing go to Configuration -> Preferences -> Plugins -> Fancy. Check `Enable Loading of Remote Content`.

* Change default editor in `~/.bashrc`.
{% highlight bash %}
alias vi='vim'
export VISUAL=vim
export EDITOR="$VISUAL"
{% endhighlight %}

* Installing .deb packages:  
Elemetary OS doesn't support double click installation of .deb packages.  
To install .deb packages:  
{% highlight bash %}
$ sudo gdebi package.deb
{% endhighlight %}
Replace `package.deb` with your package.

* Add Keyboard shortcuts for opening browser and email.  
Go to Applications -> Systme tools -> System settings -> Keyboard.  
Under `Shortcuts` tab, `Applications` section,  
Change `Internet Browser` shortcut to <kbd>⌘</kbd> + <kbd>I</kbd>.  
Change `Email` shortcut to <kbd>⌘</kbd> + <kbd>E</kbd>.  
Change `Home Folder` shortcut to <kbd>⌘</kbd> + <kbd>H</kbd>.  
Under `Windows` section,
Change `Unmaximize` shortcut to <kbd>⌘</kbd> + <kbd>↓</kbd>.  
Add custom shortcut <kbd>⌘</kbd> + <kbd>T</kbd> for command `gnome-terminal --hide-menubar`.

* Note: Hold <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>U</kbd> and then press [unicode](http://www.unicode.org/charts/PDF/U2300.pdf) to display special symbols.  
Unicode decimal for <kbd>⌘</kbd> key is 2318.  
Unicode decimal for <kbd>↓</kbd> is 2193.
Unicode decimal for <kbd>₹</kbd> is 20b9.

* Install `gpodder` podcast software.
```bash
sudo apt-get install gpodder
```
* Install [Vimium](https://vimium.github.io/) plugin for Chrome

* Changind `pantheon-terminal` color scheme
```bash
gsettings set org.pantheon.terminal.settings background '#363B3E'
# Or the following
#gsettings set org.pantheon.terminal.settings background  'rgba(37, 46, 50, .95)'
gsettings set org.pantheon.terminal.settings foreground '#FFFFFF'
gsettings set org.pantheon.terminal.settings cursor-color '#FFFAFA'
gsettings set org.pantheon.terminal.settings palette "#232323:#cccc00000000:#5EC200:#E3B900:#34346565a4a4:#757550507b7b:#00B4B8:#d3d3d7d7cfcf:#ADADAD:#efef29292929:#8a8ae2e23434:#FFE515:#49A0FF:#adad7f7fa8a8:#3434e2e2e2e2:#FFFAFA"
gsettings set org.pantheon.terminal.settings follow-last-tab "true"
```
* Change `pantheon-terminal` font size
```
gsettings set org.gnome.desktop.interface monospace-font-name '10'
```

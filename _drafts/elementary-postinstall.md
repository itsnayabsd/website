---
layout: post
title: Elementary OS Post Installtion
excerpt: Some tweaks, software installations required after installing Elementary OS
category: linux
comments: false
google_adsense: false
---
```bash
sudo apt install exuberant-ctags cscope lftp
```

* Go to [download](https://nodejs.org/en/download/) page of nodejs, download the source code, install it.

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

---
layout: post
title: Install Brave/Chrome Browser for Clear Linux
category: linux-tools
comments: true
google_adsense: true
excerpt: Instructions on how to install Chrome browser or Brave browser for Clear Linux operating system.
keywords: chrome for clear linux, brave for clear linux, install chrome for clear linux, install brave for clear linux, command to install chrome in clear linux, command to install brave in clear linux.
date: 2019-05-22 23:41:41 +5:30
image: /assets/img/brave-for-clearlinux.png
---

As of writing this, Intel's Clear Linux is new to Linux desktop OS market. So all the packages might not be available for the OS yet.

Google Chrome and Brave browser are not available in their software repositories and it's hard to find official instructions to install these browsers.

So, I have written below the simplified version of the [official forum thread discussion](https://community.clearlinux.org/t/install-brave-browser/377) about the same topic on how to install Chrome and Brave browsers. Even though [I prefer Brave to Chrome](http://www.nayab.xyz/web/get-brave-browser.html), I have given instructions on how to install both.
 * <a href="#brave-install">Instructions on how to install Brave browser</a>
 * <a href="#chrome-install">Instructions on how to install Chrome browser</a>
 * <a href="#brave-uninstall">Brave browser uninstallation steps</a>
 * <a href="#chrome-uninstall">Chrome browser uninstallation steps</a>

<h2 id="brave-install">Instructions on how to install Brave browser</h2>
Run the following command in a terminal to get the root privileges.
```
sudo su -
```
Get the `dnf` and `rpm` tools
```
swupd bundle-add package-utils
```

Add the Brave repository
```
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ --releasever 31
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
```
Download the Brave browser
```
dnf download brave-keyring brave-browser
```
Install the files without extraction
```
rpm2cpio brave-keyring*.rpm | ( cd /; cpio -idv)
rpm2cpio brave-browser*.rpm | ( cd /; cpio -idv)
```
Remove downloaded files
```
rm -f brave-*.rpm
```
Add the mission menu icon
```
sed -i 's/Icon=brave-browser/Icon=brave/g' /usr/share/applications/brave-browser.desktop 

```
Adjust the fonts
```
f=/etc/environment; s='export FONTCONFIG_PATH=/usr/share/defaults/fonts'; touch $f; if ! grep -q "$s" $f ; then echo $s >> $f; fi
```
Reboot your system
```
reboot
```
![Download Brave Browser](/assets/img/brave-for-clearlinux.png)
<h2 id="chrome-install">Instructions on how to install Chrome browser</h2>
Run the following command in a terminal to get the root privileges.
```
sudo su -
```
Get the `dnf`, `rpm`, `cpio` and `rpm2cpio` tools
```
swupd bundle-add package-utils cpio wget
```
Download the Chrome browser
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
```
Install the files without extraction
```
rpm2cpio google-chrome*.rpm | ( cd /; cpio -idv)
```
Remove downloaded files
```
rm -f google-chrome*.rpm
```
Adjust the fonts
```
f=/etc/environment; s='export FONTCONFIG_PATH=/usr/share/defaults/fonts'; touch $f; if ! grep -q "$s" $f ; then echo $s >> $f; fi
```
Reboot your system
```
reboot
```

<h2 id="brave-uninstall">Brave browser uninstallation steps</h2>
```
sudo -s
```
```
f=brave*; rm -f /etc/cron.daily/$f /usr/bin/$f /usr/share/appdata/$f /usr/share/applications/$f /usr/share/gnome-control-center/default-apps/$f /usr/share/man/man1/$f /etc/pki/rpm-gpg/*brave
```
```
rm -rf /opt/brave.com
```

<h2 id="chrome-uninstall">Chrome browser uninstallation steps</h2>
```
sudo -s
```
```
f=google-chrome*; rm -f /etc/cron.daily/$f /usr/bin/$f /usr/share/appdata/$f /usr/share/applications/$f /usr/share/gnome-control-center/default-apps/$f /usr/share/man/man1/$f
```
```
rm -rf /opt/google
```

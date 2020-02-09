---
layout: post
title: Install Brave/Chrome Browser for Clear Linux
category: linux-tools
comments: true
google_adsense: true
excerpt: Instructions on how to install Chrome browser or Brave browser for Clear Linux operating system.
keywords: chrome for clear linux, brave for clear linux, install chrome for clear linux, install brave for clear linux, command to install chrome in clear linux, command to install brave in clear linux.
date: 2020-02-08 23:41:41 +5:30
image: /assets/img/brave-for-clearlinux.png
toc: true
---
## Introduction
As of writing this, Intel's Clear Linux is new to Linux desktop OS market. So all the packages might not be available for the OS yet.

Google Chrome and Brave browser are not available in their software repositories and it's hard to find official instructions to install these browsers.

So, I have written below the simplified version of the [official forum thread discussion](https://community.clearlinux.org/t/install-brave-browser/377) about the same topic on how to install Chrome and Brave browsers.

## Instructions on how to install Brave browser
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
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
```
Download the Brave browser
```
dnf download brave-browser
```
Install the files without extraction
```
rpm -U --nodeps brave-browser*.rpm
```
Remove downloaded files
```
rm -f brave-*.rpm
```
Fix the font loading issue
```
sed -i 's\/usr/bin/brave-browser-stable\env FONTCONFIG_PATH=/usr/share/defaults/fonts /usr/bin/brave-browser-stable\g' /usr/share/applications/brave-browser.desktop
```
Reboot your system
```
reboot
```
![Download Brave Browser](/assets/img/brave-for-clearlinux.png)
## Instructions on how to install Chrome browser
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
Use only one of following two
rpm -U --nodeps google-chrome*.rpm
rpm2cpio google-chrome*.rpm | ( cd /; cpio -idv)
```
Remove downloaded files
```
rm -f google-chrome*.rpm
```
Adjust the fonts
```
sed -i 's\/usr/bin/google-chrome-stable\env FONTCONFIG_PATH=/usr/share/defaults/fonts /usr/bin/google-chrome-stable\g' /usr/share/applications/google-chrome.desktop
```
Reboot your system
```
reboot
```

## Brave browser uninstallation steps
```
sudo -s
```
```
rpm -e brave-browser
```

## Chrome browser uninstallation steps
```
sudo -s
```
```
rpm -e google-chrome*
```
<!--
root@doclr~ # dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
Unable to detect release version (use '--releasever' to specify release version)
Failed loading plugin: changelog
Adding repo from: https://brave-browser-rpm-release.s3.brave.com/x86_64/


root@doclr~ # rpm -U --nodeps brave-browser*.rpm
warning: brave-browser-1.2.43-1.x86_64.rpm: Header V4 RSA/SHA512 Signature, key ID 82d3dc6c: NOKEY
/var/tmp/rpm-tmp.a0j6Nd: line 612: /etc/default/brave-browser: No such file or directory
/var/tmp/rpm-tmp.a0j6Nd: line 646: service: command not found
/var/tmp/rpm-tmp.a0j6Nd: line 665: /usr/sbin/update-alternatives: No such file or directory

root@doclr~ # rpm -U --nodeps google-chrome*.rpm
warning: google-chrome-stable_current_x86_64.rpm: Header V4 DSA/SHA1 Signature, key ID 7fac5991: NOKEY
/var/tmp/rpm-tmp.xQxDUv: line 612: /etc/default/google-chrome: No such file or directory
/var/tmp/rpm-tmp.xQxDUv: line 615: /etc/default/google-chrome: No such file or directory
warning: %post(google-chrome-stable-80.0.3987.87-1.x86_64) scriptlet failed, exit status 1


-->

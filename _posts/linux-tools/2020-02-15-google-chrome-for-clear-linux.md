---
layout: post
title: Install Google Chrome Browser for Clear Linux
category: linux-tools
comments: true
google_adsense: true
excerpt: Instructions on how to install Chrome browser for Clear Linux operating system.
keywords: chrome for clear linux, install google chrome for clear linux, command to install google chrome in clear linux
date: 2020-02-15 20:56:35 +5:30
image: /assets/img/chrome-for-clearlinux.png
toc: true
---
## Introduction
As of writing this, Intel's Clear Linux is new to Linux desktop OS market. So all the packages might not be available for the OS yet.

Google Chrome is not available in their software repositories and it's hard to find official instructions to install this browser.

So, I have written below the simplified version of the [official forum thread discussion](https://community.clearlinux.org/t/installing-google-chrome-on-clear-linux/1132) about the same topic on how to install Goolge Chrome browser.

{% include image.html url="chrome-for-clearlinux.png" description="Google Chrome Browser for Clear Linux" %}

## Instructions on how to install Chrome browser
Run the following command in a terminal to get the root privileges.
```bash
sudo su -
```
Get the `dnf`, `rpm`, `cpio` and `rpm2cpio` tools
```bash
swupd bundle-add package-utils cpio wget
```
Download the Chrome browser
```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
```
Install the files without extraction
```bash
rpm -U --nodeps google-chrome*.rpm
```
<div class="isa_warning">
<strong>Ignore the following errors</strong><br>
warning: google-chrome-stable_current_x86_64.rpm: Header V4 DSA/SHA1 Signature, key ID 7fac5991: NOKEY<br>
/var/tmp/rpm-tmp.xQxDUv: line 612: /etc/default/google-chrome: No such file or directory<br>
/var/tmp/rpm-tmp.xQxDUv: line 615: /etc/default/google-chrome: No such file or directory<br>
warning: %post(google-chrome-stable-80.0.3987.87-1.x86_64) scriptlet failed, exit status 1<br>
</div>
Remove downloaded files
```bash
rm -f google-chrome*.rpm
```
Adjust the fonts
```bash
sed -i 's\/usr/bin/google-chrome-stable\env FONTCONFIG_PATH=/usr/share/defaults/fonts /usr/bin/google-chrome-stable\g' /usr/share/applications/google-chrome.desktop
```
Reboot your system
```bash
reboot
```

## Chrome browser uninstallation steps
```bash
sudo -s
```
```bash
rpm -e google-chrome-stable
```

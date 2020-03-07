---
layout: post
title: Install Brave Browser for Clear Linux
category: linux-tools
comments: true
google_adsense: true
excerpt: Instructions on how to install Brave browser for Clear Linux operating system.
keywords: Brave for clear linux, install brave for clear linux, command to install brave in clear linux.
date: 2020-02-15 21:18:12 +5:30
image: /assets/img/brave-for-clearlinux.png
toc: true
---
## Introduction
As of writing this, Intel's Clear Linux is new to Linux desktop OS market. So all the packages might not be available for the OS yet.

Brave browser is not available in their software repositories and it's hard to find official instructions to install this browser.

So, I have written below the simplified version of the [official forum thread discussion](https://community.clearlinux.org/t/install-brave-browser/377) about the same topic on how to install Brave browser.

{% include image.html url="brave-for-clearlinux.png" description="Brave browser for Clear Linux" %}

## Instructions on how to install Brave browser
Run the following command in a terminal to get the root privileges.
```bash
sudo su -
```
Get the `dnf` and `rpm` tools
```bash
swupd bundle-add package-utils
```

Add the Brave repository
```bash
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
```
<div class="isa_warning">
<strong>Ignore the following errors</strong><br>
Unable to detect release version (use '--releasever' to specify release version) <br>
Failed loading plugin: changelog<br>
</div>
```bash
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
```
Download the Brave browser
```bash
dnf download brave-browser
```
Install the files without extraction
```bash
rpm -U --nodeps brave-browser*.rpm
```
<div class="isa_warning">
<strong>Ignore the following errors</strong><br>
warning: brave-browser-1.2.43-1.x86_64.rpm: Header V4 RSA/SHA512 Signature, key ID 82d3dc6c: NOKEY<br>
/var/tmp/rpm-tmp.a0j6Nd: line 612: /etc/default/brave-browser: No such file or directory<br>
/var/tmp/rpm-tmp.a0j6Nd: line 646: service: command not found<br>
/var/tmp/rpm-tmp.a0j6Nd: line 665: /usr/sbin/update-alternatives: No such file or directory<br>
</div>
Remove downloaded files
```bash
rm -f brave-*.rpm
```
Fix the font loading issue
```bash
sed -i 's\/usr/bin/brave-browser-stable\env FONTCONFIG_PATH=/usr/share/defaults/fonts /usr/bin/brave-browser-stable\g' /usr/share/applications/brave-browser.desktop
```
Reboot your system
```bash
reboot
```
## Brave browser uninstallation steps
```bash
sudo -s
```
```bash
rpm -e brave-browser
```

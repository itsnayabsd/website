---
title : Remove OEM Bloatware from Android without Root Access
layout : post
category : android
date: 2021-06-03 22:50:32 +5:30
comments : true
google_adsense: true
excerpt : Remove or uninstall android bloatware apps shipped with your new android mobile phone without root access.
keywords : Remove bloatware, uninstall bloatware, Uninstall android bloatware using adb, Uninstall android bloatware without root access using adb tool, Uninstall OEM android apps, uninstalled bloatware from realme phone, Android bloatware remover tool, Stop bloatware on android
image : /assets/img/disable-android-bloatware-apps.png
toc : true
---
## Introduction
There are mobile phones with stock android experience with zero bloatware, mobile phones with custom android OS without bloatware and there are mobile phones that ship with lots of bloatware. These OEM installed applications can't be uninstalled in the traditional way.

This tutorial helps you disable the bloatware shipped by default in your android smartphone. This is tested only on Android 11 operating system.

{% include image.html url="disable-android-bloatware-apps.png" description="Disable Android Bloatware without Root Access" %}
## Prerequisites

 - Ubuntu Linux system
 - And mobile phone running with Android 11 OS

## Enable wireless debugging
#### Enable developer options
Enable developer options by tapping multiple times on *Build number*. You can find Build number here - *Settings -> About phone -> Version -> Build number*
#### Enable wireless debugging
We are going to connect our Ubuntu system wirelessly to our mobile phone. For that we need to enable wireless debugging. To enable it, goto - *Settings -> Additional Settings -> Developer options -> Wireless debugging*.

## Download android adb tool
Download *command line tools only* package from [https://developer.android.com/studio#downloads](https://developer.android.com/studio#downloads]). Unzip and copy the folder to /opt/ direcoty.

Assuming the android command line tools directory is /opt/cmdline-tools/, run the following commands in your Ubuntu terminal.

```bash
sudo apt update
sudo apt -y install default-jdk
echo "alias sdkmanager='sdkmanager --sdk_root=/opt/cmdline-tools/'" >> ~/.bashrc
source ~/.bashrc
sudo ln -s /opt/cmdline-tools/bin/sdkmanager /usr/sbin
# Now use sdkmanager command to download additonal tools including adb
sdkmanager --install platform-tools
sudo ln -s /opt/cmdline-tools/platform-tools/adb /usr/sbin/
```

## Connect mobile phone to Ubuntu system
In the mobile phone, tap on *Settings -> Additional settings -> Wireless debugging -> Pair device with pairing code*.

Note down the IP address along with the port number and the pairing code.

Now run the following commands in your Ubuntu system to connect the mobile using adb.
```bash
adb pair <IP_ADDR>:<PORT> # Example : adb pair 192.168.1.8:46723
```
Enter the pairing code when prompted. You will see message like below.
```
Enter pairing code: 771635
* daemon not running; starting now at tcp:5037
* daemon started successfully
Successfully paired to 192.168.1.8:46723 [guid=adb-VOJFKF69CEQOW8IB-5chL1r]
```
Now note down the IP address & Port displayed on the Wireless debugging page. *Do not tap on Pair device with pairing code*.

Now connect the mobile phone to Ubuntu system wirelessly using the following command.
```bash
adb connect <IP_ADDR>:<PORT>
```
You will see message like - 
```
connected to 192.168.1.8:44491
```
Mobile phone is successfully connected to Ubuntu system wirelessly.

## List installed packages
Run the following command in the Ubuntu system terminal to see the list of all installed packages in your mobile phone.
```bash
adb shell pm list packages
```
From the output you need to figure out the packages you want to disable/disappear for the current mobile user.

## Removing the bloatware apps
The general syntax of the command to remove the app is -
```bash
adb shell pm uninstall -k --user 0 <PACKAGE_NAME>
```
Here are list of applications I have removed from my realme C25 mobile phone running with colorOS.

```bash
adb shell pm uninstall -k --user 0 com.coloros.gamespace
adb shell pm uninstall -k --user 0 com.coloros.gamespaceui
adb shell pm uninstall -k --user 0 com.heytap.cloud
adb shell pm uninstall -k --user 0 com.heytap.browser
adb shell pm uninstall -k --user 0 com.coloros.calculator
adb shell pm uninstall -k --user 0 com.coloros.alarmclock
adb shell pm uninstall -k --user 0 com.os.docvault
adb shell pm uninstall -k --user 0 com.coloros.filemanager
adb shell pm uninstall -k --user 0 com.finshell.fin
adb shell pm uninstall -k --user 0 com.google.android.keep
adb shell pm uninstall -k --user 0 com.redteamobile.roaming
adb shell pm uninstall -k --user 0 com.coloros.video
```
## Re-installing the apps
You could re-install the apps which you removed for the current mobile user with the following command.
```bash
adb shell cmd package install-existing <PACKAGE_NAME>
```

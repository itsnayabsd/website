---
title : Setting up Ethernet communication with Raspberry Pi 3 Model B
layout : rpi3b-elinux-post
category : rpi3b-elinux
date: 2020-04-23 21:50:53 +5:30
comments : true
google_adsense: true
excerpt : The step by step tutorial to how to establish Ethernet communication using TFTP protocol with Raspberry Pi 3 Model B and to transfer files using TFTP to Raspberry Pi U-Boot.
keywords : transfer files to Raspberry Pi using tftp, transfer files between PC and Raspberry Pi, transfer files from Ubuntu to Raspberry PI, Raspberry Pi tftpboot.
image : /assets/img/rpi3b-elinux-tftp-comm.png
toc : true
---
## Introduction
In the [earlier post](/rpi3b-elinux/embedded-linux-rpi3-030-boot-process.html), we saw the boot process of Raspberry Pi 3 Model B and how to login to U-boot console. In this article we will see how to establish **TFTP** protocol communication between development system and RPI.

The development system acts like **TFTP server** and used to host the files which can be transferred to the RPI. After establishing TFTP communication, the U-boot will be able to download the files from TFTP server and load into the RAM. In the upcoming articles, we will be using this method to download *Linux kernel* and *Device tree* from the TFTP server to the Rapsberry Pi.

{% include image.html url="rpi3b-elinux-tftp-comm.png" description="TFTP communication with Raspberry Pi 3 Model B" %}

## Setup the U-boot
Connect Rapberry PI to the Ubuntu system using Ethernet cable. Both Raspberry PI and the host system should belong to same network to be able to communicate.

Let's setup some environment variables. Power up the Raspberry Pi, press `Enter` to login to U-boot console immediately after powerup. In the console, run the following commands.
```bash
setenv ipaddr 192.168.1.115
setenv serverip 192.168.1.15 # IP address of host system ethernet interface
saveenv
```
The environment variable `ipaddr` is the IP address of the Raspberry Pi. The `serverip` environment variable is system IP address in which TFTP server is running. I am using my development system as a TFTP server. This can be any system as long as it is in the same network as Raspberry Pi.

The environment variable `saveenv` saves the environment data to the SD card so that you don't have to enter this data every time the board boots.

## Set up the server
Please use [this tutorial](/linux/install-tftpserver.html) to install TFTP server in your development system (Ubuntu). Note down the tftp directory path. The default directory can be either `/srv/tftp` or `/var/lib/tftpboot`. This will be used to store the files which can be transferred to RPI.

Change the IP address of your Ubuntu system Ethernet interface IP address to the `serverip` address. In this case it is *192.168.1.15*. The simple way to do this is using the following command.

```bash
nmcli con add type ethernet ifname <Ethernet_interface_name> ip4 192.168.1.15/24
```
**Ex** : `nmcli con add type ethernet ifname enp3s0 ip4 192.168.1.15/24`

You can find your Ethernet interface name from the command `ifconfig -a`.

## Testing the connection
First change the ownership of the TFTP directory.
```bash
sudo chown -R USERNAME TFTP_DIRECTORY	# Replace USERNAME and TFTP_DIRECTORY with yours
```
**Ex**: `sudo chown -R nayab /srv/tftp/`

Let's create a dummy file called `testFile` in the tftp directory of your host system.
```bash
echo "dummy data" > /srv/tftp/testFile
```

Use the following command in the Raspberry Pi U-boot console to download the file `testFile` from the TFTP server.
```bash
tftp 0x1000000 testFile
```
Make sure the file is transferred successfully. At the end of transmission, you should see the message similar to following.
```
Loading: ################################### 11 Bytes
         0 Bytes/s
done
Bytes transferred = 11 (b hex)
U-Boot>
```
<!--
Other useful official pages :
 - [Device tree](https://www.raspberrypi.org/documentation/configuration/device-tree.md)
 - [Conditional filters](https://www.raspberrypi.org/documentation/configuration/config-txt/conditional.md)
 - [LED warning flash codes](https://www.raspberrypi.org/documentation/configuration/led_blink_warnings.md)
-->

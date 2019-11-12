---
layout: post
title: Install Raspbian OS on Raspberry Pi.
category: linux
comments: true
google_adsense: true
excerpt: Step by step tutorial on how to install Raspbian OS on Raspberry Pi, enable SSH and login to console.
date: 2019-11-12 22:59:08 +5:30
image: /assets/img/raspbian_on_rpi.jpg
---
## Download the Raspbian image

Download the latest Raspbian image from the [official download](https://www.raspberrypi.org/downloads/raspbian/) page. As of writing this, the latest Raspbian OS is `Raspbian Buster` (based on Debian 10). I chose the `Raspbian Buster lite` as it doesn't include any UI and and the size is less.

Unzip the downloaded file with the following command.
```
cd ~/Downloads && unzip "*raspbian-*-lite.zip"
```

![Raspbian On RPI](/assets/img/raspbian_on_rpi.jpg )
## Flash the image to SD card
Download the `etcher` tool from the [official website](https://www.balena.io/etcher/).

Unzip the tool with the following command
```
cd ~/Downloads && unzip "balena-etcher-electron-*linux-x64.zip"
```
Make the etcher AppImage executable
```
chmod +x balenaEtcher-*-x64.AppImage
```
Run the etcher tool
```
./balenaEtcher-1.5.63-x64.AppImage
```
Insert SD card into card reader slot. Follow the on screen instructions of the etcher tool and flash the extracted Raspbian image to SD card.

## Boot the image
Monitor, mouse and keyboard are required for the first time to enable the SSH. By default SSH is disabled.

After connecting raspberry to monitor, run the following command to enable SSH.
```
sudo raspi-config
```

Navigate to *Interfacing Options -> SSH* and then enable the SSH by pressing Enter.

WiFi can also be configured by going into *Network Options -> Wi-Fi* and then entering SSID credentials. I prefer connecting RaspberryPi to ethernet port of a router.

Assign a fixed IP address to your raspberry Pi device. This can be done by using *DHCP bind* or *DHCP static bind* feature or similar in your *router* settings web page. This feature will always assign the same IP address to your Raspberry Pi device.

## Login to RaspberryPi

Reboot the device so that it gets the IP address bound to it's MAC from the router.SSH into the raspberryPi using the following command
```
ssh pi@ip_add_ress # Replace the ip_add_ress with raspberryPi IP address.
```

Change the default password using the following command
```
passwd
```

## Update the OS
Run the following commands to update the system
```
sudo apt update
sudo apt -y upgrade
```
That's it. The Raspbian OS is installed on Raspberry Pi and ready to access over network for further development like creating web server, hosting or accessing applications.

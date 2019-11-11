---
layout: post
category: linux
excerpt: Step by step tutorial on how to deploy nodejs web app hosted on github to digitalocean cloud platform.
comments: false
title: Make RaspberryPi setup for local app development
google_adsense: false
---

## Download the Raspbian image

Download the latest Raspbian image from the [official download](https://www.raspberrypi.org/downloads/raspbian/) page. As of writing this, the latest Raspbian OS is `Raspbian Buster` (based on Debian 10). I chose the `Raspbian Buster lite` as it doesn't include any UI and and the size is less.

Unzip the downloaded file with the following command.
```
cd ~/Downloads && unzip "*raspbian-*-lite.zip"
```

## Flash the image to SD card
Download the `etcher` tool form the [official website](https://www.balena.io/etcher/).

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

WiFi can also be configured by going into *Network Options -> Wi-Fi*. I prefer connecting RaspberryPi to ethernet port of a router.

It's better to assign a static IP address for the RaspberryPi (*DHCP bind*) using your *router* settings. Get the IP address of the device from the following command.

```
ifconfig
```

## Login to RaspberryPi

SSH into the raspberryPi using the following command
```
ssh pi@ip_add_ress # Replace the ip_add_ress with raspberryPi IP address.
```

Change the default password using the following command
```
passwd
```

That's it. Your RaspberryPi is ready for development purpose.

---
layout: post
title: OpenWRT in RaspbettyPI
category: linux
comments: false
google_adsense: false
excerpt: 
date: 
thumbnail: 
rating: '5'
---
Download the openwrt image for rpi 3 model B from https://openwrt.org/toh/hwdata/raspberry_pi_foundation/raspberry_pi_3_b

Use the etcher software to flash the above image to memory card.

Bootup the board.

Question : RPI br-lan has IP 192.168.1.1. Board is connected to router whose default gateway is 192.168.0.1 with sub-net mask 255.255.254.0. A laptop has been connected to router's SSID and got IP address 192.168.0.104. But from laptop I can't ping 192.168.1.1. Why? Router is not detecting the RPI as a station. Why?
Answer : Change the netmask of bridge lan interface to 255.255.254.0. Now I am able to ping and take SSH.
<!--after two or more paragraphs-->

  {% if jekyll.environment == 'production' and page.google_adsense %}
  {% include goog_inart_2par.html %}
  {% endif %}

Configure the router password.

Delete the line `option disabled '1'` from the file `/etc/config/wireless` to enable the wifi. Add the lines
```
option encryption 'psk2'
option key 'password'
```
for the `OpenWRT` SSID.

Create a file /etc/init.d/rcS with the following content.
```
#!/bin/sh
# Copyright (C) 2006 OpenWrt.org

run_scripts() {
        for i in /etc/rc.d/$1*; do
                [ -x $i ] && $i $2 2>&1
        done | $LOGGER
}

system_config() {
        config_get_bool foreground $1 foreground 0
}

LOGGER="cat"
[ -x /usr/bin/logger ] && LOGGER="logger -s -p 6 -t sysinit"

. /etc/functions.sh

config_load system
config_foreach system_config system

if [ "$1" = "S" -a "$foreground" != "1" ]; then
        run_scripts "$1" "$2" &
else
        run_scripts "$1" "$2"
fi
```
This will run the all scripts present in /etc/rc.d directory when board boots up. Reboot the RPI to see SSID broadcasting.

Take the backup of config at this point. br-lan pings.

Now changed the proto of bridge lan from static to dhcp. Removed static IP address, subnet mask and other fields. Now board got the IP from router and from the board console, it possible to ping google.com. Laptop is connected to OpenWRT SSID and laptop able to access the internet. So NATing is happening between br-lan and wlan0.

At this point: bridge show command displays...
```
root@OpenWrt:~# brctl show
bridge name     bridge id       STP enabled	    interfaces
br-lan      7fff.b827ebe33348       no              eth0
                                                    wlan0
```
After removing the wlan0 from br-lan bridge, board console can't be accessed by connecting to OpenWRT. There is no bridge between br-lan and wlan0.
Take the backup of config at this point using the new IP address. br-lan google pings.

Next try is to use PPPoE with br-lan.

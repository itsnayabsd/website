---
layout: post
title: Linux Driver for Redragon Asura K501 gaming keyboard
category: drivers
comments: true
google_adsense: true
excerpt: >-
  Linux driver installation for Redragon Asura K501 gaming keyboard. Ctrl, Alt
  and Windows keys not working or mapped to Shift key issue solved.
date: 2017-12-09T06:53:50.000Z
thumbnail: /assets/img/redragon-k501-gaming-kbd.png
rating: '5'
---
I've been using Linux based operating system for a long time and I am [Steam](http://store.steampowered.com/) player.

I've recently bought [Redragon ASURA K501 USB Gaming Keyboard](https://www.amazon.in/gp/product/B00NXCGZOM/ref=as_li_tl?ie=UTF8&camp=3638&creative=24630&creativeASIN=B00NXCGZOM&linkCode=as2&tag=embedlooku-21&linkId=923223356c4e2fcfdede25830fd2ed34) from Amazon India website. I found that <kbd>Ctrl</kbd>, <kbd>Alt</kbd> and <kbd>Win</kbd> keys are mapped to <kbd>Shift</kbd>.

I modified a Linux driver from existing gaming keyboard driver suited for Redragon Asura K501 and uploaded in [bitbucket](https://bitbucket.org/nayabbashasayed/redragonkbd).

The issues resolved: 
 * Ctrl, Alt and Windows keys not working.
 * Ctrl and Alt keys mapped to Shift key.

Here are the steps to get the keyboard working on most of the Linux based distributions.

## For Debian Based Systems
```
sudo apt-get install mercurial build-essential linux-headers-generic dkms
```

# fedora:
```
sudo dnf install kernel-devel kernel-headers
sudo dnf groupinstall "Development Tools" "Development Libraries"
```

## Common steps for both
```
hg clone https://nayabbashasayed@bitbucket.org/nayabbashasayed/redragonkbd
cd redragonkbd
make clean
make
sudo ./install.sh
```

Search for `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub` file and replace that line with the following line.
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash usbhid.quirks=0x0c45:0x760b:0x4"
```

## Update the grub
```
sudo update-grub
reboot
```

**Note**: If you update your kenel (or opearating system), keyboard might not work and you need to do the whole procedure again.

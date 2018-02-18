---
layout: post
date: 2017-04-05 21:47:25 +5:30
excerpt: Step by step tutorial to install and run tftp-server in Ubuntu based operating systems.
title: Install Tftp Server in Ubuntu
category: linux
comments: true
google_adsense: true
---
## Get the software
```
sudo apt-get install tftpd-hpa
```
## Check the status of tftp server. If it is not running, start it.
```
sudo service tftpd-hpa status
```
The output looks like following...
```
.service - LSB: HPAs tftp server
   Loaded: loaded (/etc/init.d/tftpd-hpa; bad; vendor preset: enabled)
   Active: active (running) since Wed 2017-04-05 21:47:18 IST; 5min ago
     Docs: man:systemd-sysv-generator(8)
  Process: 24085 ExecStart=/etc/init.d/tftpd-hpa start (code=exited, status=0/SUCCESS)
   CGroup: /system.slice/tftpd-hpa.service
           └─24099 /usr/sbin/in.tftpd --listen --user tftp --address :69 --secure /tftpboot
```
If output is nothing, start the server:
```
$ sudo service tftpd-hpa start
```
## By default, the directory to store files is `/var/lib/tftpboot`.  
This can be changed in `tftpd-hpa` configuration file.  
```
$ cat /etc/default/tftpd-hpa
# /etc/default/tftpd-hpa
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/var/lib/tftpboot"
TFTP_ADDRESS="[::]:69"
TFTP_OPTIONS="--secure"
```
Change `TFTP_DIRECTORY` to desired folder.
## Restart the server, if configuration file changed.
```
sudo service tftpd-hpa restart
```
## To stop tftp server:
```
sudo service tftpd-hpa stop
```

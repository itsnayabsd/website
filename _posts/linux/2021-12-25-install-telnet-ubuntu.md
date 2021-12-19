---
date: 2021-12-30 11:08:55 +5:30
title: Install and Use Telnet on Ubuntu Linux
layout : post
category : linux
comments : true
google_adsense: true
excerpt : Telnet is a client-server protocol to access remote system using virtual terminal connection. Learn how to install, use, access and check open ports on the remote Linux system using telnet
keywords : Telnet Linux install, Access remote system using telnet, telnet check open ports, install telnet server ubuntu, install inetd ubuntu, telnet command examples
image : /assets/img/linux/linux-telnet.png
toc : true
---
## Introduction

*Telnet* is a client-server protocol to access remote system using virtual terminal connection.

The Telnet client is available on almost all Ubuntu Linux systems. The telnet server might not have installed by default.

{% include image.html url="/linux/linux-telnet.png" description="Remote system access using telnet" %}

## Installation
Use the following command to install Telnet server on the remote Ubuntu Linux system.
```bash
sudo apt -y install telnetd
```
We can check the status of the server by running the following command in the remote system.
```bash
sudo systemctl status inetd
```
The output should be similar to following. The *Active: active (running)* on the third line indicates that the Telnet server is running without any problem.

```
● inetd.service - Internet superserver
     Loaded: loaded (/lib/systemd/system/inetd.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2021-12-30 11:04:06 IST; 39min ago
       Docs: man:inetd(8)
   Main PID: 69727 (inetd)
      Tasks: 2 (limit: 4483)
     Memory: 2.3M
     CGroup: /system.slice/inetd.service
             ├─69727 /usr/sbin/inetd
             └─70570 in.telnetd: 192.168.1.3
```
## Accessing the remote system using telnet
Log into your local system and run the following command to login to remote system
```bash
telnet <REMOTE_IP_ADDR>
```
Replace *REMOTE_IP_ADDR* with your remote system IP address. Example -> Mine is *192.168.1.20*. You will see the output similar to following.

When prompted for Username and Password, enter your remote Linux system username and password. Once you login to remote system, you can execute any command as if you are using the system directly.

```
Trying 192.168.1.20...
Connected to 192.168.1.20.
Escape character is '^]'.
Ubuntu 20.04.3 LTS
3550 login: nayab
Password: 
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.11.0-40-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

0 updates can be applied immediately.

Your Hardware Enablement Stack (HWE) is supported until April 2025.
*** System restart required ***
Last login: Thu Dec 30 11:04:58 IST 2021 from 192.168.1.3 on pts/1
nayab@3550:~$ 
nayab@3550:~$ 
```
## Checking open ports using telnet
This is one use case of telnet other than remote server access. We can use telnet tool to test if there are any specific ports open on the remote system. Just pass the port number followed by server ip address.
```bash
telnet 192.168.1.20 80
```
Following is the result from my remote system when port 80 is tested.
```
Trying 192.168.1.20...
telnet: Unable to connect to remote host: Connection refused
```
If remote host refused the connection, that means the port is not open. In the above example, the port number 80 is not open.

Let's try checking the port number 22.
```bash
telnet 192.168.1.20 22
```
Result :-
```
Trying 192.168.1.20...
Connected to 192.168.1.20.
Escape character is '^]'.
SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.3

Invalid SSH identification string.
Connection closed by foreign host.
```
You can see the Telnet is connected to 192.168.1.20 from the second line of output. That means the port 22 is open.

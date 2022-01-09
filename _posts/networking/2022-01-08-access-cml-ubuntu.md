---
title : Access Free Cisco Modelling Labs from Ubuntu
layout : post
category : networking
date: 2022-01-08 17:29:13 +5:30
comments : true
google_adsense: true
excerpt : Access the free Cisco Modelling Labs from your Ubuntu Linux system. Cisco is offering a free sandboxed version for free to practice labs for CCNA, CCNP and DevNet certifications. SEtup and access the free CML for Ubuntu.
keywords : Free CML, free cisco modelling labs, install cisco anyconnect vpn ubuntu, access cisco modelling labs (cml) from ubuntu, Access DevNet CML sandbox from ubuntu, DevNet Cisco Modelling Labs Sandbox, CML for CCNA CCNP and DevNet, Cisco free cml.
image : /assets/img/networking/free-cisco-cml.png
toc : true
---
## Introduction
Practicing labs on Cisco physical hardware or hardware emulators is required to pass Cisco certifications. Setting up a variety of physical devices at home is a lot costlier. Other options are Cisco packet tracer and network emulators like GNS3 or EVE-NG. Cisco packet tracer doesn't support actual Cisco images (though sufficient for CCNA). Getting the Cisco IOS images is not free to use with GNS3/EVE-NG. You need to pay a annual *Cisco Modelling Labs* subscription fee to get the Cisco images.

But there is an alternative. One can reserve Cisco Modelling Labs for free and practice labs on the isolated cloud environment called DevNet SandBox. Once reserved, all you need is to run VPN in your Ubuntu system and open the Cisco DevNet Sandbox in the browser for practice.

{% include image.html url="networking/free-cisco-cml.png" description="Access Free Cisco Modelling Labs" %}<br>

The Sandbox has the following Cisco nodes at the time of writing this post. These nodes are enough to practice labs for the CCNA, CCNP or DevNet certifications.

 * Cisco IOSv Router
 * Cisco IOSvL2 Switch
 * Cisco IOS XRv Router
 * Cisco IOS XRv 9000 Router
 * Cisco NX-OSv Titanium Switch
 * Cisco NX-OSv 9000v Switch
 * Ubuntu Linux system
 * Cisco IOS XE SD-WAN Router
 * Cisco CSR 1000v Router
 * Cisco External connector in NAT/Bridge mode.
 * Unmanaged switch
 * Cisco TRex Traffic generator
 * WAM Emulator
 * Cisco SD-WAN Controllers

{% include image.html url="networking/cisco_cml_nodes.png" description="Availble nodes in DevNet sandbox CML" %}<br>

In this post, I will be explaining how to register, reserve, setup and use Cisco Modelling Labs from the Ubuntu Linux system.

## Register at DevNet sandbox
Visit the DevNet sandbox at URL [https://devnetsandbox.cisco.com/](https://devnetsandbox.cisco.com/). Login with one of the third party sign-in option. It will take you to registration form if you are not already registered.

Once registration completes, it will take you to the *Cisco Devnet* platform. Scroll down until you see *Cisco Modelling Labs*. Click on it and it will take you to the Cisco Modelling Labs Sandbox.
{% include image.html url="networking/cisco_modelling_labs.png" description="Cisco Modelling Labs Sandbox Option" %}<br>

## Cisco Modelling Labs server credentials
On the left, from the *Cisco Modelling Labs* tab, scroll down a little bit and note down the *Cisco Modelling Labs Server* detais. This includes lab server address, username and password. See following screenshot for reference. We will use these detials to log into sandbox later.

{% include image.html url="networking/sandbox_credentials.png" description="Cisco Modeeling Labs Server Credentials" %}<br>

## Reserve a slot
To use the CML sandbox, one need to reserve it for certain period of time. At upper right corner, click on *reserve* to reserve a sandbox. You can reserve the sandbox for upto 4 hours max. Once you slot is booked, it will take upto 10 minutes to setup the sandbox to you.

{% include image.html url="networking/cisco_modelling_labs_reservation.png" description="Cisco Modeeling Labs Reservation" %}<br>
## Establish a VPN connection
Once the setup is done (hopefully around 10 minutes), you should have received a mail with the subject line *Your Cisco DevNet Sandbox Lab is Ready*. This mail has Cisco anyconnect VPN credentials. These credentials needed when connecting a VPN to the server. Without VPN you can't access the sandbox.

{% include image.html url="networking/vpn_credentials_mail.png" description="Cisco CML sandbox VPN Credentials in Mail" %}<br>

### Install VPN client
Let's install VPN first. Run the following command to install *openconnect* client in the Ubuntu system. We will use openconnect client to connect to Cisco VPN.

```bash
sudo apt install openconnect
```

### Connect to Cisco anyconnect VPN
```bash
sudo openconnect --no-dtls LAB_NETWORK_ADDRESS_FROM_MAIL
```
Replace *LAB_NETWORK_ADDRESS_FROM_MAIL* with lab network address you received in the mail. When prompted for username and password, enter those details given in the mail.

## Access the Cisco Modelling Labs DevNet Sandbox
Once the VPN connection is established, enter the Cisco Modelling Labs Server IP address in the browser (We noted down these datails in [this step](#cisco-modelling-labs-server-credentials)). Enter the username and password in the required fields to log into the sandbox.

{% include image.html url="networking/cml_sandbox_login.png" description="Cisco CML sandbox login" %}<br>

The following is a simple topology created using two Cisco routers and a Cisco switch. Each of these nodes can be configured directly through web UI. And can be accessed through *console*, *VNC* (if applicable) or *SSH* (if applicable). Traffic also can be captured between these nodes to analyze through wireshark. See the below reference image.
{% include image.html url="networking/simple_topology.png" description="Simple topology in Cisco CML sandbox" %}<br>


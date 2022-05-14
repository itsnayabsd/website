---
layout: post
title: Self Host Algo VPN Server in the Cloud
category: devcloud
comments: true
google_adsense: true
excerpt: There are various reasons why I want to host my own VPN server in the cloud. While using any VPN service will give you benifits, it has drawbacks too. In this guide I will show you how to install, configure Algo VPN in the DigitalOcean Ubuntu droplet and how to configure VPN client in your local Ubuntu based Linux system.
keywords: deploy own vpn server in the cloud, deploy algo vpn in the ubuntu server, self host vpn service, self host vpn server in the cloud, self host algo vpn in the cloud, self host algo vpn in the digitalocean, deploy your own vpn server in the dititalocean, setup personal vpn server in the cloud, run your own private vpn server in the cloud, run own private vpn server in the digitalocean, setup personal vpn server in the ubuntu cloud, setup wireguard vpn in the ubuntu
date: 2022-05-16 00:30:29 +5:30
image: /assets/img/devcloud/selfhost_algo_vpn_ubuntu.png
toc: true
---
There are various reasons why I want to host my own VPN server (Algo VPN particularly) in the cloud. While using any VPN service will give you benifits, it has drawbacks too.

 * Can't trust third party VPN servers with your data, even with no-log policy.
 * Third party VPN services are costlier.
 * Algo VPN is based on Wiregaurd, which is most secure, simple and easy to use. Not all third party VPNs come with state of the art security and cryptography.
 * To know more about why I avoid using commercial VPNs, check [this algo VPN release notes](https://blog.trailofbits.com/2016/12/12/meet-algo-the-vpn-that-works/)

I would recommend *DigitalOcean* cloud service to host your personal VPN server in the cloud. Please see [this guide to create and setup a DigitalOcean droplet](/devcloud/digitalocean-droplet-setup.html) first.

In this guide I will show you how to install, configure Algo VPN in the DigitalOcean Ubuntu droplet and how to configure VPN client in your local Ubuntu based Linux system to connect to the VPN server running in the DigitalOcean droplet.

{% include image.html url="/devcloud/selfhost_algo_vpn_ubuntu.png" description="Self host Algo VPN in the Ubuntu Server" %}

## Download Algo VPN
After setting up a DigitalOcean droplet, log into the droplet and run the following command to download Algo VPN scripts.
```bash
git clone https://github.com/trailofbits/algo.git
```
## Install dependencies for Algo VPN
Run the following command to install Algo VPN dependency packages.
```bash
sudo apt install -y --no-install-recommends python3-virtualenv
```
## Setup Algo VPN
Now it's time to setup your own VPN service. Run the following commands.
```bash
cd algo

python3 -m virtualenv --python="$(command -v python3)" .env &&   source .env/bin/activate &&   python3 -m pip install -U pip virtualenv &&   python3 -m pip install -r requirements.txt
```
Above command might take few minutes. Once done, add additional usernames under *users:* section in file *config.cfg* file.
```bash
vi config.cfg
```
Here is the list of users in my *config.cfg* file
```
users:
  - phone
  - laptop
  - desktop
  - nayab
```

I have added an username called *nayab*. A configuration file will be created with this username in the later steps.

Now run the following command to setup Algo VPN
```bash
./algo
```
Follow online instructions to install Algo server in a droplet. A sample log of the installation on DigitalOcean droplet given below.

Note the following points while configuring the Algo VPN.
 * When prompted for *What provider would you like to use?*, I have selected *Install to existing Ubuntu 18.04 or 20.04 server (for more advanced users)* option which is ***12*** at the time of writing.
 * When prompted for *Enter the public IP address or domain name of your server*, enter your droplet IP address.

```
$ ./algo

PLAY [localhost] ***********************************************************************************

TASK [Gathering Facts] *****************************************************************************
ok: [localhost]
.
.
.
What provider would you like to use?
    1. DigitalOcean
    2. Amazon Lightsail
    3. Amazon EC2
    4. Microsoft Azure
    5. Google Compute Engine
    6. Hetzner Cloud
    7. Vultr
    8. Scaleway
    9. OpenStack (DreamCompute optimised)
    10. CloudStack (Exoscale optimised)
    11. Linode
    12. Install to existing Ubuntu 18.04 or 20.04 server (for more advanced users)
  
Enter the number of your desired provider
:
12
TASK [Cloud prompt] ********************************************************************************
ok: [localhost]
.
.
.
TASK [Set facts based on the input] ****************************************************************
ok: [localhost]
[Cellular On Demand prompt]
Do you want macOS/iOS clients to enable "Connect On Demand" when connected to cellular networks?
[y/N]
:
^M
TASK [Cellular On Demand prompt] *******************************************************************
ok: [localhost]
[Wi-Fi On Demand prompt]
Do you want macOS/iOS clients to enable "Connect On Demand" when connected to Wi-Fi?
[y/N]
:
^M
TASK [Wi-Fi On Demand prompt] **********************************************************************
ok: [localhost]
[Retain the PKI prompt]
Do you want to retain the keys (PKI)? (required to add users in the future, but less secure)
[y/N]
:
^M
TASK [Retain the PKI prompt] ***********************************************************************
ok: [localhost]
[DNS adblocking prompt]
Do you want to enable DNS ad blocking on this VPN server?
[y/N]
:
y^M
TASK [DNS adblocking prompt] ***********************************************************************
ok: [localhost]
[SSH tunneling prompt]
Do you want each user to have their own account for SSH tunneling?
[y/N]
:
^M
TASK [SSH tunneling prompt] ************************************************************************
ok: [localhost]

TASK [Set facts based on the input] ****************************************************************
ok: [localhost]

PLAY [Provision the server] ************************************************************************

TASK [Gathering Facts] *****************************************************************************
ok: [localhost]

--> Please include the following block of text when reporting issues:

Algo running on: Ubuntu 20.04.4 LTS (Virtualized: kvm)
Created from git clone. Last commit: c0968a8 Only offer available DigitalOcean regions (#14447)
Python 3.8.10
Runtime variables:
    algo_provider "local"
    algo_ondemand_cellular "False"
    algo_ondemand_wifi "False"
    algo_ondemand_wifi_exclude "X251bGw="
    algo_dns_adblocking "True"
    algo_ssh_tunneling "False"
    wireguard_enabled "True"
    dns_encryption "True"

TASK [Display the invocation environment] **********************************************************
changed: [localhost]

TASK [Install the requirements] ********************************************************************
ok: [localhost]

TASK [Include a provisioning role] *****************************************************************
[local : pause]
https://trailofbits.github.io/algo/deploy-to-ubuntu.html

Local installation might break your server. Use at your own risk.

Proceed? Press ENTER to continue or CTRL+C and A to abort...:
^M
TASK [local : pause] *******************************************************************************
ok: [localhost] => (item=https://trailofbits.github.io/algo/deploy-to-ubuntu.html

Local installation might break your server. Use at your own risk.

Proceed? Press ENTER to continue or CTRL+C and A to abort...)
[local : pause]
Enter the IP address of your server: (or use localhost for local installation):
[localhost]
:
^M
TASK [local : pause] *******************************************************************************
ok: [localhost]

TASK [local : Set the facts] ***********************************************************************
ok: [localhost]
[local : pause]
Enter the public IP address or domain name of your server: (IMPORTANT! This is used to verify the certificate)
[localhost]
:
167.71.21.18^M
TASK [local : pause] *******************************************************************************
ok: [localhost]
.
.
.
TASK [debug] ***************************************************************************************
ok: [localhost] => {
    "msg": [
        [
            "\"#                          Congratulations!                            #\"",
            "\"#                     Your Algo server is running.                     #\"",
            "\"#    Config files and certificates are in the ./configs/ directory.    #\"",
            "\"#              Go to https://whoer.net/ after connecting               #\"",
            "\"#        and ensure that all your traffic passes through the VPN.      #\"",
            "\"#                     Local DNS resolver 172.27.6.14, fd00::b:409a     #\"",
            ""
        ],
        "    \"#        The p12 and SSH keys password for new users is ZyeSBF2rh       #\"\n",
        "    ",
        "    "
    ]
}

PLAY RECAP *****************************************************************************************
localhost                  : ok=125  changed=27   unreachable=0    failed=0    skipped=54   rescued=0    ignored=0
```
## Troubleshooting
You might face some errors while running the setup. In that case, remove configuration files and re-run *./algo* command

```bash
sudo rm -rf /etc/wireguard/*
rm -rf configs/*
./algo
```

If you are running any other services in the droplet other than the Algo VPN, and if you are having difficulty accessing those services, you might want to re-enable the firewall.
```bash
sudo ufw enable
```

That's it. You are running your personal VPN server in the cloud successfully. The next step is to download VPN configuration file to your local system and use a local VPN client to connect this VPN server.
## Download configuration file
Now from your local system, run the following command to download configuration file from your Algo VPN server configs directory to one of your local system directory.
```bash
scp UBUNTU_DROPLET_USERNAME@DROPLET_IP_ADDRESS:~/algo/configs/DROPLET_IP_ADDRESS/wireguard/ALGO_USERNAME.conf ~/
```
 * Replace UBUNTU_DROPLET_USERNAME with the username you created during inintial Ubuntu droplet setup.
 * Replace DROPLET_IP_ADDRESS with the droplet IP address.
 * Replace ALGO_USERNAME with the username you have added in the *config.cfg* file at the starting of the Algo VPN setup.

Here is an example command for reference. In my case, both *ALGO_USERNAME* and * UBUNTU_DROPLET_USERNAME* are the same.
```
scp nayab@167.71.21.18:~/algo/configs/167.71.21.18/wireguard/nayab.conf ~/
```
## Configuring VPN client on your local Ubuntu system
Update the system and reboot if required.
```bash
sudo apt update && sudo apt upgrade
[ -e /var/run/reboot-required ] && sudo reboot
```
Install the supported packages - *wireguard* and *openresolv*
```bash
sudo apt install wireguard openresolv
```
Install the configuration file you downloaded from VPN server to the */etc/wireguard* directory.
```bash
sudo install -o root -g root -m 600 ~/ALGO_USERNAME.conf /etc/wireguard/wg0.conf
```
Don't forget to replace ALGO_USERNAME with yours.
## VPN client commands to start/stop/auto-run in your local system
### Start VPN client service
To start wireguard VPN client, run the following command.
```bash
sudo systemctl start wg-quick@wg0
```
You can check the status of the service using following command.
```bash
sudo systemctl status wg-quick@wg0
```
### Stop the VPN client service
To stop wireguard VPN client service, run the following command.
```bash
sudo systemctl stop wg-quick@wg0
```
### Autostart the VPN service on reboot
You do not have to enter the above command each time you start your systems. Instead run the following command to self start the wireguard VPN client on it's own.
```bash
sudo systemctl enable wg-quick@wg0
```
## Check the VPN functionality
```bash
sudo wg
curl ipv4.icanhazip.com
```
Above command should display your droplet IP address instead of your ISP global IP address.

Hope this post helps configuring your personal VPN service in the cloud, helps you unblocking websites and take full control of your VPN usage data and probably save some bucks.

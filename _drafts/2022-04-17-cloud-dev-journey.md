---
layout: post
title: Cloud is part of my developer journey
category: cloud
comments: true
google_adsense: true
excerpt: 
keywords: 
date: 2022-04-17 11:52:02 +5:30
image: /assets/img/mirror_git_platforms.png
---
## Algo VPN
```bash
git clone https://github.com/trailofbits/algo.git
sudo apt install -y --no-install-recommends python3-virtualenv
cd algo
python3 -m virtualenv --python="$(command -v python3)" .env &&   source .env/bin/activate &&   python3 -m pip install -U pip virtualenv &&   python3 -m pip install -r requirements.txt
```

Add additional usernames under *users:* section in file *config.cfg* file.

```bash
./algo
```
Follow online instructions to install Algo server in a droplet.

```bash
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
167.71.211.185^M
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
            "\"#                     Local DNS resolver 172.27.64.154, fd00::b:409a                   #\"",
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
You might want to do the following if you face any errors and rerun again the command *./algo*.

```bash
sudo rm -rf /etc/wireguard/*
rm -rf configs/*
```
Configuring local VPN client ->

```bash
sudo apt update && sudo apt upgrade
[ -e /var/run/reboot-required ] && sudo reboot
sudo apt install wireguard openresolv
sudo install -o root -g root -m 600 ~/algo/configs/167.71.198.107/wireguard/nayab.conf /etc/wireguard/wg0.conf
sudo systemctl start wg-quick@wg0
sudo systemctl status wg-quick@wg0
sudo wg
curl ipv4.icanhazip.com
sudo systemctl enable wg-quick@wg0
sudo systemctl stop wg-quick@wg0
```
## URL Shortener
Check if all the package below are necessary
```
sudo apt install php-fpm
sudo apt install php-apcu php php-sqlite3 php-gd php-common php-curl php-intl php-gmp php-xml php-dev php-pear unzip sqlite3
wget https://github.com/shlinkio/shlink/releases/download/v2.7.1/shlink2.7.1_php7.4_dist.zip
unzip shlink2.7.1_php7.4_dist.zip
sudo mv shlink2.7.1_php7.4_dist /var/www/html/shlink
sudo chown -R www-data:www-data /var/www/html/shlink/
sudo chmod -R 755 /var/www/html/shlink/
sudo -u www-data php /var/www/html/shlink/bin/install -vvv
```
Put this nginx configuration
```
sudo vi /etc/nginx/conf.d/shlink.conf
```
```
server {
   listen 80;
   server_name short.nayab.xyz;

   root /var/www/html/shlink/public;
   error_log /var/log/nginx/shlink.error;
   access_log /var/log/nginx/shlink.access;

   index index.php index.html index.htm index.nginx-debian.html;

   location / {
     # try to serve file directly, fallback to app.php
     try_files $uri /index.php$is_args$args;
   }

   # redirect some entire folders
     rewrite ^/(vendor|translations|build)/.* /index.php break;

   location ~ \.php$ {
     fastcgi_split_path_info ^(.+\.php)(/.+)$;
     fastcgi_pass unix:/var/run/php/php-fpm.sock;
     fastcgi_index index.php;
     fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
     include fastcgi_params;
   }

}
```
Restart nginx server

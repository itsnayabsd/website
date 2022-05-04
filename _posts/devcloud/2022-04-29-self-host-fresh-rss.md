---
layout: post
title: Self Host FressRSS on Ubuntu Server
category: devcloud
comments: true
google_adsense: true
excerpt: 
keywords: 
date: 2022-04-29 14:05:14 +5:30
image: /assets/img/mirror_git_platforms.png
toc: true
---
RSS is a great way to get updates from your favorite blogs or websites. There are many RSS aggregators available online to fetch latest updates from your favorite blogs and websites and create a web feed for you. Most of these services offer free plan with limitations. You can use these services with limited functionality or you can host one for yourself either in your local system or in the cloud.

This post explains how to self host a free opensource RSS aggregator called *FreshRSS*, assign a subdomain/domain if you are hosting the service in the cloud and access it from anywhere.

If you want to host the FreshRSS in the cloud, I would recommend *DigitalOcean* cloud service. Please see [this guide to create and setup a DigitalOcean droplet first](/devcloud/digitalocean-droplet-setup.html).
## Installing the Nginx web server and dependent packages
### Install Nginx web server
Run the following command to install Nginx web server.
```bash
sudo apt update && sudo apt -y install nginx
```
### Configure firewall for Nginx
Add Nginx service to the firewall allow list.
```bash
sudo ufw allow "Nginx Full"
```
At this point make sure you see the Nginx default web page when you visit your droplet IP address in the web browser and the url [http://127.0.0.1/](http://127.0.0.1/) if you are configuring in your local system.
{% include image.html url="/devcloud/digitalocean_droplet_setup.png" description="Digitalocean Ubuntu Droplet Initial Setup" %}
### Install php and other dependencies
Installing *php-fpm* separately will somehow avoids installing Apache web server. We are using Nginx.
```bash
sudo apt -y install php-fpm
```
Install remaining packages.
```bash
sudo apt -y install php-curl php-gmp php-intl php-mbstring php-sqlite3 php-xml php-zip
```
### Pointing sub-domain/domain to droplet address.
This step is optional if you are using FreshRSS locally. How ever if you want to run FreshRSS in the cloud, you need to configure your DNS settings such that the sub-domain/domain points to your droplet address.

You need to create an *A record* in the DNS settings. I am using Cloudflare DNS settings and the setting looks like following. The setting is probably the same for all DNS providers.

{% include image.html url="/devcloud/digitalocean_droplet_setup.png" description="Digitalocean Ubuntu Droplet Initial Setup" %}

To reflect these changes in effect, your DNS server might take upto 24 hours. Meanwhile let's proceed with next steps.

### Configure Nginx configuration file
Remove the default configuration file available. We will write the file from scratch in the next step.
```bash
sudo rm /etc/nginx/sites-enabled/default
```
```
sudo vi /etc/nginx/sites-enabled/default
```
```
server {
        # Domain name below.
        server_name rss.nayab.xyz;

        # Replace the following root path to your website or app folder
        root  /var/www/html/p/;

        # This is the order in which server searches for the file names.
        # If index.html is not found, it will search for index.htm and so on.
        index index.php index.html index.htm index.nginx-debian.html;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
        }

        # php files handling
        # this regex is mandatory because of the API
        location ~ ^.+?\.php(/.*)?$ {
                fastcgi_pass unix:/var/run/php/php-fpm.sock;
                fastcgi_split_path_info ^(.+\.php)(/.*)$;
                # By default, the variable PATH_INFO is not set under PHP-FPM
                # But FreshRSS API greader.php need it. If you have a “Bad Request” error, double check this var!
                # NOTE: the separate $path_info variable is required. For more details, see:
                # https://trac.nginx.org/nginx/ticket/321
                set $path_info $fastcgi_path_info;
                fastcgi_param PATH_INFO $path_info;
                include fastcgi_params;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
}
```
```
sudo nginx -t
sudo systemctl reload nginx
```
Cloudflare dashboard -> Click on Domain name -> SSL/TLS -> Edge Certificates -> Disable Always Use HTTPS
```
sudo apt-get install certbot python3-certbot-nginx
sudo certbot --nginx
```
Cloudflare dashboard -> Click on Domain name -> SSL/TLS -> Edge Certificates -> Enable Always Use HTTPS

### Apache2
Install apache2 and php. Because alternatively FreshRSS uses SQLite.
```bash
sudo apt update
sudo apt install apache2
sudo a2enmod headers expires rewrite ssl
sudo ln -s /etc/apache2/sites-available/freshrss.conf /etc/apache2/sites-enabled/freshrss.conf
sudo apt install php php-curl php-gmp php-intl php-mbstring php-sqlite3 php-xml php-zip
sudo apt install libapache2-mod-php
sudo service apache2 restart
```
Install FreshRSS now
```bash
sudo apt install git
cd /usr/share/
sudo git clone https://github.com/FreshRSS/FreshRSS.git
sudo ufw allow "Apache Full"
cd FreshRSS
sudo chown -R :www-data .
sudo chmod -R g+r .
sudo chmod -R g+w ./data/
sudo chmod -R g+w .
sudo ln -s /usr/share/FreshRSS/p /var/www/html/
sudo service apache2 restart
```
Access the FreshRSS at [http://DROP.LET.IP.ADDR/p/](http://DROP.LET.IP.ADDR/p/)

 * Step 1 -> Choose a language for FreshRSS -> English
 * Step 2 -> Check if all requirements are met.
 * Step 3 -> Database configuration -> SQLite
 * Step 4 -> Enter desired username and password
 * STep 5 -> Complete installation.

Go to Settings

 * Reading -> Mark article as read -> Uncheck "when the article is viewed" and "while scrolling" options. -> Submit
 * Archiving -> Maximum number of articles to keep -> 10000
 * Authentication -> Allow API access

Pointing subdomain to FreshRSS

 * Go to the Cloudflare dashboard.
 * Click on domain name -> DNS tab
 * Add an *A* record => Type -> A, Name -> rss.nayab.xyz, Content -> DROP.LET.IP.ADDR
 * Wait for up to 48 hours



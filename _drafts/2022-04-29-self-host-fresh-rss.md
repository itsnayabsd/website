---
layout: post
title: Self Host FressRSS on Ubuntu Server
category: devcloud
comments: true
google_adsense: true
excerpt: Digitalocean droplets are great to self-host a lot variety of tools and personal projects. This post explains how to properly setup a droplet with Ubuntu OS before setting up any tools/projects.
keywords: 
date: 2022-04-29 14:05:14 +5:30
image: /assets/img/mirror_git_platforms.png
toc: true
---
## FreshRSS
### Nginx
```bash
sudo apt install nginx
sudo ufw allow "Nginx Full"
sudo apt install php-fpm
sudo apt install php-curl php-gmp php-intl php-mbstring php-sqlite3 php-xml php-zip

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



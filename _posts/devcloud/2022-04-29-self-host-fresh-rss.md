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

Either log into the Ubuntu droplet using above guide or open the *Termainal* in you local Ubuntu Linux system and follow the steps below.

## Install Nginx web server
Run the following command to install Nginx web server.

```bash
sudo apt update && sudo apt -y install nginx
```

## Configure firewall for Nginx
Add Nginx service to the firewall allow list.
```bash
sudo ufw allow "Nginx Full"
```
At this point you should see the Nginx default web page when you visit your droplet IP address in the web browser. Access [http://127.0.0.1/](http://127.0.0.1/) if you are configuring in your local system.

{% include image.html url="/devcloud/nginx_default_page_screenshot.png" description="Default Nginx web server page" %}

## Install php and other dependencies
Installing *php-fpm* separately will somehow avoids installing another web server - *Apache*. We are already using Nginx. So dont' want that.
```bash
sudo apt -y install php-fpm
```
Install remaining packages.
```bash
sudo apt -y install php-curl php-gmp php-intl php-mbstring php-sqlite3 php-xml php-zip
```
## Installing FreshRSS
Install FreshRSS now
```bash
sudo apt -y install git
```
```bash
cd /usr/share/
sudo git clone https://github.com/FreshRSS/FreshRSS.git
cd FreshRSS
sudo chown -R :www-data .
sudo chmod -R g+r .
sudo chmod -R g+w ./data/
sudo chmod -R g+w .
sudo ln -s /usr/share/FreshRSS/p /var/www/html/
```
## Configure Nginx configuration file
Remove the default configuration file available. We will write the file from scratch in the next step.
```bash
sudo rm /etc/nginx/sites-enabled/default
```
```bash
sudo vi /etc/nginx/sites-enabled/default
```
Add the following configuration in the */etc/nginx/sites-enabled/default* file.

```
server {
        # Domain name below.
        server_name DOMAIN_NAME;

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

Replace *DOMAIN_NAME* with *localhost*. if you have a domain/sub-domain with which you want to access FreshRSS later, then, replace *DOMAIN_NAME* with the domain/sub-domain name (ex: *nayab.xyz* or *rss.nayab.xyz*).

Make sure the configuration in the file is syntactically correct with the following command.
```bash
sudo nginx -t
```
Reload the Nginx service.
```bash
sudo systemctl reload nginx
```
## Configuring FreshRSS
Enter your droplet address (or [http://localhost/](http://localhost/) for local installation) into the browser. You should see the following installation web page. Let's proceed with the FreshRSS configuration.

{% include image.html url="/devcloud/freshrss_conf_page_screenshot.png" description="FreshRSS Installation Page" %}

Complete the setup with the following configuration.

 * Language -> Choose a language for FreshRSS -> Language -> English
 * Checks -> Make sure all checks are *Okay*
 * Database Configuration -> Type of database -> SQLite
 * General configuration
	* Username of default user -> Username of your choice
	* Password -> your desired password
	* Click on `Submit`
 * This is the end -> Complete installation.

Now log into the FreshRSS with your username and password.

**Congragulations on setting up FreshRSS successfully.**

{% include image.html url="/devcloud/freshrss_ready_screenshot.png" description="FreshRSS Installation Done" %}

The following steps are optional. If you want to access FreshRSS with a domain or sub-domain so that you can access it with the memorable address, follow the steps mentioned below.
## Pointing sub-domain/domain to droplet address.
This step is not necessary if you are using FreshRSS locally. How ever if you want to run FreshRSS in the cloud, you need to configure your DNS settings such that the sub-domain/domain points to your droplet address.

You need to create an *A record* in the DNS settings. I am using Cloudflare DNS settings and the setting looks like following. The setting is probably the same for all DNS providers.

{% include image.html url="/devcloud/dns_sub_domain_rss_screensot.png" description="Adding 'A' record for sub-domain in DNS settings" %}

To reflect these changes in effect, your DNS server might take upto 24 hours. Meanwhile let's proceed with next steps.

## Configuring SSL certificate
First Let's make sure you disable *Always User HTTPS* option in your DNS provider settings. For Cloudflare, it's available in the following path.

**Cloudflare dashboard -> Click on Domain name -> SSL/TLS -> Edge Certificates -> Disable Always Use HTTPS**

Now log into your droplet and enter the following commands to configure SSL for your domain (ex: rss.nayab.xyz).
```bash
sudo apt -y install certbot python3-certbot-nginx
sudo certbot --nginx
```
A sample configuration log is shown below.
```
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator nginx, Installer nginx
Enter email address (used for urgent renewal and security notices) (Enter 'c' to
cancel): bash@gmail.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf. You must
agree in order to register with the ACME server at
https://acme-v02.api.letsencrypt.org/directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(A)gree/(C)ancel: A

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Would you be willing to share your email address with the Electronic Frontier
Foundation, a founding partner of the Let's Encrypt project and the non-profit
organization that develops Certbot? We'd like to send you email about our work
encrypting the web, EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: N

Which names would you like to activate HTTPS for?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: rss.nayab.xyz
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate numbers separated by commas and/or spaces, or leave input
blank to select all options shown (Enter 'c' to cancel):
Obtaining a new certificate
Performing the following challenges:
http-01 challenge for rss.nayab.xyz
Waiting for verification...
Cleaning up challenges
Deploying Certificate to VirtualHost /etc/nginx/sites-enabled/default

Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: No redirect - Make no further changes to the webserver configuration.
2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for
new sites, or if you're confident your site works on HTTPS. You can undo this
change by editing your web server's configuration.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 2
Redirecting all traffic on port 80 to ssl in /etc/nginx/sites-enabled/default

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations! You have successfully enabled https://rss.nayab.xyz

You should test your configuration at:
https://www.ssllabs.com/ssltest/analyze.html?d=rss.nayab.xyz
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/rss.nayab.xyz/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/rss.nayab.xyz/privkey.pem
   Your cert will expire on 2022-08-03. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot again
   with the "certonly" option. To non-interactively renew *all* of
   your certificates, run "certbot renew"
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```
Now enable back the *Always Use HTTPS* option using the same path.

**Cloudflare dashboard -> Click on Domain name -> SSL/TLS -> Edge Certificates -> Enable Always Use HTTPS**

Now you can access your FreshRSS aggregator with the memorable domain/sub-domain name. For ex: [https://rss.nayab.xyz](https://rss.nayab.xyz)

The FreshRSS supports many useful plugins. To know more about plugin installations visit the [project official page](https://github.com/FreshRSS/Extensions)

## A few extra personal FreshRSS settings
Completely optional. These are my personal settings on how I use FreshRSS to read blog posts. Go to Settings (Gear icon on top right corner) -

 * *Reading -> Mark article as read -> Uncheck "when the article is viewed" and "while scrolling" options. -> Submit*
 * *Archiving -> Maximum number of articles to keep -> 10000*



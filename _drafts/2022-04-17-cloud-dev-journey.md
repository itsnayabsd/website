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

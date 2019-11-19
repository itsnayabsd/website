---
layout: post
category: linux
excerpt: Step by step tutorial on how to install nginx web server and configure it for multiple websites hosting.
comments: false
title: Configure Nginx web server on Ubuntu or Debian or Raspbian
google_adsense: false
---

```
sudo apt update
```

```
sudo apt install nginx
```
```
sudo /etc/init.d/nginx start
```
The following might not be required
```
sudo systemctl enable nginx
```

Remove files
```
sudo rm /etc/nginx/nginx.conf
```
Create same file with our configuration
```
events {
}

http {

	# Loading all mime types
	include mime.types;

	server {
		listen 80;
		# Domain name below. This can be ip address also
		server_name asstracker.in www.asstracker.in;
		# Website root path below
		root  /home/pi/demo;
		index index.html;
	}
}
```
Nginx uses Perl compatible regular expressions.
Src : [Wiki PCRE](https://en.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions)

To see all the configuration at one place
```
nginx -T
```
To check whether the new configuration is without any errors before reloading nginx server,
```
nginx -t
```
To check with which configurations nginx is built,
```
nginx -V
```

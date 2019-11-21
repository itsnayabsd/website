---
layout: post
category: linux
excerpt: Step by step tutorial on how to install nginx web server and configure it for multiple websites hosting.
comments: false
title: Configure Nginx web server on Ubuntu or Debian or Raspbian
google_adsense: false
---
The following configuration is tested on Ubuntu 18.04 and later versions, Debian 10 (Buster) and the Raspbian Buster Lite operating systems.

 * [Install nginx and verify test server](#install)
 * [Configure the localhost or domain](#conf_domain)
 * [Configure multiple virtual hosts for multiple apps or websites](#multiple_hosts)
 * Configure SSL certificate
 * Some troubleshooting commands


<hr id="install">
## Install nginx and verify test server
Update the repositories with the following command.
```
sudo apt update
```

Install the Nginx web server.
```
sudo apt install nginx
```
Enable auto start of Nginx on next boot.
```
sudo systemctl enable nginx
```
Check whether Nginx is running successfully with the following command.
```
sudo systemctl status nginx | grep "Active:"
```
The output should have **active (running)** in the result.
```
   Active: active (running) since Thu 2019-11-21 14:28:16 IST; 26s ago
```
If it's not, there must be some problem with the installation.

Now, open the browser and visit the address **http://127.0.0.1** in the address bar. The test server should be running and show the following greeting on the web page.
```
                Welcome to nginx!

If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.

For online documentation and support please refer to nginx.org.
Commercial support is available at nginx.com.

Thank you for using nginx.
```

<hr id="conf_domain">
##  Configure the localhost or domain

There is a default config file present for *localhost* in the path */etc/nginx/sites-available/default*. We will keep this for reference. Instead we will remove the shortcut of this file present in the folder */etc/nginx/sites-enabled/*.

```
sudo rm /etc/nginx/sites-enabled/default
```
We will recreate the same file with our localhost / domain configuration.
```
sudo vi /etc/nginx/sites-enabled/default
```
### If domain name available :
Put the following content in that file
```
server {
        listen 80;

        # Replace the following root path to your website or app folder
        root /path/to/your/website;

        # This is the order in which server searches for the file names.
        # If index.html is not found, it will search for index.htm and so on.
	index index.html index.htm index.nginx-debian.html;

        # Replace the following domain name with yours.
        # Or simply put localhost if domain is not available.
        server_name domain.com www.domain.com;
	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}
}

```
Don't forge to replace the **domain.com**, **www.domain.com** with your domain name. Or this can be ***localhost*** if you don't have domain name.

### If domain name is not available :
You can still configure server with localhost. Put the following content in that file
```
server {
        listen 80;

        # Replace the following root path to your website or app folder
        root /path/to/your/website;

        # This is the order in which server searches for the file names.
        # If index.html is not found, it will search for index.htm and so on.
	index index.html index.htm index.nginx-debian.html;

        # Replace the following domain name with yours.
        # Or simply put localhost if domain is not available.
        server_name localhost;
	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}
}

```

Replace **root** path also with your website path for any one of above configurations.

Before reloading the configuration, test whether the configuration syntax is correct or not with the following command.

```
sudo nginx -t
```
If syntax is correct, it will display following output.
```
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```
Reload the configuration with the following command.
```
sudo systemctl reload nginx
```

## ***Pointing domain name servers ip address ***

Visit the domain name or simply ***localhost*** in the browser to see your website working.

The above configuration for a single website/app is called ***virtual host***. We can configure more than one virtual hosts within the same config file.

<hr id="multiple_hosts">
## Configure multiple virtual hosts for multiple apps or websites.

First remove the configuration file created above if you are going to use the below configuration.

```
sudo rm /etc/nginx/sites-enabled/default
```
In the following configuration, we will be creating three virtual hosts for the domains **nayab.xyz**, **asstracker.in** and the blog **blog.nayab.xyz**.

Replace above domains with yours.

Create same file with our configuration
```
sudo rm /etc/nginx/sites-enabled/default
```
```
	server {
		# Domain name below. This can be ip address also
		server_name www.asstracker.in asstracker.in;

                # Replace the following root path to your website or app folder
		root  /home/pi/demo;

                # This is the order in which server searches for the file names.
                # If index.html is not found, it will search for index.htm and so on.
	        index index.html index.htm index.nginx-debian.html;

	        location / {
		        # First attempt to serve request as file, then
		        # as directory, then fall back to displaying a 404.
		        try_files $uri $uri/ =404;
	        }
	}
	server {
		# Domain name below. This can be ip address also
		server_name nayab.xyz www.nayab.xyz;

                # Replace the following root path to your website or app folder
		root  /home/pi/demoblog;

                # This is the order in which server searches for the file names.
                # If index.html is not found, it will search for index.htm and so on.
	        index index.html index.htm index.nginx-debian.html;

	        location / {
		        # First attempt to serve request as file, then
		        # as directory, then fall back to displaying a 404.
		        try_files $uri $uri/ =404;
	        }
	}
	server {
		# Domain name below. This can be ip address also
		server_name blog.nayab.xyz;

                # Replace the following root path to your website or app folder
		root  /home/pi/blog;

                # This is the order in which server searches for the file names.
                # If index.html is not found, it will search for index.htm and so on.
	        index index.html index.htm index.nginx-debian.html;

	        location / {
		        # First attempt to serve request as file, then
		        # as directory, then fall back to displaying a 404.
		        try_files $uri $uri/ =404;
	        }
	}
}
```
Replace **root** path also with your website path for any one of above configurations.

Before reloading the configuration, test whether the configuration syntax is correct or not with the following command.

```
sudo nginx -t
```
If syntax is correct, it will display following output.
```
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```
Reload the configuration with the following command.
```
sudo systemctl reload nginx
```
Now browse the domain name in the browser.
>>>>>>> Modify configure-nginx-ubuntu-debian-raspbian.md

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

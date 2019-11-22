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
 * [Check the configuration syntax before reloading the server](#check)
 * [Configure multiple virtual hosts for multiple apps or websites](#multiple_hosts)
 * Configure SSL certificate for domain names
 * [Some troubleshooting commands](#troubleshooting)


<hr id="install">
## Install nginx and verify test server
If you are using Raspberry Pi, [install Raspbian and take SSH of the board](/linux/rpi-local-dev-setup.html).

If you are using [digitalocean](https://m.do.co/c/e80679853c2f) to host your app or website, use [this tutorial](https://www.digitalocean.com/docs/droplets/how-to/create/) to create droplet and take SSH of the digitalocean droplet.

If you want to test the nginx configuration on your local Ubuntu/Debian system, open `Terminal` to proceed with the following tutorial.

First step is to update the repositories with the following command.
```
sudo apt update
```

Install the Nginx web server.
```
sudo apt install nginx
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

Now, open the browser and,
 * If you are using raspberry pi, visit the raspberry pi IP address in the address bar.
 * If you are using digitalocean droplet, enter the droplet IP address in the address bar. IP address can get from [digitalocean dashboard](https://cloud.digitalocean.com/).
 * If you are using local Ubuntu/Debian system enter **http://127.0.0.1** in the address bar.

The test server should be running and show the following greeting on the web page.
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
If you don't have any domain name to configure, skip this section and proceed to [next](#domain_not_available) for localhost configuration.
### If domain name available :
You need to point your domain dns server settings to your app/website host provider. I bought my domain from [Namecheap](https://namecheap.pxf.io/m356a) and I am using [digitalocean](https://m.do.co/c/e80679853c2f) to host my website and the [instructions given here for changing my domain name dns server settings to digitalocean](https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars). The process is similar for any host provider.

Once the above step is completed, the domain settings might take upto 24 hrs to take effect.

Meanwhile, put the following configuration in the *default* configuration file.
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
Don't forge to replace the **domain.com**, **www.domain.com** with your domain name.

Replace **root** path also with your website path for any one of above configurations.

<span id="domain_not_available"></span>
### If domain name is not available :
You can still configure server with localhost on your device. Put the following content in that file
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

Replace **root** path with your website path for any one of above configurations.
<hr id="check">
## Check the configuration syntax before reloading the server
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

Now in the browser address bar,
 * If domain name is configured, visit the domain name in the address bar.
 * If domain name is not configured, visit the IP address of digitalocean droplet or Raspberry PI or http://127.0.0.1 depends on the platform you are using.

The above configuration for a single website/app is called ***virtual host***. We can configure more than one virtual hosts within the same config file.

<hr id="multiple_hosts">
## Configure multiple virtual hosts for multiple apps or websites.

First remove the configuration file created above to start fresh with multiple virtual hosts.

```
sudo rm /etc/nginx/sites-enabled/default
```
In the following configuration, we will be creating three virtual hosts for the domains **nayab.xyz**, **asstracker.in** and the blog **blog.nayab.xyz**.

**Replace** above domains with yours. If you don't have domain names, replace these domain names with ***localhost:port*** values for each app/website. For example,
 * localhost:3000	# For website 1
 * localhost:4000	# For app 1
 * localhost:5000	# For app 2

Create same file with our configuration
```
sudo vi /etc/nginx/sites-enabled/default
```
```
	server {
		# Domain name below. This can be localhost:port also
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
```
Replace **root** path with your website or app path for everywhere.

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
Now browse the domain names or IP address along with the port number in the browser address bar. For example,
 * 192.168.1.10:3000, 192.168.1.10:4000 and 192.168.1.10:5000 for Raspberry Pi. Or
 * http://206.189.132.174:3000, http://206.189.132.174:4000 and http://206.189.132.174:5000 for digitalocean droplets.

<hr id="troubleshooting">
## Some troubleshooting commands

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

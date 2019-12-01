---
layout: post
title: Auto deploy node app on digitalocean using codeship
category: cloud
comments: true
google_adsense: true
excerpt: Step by step tutorial on how to automatically deploy nodejs web app hosted on github to digitalocean cloud platform using codeship build platform.
keywords: automatically deploy node app to digitalocean, nginx reverse proxy, point name servers to digitalocean, codeship build to digitalocean integration, run node app in the background using pm2, install ssl digitalocean droplet letsencrypt, deploy node app on production server
image: /assets/img/deploy_node_app_droplet_codeship.png
---

This tutorial explains how to deploy *node* application automatically to digitalocean droplet every time there is a new commit pushed to Github, Gitlab or Bitbucket.

Tested on the OS :
 * Ubuntu 18.04 and later
 * Debian 9 and later
 * Raspbian 9 and later

Following are the contents.
 * [Prerequisites](#prereq)
 * [Install PM2 npm module on digitalocean](#pm2)
 * [Setup node app git repository on digitalocean](#digirepo)
 * [Configure the project on Codeship](#codeship)
 * [Copy codeship SSH public key to digitalocean user account](#cpsshkey)
 * [Push a dummy commit to verify functionality](#dummypush)
 * [Configure Nginx as reverse proxy server](#revproxy)

`{% include image.html url="deploy_node_app_droplet_codeship.png" description="Deploy node app on drigitalocean droplet wiht codeship" %}`
<hr id="prereq"/>

## Prerequisites
It's already assumed that,
 * Your node app is already hosted on github / gitlab or bitbucket. If not, clone the *Hello World* app [from here](https://github.com/nayabbashasayed/node_hello_world.git) to your git hosting account.
 * You already have a Digitalocean account. If not, [Signup one on digitalocean](https://m.do.co/c/e80679853c2f).
 * [Initial server setup](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-debian-10) has been done on digitalocean.
 * [Already installed nodejs](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-debian-10) on digitalocean. I prefer installing node with *nvm*.
 * Your [domain nameservers should be pointed to digitalocean droplet](https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars). If you don't have a domain name yet, you can buy one [from Namecheap](https://namecheap.pxf.io/m356a), one of the lead domain name provider for less price.
<p class="isa_warning">Do not forget to <a href="https://www.digitalocean.com/docs/networking/dns/how-to/manage-records/#a-records)">add an A record</a> pointing to your droplet</p>
 * You already [installed Nginx with ssl certificates for your domain](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-debian-10).

<hr id="pm2"/>
## Install PM2 npm module on digitalocean
PM2 npm module allows your node application to run in the background, restarting the application without stopping it.

Login to digitalocean droplet using SSH and install the PM2 npm module.
```
ssh USERNAME@DROPLET_IP
```
Replace USERNAME and DROPLET_IP with your user account on digitalocean droplet and it's IP address respectively.

Install PM2 module.
```
npm install pm2 -g
```
<hr id="digirepo"/>
## Setup node app git repository on digitalocean
Git clone the node app repository to your droplet. Make sure you have access to the repository so that you can give permissions to the third party app called *codeship* in the next step.

```
git clone CLONE_URL
```
ex: `git clone https://github.com/nayabbashasayed/node_hello_world.git`

The following script is needed and will be invoked from codeship. Run the following commands in the terminal to create a script called `node_app_start` in home directory.
```
echo '#!/bin/sh' > ~/node_app_start
path=$(echo `which npm` | sed 's/.\{3\}$//')
echo "path=$path" >> ~/node_app_start
echo 'PATH=$PATH:$path' >> ~/node_app_start
echo "export PATH" >> ~/node_app_start
chmod +x ~/node_app_start 
```
<hr id="codeship"/>
## Configure the project on Codeship
> Codeship is a hosted continuous delivery service that focuses on speed, reliability and simplicity. You configure Codeship to build and deploy your application from GitHub to the staging or the production platform of your choice.

So we use codeshitp to deploy to digitalocean droplet when there is a new commit pushed to Github or Gitlab or Bitbucket.

Create an account on [https://codeship.com/](https://codeship.com/). After sign up, it will guide you through creating new project. Other way to create project is to click on `Projects` tab on top navigation bar.

### Creating a project
Creating a project involves three steps
 * *Select an SCM (Source code management)* : Select one among Github, Gitlab or Bitbucket. You may need to grant permissions to codeship from the selected SCM.
 * *Connect repository*: Select your node app here.
 * *Configure project*: Select *Codeship Basic*.

### Configure project settings
Now, the configuration takes you to *Project Settings* in which you see sub navigation bar with tabs `Tests`, `Deploy`, `Build Triggers` etc. Do the following steps.
#### Tests
In the *Setup Commands* window, type `npm install`. Go to the bottom of the page and click on `Save changes`.

{% include image.html url="codeship_tests_setup_commands.png" description="Codeship tests setup commands" %}

<br/>
#### Deploy
Click on *Deploy* buttion. Write the branch name and click on *Save Pipeline Settings*. On the next step, select the script under *Add Deployment* section.
{% include image.html url="codeship_deploy_branch.png" description="Codeship deploy branch" %}
<br/>
{% include image.html url="codeship_deploy_script.png" description="Codeship deploy script" %}
<br/>
 In the *Deployment Commands* window, add the following commands.
```
ssh USERNAME@DROPLET_IP 'cd PATH_TO_CLONED_NODE_REPO; git checkout master; git pull; source /home/$USER/node_app_start;npm install; npm restart || npm start;'

```
Replace *USERNAME*, *DROPLET_IP* and *PATH_TO_CLONED_REPO* with your digitalocean droplet credentials.
{% include image.html url="codeship_deploy_commands.png" description="Codeship deploy commands" %}
<br/>
Click on *Save Deployment*.

We can skip configuring remaining tabs except for the last tab `General`. We will configure that in the next step.
<hr id="cpsshkey"/>
## Copy codeship SSH public key to digitalocean user account
We need to allow codeship build system to login to our digitalocean droplet using SSH. For that we will be storing codeship SSH public key into our droplet.
### General
{% include image.html url="codeship_project_general.png" description="Codeship Project General Settings" %}
<br/>
Copy the SSH public key. Login to your droplet user account using SSH. Create and paste the key into **~/.ssh/authorized_keys** file.
<hr id="dummypush"/>
## Push a dummy commit to verify functionality
Create some dummy file with dummy content on your local laptop or desktop. Push that file to github/gitlab or bitbucket.

```
# On your local laptop or system
git clone https://github.com/nayabbashasayed/node_hello_world.git
cd node_hello_world
echo "codeship" > codeship
git add codeship
git commit -m "Codeship dummy"
git push origin master
```
As soon as the commit push finished, codeship started executing build scripts.

In your browser address bar, enter `http://DROPLET_IP:3000/` or `DOMAIN.COM:3000`. Ex: `http://139.59.61.221:3000/` or `nayab.xyz:3000`. Node runs on the port 3000 by default.

You should be greeted with your node app home page. In the above case, a white page with the message *Hello World!*.
<hr id="revproxy"/>
## Configure Nginx as reverse proxy server
Replace the `location / { .... }` block in your existing nginx config file with the below block of code.
```
  location / {
      proxy_pass http://localhost:3000/;
  }
```
The above code passes all the http requests receive to node server. We can now visit the above URLs without port numbers.

ex: *http://139.59.61.221* or *nayab.xyz*. The node app is loaded now on this address.


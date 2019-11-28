---
layout: post
category: cloud
excerpt: Step by step tutorial on how to automatically deploy nodejs web app hosted on github to digitalocean cloud platform.
comments: false
title: Automatically deploy nodejs web app from Github to digitalocean
google_adsense: false
---

Prerequisites :
It's already assumed that,
 * The node app is already hosted on github / gitlab or bitbucket. If not, clone the *Hello World* app [from here](https://github.com/nayabbashasayed/node_hello_world.git).
.eposIf it's not, clone the .
Setup digitalocean droplets and configuration. Point appropriate URLs for that.
Initial server setup. https://www.digitalocean.com/community/tutorials/initial-server-setup-with-debian-10 .
Configure web server and point domain name and install ssl certificates on digitalocean
install nodejs on digitalocean https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-debian-10
Install pm2 module

Git clone the repo. Make sure you have access to the repository so that you can give permissions to the third party apps. It is necessary for the next step.

Run the following commands in the terminal to create a script called `node_app_start` in home directory.
```
echo '#!/bin/sh' > ~/node_app_start
path=$(echo `which npm` | sed 's/.\{3\}$//')
echo "path=$path" >> ~/node_app_start
echo 'PATH=$PATH:$path' >> ~/node_app_start
echo "export PATH" >> ~/node_app_start
chmod +x ~/node_app_start 
```
Create an account on codeship.com. After sign up, it will guide you through creating new project. Other way to create project is to click on `Projects` tab on top navigation bar.

New project : Involves three steps
 * Select an SCM (Source code management) : Select one among Github, Gitlab or Bitbucket. You may need to grant permissions to codeship from the selected SCM.
 * Connect repository. Select your node app here.
 * Configure project. Select *Codeship Basic*.

Now, the configuration takes you to *Project Settings* in which you see sub navigation bar with tabs `Tests`, `Deploy`, `Build Triggers` etc. Do the following steps.
 * **`Tests`**: In the *Setup Commands* window, type `npm install`. Go to the bottom of the page and click on `Save changes`.

{% include image.html url="codeship_tests_setup_commands.png" description="Codeship tests setup commands" %}

<br/>
 * **`Deploy`**: Click on *Deploy* buttion. Write the branch name and click on *Save Pipeline Settings*. On the next step, select the script under *Add Deployment* section.
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

 * **`General`** :
{% include image.html url="codeship_project_general.png" description="Codeship Project General Settings" %}
<br/>
Copy the SSH public key. Login to digitalocean droplet using SSH. Paste the key into **~/.ssh/authorized_keys** file.

Create a droplet on digitalocean.
Take SSH into it.

 * Configure nginx server
    * Host multiple websites on single droplet
    * Host sub domains on single droplet
 * Configure domain name
 * Configure SSL certificates for core domain and sub domains

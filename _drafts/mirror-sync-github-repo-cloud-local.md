---
layout: post
title: Mirror and sync github repo with remote and local repositories
category: cloud
comments: false
google_adsense: false
excerpt:
keywords:
date: 2019-11-23 01:46:16 +5:30
image: /assets/img/nginx_conf_linux.png
---
Github, Gitlab, Bitbucker or any other code hosting platforms are great for hosting websites, apps or any other software. Each platform has it's own large user base. It would be great if our code base is in sync across all emerging platforms like these. I have seen some great software already doing this. For example [Linux kernel](https://www.kernel.org/) has it's own repository hosting at [https://git.kernel.org/](https://git.kernel.org/) and a [mirror exists on Github](https://github.com/torvalds/linux).

I am using [digitalocean](https://m.do.co/c/e80679853c2f) droplet as my own git hosting platform. Refer the [official documentation] (https://www.digitalocean.com/docs/droplets/how-to/) for setting up droplet and taking SSH into it. After that [add an user with sudo permissions](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-debian-10).

## Remote server configuration for own git repo hosting
### Creating --bare repositories
Login using SSH to digitalocean droplet with new user account.

```
ssh username@droplet_ip_addr  # ex: ssh pi@206.189.134.23
```
You can start an empty repository or clone an existing repository.

To start an empty repository, use the following command
```
git init --bare
```
To clone an existing repository, use *git clone --bare* option.

git clone --bare https://github.com/`username`/`repo`.git

For example, I am cloning my existing repository from the Github to digitalocean droplet.

`git clone --bare https://github.com/nayabbashasayed/website.git`

The *--bare* option allows this repo to receive/send push operations from/to remote repositories.

### Create empty repositories on other hosting platforms
#### Create empty repo on Gitlab
Visit [https://gitlab.com/](https://gitlab.com/) and create an empty repository and note down the repo URL. It looks something like this.

https://gitlab.com/`username`/`repository`.git
#### Create empty repo on Github
Visit [https://github.com/](https://github.com/) and create an empty repository. The repo URL looks like following.

https://github.com/`username`/`repository`.git`
#### Create empty repo on Bitbucket
Visit [https://bitbucket.org/](https://bitbucket.org/) and create an empty repository. The repo URL looks like this.

https://`username`@bitbucket.org/`username`/`repository`.git

ex: https://nayabbashasayed@bitbucket.org/nayabbashasayed/website.git
remote server*) every time I push some commit to my Github repository. I came across some solutions like [Jenkins](https://jenkins.io/), [Codeship](https://codeship.com/), [HookDoo](https://www.hookdoo.com/) etc. All these are third party apps that need to be configured, which I feel is additional overhead.

What I needed is without integrating third party apps
On remote :
git clone --bare https://github.com/nayabbashasayed/website.git

vi /home/pi/website.git/hooks/post-receive

#!/bin/sh

git --git-dir=/home/pi/website.git push -f origin master

To store username and password
vi ~/.git-credentials

https://my_username:my_password@github.com
Following line might not needed

git config --global credential.helper store


On local laptop/Desktop/Raspberry Pi :

clone the github repo on local system.
cd ~/cloned/repo/path

git remote add asst ssh://pi@192.168.1.10/home/pi/website

create dummy for testing.

git push asst master

![Raspbian On RPI](/assets/img/nginx_conf_linux.png )

---
layout: post
title: Sync github repo with remote and local repositories
category: cloud
comments: false
google_adsense: false
excerpt:
keywords:
date: 2019-11-23 01:46:16 +5:30
image: /assets/img/nginx_conf_linux.png
---
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

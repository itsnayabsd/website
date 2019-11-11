---
layout: post
category: cloud
excerpt: Step by step tutorial on how to deploy nodejs web app hosted on github to digitalocean cloud platform.
comments: false
title: Deploy nodejs web app on digitalocean
google_adsense: false
---
 * Select a LTS Linux distribution for digitalocean droplet and raspberry pi.
 * Make the local development setup using raspberry pi with the same LTS distribution.
    * Flash the image
    * Connect RaspberryPi to network and get ssh credentials
 * Install latest LTS node version.
 * Deploy github repository to digitalocean droplet.
 * Run the app and test in the browser
    * Install git hooks for CI/CD.
 * Configure nginx server
    * Host multiple websites on single droplet
    * Host sub domains on single droplet
 * Configure domain name
 * Configure SSL certificates for core domain and sub domains

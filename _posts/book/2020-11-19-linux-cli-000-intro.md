---
title : Learning Linux Command Line
layout : post
category : book
date: 2020-11-19 22:02:33 +5:30
comments: true
google_adsense: true
excerpt : A series of articles/tutorials explaining the everyday useful Linux commands along with the detailed examples.
kerwords : Linux Command Line Interface, Linux cli, Linux commands, Learn Linux commands in Ubuntu, Linux commands for begineers, Linux commands tutorial, Linux commands book.
image : /assets/img/linux-cli-book.png
toc : true
---
## Introduction

Linux is the main part or kernel of an Unix-like operating system. Whenever the term 'Linux' appears, it actually means Linux kernel. Operaing systems built based on Linux kernel are generally referred as Linux distributions. Examples of Linux distributions are Debian, Ubuntu, Fedora, Red Hat Linux, Linux Mint, Cent OS et cetera. Thousands of Linux distributions are freely available for downloading.

{% include image.html url="linux-cli-book.png" description="Learning Linux Command Line" %}

Command Line Interface is the way you communicate with your computer. Mastering Command Line means full control over your computer. That is the freedom most of the geeks are talking about. Since we are talking about Command Line here, and working actually with Linux kernel, any Linux distribution is fine for learning. Note that the terms Command Line, Shell or Bash refers to the same.

Every Linux distribution comes with an user interface (UI) through which we can access Command Line or Shell or Bash. This UI is called Terminal Emulator. Examples for terminal emulators are gnome-terminal or konsole et cetera. This name differs with respective Desktop Environment (DE). In Gnome DE, terminal emulator is called gnome-terminal and in KDE it is called Konsole. Whatever the name may be, its functionality is same.

Let's begin by installing any one of the Linux distributions. There are numerous tutorials available online. Just google it.

## Learning path
Consider following list of articles as a *table of contents* or the *overview of the learning path*.
{% assign cat = "linux-cli" %}
<ul class="list-none">
{% for category in site.categories %}
{% if category.first == cat %}
{% assign sorted = (category[1] | sort: 'url') %}
{% for posts in sorted %}
<li><a class="post-link" href="{{ posts.url }}">{{ posts.title }}</a></li>
{% endfor %}
{% endif %}
{% endfor %}
</ul>


**More articles coming**....

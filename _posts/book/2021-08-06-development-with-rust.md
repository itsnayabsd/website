---
title : Development with Rust
layout : post
category : book
date: 2021-08-06 18:14:31 +5:30
comments: true
google_adsense: true
excerpt : 
kerwords :
image : /assets/img/rpi3b-elinux-intro.png
toc : true
---
## Introduction

{% include image.html url="rpi3b-elinux-intro.png" description="Embedded Linux with Rapsberry Pi 3 Model B" %}
## Requirements

## Why Raspberry Pi

## Learning path
Consider following list of articles as a *table of contents* or the *overview of the learning path*.
{% assign cat = "rust" %}
<ul class="list-none">
{% for category in site.categories %}
{% if category.first == cat %}
{% assign sorted = (category[1] | sort: 'url') %}
{% for posts in sorted %}
<li><a class="post-link" href="{{ posts.url }}">{{ posts.title | remove : "for Raspberry Pi 3 Model B" | remove : "of Raspberry Pi 3 Model B" | remove : "with Raspberry Pi 3 Model B"}}</a></li>
{% endfor %}
{% endif %}
{% endfor %}
</ul>


**More articles coming**....

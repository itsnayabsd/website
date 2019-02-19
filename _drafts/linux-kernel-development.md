---
layout: post
title: Linux kernel development
category: linux
comments: true
google_adsense: false
excerpt: 
date: date: 2019-02-17 16:03:31 +5:30
---
## Building out of tree kernel module

Documentation for building external kernel module is available [here](https://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git/tree/Documentation/kbuild/modules.txt). The same is available in the Linux kenel source tree at path `Documentation/kbuild/modules.txt`.

### Installing Linux kernel headers

If kernel module need to be built for already running kernel in a Linux distro like Ubuntu / Debian or Linuxmint then, header files can be downloaded with,

`sudo apt-get install linux-headers-$(uname -r)`

If latest kernel is downloaded from [official](https://www.kernel.org/) website and built, then it has the configuration and header files already to build external kernel module. The external module built from this kernel can't be loaded into the system which is running other version of kernel. Once we install this kernel into system and boot from it, we can insert the module.

<!--after two or more paragraphs-->

  {% if jekyll.environment == 'production' and page.google_adsense %}
  {% include goog_inart_2par.html %}
  {% endif %}


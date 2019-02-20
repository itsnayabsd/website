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

Above command can be skipped, if latest Linux kernel source is downloaded from official git repository.

<!--after two or more paragraphs-->

  {% if jekyll.environment == 'production' and page.google_adsense %}
  {% include goog_inart_2par.html %}
  {% endif %}

### Building and installing latest kernel source

To download latest kernel source,

```
git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
```

To build the kernel,
```
make localmodconfig
make -j4
make modules
sudo make modules_install
sudo make install
```

### Submitting patches

Documentation for the process of submitting patches can be found [here](https://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git/tree/Documentation/process/submitting-patches.rst)

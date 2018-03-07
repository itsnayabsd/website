---
title: Important Repositories
layout: post
excerpt: Repositories of tools and packages that would be useful for developers.
category: me
comments: false
google_adsense: false
---
## VIM Editor
{% highlight bash %}
$ git clone https://github.com/vim/vim.git
$ cd vim/src
$ sudo apt-get install ncurses-dev
$ make
$ make test
$ sudo make install
{% endhighlight %}
If something wrong happens, then install vim with
{% highlight bash %}
$ sudo apt install vim
{% endhighlight %}

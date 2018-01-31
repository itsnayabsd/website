---
layout: post
date: 2017-02-05 17:46:46 +5:30
title: Jekyll Package Post Installation.
excerpt: Things to do After Installing Jekyll Package
category: web
comments: false
google_adsense: false
---
1\. To install jekyll on Ubuntu based system
```
sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
sudo apt-get install ruby-full 
```
Install `jekyll` and `bundler` using this
{% highlight bash %}
$ sudo gem install jekyll bundler 
{% endhighlight %}
Go to the project directory and install supporting packages using `bundler`
{% highlight bash %}
$ bundler install 
{% endhighlight %}

2\. Add an alias for date in <code>.bashrc</code> file.
One of the formats supported by jekyll is like <code>2017-02-05 19:25:49 +5:30</code>. 
Open <code>.bashrc</code> file.
{% highlight bash %}
$ vi ~/.bashrc
{% endhighlight %}
And add following line at the end of file.
<pre>alias jdate='echo "date: $(date "+%F %T") +5:30"'</pre>

3\. Add aliases for building in .bashrc file.
<pre>alias jbuild='JEKYLL_ENV=production bundle exec jekyll build'
alias jserve='bundle exec jekyll serve'
alias jdserve='bundle exec jekyll serve --detach'
alias jkill='pkill -f jekyll'</pre>

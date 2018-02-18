---
layout: post
date: 2017-02-05 17:46:46 +5:30
title: Jekyll Package Post Installation.
excerpt: Things to do After Installing Jekyll Package
category: web
comments: false
google_adsense: false
---
## To install jekyll on Ubuntu based system
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

## Add the following aliases in <code>.bashrc</code> file.
Open <code>.bashrc</code> file.
```
$ vi ~/.bashrc
```
And add following aliases at the end of file.
```
alias jdate='echo "date: $(date "+%F %T") +5:30"'
alias jbuild='JEKYLL_ENV=production bundle exec jekyll build'
alias jserve='bundle exec jekyll serve'
alias jdserve='bundle exec jekyll serve --detach'
alias jkill='pkill -f jekyll'
```
```
source ~/.bashrc
```
## Create a vim template for markdown files
```
mkdir -p ~/.vim/templates
vi ~/.vim/templates/md.skeleton
```
Add following line to `md.skeleton` file
<pre>---
layout:
title:
category:
comments:
google_adsense:
excerpt:
date:
thumbnail:
rating: '5'
---</pre>
```
vi ~/.vimrc
```
Add following line to `~/.vimrc` file.
```
autocmd BufNewFile *.md 0r $HOME/.vim/templates/md.skeleton
```

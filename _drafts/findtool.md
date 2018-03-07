---
layout: post
excerpt: Linux <code>find</code> command examples for every day developer programming.
title: find command examples
category: linux-tools
comments: false
google_adsense: false
---
* Search only regular files. This excludes directories and all other types of files.

{% highlight bash %}
find -type f -name "wifi"
{% endhighlight %}
Above command searches for files named `wifi`. It excludes any directories named wifi.

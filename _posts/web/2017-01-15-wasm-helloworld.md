---
layout: post
title: 	WebAssembly Hello World!
date: 2017-01-15 15:56:32 +05:30
excerpt: A quick guide to install WebAssembly environment, compile and run 'Hello World!' C program to WebAssembly code and to display the output in html web page.
category: web
comments: true
google_adsense: true
---

{% include image.html url="arithmetic-wasm.png" description="Arithmetic calculation using WebAssembly" %}

The web is about to get a lot faster by using WebAssembly (wasm). It's main focus is to convert the code written in C/C++ into webassembly byte code.

This page is a quick guide to install all the packages related to WebAssembly, compile and run a simple Hello World! C program into WebAssembly and to execute that code in browser.

Following are the steps to install necessary tools on Ubuntu Linux distribution.

<h2>Installation</h2>

Execute following commands in Terminal for <code>git</code> and <code>cmake</code>.

{% highlight bash %}
$ sudo apt-get install git
$ sudo apt-get install cmake
{% endhighlight %}

For Python 2.7.x follow instructions <a href="https://wiki.python.org/moin/BeginnersGuide/Download"> here</a>.

For compiling Emscripten from Source

{% highlight bash %}
$ git clone https://github.com/juj/emsdk.git
$ cd emsdk
$ ./emsdk install sdk-incoming-64bit binaryen-master-64bit #This will take a lot time to compile.
$ ./emsdk activate sdk-incoming-64bit binaryen-master-64bit
{% endhighlight %}

Execute the following command to enable all Emscripten compiler environmental variables. If new terminal is opened, this command needs to be re-executed.
{% highlight bash %}
$ source ./emsdk_env.sh
{% endhighlight %}

<h2>Compiling Hello World! C program into WebAssembly</h2>
Create a directory called <code>hello</code>.
{% highlight bash %}
$ mkdir hello
$ cd hello
{% endhighlight %}

Save following C program into <code>hello.c</code> file.

{% highlight C %}
#include <stdio.h>

int main(int argc, char ** argv)
{
	printf("Hello World!");
	return 0;
}
{% endhighlight %}

Compile above code using Emscripten compiler. To run this program in html page, specify ouput file name with <code>.html</code> extension (Here it is <code>hello.html</code>). This html page runs our program in browser.

{% highlight bash %}
$ emcc --emrun hello.c -s WASM=1 -o hello.html
{% endhighlight %}
Now <code>hello.html</code> is created. Since WebAssembly is in development state, we need to use latest development versions of Chrome and Firefox. Download either <a href="https://www.google.com/chrome/browser/canary.html"><code>Chrome Canary</code></a> or <a href="https://nightly.mozilla.org/"><code>Firefox Nightly</code></a>.

This example is tested on Firefox Nightly. To download firefox nightly:
{% highlight bash %}
$ sudo apt-get install firefox-trunk
{% endhighlight %}

To enable wasm on these browsers, for Chrome: open <code>chrome://flags/#enable-webassembly</code> in url field and click on enable. For firefox: open <code>about:config</code> in url field, search for wasm and double click on <code>javascript.options.wasm</code> to set it to <code>true</code>. After enabling wasm support <code>Restart</code> the browser.

This web page, <code>hello.html</code> can't be opened directly using browser. Instead a running server is needed to view <code>hello.html</code> in action. Run following command to run HTTP server.
{% highlight bash %}
$ emrun --no_browser --port 8080 .
{% endhighlight %}

Now open the web page in your browser by entering following line in url field.
<pre>http://localhost:8080/hello.html</pre>

You should be seeing <code>Hello World!</code> on the output console.

{% include image.html url="hello-world-wasm.png" description="Hello World! C program compiled into WebAssembly" %}

<h3>References</h3>

{% include anchor_blank.html url="https://medium.com/javascript-scene/what-is-webassembly-the-dawn-of-a-new-era-61256ec5a8f6#.1flwb93vt" value="What is WebAssembly?" %}
{% include anchor_blank.html url="https://blog.mozilla.org/blog/2014/03/12/mozilla-and-epic-preview-unreal-engine-4-running-in-firefox/" value="Mozilla and Epic Preview Unreal Engine 4 Running in Firefox" %}
{% include anchor_blank.html url="http://www.2ality.com/2015/06/web-assembly.html" value="WebAssembly: a binary format for the web" %}

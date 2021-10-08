---
layout: post
date: 2021-10-03 14:51:20 +5:30
title: Escape Codes in Linux
excerpt: Style Your Terminal Text With Escape codes (or Sequences) In Linux. Print colored output text or change text background color in Linux terminal using escape sequences.
category: linux
comments: true
google_adsense: true
keywords : Linux terminal escape codes, Linux console escape sequences, Linux terminal escape sequences, color Linux terminal text, output colored text to terminal, change color of text in Linux terminal, customize text color on Linux terminal, change text background color in Linux terminal, ANSI color escape sequences, ANSI color escape codes for the text.
image : /assets/img/escape-codes.png
---

{% include image.html url="escape-codes.png" description="Terminal text styling with escape codes" %}

ANSI escape codes can be used to style the output of <code>echo</code> or <code>printf</code>. An escape code is a sequence of characters start with an <kbd>ESC</kbd> character, followed by second character in the ASCII range <code>64</code> to <code>95</code>. This sequence can be of different length.<!--more-->

The general format of escape code for styling the terminal text is:<br/>
<code>ESC</code><code>[</code><code>{attr1};{attr2};....{attrn)m</code>.

Note that above escape code sequece ends with <kbd>m</kbd> and there is no <kbd>;</kbd> before that.

The ASCII equivalent of <code>ESC</code> character is 033(in decimal) or 0x1b(in hexa). We use 033 because it works for all operating systems.

Some examples for escape codes are:
<pre>
'\033[0m'       #Reset text
'\033[0;33m'    #Yello color text
'\033[42m'      #Green background
'\033[1;42m'    #Bold text with Green background
</pre>

If we examine the code <code>'\033[1;42m'</code>,
<div class="overflow">
<table>
<tr><th>\033</th><th>[</th><th>1</th><th>;</th><th>42</th><th>m</th></tr>
<tr><td>Octal value of <code>ESC</code> char.</td><td>left square bracket</td><td>Attribute 1 (bold)</td><td>Divider</td><td>Attribute 2 (Green)</td><td>Ending Char.</td></tr>
</table>
</div>

<h3>Usage with <code>echo</code></h3>
{% highlight bash %}
$ echo -e '\033[1;42m'This is text with green background
{% endhighlight %}
Don't forget to use <code>-e</code> option along with <code>echo</code> command. Any text following the above code sequence will print with green background color.

<h3>Usage with <code>printf</code></h3>
{% highlight bash %}
$ printf '\033[1;42m'This is text with green background
{% endhighlight %}

<h3>Text Formatting</h3>

Examples of text formatting:

<table>
<tr><th>Value</th><th>Escape Code</th><th>Text Style</th></tr>
<tr><td>0</td><td>'\033[0;31m'</td><td>Regular</td></tr>
<tr><td>1</td><td>'\033[1;31m'</td><td>Bold</td></tr>
<tr><td>2</td><td>'\033[2;31m'</td><td>Low Intensity</td></tr>
<tr><td>3</td><td>'\033[3;31m'</td><td>Italic</td></tr>
<tr><td>4</td><td>'\033[4;31m'</td><td>Underline</td></tr>
<tr><td>5</td><td>'\033[5;31m'</td><td>Blinking</td></tr>
<tr><td>6</td><td>'\033[6;31m'</td><td>Reverse</td></tr>
<tr><td>7</td><td>'\033[7;31m'</td><td>Background</td></tr>
<tr><td>8</td><td>'\033[8;31m'</td><td>Invisible</td></tr>
</table>


{% include image.html url="terminal-text-decoration.png" description="Terminal text decoration escape codes" %}


<h3>Text Colour</h3>

Examples of text color:

<table>
<tr><th>Value</th><th>Escape Code</th><th>Text Color</th></tr>
<tr><td>30</td><td>'\033[0;30m'</td><td>Black</td></tr>
<tr><td>31</td><td>'\033[0;31m'</td><td>Red</td></tr>
<tr><td>32</td><td>'\033[0;32m'</td><td>Green</td></tr>
<tr><td>33</td><td>'\033[0;33m'</td><td>Yello</td></tr>
<tr><td>34</td><td>'\033[0;34m'</td><td>Blue</td></tr>
<tr><td>35</td><td>'\033[0;35m'</td><td>Magenta</td></tr>
<tr><td>36</td><td>'\033[0;36m'</td><td>Cyan</td></tr>
<tr><td>37</td><td>'\033[0;37m'</td><td>White</td></tr>
</table>


{% include image.html url="terminal-text-color.png" description="Terminal text color escape codes" %}

<h3>Background Colour</h3>

Examples of Background color:

<table>
<tr><th>Value</th><th>Escape Code</th><th>Background Color</th></tr>
<tr><td>40</td><td>'\033[0;40m'</td><td>Black</td></tr>
<tr><td>41</td><td>'\033[0;41m'</td><td>Red</td></tr>
<tr><td>42</td><td>'\033[0;42m'</td><td>Green</td></tr>
<tr><td>43</td><td>'\033[0;43m'</td><td>Yello</td></tr>
<tr><td>44</td><td>'\033[0;44m'</td><td>Blue</td></tr>
<tr><td>45</td><td>'\033[0;45m'</td><td>Magenta</td></tr>
<tr><td>46</td><td>'\033[0;46m'</td><td>Cyan</td></tr>
<tr><td>47</td><td>'\033[0;47m'</td><td>White</td></tr>
</table>


{% include image.html url="terminal-text-bg-color.png" description="Terminal text color escape codes" %}

<h3> Random Text Style Attributes</h3>

One or more attributes can be clubbed together for more styling.

{% include image.html url="random-text-attributes.png" description="Random Text Style Attributes" %}

<h3> A simple color echo solution for shell scripts</h3>

Save the following code in a file, let's say <code>cecho.sh</code>

{% highlight bash %}
cecho() {
	local code="\033["
	case "$1" in
		black  | bk) color="${code}0;30m";;
		red    |  r) color="${code}1;31m";;
		green  |  g) color="${code}1;32m";;
		yellow |  y) color="${code}1;33m";;
		blue   |  b) color="${code}1;34m";;
		purple |  p) color="${code}1;35m";;
		cyan   |  c) color="${code}1;36m";;
		gray   | gr) color="${code}0;37m";;
		*) local text="$1"
			esac
			[ -z "$text" ] && local text="$color$2${code}0m"
			echo -e "$text"
}
{% endhighlight %}

Including the above file in any shell script will allow us to print color text on terminal.

Let's say file <code>display.sh</code> has the following content.

{% highlight bash %}
#!/bin/sh
. /path/to/cecho.sh

cecho red "This is red text"
{% endhighlight %}

Now executing second shell script will display output in red color.
<pre>$ bash display.sh</pre>

{% include image.html url="cecho-red-text.png" description="color text on terminal using shell script" %}

<h3>References</h3>

{% include anchor_blank.html url="http://misc.flogisoft.com/bash/tip_colors_and_formatting" value="bash:tip_colors_and_formatting" %}
{% include anchor_blank.html url="http://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux" value="Stackoverflow: Change echo output" %}
{% include anchor_blank.html url="http://www.termsys.demon.co.uk/vtansi.htm" value="Terminal color escape sequences" %}

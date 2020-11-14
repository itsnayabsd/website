---
title : Redirection to and from Files
layout : linux-cli-post
category : linux-cli
date : 2020-11-13 23:47:44 +5:30
comments : true
google_adsense: true
excerpt : 
keywords : 
image : /assets/img/rpi3b-elinux-toolchain.png
toc : true
---
There may be cases where we want to store the output in a separate disk file rather than just displaying on the screen. And there is need to read data from the disk file as an input for some program. This is why redirection matters.

Redirecting to Disk File

Generally the output will be displayed on screen when we run any command :

```bash
me@linux ~ $ ls
Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
```
Redirection operators are used to redirect output and error messages to separate disk file.

Redirection Operators

| Operator	| Operation |
|--|--|
| >|	Redirects Output to a disk file. If file already exists, it overwrites.|
| >>|	Redirects Output to a disk file. If file already exists, output will be appended to the content of the file.|

To redirect ls output to a disk file called output.txt:

```bash
me@linux ~ $ ls > output.txt
```
A text file with name output.txt is created in your home folder with output of the ls. How do we check the content of that file through command line? There is special command called less for this purpose.

```bash
me@linux ~ $ less output.txt 
```
The output will be displayed as shown below.

```
Desktop
Documents
Downloads
Music
output.txt
Pictures
Public
Templates
Videos
output.txt (END) 
```
Press Q to return to shell prompt.

Now we want to add the output of command ls /usr/bin to the existed file output.txt. If we run the command ls /usr/bin > output.txt, it will overwrite the file with fresh content. To retain old content in the file and to append new output to existed file, we have to use >> operator.

```bash
me@linux ~ $ ls /usr/bin >> output.txt 
```
Check the content with less output.txt command.

The status or error messages generated for any reason, are not redirected to disk file if we use redirection operations like above method.

```bash
me@linux ~ $ ls /usr/none > output-err.txt
ls: cannot access /usr/none: No such file or directory
```
In the above example, /usr/none is a non existed directory. So it generates an error message. Instead of just redirecting error message to disk file output-err.txt, it is displayed on the screen.

Generally when we run some command, the output is sent to standard output stream and then to screen. If error or status messages are generated, those are sent to standard error stream and then to the screen. By default when we use > or >> operator, the output from the standard output stream (stdout) is redirected to disk file, but not from standard error (stderr) stream.

To redirect error message or status message to disk file, we have to use file descriptor.

|Stream	|File Descriptor|
|--|--|
|Standard Input (stdin)	|0|
|Standard Output (stdout)|	1|
|Standard Error (stderr)|	2|

If we try again to redirect error message for ls /usr/none command using file decriptor :

```bash
me@linux ~ $ ls /usr/none 2> output-err.txt
```
Check the content with less output-err.txt command. The result will be :

```
ls: cannot access /usr/none: No such file or directory
output-err.txt (END)
```
Press Q to return to shell prompt.

To send both standard output messages and standard error messages to disk files :

```bash
me@linux ~ $ ls ~ /usr/none &> output-both.txt
```
The result will be :

```
ls: cannot access /usr/none: No such file or directory
/home/me:
Desktop
Documents
Downloads
Music
output-both.txt
output-err.txt
output.txt
Pictures
Public
Templates
Videos
output-both.txt (END)
```
Up to now we have seen that, redirection from stdout and stderr streams to disk file. Now we will see redirecting content form stdin stream to disk file.

For this, we use the command cat.

Whenever we enter something from keyboard, it goes to stdin stream. cat command redirects input from stdin stream to a disk file or to standard output stream (screen).

Simply type cat and press Enter.

```bash
me@linux ~ $ cat
```
It waits for us to type something. Try typing some text. When finished press Ctrl+D. Whatever you typed will be displayed again on screen. That is the content you typed is redirected from stdin to stdout.

```bash
me@linux ~ $ cat
Some text
Some text
```
To redirect content from stdin (keyboard) to diskfile:

```bash
me@linux ~ $ cat > output-test.txt
```
When prompted type some text. Here I typed This is the first sentence. This is second sentence.. And press Ctrl+D when done. Check the result with less output-test.txt command. Here is the result:

```
This is the first sentence. This is second sentence.
output-test.txt (END)
```
Redirecting From Disk File

cat command concatenates files. It redirects data from one or more files to the single file.

```bash
me@linux ~ $ cat output-both.txt output-err.txt > output-cat.txt
```
The content of output-both.txt and output-err.txt is redirected to output-cat.txt. Check the result with less output-cat.txt command.


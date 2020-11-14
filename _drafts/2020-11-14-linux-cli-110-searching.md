---
title : File Searching
layout : linux-cli-post
category : linux-cli
date : 2020-11-14 11:19:48 +5:30
comments : true
google_adsense: true
excerpt : 
keywords : 
image : /assets/img/rpi3b-elinux-toolchain.png
toc : true
---
Searching for a file or directory is difficult when there are hundreds or thousands of files. Especially if we want to search based on its property. Linux has got tools for these requirements.

* grep
* locate
* find

Searching with grep command

grep searches for a word in a given file.

```bash
me@linux ~ $ ls /usr/share > test.txt
me@linux ~ $ grep mode test.txt
recovery-mode
usb_modeswitch
```

Instead of redirecting the output from ls /usr/share to test.txt file, the same output can be sent as input to the grep command. This process is called pipelining.

```bash
me@linux ~ $ ls /usr/share | grep mode
recovery-mode
usb_modeswitch
```
Searching with locate command

locate command searches for a word in a database, which consists of all file locations.

```bash
me@linux ~ $ locate zip
```

The above command will give a large result. If it won't stop, press Ctrl + C. This result usually consists of all file locations which has string 'zip'. This may be a file name or a directory name.

```bash
me@linux ~ $ locate bin/zip
/usr/bin/zip
/usr/bin/zipcloak
/usr/bin/zipdetails
/usr/bin/zipgrep
/usr/bin/zipinfo
/usr/bin/zipnote
/usr/bin/zipsplit
```
Above result displays all file locations, which consists of string 'bin/zip'.

Here is another example:

```bash
me@linux ~ $ locate sr/bin/z
/usr/bin/zdump
/usr/bin/zenity
/usr/bin/zip
/usr/bin/zipcloak
/usr/bin/zipdetails
/usr/bin/zipgrep
/usr/bin/zipinfo
/usr/bin/zipnote
/usr/bin/zipsplit
/usr/bin/zjsdecode
/usr/bin/zlib-flate
/usr/bin/zsoelim
```
Newly downloaded or created files/folders may not be displayed in the result when we search using locate program. Let's download a file and check this operation.

```bash
me@linux ~ $ wget ftp://ftp.embeddedlookup.com/einstein.jpg
```
This will download an image 'einstein.jpg' in home folder.

```bash
me@linux ~ $ locate einstein.jpg
```
Above command displays nothing if it won't find the file. Database has to be updated to display the file in result.

```bash
me@linux ~ $ sudo updatedb
me@linux ~ $ locate einstein.jpg
home/me/einstein.jpg
```
Searching for files using find command

To display all your files in your home folder:

```bash
me@linux ~ $ find ~
```
Above result includes hidden files too. That's the reason the list is so long.

To count total number of files in your folder:

```bash
me@linux ~ $ find ~ | wc -l
15378
```
wc -l command counts total number of lines in the result. Each line represents a file location.

To count total number of directories:

```bash
me@linux ~ $ find ~ -type d | wc -l
347
```
To count total number of regular files:

```bash
me@linux ~ $ find ~ -type f | wc -l
15028
```
Using find command with -name option

To find all jpg image files:

```bash
me@linux ~ $ find ~ -type f -name "*.jpg"
/home/me/einstein.jpg
```

Try command me@linux ~ $ find ~ -type f -name "*.png". This will give all default png images in your home directory (possibly in hidden folders).

Here is an example if we remember only part of file name:

```bash
me@linux ~ $ find ~ -type f -name "*stein*"
/home/me/einstein.jpg
```
Operators can also be used when we want to do one or more operations using find. General operators are and, or and not.

```bash
me@linux ~ $ find ~ \( -type f -name "*stein*" \) -or \( -type f -name "*.txt" \)
/home/me/.config/chromium/chrome_shutdown_ms.txt
/home/me/.pki/nssdb/pkcs11.txt
/home/me/einstein.jpg
/home/me/yoyo.txt
/home/me/yoyoyo.txt
/home/me/.mozilla/firefox/mwad0hks.default/SiteSecurityServiceState.txt
/home/me/test.txt
/home/me/yo.txt
```
Don't forget to include space before and after '\('.


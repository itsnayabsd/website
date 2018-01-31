---
layout: post
title: Linux Command Line Google Drive Sync Tool
category: linux-tools
comments: true
google_adsense: true
excerpt: >-
  Rich featured command line tool `drive` to sync google drive account in a
  Linux based operating system (Debian or Ubuntu derived systems, Fedora based
  systems or any other Linux distribution).
date: 2018-01-27T18:41:24.000Z
thumbnail: /assets/img/google+drive.jpg
rating: '5'
---
## Installing dependencies

### Download `go` prgramming tools

```
wget -c https://dl.google.com/go/go1.9.3.linux-amd64.tar.gz
```

### Installing `go` programming tools

```
sudo tar -C /usr/local -xzf go1.9.3.linux-amd64.tar.gz
```

```
cat << ! >> ~/.bashrc
export PATH=$PATH:/usr/local/go/bin
!
```

### Set GOPATH `env` variable

```
cat << ! >> ~/.bashrc
export GOPATH=\$HOME/gopath
export PATH=\$GOPATH:\$GOPATH/bin:\$PATH
!
```

```
source ~/.bashrc
```

## Installing `drive`

### For `Debian` or Debian based systems

```
sudo apt-get install software-properties-common dirmngr
```

```
sudo apt-add-repository 'deb http://shaggytwodope.github.io/repo ./'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7086E9CC7EC3233B
sudo apt-key update
sudo apt-get update
sudo apt-get install drive
```

### For `Ubuntu` or Ubuntu based systems

```
sudo add-apt-repository ppa:twodopeshaggy/drive
```

```
sudo apt-get update
sudo apt-get install drive
```

### For `Fedora` based systems

```
dnf copr enable vaughan/drive-google
```

```
dnf install drive-google
```
## Working with `drive`
### Authentication with google drive account
Create a folder for syncing google drive files.
```
mkdir ~/GDrive
cd ~/GDrive
```
Use the following command to add your google account to the current folder.
```
drive init
```
This will produce the output like below:
```
Visit this URL to get an authorization code
https://accounts.google.com/o/oauth2/auth?access_type=offline&client_id=354770936074-7rrlnmfgsfgamgg1i4feed1245duq871bvd.apps.googleusercontent.com&redirect_uri=urn%3Aigtf%3Atg%3Aoauth%3A2.0%3Apob&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive&state=2018-01-31+23%3A02%3A5d8.54082288+%2B0530+IST2599896162
Paste the authorization code: 
```
Note the URL from the output. In my case the URL is:
```
https://accounts.google.com/o/oauth2/auth?access_type=offline&client_id=354770936074-7rrlnmfgsfgamgg1i4feed1245duq871bvd.apps.googleusercontent.com&redirect_uri=urn%3Aigtf%3Atg%3Aoauth%3A2.0%3Apob&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive&state=2018-01-31+23%3A02%3A5d8.54082288+%2B0530+IST2599896162
```
Copy the URL link from the above output and paste it into the browser. Follow the on-screen instructions for your account and it will provide the authorization code. It looks like this:
```
4sgsfgb8GW5bjE98yLDxTWsgNHcnUdssfgUacfiMpGR9KK
```
Paste the code in the terminal and press <kbd>Enter</kbd>. Now your google drive files are ready to be synced in the current folder.
### Pull your files
```
drive pull
```
This might take some time for analysing your google drive data. After the completion of analysing part, it prompts you with list of downloadable files, size. Press <kbd>Y</kbd> to start downloading files.
```
Addition count 124 src: 466.47MB
Proceed with the changes? [Y/n]:
```

In case, if your google drive files name have an invalid characters, `drive` throws you with the following error:
```
clashes detected. Use `ignore-name-clashes` to override this behavior or `fix-clashes` to try fixing this
```
This can be rectified using the following command:
```
drive clashes -fix
```
After that try pulling with `drive pull` command.
### Making changes
You can edit, create or delete files locally. To view your changes, use the following command:
```
drive diff
```
The output might be something like this:
```
File: /Others/wpa_supp_logs.txt
* local:          2018-01-31T18:00:01.000Z                
* remote:         2016-08-04T12:07:22.000Z                
wpa_supp_logs.txt
****

--- /home/nayab/GDrive/Others/wpa_supp_logs.txt	2018-01-31 23:30:00.604117061 +0530
+++ .xtmp3916589616287113937.tmp229874439	2018-01-31 23:30:19.360313667 +0530
@@ -13,6 +13,14 @@
 Line: 1 - start of a new network block
 ssid - hexdump_ascii(len=4):
      77 6f 6c 66                                       wolf            
+key_mgmt: 0x2
+PSK (ASCII passphrase) - hexdump_ascii(len=9): [REMOVED]
+pairwise: 0x10
+group: 0x10
+proto: 0x3
+PSK (from passphrase) - hexdump(len=32): [REMOVED]
+Priority group 0
+   id=0 ssid='wolf'
 athr: Driver version 
 call80211ioctl: 5 op=0x8be1 (GETPARAM) subop=0x284=644 value=0x0,0x0
 call80211ioctl: op=0x8be1 (GETPARAM) subop=0x284=644 value=0x0,0x0 failed: 95 (Operation not supported)
@@ -391,4 +399,4 @@
 /home/cli/menu # 
 /home/cli/menu # 
 /home/cli/menu # 
-/home/cli/menu # 
+/home/cli/menu # 
\ No newline at end of file

****
/testfile only on local
```
### Uploading to drive
Use the following command to push your local changes to your drive account
```
drive push
```

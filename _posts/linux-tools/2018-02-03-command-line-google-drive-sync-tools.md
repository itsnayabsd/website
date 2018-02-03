---
layout: post
title: Command Line Google Drive Sync Tools
category: linux-tools
comments: true
google_adsense: true
excerpt: >-
  Rich featured Google Drive command line sync tools to sync files  to your
  Linux based operating system (Debian or Ubuntu derived systems, Fedora based
  systems or any other Linux distribution).
date: 2018-02-03T09:50:51.000Z
thumbnail: /assets/img/google+drive.jpg
rating: '6'
---
Though there are some work arounds to get your Google Drive files in sync with any Linux based operating system, none of those are satisfiable (at least for me).

But there are two command line tools available that do the job nice.

* Grive
* Drive

## Grive

The `grive` is a small program to sync google drive files to your local system with the help of short commands.

Additional features of `grive` are:

* Single sub directory sync
* Preview the changes before sync
* Download only or Upload only featues

Follow the below short tutorial to get started using `grive` tool.

### Installing dependencies

Install the following dependencies using the terminal.

For Debian/Ubuntu based operation systems:
```
sudo apt-get install git cmake build-essential libgcrypt11-dev libyajl-dev \
    libboost-all-dev libcurl4-openssl-dev libexpat1-dev libcppunit-dev binutils-dev \
    debhelper zlib1g-dev dpkg-dev pkg-config
```
For Fedora:
```
pkg install git cmake boost-libs yajl libgcrypt pkgconf cppunit libbfd
```
### Installing grive

#### Clone the following repository from github

```
https://github.com/vitalif/grive2
```

#### Compile the source

```
cd grive2
mkdir build
cd build
cmake ..
```

Upon success, the output will be something like `-- Build files have been written to: /home/me/grive2/build`.

Compile the source:

```
make -j4
```

#### Install the package

```
sudo make install
```

### Working with grive

#### Setup the account

Create a folder for syncing google drive files.

```
mkdir ~/Grive
cd ~/Grive
```

Get the authorization code:

```
grive -a
```

This will prompt you to go to the specific URL using browser to get the authorization code:
```
Please go to this URL and get an authentication code:

https://accounts.google.com/o/oauth2/auth?scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile+https%3A%2F%2Fdocs.google.com%2Ffeeds%2F+https%3A%2F%2Fdocs.googleusercontent.com%2F+https%3A%2F%2Fspreadsheets.google.com%2Ffeeds%2F&redirect_uri=urn:ietf:wg:oauth:2.0:aob&response_type=code&client_id=22311486597474.apps.googleusercontent.com

- - ---

Please input the authentication code here:
```
Copy the URL in the browser and follow the on-screen instructions to get the code. Paste the code in ther terminal and press enter to finish the setup.

In my case the code is something like this:
```
3/u-6XV_B2E4lr8pjHLltG-ee37y83G8-NJDGu-8O-2
```
Immediately grive will start syncing your Google Drive files to your local system.

#### Preview your changes
Make some changes to see preview featues.
```
mkdir test
echo "Testing" > test/testfile.txt
```

```
grive --dry-run
```
This gives output like below:
```
Reading local directories
Reading remote server file list
Synchronizing files (dry-run)
sync "./test" doesn't exist in server, uploading
sync "./test/testfile.txt" doesn't exist in server, uploading
Finished!
```
** Note **: Files are not uploaded to Google Drive. This is just preview.
#### Sync your changes
Either you can sync all your work at once or you can sync specific directory.
To sync eveything:
```
grive
```
To sync only specific directory:
```
grive --dir test
```
For complete list of grive options:
```
grive --help
```
## Drive
`drive` is a small program to `pull` or `push` google drive files to or from your local system.
### Installing dependencies

#### Download `go` prgramming tools
Open the terminal and enter the following command to download `go` programming tools
```
wget -c https://dl.google.com/go/go1.9.3.linux-amd64.tar.gz
```
#### Installing `go` programming tools
```
sudo tar -C /usr/local -xzf go1.9.3.linux-amd64.tar.gz
```

```
cat << ! >> ~/.bashrc
export PATH=$PATH:/usr/local/go/bin
!
```
#### Set GOPATH `env` variable
```
cat << ! >> ~/.bashrc
export GOPATH=$HOME/gopath
export PATH=$GOPATH:$GOPATH/bin:$PATH
!
```

```
source ~/.bashrc
```
### Installing `drive`

#### For `Debian` or Debian based systems
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
#### For `Ubuntu` or Ubuntu based systems
```
sudo add-apt-repository ppa:twodopeshaggy/drive
```

```
sudo apt-get update
sudo apt-get install drive
```
#### For `Fedora` based systems
```
dnf copr enable vaughan/drive-google
```

```
dnf install drive-google
```
### Working with `drive`
#### Authentication with google drive account
Create a folder for syncing google drive files.
```
mkdir ~/Drive
cd ~/Drive
```
Use the following command to add your google drive account to the current folder.
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
Proceed with the changes? \[Y/n]:
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
#### Making changes
You can edit, create or delete files locally. To view your changes, use the following command:
```
drive diff
```
The output might be something like this:
```
File: /Others/wpa_supp_logs.txt

* local:          2018-01-31T18:00:01.000Z                
* remote:         2016-08-04T12:07:22.000Z\
  wpa_supp_logs.txt
- - -

\--- /home/nayab/Drive/Others/wpa_supp_logs.txt	2018-01-31 23:30:00.604117061 +0530
+++ .xtmp3916589616287113937.tmp229874439	2018-01-31 23:30:19.360313667 +0530
@@ -13,6 +13,14 @@
 Line: 1 - start of a new network block
 ssid - hexdump_ascii(len=4):
      77 6f 6c 66                                       wolf\
+key_mgmt: 0x2
+PSK (ASCII passphrase) - hexdump_ascii(len=9): \[REMOVED]
+pairwise: 0x10
+group: 0x10
+proto: 0x3
+PSK (from passphrase) - hexdump(len=32): \[REMOVED]
+Priority group 0

* id=0 ssid='wolf'
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

- - -

/testfile only on local
```
#### Uploading to drive
Use the following command to push your local changes to your drive account
```
drive push
```
Hope you like the post. Comments in case you are stuck at somewhere.

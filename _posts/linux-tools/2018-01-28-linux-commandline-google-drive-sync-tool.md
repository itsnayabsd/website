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

---
date: 2021-08-06 15:23:17 +5:30
title: Setting up Rust in VS Code for Linux
layout : post
category : rust
comments : true
google_adsense: true
excerpt : 
keywords : 
image : /assets/img/disable-android-bloatware-apps.png
toc : true
---
## Introduction
{% include image.html url="disable-android-bloatware-apps.png" description="Disable Android Bloatware without Root Access" %}

## Download VS Code
### Download microsoft signing key
```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
```
Type your password and press Enter.

### Add VS code repository to the sources list
```bash
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
```
### Update the sources and install vscode

```bash
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
```
For other Linux based systems, use the link https://code.visualstudio.com/docs/setup/linux
## Useful rust-extensions
press `Ctrl`+`Shift`+`X` to open extension market place. Search for the following extension and install.

rust-analyzer

Supports code completion, go to definition,go to implementation and go to type definiton, syntax highlighting and much more at https://rust-analyzer.github.io/manual.html

crates
To manage the dependencies with cargo.toml

codelldb

Breakpoints, disassembly, Remote debugging, reverse debugging, core dump inspection, 
More at https://github.com/vadimcn/vscode-lldb/blob/VERSION/MANUAL.md // Replace VERSION with codelldb version. ex -> v1.6.5

better-toml

Syntax hightlighting and validation for toml files and markdown files.

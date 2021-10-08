---
date: 2021-09-12 23:01:49 +5:30
title: Unpack or Extract the Archive Files in Linux
layout : linux-cli-post
category : linux-cli
comments : true
google_adsense: true
excerpt : Learn the Linux commands to extract or decompress the archive files .zip, .gz, .tar, .bz2, .7z, .xz, .rar, tar.bz2 and tar.gz2 files.
keywords : linux command to decompress .zip file, linux command to uncompress .gz file, linux command to extract .tar file, linux command to decompress .bz2 file, linux command to uncompress .7z file, linux command to extract .tar.bz2 file, linux command to decompress .tar.gz2 file, linux decompression with unxz, linux decompression with bunzip2, linux decompression with gunzip, unzip command examples, bunzip2 command examples, gunzip command examples, tar command to extract archive files with examples, 7z command to extract files with examples.
image : /assets/img/linux-cli/linux-cli-archive-extract.png
toc : true
---
## Introduction
Archiving is process of packaging a bunch of files or directories into a single file. Archiving is needed for better portability and to preserve the storage. There are lots of ways to creating (compressed and uncompressed) archives of the files. You can checkout the [commands here](/linux-cli/linux-cli-120-archive-files.html).

The archive feels need to be uncompressed or extracted when we want to use files in an archive. In this post, different tools are explained to uncompress or extract different archive files.

{% include image.html url="/linux-cli/linux-cli-archive-extract.png" description="Extraction of Archive Files in Linux" %}
## Installing the necessary tools
Your Ubuntu distribution might have already shipped with most of the following packages. In case not, please install using the following command.
```bash
sudo apt install zip gzip bzip2 p7zip-full p7zip-rar tar xz-utils
```
## Decompressing the *.zip* file
There are many tools available to extract the *.zip* file. We are using *unzip* and *7z* tools below.
### Extracting .zip file using unzip
```bash
unzip foo.zip
```
Replace *foo.zip* with your desired zip file.
### Extracting .zip file using 7z
Here is another way to extract the .zip file using 7z tool.
```bash
7z x foo.zip
```
## Extracting the *.tar* file
### Extracting .tar file using tar
*tar* is most commonly used command to archive or extract the files in Linux.
```bash
tar -xf foo.tar 
```
### Extracting .tar file using 7z
Here is another way to extract the .tar file using 7z tool.
```bash
7z x foo.tar
```
## Decompressing the *.gz* file
*.gz* or gzip file is a compressed file. Use following commands to extract *.gz* file.
### Decompressing .gz file using gunzip
We are using *gunzip* command to uncompress the .gz file. Removing *-k* option in the following command will replace the compressed file with extracted file.
```bash
gunzip -k foo.gz
```
### Decompressing .gz file using 7z
```bash
7z x foo.gz
```
## Extracting the *.tar.gz* file
*.tar.gz* file is an archive file with gzip compression.
### Extraction and decompresion in a single step with tar command
```bash
tar xzvf foo.tar.gz
```
### Decompression and extraction with gunzip and tar
To extract *.tar.gz* file, it need to be uncompressed first using *gunzip* or *7z* and then need to be extracted using *tar* or *7z*. Here is an example.
```bash
gunzip foo.tar.gz
tar xf foo.tar
```
## Decompressing the *.xz* file
*.xz* file can be extracted using *unxz* or *7z* as mentioned in the below commands.
### Decompressing .xz file using unxz
```bash
unxz foo.xz
```
### Decompressing .xz file using 7z
```bash
7z x foo.xz
```
## Extracting the *.tar.xz* file
*.tar.xz* is an archive file with XZ compression.
### Extraction and decompression in a single step using tar command
```bash
tar xJvf foo.tar.xz
```
### Extracting and decompression in multiple steps with tar and unxz
To extract *.tar.xz* file, it need to be uncompressed first using *unxz* or *7z* and then need to be extracted using *tar* or *7z*. Here is an example.
```bash
unxz foo.tar.xz
tar xf foo.tar
```
## Extracting the *.tar.bz2* file
*.tar.bz2* is an archive file *bzip2* compression.
### Extracting and decompressing tar.bz2 file in a single step
```bash
tar xjvf foo.tar.bz2
```
### Extracting and decompressing .tar.bz2 file in multiple steps with tar and bunzip2
To extract *.tar.bz2* file, it need to be uncompressed first using *bunzip2* or *7z* and then need to be extracted using *tar* or *7z*. Here is an example.
```bash
bunzip2 foo.tar.bz2
tar xf foo.tar
```
## Extracting the *.7z* file
```bash
7z x foo.7z
```

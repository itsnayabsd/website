---
date: 2021-09-12 23:01:49 +5:30
title: Archive or compress the files in Linux
layout : linux-cli-post
category : linux-cli
comments : true
google_adsense: true
excerpt : Learn the Linux commands to compress or package or archive the .zip, .gz, .tar, .bz2, .7z, .xz, .rar, tar.bz2 and tar.gz2 files.
keywords : linux command to create .zip file, linux command to create .gz file, linux command to create .tar file, linux command to create .bz2 file, linux command to create .7z file, linux command to create .tar.bz2 file, linux command to create .tar.gz2 file, linux compression with xz, linux compression with bzip2, linux compression with gzip, zip command examples, bzip2 command examples, gzip command examples, tar command examples, 7z command examples, tar with xz, tar with bzip2, tar with gzip, 7z with LZMA, 7z with ZIP, 7z with bzip2, 7z with gzip, 7z with zip.
image : /assets/img/linux-cli/linux-cli-archive-compress.png
toc : true
---
## Introduction
Archiving means packaging a bunch of files into a single file. The generated final file size is same as combined size of all those files. But if you compress those files (either as a single file or individual files), the resulted size is less than original size.

In this post, various archiving and compression tools are explained with examples. To learn more about extracting or decompressing of these archive files, [read here](/linux-cli/linux-cli-130-unpack-files.html).
{% include image.html url="/linux-cli/linux-cli-archive-compress.png" description="Archiving and Compression in Linux" %}

## Installing packaging and compressing tools.
Most of the following packages might be already shipped with Ubuntu OS. If not please install the tools using the following command.
```bash
sudo apt install zip gzip bzip2 p7zip-full p7zip-rar tar xz-utils
```
## Compression or archiving with *zip*
*zip* utility is used to compress and package a set of files or directories. The syntax of the command is
```
zip [options] archive_name file_or_dir_path1 file_or_dir_path2 ...
```
Let's say you have a directory called *zip_folder* in home directory with the following file hierarchy.
```
zip_folder/
├── file5
├── file4
└── zip_dir
    ├── file1
    ├── file3
    └── file2

1 directory, 5 files
```
To compress the files *file4*, *file5* along with the directory *zip_dir* and it's contents,
```bash
cd ~/zip_folder
zip -r zip_archive.zip zip_dir file4 file5
```
Now you could see the zip file is created with name *zip_archive.zip*
```bash
$ ls ~/zip_folder/
file5  file4  zip_archive.zip  zip_dir
```

The *.zip* file can be compressed from level 0 to level 9. *0* means low or no compression and *9* means high compression. You can use compression level as an argument to the command.
```bash
zip -9 -r zip_archive.zip zip_dir file4 file5
```
## Compression using *gzip*
*gzip* is a tool to compress the files. It can't be used for archiving purpose. When you use *gzip* command with the file as an argument, the compressed file generated with *.gz* extension and will replace the original file.
The syntax to use the command is
```
gzip [options] file
```
As an example, the following command creates *file.txt.gz* file and will replace the original file.
```bash
gzip file.txt
```
The compressed file is created with the extension *.gz*.

To keep both the original file and the compressed file, use the *gzip* command with *-k* option.
```bash
gzip -k file.txt
```
## Compression using *xz*
Just like *gzip*, *xz* can be used on single files only.
```bash
xz foo
```
The above command compresses and replaces the *foo* file with *foo.xz* file. Use *-k* option to keep the original file.

## Compression using *bzip2*
Just like *gzip* or *xz*, *bzip2* can be used on single files only.
```bash
bzip2 foo
```
The above command compresses and replaces the *foo* file with *foo.bz2* file.
## Compression or archiving using tar
*tar* is an utility used for archiving files. When combining with the gzip or xz compression, it creates a compressed archive file.

The syntax for tar is
```
tar [options] path1 path2 ..
```
Here is an example -
```bash
tar -cvf tar_archive.tar tar_dir file1 file2
```
The above command creates an archive *tar_archive.tar*. The command archives the directory *tar_dir* and the files *file1* and *file2*.
### tar archive with gzip compression
We can combine the tar archiving capability with the gzip compression. Use *-z* option for that.
```bash
tar -czvf tar_archive.tar.gz tar_dir file1 file2
```
The *.tar.gz* extension is a notation to tell that the file was a compressed tar archive.
### tar archive with xz compression
Combine tar archiving with *xz* compression with the option *-J*.
```bash
tar -cJvf tar_dir.tar.xz tar_dir/ file1
```
### tar archive with bzip2 compression
Combine tar archiving with *bzip2* compression with the option *-j*.
```bash
tar -cjvf tar_dir.tar.bz2 tar_dir/ file1
```
## Compression or archiving using 7z
*7z* supports archiving with compression formats *LZMA*, *XZ*, *BZIP2*, *ZIP* and *GZIP*. And 7z can't create a *RAR* file.
### 7z with LZMA compression
```bash
7z a archive file1 file2 dir1 dir2
```
This created archive.7z archive file .7z extension. The *.7z* default compression is LZMA.
### 7z with XZ compression
*xz* is a compression format. We can't compress a bunch of directories and files directly unless we made an archive of those. We can compress a single file though, using the following command.
```bash
7z a -txz file.xz file1
```
So, to create a *.xz* compressed archive of directories and files, we need to archive those first and then create compressed archive.
```bash
7z a -ttar archive dir1 dir2 file1 file2
7z a -txz archive archive.tar
```
### 7z with bzip2 compression
Like *xz*, *bzip2* is also a compression format. Create an archive or directories and files first and then compress the archive into *.bz2* format.
```bash
7z a -ttar archive dir1 dir2 file1 file2
7z a -tbzip2 archive archive.tar
```
### 7z with gzip compression
Like *xz* and *bzip2*, *gzip* is also a compression format. Create an archive or directories and files first and then compress the archive into *.gz* format.
```bash
7z a -ttar archive dir1 dir2 file1 file2
7z a -tgzip archive archive.tar
```
### 7z with zip archiving and compression
Unlike *xz*, *bzip2* and *gzip*, *zip* can be used to archive and compression.
```bash
7z a -tzip archive dir1 dir2 file1 file2
```

---
title : Files and Directories Manipulation
layout : linux-cli-post
category : linux-cli
date : 2020-11-24 23:18:14 +5:30
comments : true
google_adsense: true
excerpt : Linux commands to manipulate files and directories, copy, rename, delete, create commands explained with examples.
keywords : Linux files manipulation, Linux directory manipulation, Linux cp command, Linux mkdir command, Linux mv command, Linux rmdir command, Linux rm command, Create directory or folder command in Linux, Copy command in Linux, Rename file command in Linux, Rename directory command in Linux, Remove directory command in Linux, Remove file command in Linux.
image : /assets/img/linux-cli-manipulation.png
toc : true
---
## Introduction
The commands mostly used for the manipulation of files and directories are

 * ***mkdir*** - Used to create directories.
 * ***cp*** - Used to copy files and directories
 * ***mv*** - Used to move files and directories
 * ***rmdir*** - Used to remove/delete empty directories
 * ***rm*** - Used to delete files and directories

Let's practice these commands each with examples.

{% include image.html url="linux-cli-manipulation.png" description="Files and Directories Manipulation" %}

## Creating Directories

*mkdir* command is used to create directories. Usage is given in the following table.

|command	|Operation|
|-------|-----------------|
|mkdir directory	|Creates directory in current working directory.|
|mkdir location/directory	|Created directory in a given location|

### mkdir example 1

```bash
me@linux ~ $ mkdir dir1
me@linux ~ $ ls
Desktop  dir1  Documents  Downloads  Music  Pictures  Public  Templates  Videos 
```
The above command *mkdir dir1* creates a directory called *dir1* in your home folder and it is verified through *ls* command. More than one directories can be created at a time using mkdir command.

### mkdir example 2

```bash
me@linux ~ $ mkdir dir2 dir3 dir4
me@linux ~ $ ls
Desktop  dir2  dir4       Downloads  Pictures  Templates
dir1     dir3  Documents  Music      Public    Videos 
```
### mkdir example 3
```bash
me@linux ~ $ mkdir dir1/dir5
me@linux ~ $ ls dir1
dir5
```
The above command created *dir5* directory in *dir1*.

Lets try to create a directory dir6 in /usr/bin directory.

```bash
me@linux ~ $ mkdir /usr/bin/dir6
mkdir: cannot create directory ‘/usr/bin/dir6’: Permission denied
```
Normal user can't create, change and delete anything in file system directories except in his home directory and its sub directories. Root(or Administrative or Super User) privileges are required to do that. About *root* comes in later chapter.

## Copying Files and Directories

Usage of *cp* command is given in the following table.

|Command|	Operation|
|--------|---------------|
|cp source_file destination	| Copy source_file to destination directory. It overwrites file with the same name without prompting.|


By default *cp* command only copies files but not directories. Lets copy *hosts* file which is presented in directory */etc* to home directory.

### cp example 1
```bash
me@linux ~ $ cp /etc/hosts .
me@linux ~ $ ls
Desktop  dir1  dir3  Documents  hosts  Pictures  Templates
dir2  dir4  Downloads  Music  Public    Videos
```
Single dot (.) represents current working directory. Here current working directory is home directory. Copying from all file system directories is allowed because it doesn't alter the original file.

### cp example 2
```bash
me@linux ~ $ cp hosts dir1
me@linux ~ $ ls dir1
dir5  hosts
```
Above command copied hosts file in dir1 directory. Now we have two hosts files each one in home directory and dir1 directory.

## Moving Files and Directories

Apart from moving the file from one place to other, mv command is also used to rename file or directory. Usage is given in the following table.

|Command	|Operation|
|---------|---------------|
|mv source_file destination	|Moves source_file to the destination if destination exists. Otherwise it names the source_file.|

### mv example 1
```bash
me@linux ~ $ mv hosts ghosts
me@linux ~ $ ls
Desktop  dir1  dir3  Documents  ghosts  Pictures  Templates
dir2  dir4  Downloads  Music   Public    Videos
```
There is no directory called ghosts in current working directory. So above command renames the file hosts to ghosts.

### mv example 2
```bash
me@linux ~ $ mv dir1/hosts .
me@linux ~ $ ls
Desktop  dir1  dir3  Documents  ghosts hosts  Pictures  Templates
dir2  dir4  Downloads  Music  Public    Videos
```
The above command moves hosts file from dir1 directory to current working directory. Be careful that files with the same name will be overwritten.
### mv example 3

```bash
me@linux ~ $ mv ghosts dir1/host
me@linux ~ $ ls dir1
dir5  host
```
This command renames ghosts file and then moves to dir1 directory.

### mv example 4
Until now, operations are performed on files. These same operations can be applied on directories too.

```bash
me@linux ~ $ mv dir3 dir4 dir2
me@linux ~ $ ls dir2
dir3  dir4
```
More than one files or directories can be moved to destination directory. In the above command the directories dir3 and dir4 are moved to dir2.

## Deleting Files and Directories

rmdir is used to delete empty directories. Where as rm command is used to delete both files and directories.

### Example 1
```bash
me@linux ~ $ rm dir1/host
me@linux ~ $ ls dir1
dir5
```
The file host is deleted from dir1 directory.

### Example 2
Deleting any directory simply with rm command is not possible.

```bash
me@linux ~ $ rm dir1
rm: cannot remove ‘dir1’: Is a directory
```
### Example 3
Using rm with option -r deletes directory and all its contents.

```bash
me@linux ~ $ rm -r dir1
me@linux ~ $ ls
Desktop  dir2       Downloads  Music     Public     Videos
Documents  hosts      Pictures  Templates
```
```bash
me@linux ~ $ rm -r dir2 hosts
me@linux ~ $ ls
Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
```
hosts file and the directory dir2 are deleted in the above command.


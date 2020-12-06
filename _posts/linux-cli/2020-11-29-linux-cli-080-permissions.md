---
title : File and Directory Permissions
layout : linux-cli-post
category : linux-cli
date : 2020-11-29 22:51:34 +5:30
comments : true
google_adsense: true
excerpt : This post explains what are the Linux file and directory permissions, different types of files in Linux, how to change and restrict access the files to others, changing ownership of files etc. explained with examples.
keywords : Linux chown, Linux file permissions, Linux directory permissions, rwx, root, user, group and others permissions, Linux file types, Linux chmod, Linux file permission 754, Linux file permissions 777, Linux file permissions octal, Linux file permissions explained, Linux file permissions tutorial, Linux file permissions -rw-rw-r, Linux file permissions command
image : /assets/img/linux-cli-permissions.png
toc : true
---
## Introduction
Linux systems are multi-user systems. More than one user can access the system at once using **ssh**. But one user's activity shouldn't cause trouble to other users using that computer. Fortunately Linux systems comes with certain commands that makes user operations secure.

When a file or directory is created on a computer, it comes with permissions set for file user (owner), file group, and others remaining. Permissions are generally for read(r) access, write(w) access and to execute(x) files. The r, w, and x attributes are explained below.

| Attribute | Action                                                                                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| r         | When set to file, the content of the file can be read. When set to directory, the contents of directory can be listed using ls command.                                |
| w         | When set to file, the file content can be changed. When w attribute along with x attribute are set to directory, the contents of directory can be renamed and deleted. |
| x         | When set to file, it acts as executable program. When set to directory, we can enter into directory using cd command.

{% include image.html url="linux-cli-permissions.png" description="File and Directory Permissions" %}

### Examples

Let's create a text file and check its permissions.

```bash
me@linux ~ $ > perm.txt
me@linux ~ $ ls -l perm.txt
-rw-r--r-- 1 me me 0 Nov 27 20:03 perm.txt
```
Look at the first column `-rw-r--r--`. Total 10 characters in there called file attributes. Second column **me** is username of file's owner. Third column **me** represents files group name.

The first character of file attributes represents file type. Various file types are given below.

| First Character | File Type                          |
| --------------- | ---------------------------------- |
| -               | A Regular File                     |
| l               | A Symbolic Link                    |
| d               | A Directory                        |
| c               | Device That Accepts Bytes of Data  |
| b               | Device That Accepts Blocks of Data |

And the remaining 9 characters are classified as follows.

| user | group | others |
| ---- | ----- | ------ |
| rwx  | rwx   | rwx    |

Characters 2nd, 3rd and 4th are *rwx* permissions set for user (file owner). Next three for file group. And next three for remaining.

In the above example, file attributes for perm.txt file are `-rw-r--r--`. That means it is a regular file with file permissions assigned to user are *read* and *write (rw-)*. File's group members and others can just read (*r--*) the file.

To determine how many groups a user belongs to, a simple command called id can be used.

```bash
me@linux ~ $ id
uid=1000(me) gid=1000(me)
groups=1000(me),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),112(lpadmin),118(sambashare)
```
Here the total groups to which user me belongs are:

```
1000(me),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),112(lpadmin),118(sambashare)
```

To find other user's groups to which he belongs to:

```bash
me@linux ~ $ id you
uid=1001(you) gid=1001(you) groups=1001(you)
```
## Changing Permissions with chmod command

Permissions of a particular file or directory can be changed using chmod command in two ways.

* Using Octal Notations
* Using Symbolic Notations

### chmod using octal notations

Numbers can be represented in number systems like binary, decimal, octal and hexadecimal. Here we are using octal number system to change file permissions.

Following table represents the octal equivalent of different combinations of rwx attributes.

| Attributes | Binary | Octal |
| ---------- | ------ | ----- |
| ---        | 000    | 0     |
| --x        | 001    | 1     |
| -w-        | 010    | 2     |
| -wx        | 011    | 3     |
| r--        | 100    | 4     |
| r-x        | 101    | 5     |
| rw-        | 110    | 6     |
| rwx        | 111    | 7     |

If number 544 is in octal notation, the binary equivalent of that number is 101100100, which is equivalent to *r-xr--r--*. That means the file owner has read and execute access (first three characters), group members have only read access (next three characters), others also have only read access (last three characters).

#### Example 1
Now let's change file permissions for file perm.txt.

```bash
me@linux ~ $ chmod 600 perm.txt
me@linux ~ $ ls -l perm.txt
-rw------- 1 me me 0 Nov 27 20:03 perm.txt
```
Now file perm.txt can be only read and write by file owner. Group members and others can't read, write or execute.

#### Example 2

If you is another account exists on the same computer, since perm.txt has no permissions set for others, the user you shouldn't access this file.

```bash
me@linux ~ $ su - you
Password:
you@linux ~ $ less ~me/perm.txt
/home/me/perm.txt: Permission denied
you@linux ~ $ exit
me@linux ~ $
```
### chmod using symbolic notation

chmod supports symbolic notation to change file and directory permissions. Table below shows symbolic notations

| Symbol | Meaning            |
| ------ | ------------------ |
| u      | File Owner/User    |
| g      | File Group Members |
| o      | Others             |
| a      | Everybody          |

Here are some examples on chmod symbolic notation.

#### Example 1

To assign rwx permissions to user -

```bash
me@linux ~ $ chmod u=rwx perm.txt
me@linux ~ $ ls -l perm.txt
-rwx------ 1 me me 0 Nov 27 20:03 perm.txt
```
#### Example 2
To assign rwx permissions to group:

```bash
me@linux ~ $ chmod g=rwx perm.txt
me@linux ~ $ ls -l perm.txt
-rwxrwx--- 1 me me 0 Nov 27 20:03 perm.txt
```
#### Example 3
To assign read and write access to all (user, group members and others):

```bash
me@linux ~ $ chmod ugo=rw perm.txt
me@linux ~ $ ls -l perm.txt
-rw-rw-rw- 1 me me 0 Nov 27 20:03 perm.txt
```
Note that execute(x) access for user and group members are disabled. Above command is equivalent to `me@linux ~ $ chmod a=rw perm.txt`.

#### Example 4
To assign different permissions for user, group and others:

```bash
me@linux ~ $ chmod u=rwx,g=rw,o=r perm.txt
me@linux ~ $ ls -l perm.txt
-rwxrw-r-- 1 me me 0 Nov 27 20:03 perm.txt
```
#### Example 5
To remove particular permissions with out changing remaining:

```bash
me@linux ~ $ chmod u=u-wx perm.txt
me@linux ~ $ ls -l perm.txt
-r--rw-r-- 1 me me 0 Nov 27 20:03 perm.txt
```
#### Example 6
To add particular permissions without changing remaining:

```bash
me@linux ~ $ chmod u=u+w perm.txt
me@linux ~ $ ls -l perm.txt
-rw-rw-r-- 1 me me 0 Nov 27 20:03 perm.txt
```
## Changing File Ownership with chown command

Using chown command requires super user privileges. One user can transfer his file ownership to other user or group exists on that computer.

### Example 1
```bash
me@linux ~ $ sudo chown you perm.txt
[sudo] password for me:
me@linux ~ $ ls -l perm.txt
-rw-rw-r-- 1 you me 0 Nov 28 11:07 perm.txt
```
Above command changed file ownership from user me to you. Notice the second field in -rw-rw-r-- 1 you me 0 Nov 28 11:07 perm.txt.

### Example 2
Now try changing the file permissions with chmod command. You can't.

```bash
me@linux ~ $ chmod u=u+x perm.txt
chmod: changing permissions of ‘perm.txt’: Operation not permitted
```
### Example 3
To change group ownership:

```bash
me@linux ~ $ sudo chown :adm perm.txt
me@linux ~ $ ls -l perm.txt
-rw-rw-r-- 1 you adm 0 Nov 28 11:07 perm.txt
```
Notice third field changed in ther result.

### Example 4
To change file owner and file group owner at a time:

```bash
me@linux ~ $ sudo chown me:sambashare perm.txt
me@linux ~ $ ls -l perm.txt
-rw-rw-r-- 1 me sambashare 0 Nov 28 11:07 perm.txt
```

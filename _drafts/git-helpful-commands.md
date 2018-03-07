---
title: Git Helpful Commands
layout: post
category: linux-tools
excerpt: Useful git commands for every day developer programming
comments: false
google_adsense: false
---
* To enable line wrap in `git diff` output,
```bash
git config core.pager 'less -r'
```
* To `Undo` `git add`,
```bash
git reset <file_name>
```
* To `Undo Latest Commit`, add an alias for it
```bash
$ git config alias.uncommit 'reset HEAD~1'
```
* To checkout specific tag
```bash
git tag -l
git checkout tags/<tag_name>
```

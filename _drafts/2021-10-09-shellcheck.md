---
date: 2021-10-03 15:23:17 +5:30
title: Shellcheck - A static analysis tool (linter) for shell scripts
layout : post
category : linux-tools
comments : true
google_adsense: true
excerpt : 
keywords : 
image : /assets/img/rust_extension_pack.png
toc : true
---

{% include image.html url="rust_extension_pack.png" description="Setting up Rust in VS Code for Linux" %}


Supported shells - bash, dash and ksh

Written to point out syntax issues, symantic problems that cause shell script to behave weird and some other corner cases.

sudo apt install shellcheck

Integration with Vim

## Checking quotes
## Checking conditionals
## Checking misuse of commands
## Checking beginner's mistakes
## Checking style of script
## Checking typing errors
## Checking robustness
## Checking protability between shells
## Miscellaneous checking
```
Usage: shellcheck [OPTIONS...] FILES...
  -a                  --check-sourced            Include warnings from sourced files
  -C[WHEN]            --color[=WHEN]             Use color (auto, always, never)
  -i CODE1,CODE2..    --include=CODE1,CODE2..    Consider only given types of warnings
  -e CODE1,CODE2..    --exclude=CODE1,CODE2..    Exclude types of warnings
  -f FORMAT           --format=FORMAT            Output format (checkstyle, diff, gcc, json, json1, quiet, tty)
                      --list-optional            List checks disabled by default
                      --norc                     Don't look for .shellcheckrc files
  -o check1,check2..  --enable=check1,check2..   List of optional checks to enable (or 'all')
  -P SOURCEPATHS      --source-path=SOURCEPATHS  Specify path when looking for sourced files ("SCRIPTDIR" for script's dir)
  -s SHELLNAME        --shell=SHELLNAME          Specify dialect (sh, bash, dash, ksh)
  -S SEVERITY         --severity=SEVERITY        Minimum severity of errors to consider (error, warning, info, style)
  -V                  --version                  Print version information
  -W NUM              --wiki-link-count=NUM      The number of wiki links to show, when applicable
  -x                  --external-sources         Allow 'source' outside of FILES
                      --help                     Show this usage summary and exit
```

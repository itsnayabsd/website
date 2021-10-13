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
```bash
#!/bin/bash
echo Creating and changing directory to demo directory ..
mkdir -p ~/shellcheck_demo
cd ~/shellcheck_demo
echo ""

# Example 1
echo Crating a file called 'hello world'
echo Hi > "hello world"
cat $1
echo ""

# Example 2
echo Crating files 1.txt, 2.txt ... 5.txt
touch {1..5}.txt
echo The .txt files in current directory
ls *.txt
find ./ -name *.txt
echo ""

# Example 3
touch "~/myfile.txt"
echo ""

# Example 4
echo 'The PATH is $PATH'
```
```bash
# Cleanup
rm *.txt
```

```
chmod +x quotes.sh
```
```bash
./quotes.sh "hello world"
```

```bash
$ shellcheck quotes.sh 

In quotes.sh line 4:
cd ~/shellcheck_demo
^------------------^ SC2164: Use 'cd ... || exit' or 'cd ... || return' in case cd fails.

Did you mean: 
cd ~/shellcheck_demo || exit


In quotes.sh line 10:
cat $1
    ^-- SC2086: Double quote to prevent globbing and word splitting.

Did you mean: 
cat "$1"


In quotes.sh line 17:
ls *.txt
   ^-- SC2035: Use ./*glob* or -- *glob* so names with dashes won't become options.


In quotes.sh line 18:
find ./ -name *.txt
              ^---^ SC2061: Quote the parameter to -name so the shell won't interpret it.
              ^-- SC2035: Use ./*glob* or -- *glob* so names with dashes won't become options.


In quotes.sh line 22:
touch "~/myfile.txt"
       ^----------^ SC2088: Tilde does not expand in quotes. Use $HOME.


In quotes.sh line 26:
echo 'The PATH is $PATH'
     ^-----------------^ SC2016: Expressions don't expand in single quotes, use double quotes for that.

For more information:
  https://www.shellcheck.net/wiki/SC2061 -- Quote the parameter to -name so t...
  https://www.shellcheck.net/wiki/SC2088 -- Tilde does not expand in quotes. ...
  https://www.shellcheck.net/wiki/SC2164 -- Use 'cd ... || exit' or 'cd ... |...
```
Here are other kind of quote checks
```bash
echo 'Don't do it'
```
## Checking conditionals
```bash
#!/bin/bash

# Example 1
n=2
if [[ n != 2 ]]; then
    echo "n is not 2";
else
    echo "n is 2";
fi

## `[[ n != 2 ]]` returns true always. And echo statement will not print.

# Example 2
touch {1..5}.txt
echo The .txt files are -
ls *.txt

if [[ -e *.txt ]]; then
    echo ".txt files exist"
else
    echo ".txt files don't exist"
fi
```
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

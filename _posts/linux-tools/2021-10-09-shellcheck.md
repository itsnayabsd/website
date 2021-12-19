---
date: 2021-10-03 15:23:17 +5:30
title: Shellcheck - A Static Analysis Tool (linter) for Shell Scripts Introduction
layout : post
category : linux-tools
comments : true
google_adsense: true
excerpt : Shellcheck is a static analysis tool (or linter) for shell scripts. It detects various types of errors, gives suggestions and warnings for a shell script. It points out syntax issues, symantic problems that cause shell script to behave weird and some other corner cases. This guide explains various shellcheck features using examples.
keywords : shellcheck, linter for shell, detect syntax errors using shellcheck, shellcheck zsh, shellcheck bash, shellcheck dash, shellcheck error codes, shellcheck ignore codes, shellcheck linter, install shellcheck ubuntu, install shellcheck debian linux, shellcheck guide
image : /assets/img/linux-tools/shellcheck.png
toc : true
toc_min : 2
toc_max : 3
---
## Introduction

***Shellcheck*** is a static analysis tool (or linter) for shell scripts. It detects various types of errors, gives suggestions and warnings for a shell script. It points out syntax issues, symantic problems that cause shell script to behave weird and some other corner cases.

Various types of bad shell code examples are given in the subsequent sections. Usage of shellcheck to detect the errors/suggestions/warnings present in these examples is explained.

{% include image.html url="linux-tools/shellcheck.png" description="Shellcheck - Static analysis tool for shell scripts" %}

## Supported shells
The supported shells currently are -
 - bash
 - dash and
 - ksh

## Installation of shellcheck
On Ubuntu/Debian based Linux based systems, shellcheck can be installed with the following command.
```bash
sudo apt install shellcheck
```

<!-- Integration with Vim : TODO -->
## Bad code examples and usage of shellcheck
Let's create a demo directory to practice the following commands.
```bash
mkdir -p ~/shellcheck_demo
cd ~/shellcheck_demo
```
### Checking quotes
Following is the shell script called *quotes.sh* in which there are 4 examples.
#### quotes.sh
```bash
#!/bin/bash

# Example 1
print_seed() {
    cat $1
}

echo "animal mammal dinner hot now yesterday" > "Seed Phrase"

print_seed "Seed Phrase"

# Example 2
touch file1.txt file2.txt
find ./ -name *.txt

# Example 3
touch "~/myfile.txt"

# Example 4
echo 'The PATH is $PATH'
```
Try to execute this script and see if the output is as expected.
```bash
chmod +x ./quotes.sh
./quotes.sh
```
#### Checking the script with shellcheck
Let's see what's wrong with the above script using the shellcheck command.
```bash
shellcheck quotes.sh 
```
Here is the output
```
In quotes.sh line 5:
    cat $1
        ^-- SC2086: Double quote to prevent globbing and word splitting.

Did you mean: 
    cat "$1"


In quotes.sh line 14:
find ./ -name *.txt
              ^---^ SC2061: Quote the parameter to -name so the shell won't interpret it.
              ^-- SC2035: Use ./*glob* or -- *glob* so names with dashes won't become options.


In quotes.sh line 17:
touch "~/myfile.txt"
       ^----------^ SC2088: Tilde does not expand in quotes. Use $HOME.


In quotes.sh line 20:
echo 'The PATH is $PATH'
     ^-----------------^ SC2016: Expressions don't expand in single quotes, use double quotes for that.

For more information:
  https://www.shellcheck.net/wiki/SC2061 -- Quote the parameter to -name so t...
  https://www.shellcheck.net/wiki/SC2088 -- Tilde does not expand in quotes. ...
  https://www.shellcheck.net/wiki/SC2016 -- Expressions don't expand in singl...
```
#### Analysis from above output
The output is self explanatory.

In the example 1 - line 5 - *$1* should be in quotes.

In the example 2 - line 14 - Wrap **.txt* in the quotes

In the example 3 - line 17 - Tilde won't exapand inside the double quotes. We can use $HOME

In the example 4 - line 20 - $PATH won't expand in single quotes. Use double quoes.

#### Modified quotes.sh
```bash
#!/bin/bash

# Example 1
print_seed() {
    cat "$1"
}

echo "animal mammal dinner hot now yesterday" > "Seed Phrase"

print_seed "Seed Phrase"

# Example 2
touch file1.txt file2.txt
find ./ -name "*.txt"

# Example 3
touch "$HOME/myfile.txt"

# Example 4
echo "The PATH is $PATH"
```
### Checking conditionals
Following is the *conditionals.sh* script which has examples of conditionals related issues.
#### conditionals.sh
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
touch file1.txt

if [[ -e *.txt ]]; then
    echo "file1.txt present"
else
    echo "file1.txt not present"
fi

# Example 3
n=3
if [[ ${n}==2 ]]; then
    echo "n is 2";
else
    echo "n is not 2";
fi

# Example 4

n=""
if [[ -n "$n " ]];then
    echo "n is not empty"
else
    echo "n is empty"
fi
```
Execute the script and see if the output is as expected.
#### Running shellcheck on the script
```bash
shellcheck conditionals.sh
```
Here is the analysis -

In example 1 - line 5 - It should be *$n* instead of *n*.

In example 2 - line 16 - *-e* can't be used with **.txt*. Either use file path or use for loop to check all the **.txt* files.

In example 3 - line 24 - There should be spaces around the comparison operator.

In example 4 - line 33 - The if condition is always true regardless of n value because there is a space inside the quotes. Remove it.

Here are other type of conditional issues the shellcheck capable of detecting.

 - Comparing numerical values with strings
 - Using logical operators inside brackets.
 - Accidental backgrounds and piping *[[ condition1 ]] & [[ condition 2 ]] \| [[ condition 3 ]]*

### Checking Syntax errors
Here are the few bad examples related to syntax issues. Read the respective comment for the fix.
```bash
n = 42                          # Spaces shouldn't be there around = operator while assignments
$n=42                           # $ should not be used when assigning a value to a variable

# Shouldn't use $ with loop variable (i). Following is wrong
for $i in {1..10};do
    # Do something here
done

n=1
num$n="36"                      # Use arrays instead

arr=(1, 2, 3)                   # Commas can't be used when defining arrays
echo $arr[14]                   # Missing {} in array references

else if condition; then ..      # Using 'else if' instead of 'elif'

func; func() { echo "hello world; }     # Using function before definition
```
### Checking protability between shells
Here are few examples which run fine in one shell variant and is a problem on other. shellcheck does good job on detecting these issues.

```bash
echo {1..10}                    # Works in bash and ksh. Doesn't work in sh or dash
local var=2                     # local keyword is undefined in sh
```
### Miscellaneous checking
Following are few more bad examples.
```bash
echo 'Don't do it'              # Three apostrophes. Unclosed single quote.
cat file1.txt | grep word       # cat is unnecessary. Use - grep word file1.txt
echo "Today date is `date`"     # Use $ instead of backticks for date command
echo $(( $a + 2 ))              # Don't use $ on variables inside the $((..)).
                                # Might not work in all shells.
rm -rf "$PROJECTROOT/"*         # Warns user the possibility of removing root directory if PROJECTROOT is empty
```
## Getting additional help on shellcheck
### The shellcheck help command
The `shellcheck --help` command gives the brief info and options supported for the *shellcheck* tool.
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
We can make shellcheck ignore certain error codes using the option `--exclude=CODE1,CODE2..`. Useful while deploying the shellcheck in some build system.

### Report from the shellcheck output
If you see the shellcheck output for [quotes.sh](/linux-tools/shellcheck.html#checking-quotes) script, for every error/warning/suggestion, there is an URL provided at the end of the report for further reference. Something like the following ...
```
For more information:
  https://www.shellcheck.net/wiki/SC2061 -- Quote the parameter to -name so t...
  https://www.shellcheck.net/wiki/SC2088 -- Tilde does not expand in quotes. ...
  https://www.shellcheck.net/wiki/SC2016 -- Expressions don't expand in singl...
```
Feel free to open those URLs in the browser and read the detailed info about the issue there.
### Page consisting of all error codes
You can find the all shellcheck error codes [here](https://gist.github.com/nicerobot/53cee11ee0abbdc997661e65b348f375). If this link is broken, you can find the modified web page link [here](https://github.com/koalaman/shellcheck/wiki/Checks)

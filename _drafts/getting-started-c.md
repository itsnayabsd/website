---
layout: post
title: Getting started with C programming language
category: programming
comments: true
google_adsense: true
excerpt:
keywords:
image:
date: 2020-02-05 00:19:30 +5:30
toc: true
---
## Introduction
A programmer's job typically involves writing a program, compiling, executing and debugging. This article helps any newbie to get started C programming language, including setting up the system for programming, the compilation process and debugging.

## Setting up the system
Learning C programming language on Linux based system is recommended. I use [Ubuntu Linux Desktop](https://ubuntu.com/download/desktop) for programming. Setting up the system typically involves installing editor, compiler and other programming tools.
### Install editor, compiler and other tools
```shell
sudo apt install vim build-essential
```
`Vim` is a terminal based editor. `build-essential` package consists of `gcc`, `g++`, `make` utility and Gnu C library.
### Install code completion plugin
There are many code completion plugins available for Vim editor. [YouCompleteMe](/linux-tools/you-complete-me-vim-plugin.html) is one of best code completion engines for Vim. Please follow the steps mentioned [here](/linux-tools/you-complete-me-vim-plugin.html).

## Compiling and executing **Hello World!** program
Run the following command in the terminal to open the file `helloWorld.c` with vim editor.
```bash
vim helloWorld.c
```
Write the following program in that file and save it.
```C
/* Header file inclusion */
#include <stdio.h>

/* Main function */
int main(void)
{
    printf("Hello World!\n");
    return 0;
}
```
Compile the program by running the following command
```bash
gcc helloWorld.c -o helloWorld
```
Above command generates a binary called **helloWorld**. Execute the binary by running the following command.
```shell
./helloWorld
```
This should print the **Hello World!** output.
```
Hello World!
```
## Behind the compilation and executing
### Compilation steps
The process of compilation involves the following steps.
 * Preprocessing
 * Linking and
 * Final compilation

#### Preprocessing
A preprocessing step by compiler includes macro substitution, inclusion of other source files and conditional compilation.

### Executing
## Data types
The size of data types are machine-dependent. How?

## Storage classes
Variables declared in the function are generally `automatic` storage class.
## Miscellaneous
### C program without main() function


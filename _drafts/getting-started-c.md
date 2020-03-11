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
## Behind the scenes of compilation
The process of compilation involves the following steps.
 * Preprocessing
 * Generating assembly code (Called compilation proper)
 * Assembly
 * Linking

### Preprocessing
A preprocessing step by compiler includes macro substitution, inclusion of other source files, removal of comments and conditional compilation.

Consider the following program,

**File :** hello_new_world.c

```C
#include <stdio.h>

#define HELLO_NEW_WORLD "Hello New World!"

/* Program starts from here */
int main(void)
{
#ifdef HELLO_NEW_WORLD
    puts(HELLO_NEW_WORLD);
#else
    puts("Hello World!");
#endif
    return 0;
}
```
Run the preprocessor on the above file and save the output in a separate file. We can use the following command.
```bash
gcc -E hello_new_world.c -o hello_new_world.i
```
The output file `hello_new_world.i` has `#include <stdio.h>` replaced with the *stdio.h* file content; removed comments; removed some lines of code from the `main` function based on conditional compilation (if HELLO_NEW_WORLD is defined first `puts` will be processed or the other one) and substituted the macro `HELLO_NEW_WORLD` macro with its value `"Hello New World!"` (please check the last lines of following file).

**File :** hello_new_world.i
```C
# 1 "hello_new_world.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "hello_new_world.c"
# 1 "/usr/include/stdio.h" 1 3 4
# 27 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/libc-header-start.h" 1 3 4
# 33 "/usr/include/x86_64-linux-gnu/bits/libc-header-start.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 446 "/usr/include/features.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 1 3 4
# 460 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 461 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/long-double.h" 1 3 4
# 462 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 2 3 4
# 447 "/usr/include/features.h" 2 3 4
# 470 "/usr/include/features.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 1 3 4
# 10 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/gnu/stubs-64.h" 1 3 4
# 11 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 2 3 4
# 471 "/usr/include/features.h" 2 3 4
# 34 "/usr/include/x86_64-linux-gnu/bits/libc-header-start.h" 2 3 4
.
.
.
.
.
.
.
extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
# 858 "/usr/include/stdio.h" 3 4
extern int __uflow (FILE *);
extern int __overflow (FILE *, int);
# 873 "/usr/include/stdio.h" 3 4

# 2 "hello_new_world.c" 2




# 5 "hello_new_world.c"
int main(void)
{

    puts("Hello New World!");



    return 0;
}
```
### Generating assembly code
The C code in the above file **hello_new_world.i** can be converted into assembly by the follwing command.
```bash
gcc -S hello_new_world.i -o hello_new_world.s
```
The output file **hello_new_world.s** has the assembly code
```C
	.file	"hello_new_world.c"
	.text
	.section	.rodata
.LC0:
	.string	"Hello New World!"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
```
### Assembly
This part converts the assembly file into relocatable object file (which is in [ELF](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format) format).
```bash
gcc -c hello_new_world.s -o hello_new_world.o
```
At this point, this object file consists of following sections.
 * .text - Program code
 * .data - Initialized global variables
 * .bss - Uninitialized global variables (Block storage start)
 * .rodata - Read only data such as format strings
 * Other custom fields.

Run the following command to see above sections.
```bash
objdump -h hello_new_world.o
```
The *.text*, *.bss* and *.rodata* contain functions, global variables and format stirngs mapped to addresses starting with 0. These addresses can be relocable when linked with other relocatable objects to form final binary executable. The linking step is explained below clearly.

### Linking
The Linker's job can be explained clearly with multiple source files.

Let's assume the files **a.c** and **b.c**.

## Behind the scenes of execution

## Memory management
Initialized data, uninitialized data, stack etc. Global variable initialized with uninitialized. ex : a.h have `int num` and b.c and c.c using that header file. What if `int num = 6`. compile error will be generated. Then how this data is being stored?

If the variable is not automatic, initialization is done before the program execution.
## Data types
The size of data types are machine-dependent. How?

## Storage classes
Variables declared in the function are generally `automatic` storage class.
### Static Variables
External variables or functions declared with `static` limits the scope of that variable or function to the file it is declared. Other files can't access this variable or functions.

When local/automatic variables are declared with `static`, it's scope is limited to that function or block, but the variable will be in existence through out the life of program.

Static or external variables are initialized only once before the execution of program.

### Register variables
Variables declared with `register` tells the compiler that these variables will be used heavily so that the compilers may consider to place these variables in machine registers for faster execution.
## Miscellaneous
Where string constants are stored?

```C
char *p = "Hello World!";
```
```
A loader allocates memory for the program. Then it loads the program and required libraries into memory.

The linker (ld on Linux systems), which is a part of binutils, is responsible for the placement of symbols (data, code, and so on) in the appropriate section in the generated binary in order to be processed by the loader when the program is executed
```
### C program without main() function

How local variables are stored in stack?

---
layout: post
title: Test Your C Skills
category: programming
comments: true
google_adsense: true
excerpt: YouCompleteMe code completion engine installation instructions in Debian/Ubuntu, configuration, customization for languages like C/C++, Objective C/C++, Rust, C#, Javascript/Typescript.
keywords: YouCompleteMe Vim plugin for C, YouCompleteMe Vim plugin for JavaScript, YouCompleteMe Vim plugin for Ubuntu Installation, YouCompleteMe Vundle plugin install, Vim code completion plugin, Vim code completion javascript, Vim code completion C, Vim CPP code complete
image: /assets/img/youcompleteme-code-completion-engine.png
date: 2020-01-23 00:19:30 +5:30
---
## Question 1

```C
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(void)
{
    const char name[32], *name_ptr = name;

    memset(name, 0, sizeof(name));
    snprintf(name, sizeof(name), "nayab.xyz");
    puts(name);
    free(name_ptr);
    return 0;
}
```
**Guess the output**
```
a) nayab.xyz  
b) Segmentation fault  
c) Aborted (core dumped)  
d) None of the above  
```
___

## Question 2
Assuming the address of `a` is `0xabcdef` and the address of `b` is `0xfedcba`

```C
#include <stdio.h>

int main(void)
{
    unsigned long a = 10;
    unsigned long *b = &a;
    unsigned long **c = &b;

    printf("a value : %lu, ",
        a);
    printf("*b value : %lu, *c value : %p\n", *b, *c);

    return 0;
}
```
**Guess the ouput.**
```
a) a value : 10, *b value : 10, *c value : 0xabcdef
b) a value : 10, *b value : 10, *c value : 0xfedcba
c) Compilation error
d) Segmentation fault
```
___
## Question 3
```C
#include <stdio.h>

int main(void)
{
    printf("\z\n");
    return 0;
}
```
**Guess the output**
```
a) Compilation error
b) z
c) Garbage
d) \z
```
___
## Question 4
```C
#include <stdio.h>

int b = 1;

int main(void)
{
    b++;
    b = b + 1;
}
```
**Which line in the main function is a statement?**
<!-- Expressions, including an assignment or a function call is a statement -->
```
a) b++;
b) b = b + 1;
c) Both
d) None
```

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
## Find the output of following programs.
### Question 1

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
```
a) nayab.xyz  
b) Segmentation fault  
c) Aborted (core dumped)  
d) None of the above  
```
___

### Question 2

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
```
a) a value : 10, *b value : 10, *c value : 0xabcdef
b) a value : 10, *b value : 10, *c value : 0xfedcba
c) Program won't compile
d) Segmentation fault
```

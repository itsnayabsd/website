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

#define SQUARE(x) x * x;

int main(void)
{
    printf("%d\n", SQUARE(2 + 1));
    return 0;
}
```
Guess the output
```
a) 9
b) 5
c) 6
d) Program won't compile
```
___
## Question 5
```C
#include <stdio.h>

int main(void)
{
    int data[5] = {10, 20, 30};
    int i;

    for (i = 0; i < sizeof(data)/sizeof(data[0]); i++) {
        printf("%d ", *data);
        data++;
    }

    return 0;
}
```
**Guess the output**
```
a) 10 20 30
b) 10 20 30 0 0
c) Compile time error
d) Segmentation fault
```
___
## Question 6
**Guess the output**
```C
#include<stdio.h>

void function(int *p)
{
    int c=10;
    p=&c;
}

int main()
{
    int a=20;
    int *p=&a;

    function(p);
    printf("%d\n",*p);

    return 0;
}
```
**Options**
```
a) Garbage value
b) 10
c) 20
d) Segmentation fault
```
___
## Question 7
**Guess the output**
```C
#include <stdio.h>

int a;

int main()
{
   a+=5;

   if(a/2.0 == 2.5)
       printf("if");
   else if(a/2 == 2)
       printf("else if");
   else
       printf("else");

   return 0;
}
```
**Options**
```
a) if
b) else if
c) else
d) Prints nothing
```
___
## Question 8
```C
#include<stdio.h>

int main(void)
{
 char *ptr = "nayab.xyz";
 void *vptr;

 vptr = &ptr;

 /* Print "nayab.xyz" using vptr */
 return 0;
}
```

**Print <i>nayab.xyz</i>  using vptr**
```
a) printf("%s" , *(char **)vptr);
b) printf("%s" , *(vptr);
c) Both
d) Compile time error or Segmentation fault
```

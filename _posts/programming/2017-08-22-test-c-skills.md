---
layout: post
category: programming
title: Test Your C Skills
date: 2017-08-22 14:35:59 +5:30
excerpt: Series of multiple choice questions to test your C skills.
comments: true
google_adsense: false
---
## Find the output of following programs.

~~~C
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
~~~
a) nayab.xyz  
b) Segmentation fault  
c) Aborted (core dumped)  
d) None of the above  

___

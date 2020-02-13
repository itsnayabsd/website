---
layout: post
title: Storage Classes and Scope of Variables
category: programming
comments: true
google_adsense: true
excerpt:
keywords:
image: /assets/img/test-c-skills.png
date: 2020-02-12 23:04:36 +5:30
---
## Extern
### Different ways of using extern
**File**: a.c
```
#include <stdio.h>
#include <string.h>

char name[64];
extern void func(void);

int main(void)
{
    strncpy(name, "nayab.xyz", 64);

    func();
    return 0;
}
```
**File**: b.c
```
#include <stdio.h>

extern char name[];

void func(void)
{
    puts(name);
}
```
```
gcc a.c b.c
```
Function defined in ***b.c***. Without header file, a.c able to use func() in b.c using extern keyword to that function.
## Definition and declaration
Definition means a variable is created and assigned storage.
Declaration means the nature of the variable is stated but no storage is allocated

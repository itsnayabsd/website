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
### C program without main() function

How local variables are stored in stack?

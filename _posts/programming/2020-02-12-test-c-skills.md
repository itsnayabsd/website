---
layout: post
title: Test Your C Skills
category: programming
comments: true
google_adsense: true
excerpt: C objective type questions to test your C skills. Each question has 4 options. Chose the correct one. If you find something new, run the programs in the system and find the concept behind it.
keywords: Test your C skills, test your C skills online, test your C skills by Yashwant Kanetkar alternative, C objective questions, C objective questions online test, C multiple choice questions, C multiple choice questions geeks for geeks alternative, C multiple choice questions indiabix alternative, C assessment questions.
image: /assets/img/test-c-skills.png
date: 2020-02-16 22:48:57 +5:30
---
## Introduction
All the following programs are run and verified in the ***Linux based operating system*** with ***GCC*** compiler. Each question has 4 options. Chose the correct one. If you find something new, change and run the programs in the system and find the concept behind it.

<div class="isa_info"><strong>Note</strong> : For all the questions, the following <strong>data type sizes</strong> are considered.<br></div>

|Data type|Size|
|---------|----|
|char| 1 byte|
|short| 2 bytes|
|int| 4 bytes|
|long | 8 bytes|
|long long | 8 bytes |
|float| 4 bytes|
|double| 8 bytes|
|long double| 16 bytes|
|pointer| 8 bytes|

<br>

{% include image.html url="test-c-skills.png" description="Test Your C Skills" %}

<br>
<div class="isa_warning"><strong>Warning : </strong>Run the program to confirm the answer. Answers are not so obvious as it seems</div>

## Question 1
**Guess the output**
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
**Options**
```
a) nayab.xyz  
b) Segmentation fault  
c) Aborted (core dumped)  
d) None of the above  
```
___

## Question 2
**Guess the output**

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
**Options**
```
a) a value : 10, *b value : 10, *c value : 0xabcdef
b) a value : 10, *b value : 10, *c value : 0xfedcba
c) Compilation error
d) Segmentation fault
```
___
## Question 3
**Guess the ouput.**
```C
#include <stdio.h>

int main(void)
{
    printf("\z\n");
    return 0;
}
```
**Options**
```
a) Compilation error
b) z
c) Garbage
d) \z
```
___
## Question 4
**Guess the ouput.**

```
#include <stdio.h>

#define SQUARE(x) x * x;

int main(void)
{
    printf("%d\n", SQUARE(2 + 1));
    return 0;
}
```
**Options**
```
a) 9
b) 5
c) 6
d) Program won't compile
```
___
## Question 5
**Guess the ouput.**
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
**Options**
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

int a = 2;

int main()
{
   int b = a + 3;

   if(b/2.0 == 2.5)
       printf("if\n");
   else if(b/2 == 2)
       printf("else if\n");
   else
       printf("else\n");

   return 0;
}
```
**Options**
```
a) if
b) else if
c) else
d) Program won't compile
```
___
## Question 8
**Print <i>nayab.xyz</i>  using vptr**
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
**Options**
```
a) printf("%s" , *(char **)vptr);
b) printf("%s" , *(vptr);
c) Both
d) Segmentation fault for a) and b)
```
___
## Question 9
**Guess the output**
```C
#include <stdio.h>

int aa(int a)
{
   return --a;
}

int main()
{
   int a = 'a'-87;
   for ( ; a; )
       printf("%d ",aa(--a));
   return 0;
}
```
**Options**
```
a) 8 6 4 2 0
b) 10 8 6 4 2 0
c) 8 7 6 5 4 3 2 1 0 -1
d) None of the above
```
___
## Question 10
**Guess the output**
```C
#include<stdio.h>

int main(void)
{
    int arr[4] = {23, 11, 56, 29};
    int *p, *q;

    q = arr / 2;
    p = q * 2;
    printf("%d %d", *(p + 1), *(p + 3));

    return 0;
}
```
**Options**
```
a) 11 29
b) 23 56
c) Compile time error
d) Segmentation fault
```
___
## Question 11
**Guess the output**
```C
#include <stdio.h>
#include <stdbool.h>

bool func (void) {
     return -2;
}

int main()
{
    if (func() == -2) {
       printf("if");
    } else {
       printf("else");
    }
}
```
**Options**
```
a) if
b) else
c) Prints nothing
d) Compile time error
```
___
## Question 12
**Guess the output**
```C
#include <stdio.h>

int var = 20;

int main()
{
    int var = var;
    printf("%d ", var);

    return 0;
}
```
**Options**
```
a) Undefined behavior
b) 0
c) 20
d) Compile time error
```
___
## Question 13
**Guess the output**
```C
#include <stdio.h>

int main()
{
    printf("%c ", 4["nayab.xyz"]);
    return 0;
}
```
**Options**
```
a) Compile time error
b) b.xyz
c) b
d) nayab.xyz
```
___
## Question 14
**Guess the output**
```C
#include <stdio.h>

union uni1 {
    unsigned int a;
    unsigned int d;
    unsigned char b;
    unsigned char c;
} un;

int main()
{
    un.a = 498;
    un.d = un.d & 0xceba;

    printf("un.a : %d, un.c : %d\n",un.a, un.c);
}
```
**Options**
```
a) un.a : 255, un.c : 178
b) un.a : 498, un.c : 178
c) un.a : 178, un.c : 178
d) un.a : 498, un.c : 255
```
___
## Question 15
**Guess the output**
```C
#include <stdio.h>
#include <string.h>

char name[64];

int main(void)
{
    extern char name[] = "nayab.xyz";

    puts(name + 6);
    return 0;
}

```
**Options**
```
a) xyz
b) extern variable can't have an initializer
c) Compile time error
d) b and c
```
___
## Question 16

Here are the contents of files `a.c`, `b.c` and `num.h`

**File** : num.h
```C
int num = 5;
```

**File** : a.c
```C
#include <stdio.h>
#include <string.h>
#include "num.h"

extern void func(void);

int main(void)
{
    num = 6;
    func();
    return 0;
}
```

**File** : b.c
```C
#include <stdio.h>
#include "num.h"

void func(void)
{
    printf("%d\n", num);
}
```

***Compile the above files together and Guess the output***
```
a) 6
b) Compile time error
c) 5
d) None of the above
```
## Question 17
**Guess the output**
```C
#include <stdio.h>
#include <string.h>

int main(void)
{
    extern char name[];

    puts(name + 6);
    return 0;
}

char name[64] = "nayab.xyz";
```
**Options**
```
a) xyz
b) Undefined reference to name.
c) Compile time error
d) b and c
```
___
## Question 18
**Guess the output**
```C
#include <stdio.h>

#define VALUE 1999999999L

int main(void)
{
    printf("The size of VALUE : %lu\n", sizeof(VALUE));
    return 0;
}
```
**Options**
```
a) 11
b) 4
c) 8
d) Compile time error
```
___
## Question 19
**Guess the output**
```C
#include <stdio.h>

#define PI  3.1415

int main(void)
{
    printf("The size of PI : %lu\n", sizeof(PI));
    return 0;
}
```
**Options**
```
a) 6
b) 4
c) 8
d) Compile time error
```
___
## Question 20
**Guess the output**
```C
#include <stdio.h>

#define A 010
#define B 200

int main(void)
{
    printf("%02X %02X\n", A, B);
    return 0;
}
```
**Options**
```
a) 0A C8
b) 08 C8
c) 10 C8
d) 10 D8
```
___
## Question 21
**Guess the output**
```C
#include <stdio.h>

#define A 100.23F
#define B 200F

int main(void)
{
    printf("%0.2f %0.2f\n", A, B);
    return 0;
}
```
**Options**
```
a) 100.23 200
b) 100.23 200.00
c) Compile time error
d) 100.230000 200.000000
```
___
## Question 22
**What does the following line prints**
```C
printf("\012");
```
**Options**
```
a) 012
b) A new line
c) Veritcal tab
d) Compile time error
```
___
## Question 23
**Guess the output**
```C
#include <stdio.h>

int func(const int a)
{
    a++;
    return a;
}
int main(void)
{
    int var = 30;

    func(var);
    printf("%d\n", var);
    return 0;
}
```
**Options**
```
a) 31
b) 30
c) Compile time error
d) Segmentation fault
```
___
## Question 24
```C
#include <stdio.h>

int main(void)
{
    if (-1L > 1UL) {
        printf("-1L > 1UL true\n");
    } else {
        printf("-1L > 1UL false\n");
    }
    return 0;
}
```
**Options**
```
a) -1L > 1UL true
b) -1L > 1UL false
c) None of the above
d) Compile time error
```
___
## Question 25
**Guess the output**
```C
#include <stdio.h>

int main(void)
{
    int x = 177;

    int y = x & 0177;

    printf("%d\n", y);
    return 0;
}
```
**Options**
```
a) 177
b) 49
c) 0
d) None of the above
```
___
## Question 26
**Guess the output**
```C
#include <stdio.h>

int main(void)
{
    int a = 2, b = 3, c = 4;

    if (a > 2)
        if (b > 3)
            printf("3");
    else
        printf("else");
}
```
**Options**
```
a) else
b) 3
c) Prints nothing
d) None of the above
```
___
## Question 27
**Guess the output**
```C
#include <stdio.h>

int main(void)
{
    int func();
    func();
    return 0;
}

int func(void)
{
    printf("func\n");
    return 0;
}
```
**Options**
```
a) Compile time error
b) func
c) Functions can't be declared inside a function
d) a and c
```
___
## Question 28
*array.c*
```C
#include <stdio.h>

int arr[24];
extern void func(void);

int main(void)
{
    func();
    return 0;
}
```
*array_extern.c*
```C
#include <stdio.h>

extern int arr[];

void func(void)
{
    printf("The arr size : %ld\n", sizeof(arr));
}
```
**Compile above two files together and guess the output**

**Options**
```
a) Compile time error
b) 96
c) 48
d) Garbage value
```
___
## Question 29
**Guess the output**
```C
#include <stdio.h>

int main(void)
{
        register float a = 2, b = 0;

        printf("%f\n", a / b);
        return 0;
}
```
**Options**
```
a) Program won't compile
b) inf
c) Floating point exception (core dumped)
d) 0
```
___
## Question 30
```C
#include <stdio.h>

register float d;

int main(void)
{
        register float a = 2, b = 1;

        d = b / a;
        printf("%f\n", d);
        return 0;
}
```
**Options**
```
a) 0.500000
b) 0
c) Program won't compile
d) Segmentation fault
```
___
## Question 31
```C
#include<stdio.h>

void function(int *p)
{
    int c=10;
    p=&c;
}

int main()
{
    register int a=20;
    int *p=&a;

    function(p);
    printf("%d\n",*p);

    return 0;
}

```
**Options**
```
a) 10
b) 20
c) Program won't compile
d) Garbage value
```
___
## Question 32
**Guess the output**
```C
#include <stdio.h>

int a = 2;
int b = a + 3;

int main()
{
   if(b/2.0 == 2.5)
       printf("if\n");
   else if(b/2 == 2)
       printf("else if\n");
   else
       printf("else\n");

   return 0;
}
```
**Options**
```
a) if
b) else if
c) else
d) Program won't compile
```
___
## Question 33
**Guess the output**
```C
#include <stdio.h>
#include <string.h>

int main(void)
{
    char name[] = "nayab.xyz blog";

    printf("%lu ", sizeof(name));
    snprintf(name, 128, "embed");
    printf("%lu\n", sizeof(name));

    return 0;
}
```
**Options**
```
a) 15 6
b) 15 15
c) Aborted (core dumped)
d) 15 128
```
___
## Question 34
**Guess the output**
```C
#include <stdio.h>

#define EMBEDDED "Embedded"
#define SYSTEMS "Systems"

int main(void)
{
    printf("%s\n", EMBEDDEDSYSTEMS);
    return 0;
}
```
**Options**
```
a) EmbeddedSystems
b) Embedded Systems
c) Compile time error
d) None of the above
```
___
## Question 35
**Guess the output**
```C
#include <stdio.h>

#define printd(x) printf(#x"\n")

int main(void)
{
    printd("nayab.xyz");
    return 0;
}
```
**Options**
```
a) nayab.xyz
b) "nayab.xyz"
c) Compile time error
d) None of the above
```
___
## Question 36
**Guess the output**
```C
#include <stdio.h>

#define concat(x, y) x ## y
#define nam(x) #x

int main(void)
{
    char *concat(my, name) = nam(nayab.xyz);

    printf("%s : %s\n", concat(my, name), nam(nayab.xyz));
    return 0;
}
```
**Options**
```
a) myname : nayab.xyz
b) nayab.xyz : nayab.xyz
c) Compile time error
d) None of the above
```
___
## Question 37
**Which of the following preprocessor condition syntax is valid?**
```
a) #if (defined(A) || defined(B))
b) #if defined(A) || defined(B)
c) #if (defined(A) or defined(B))
d) a and b
```
___
## Question 37
**Guess the output**
```C
#include <stdio.h>

void print_a(int *a, int len)
{
    int i = 0;

    printf("a[] = ");
    for (i = 0; i < len; i++) {
        printf("%d ", a[i]);
    }
    puts("");
}

int main(void)
{
    int a[] = {2, 3, 4, 5, 6}, b = 0, *p = NULL;

    p = a;

    *p++;
    ++*p;
    b = (*p)++;

    printf("b = %d and ", b);
    print_a(a, sizeof(a)/sizeof(a[0]));
    return 0;
}
```
**Options**
```
a) b = 4 and a[] = 5 3 4 5 6
b) b = 5 and a[] = 2 3 5 5 6
c) b = 4 and a[] = 2 5 4 5 6
d) None of the above
```
___
## Question 38
**Guess the output**
```C
#include <stdio.h>

int main(void)
{
    char *p;
    int a[] = {2, 3, 4, 5, 6};

    p = a;
    p += sizeof(int);
    printf("%d\n", *(int *)p);
    return 0;
}
```
**Options**
```
a) Undefined behaviour
b) 3
c) 6
d) None of the above
```
___
## Question 39
**Guess the output**
```C
#include <stdio.h>

int main(void)
{
    char *p = "Hello";

    p[3] = 'o';
    putchar(p[3]);
    return 0;
}
```
**Options**
```
a) Heloo
b) Segmentation fault (core dumped)
c) Compile time error
d) None of the above
```
___
## Question 40
**Guess the output**
```C
#include <stdio.h>

int main(void)
{
    char name[][32] = {"Hello World!", "Howdy"};
    char *aname[] = {"Hello World!", "Howdy"};

    printf("%lu %lu\n", sizeof(name[1]), sizeof(aname[1]));
    return 0;
}
```
**Options**
```
a) 32 32
b) 6 6
c) 32 8
d) 32 6
```
___
## Question 41
**Guess the output**
```C
#include <stdio.h>

void func(int arg[])
{
    printf("%d\n", *++arg);
}

int main(void)
{
    int arg[] = {2, 3, 4, 5};

    func(arg);
    return 0;
}
```
**Options**
```
a) In func(), base address of arg can't be incremented
b) Compile time error
c) 3
d) a and b
```
___
## Question 42
**Guess the output**
```C
#include <stdio.h>

struct name {
    int len;
    char *name;
};

int main(void)
{
    struct name data[2] = {
        {5, "nayab"},
        {3, "xyz"}
    };

    struct name *ptr = data;

    printf("%d %s\n", ++ptr->len, ptr++->name);

    return 0;
}
```
**Options**
```
a) 4 xyz
b) 3 xyz
c) 3 nayab
d) 4 nayab
5) None of the above
```
___
## Question 43
**Guess the output**
```C
#include <stdio.h>

#define arr_size (sizeof(a) / sizeof(a[0]))

int main(void)
{
    int a[] = {2, 3, 4, 5};

    int *p = &a[0], *q = &a[arr_size];

    int *mid = p + (q - p) / 2;

    printf("%d\n", *mid);
    return 0;
}
```
**Options**
```
a) Behaviour undefined as the q pointing beyond the end of array
b) 3
c) 4
d) Segmentation fault
```
<!-- Pointer arithmetic that involves the first element beyond the end of array will work correctly-->

___
## Question 44
**What does the following line do?**

```C
typedef int (*PFI)(char *, char *);
```
<!-- Creates a type PFI for function to pointer returning int. Can be used like 'PFI strcmp, numcmp;'-->
___
## Question 45
**Guess the output**
```C
#include <stdio.h>

int main(void)
{
    struct data {
        int is_extern: 1;
        int is_auto: 1;
    } is_data = {1, 1};

    printf("%d %d\n", is_data.is_extern, is_data.is_auto);
    return 0;
}
```
**Options**
```
a) 1 1
b) -1 -1
c) Behaviour undefined. Different for diffent machines. Implementation defined.
d) 4294967295 4294967295
```
___
## Question 46

*File : arg.c*
```C
#include <stdio.h>

int main(int argc, char **argv)
{
    int i = 0;

    while (i < argc) {
        printf("%s ", argv[i]);
        i++;
    }
    puts("");
    return 0;
}
```
<br>
*File : dataFile*
```
This is temporary data
```

`arg.c` is compiled with:
```bash
gcc -Wall arg.c -o arg
```
**Guess the output of following**
```bash
./arg < dataFile
```
**Options**
```
a) ./arg
b) ./arg < dataFile
c) ./arg This is temporary data
d) None of the above
```
___
## Question 47
**Guess the output**
```C
#include <stdio.h>

int main(void)
{
    char *s = "Hello World!";

    printf(s);
    return 0;
}
```
**Options**
```
a) Hello World!
b) Compile time error
c) Segmentation fault
d) None of the above
```
___
## Question 48
**Guess the output**
```C
#include <stdio.h>

int main(void)
{
    char *s = "Hello World!";

    printf(":%-20.5s:\n", s);
    return 0;
}
```
**Options**
```
a) :               Hello:
b) :Hello               :
c) :Hello World!        :
d) :        Hello World!:
```
___
## Question 49
**Guess the output**
```C
#include <stdio.h>
#include <string.h>

int main(void)
{
    char *mac = "ab:bc:cd:de:ef:f0";
    unsigned int macHex[6];
    int i = 0, count = 0;

    memset(macHex, 0, sizeof(macHex));
    count = sscanf(mac, "%02X : %02X : %02X , %02X : %02X : %02X",
            &macHex[0], &macHex[1], &macHex[2], &macHex[3],
            &macHex[4], &macHex[5]);
    for (i = 0; i < count; i++) {
        printf("%02X ", macHex[i]);
    }
    puts("");
    return 0;
}
```
**Options**
```
a) AB BC CD 00 00 00
b) ab:bc:cd:de:ef:f0
c) AB BC CD DE EF F0
d) AB BC CD
e) ab bc cd de ef f0
```
___
## Question 50

<strong><i>FILE</i> is a type defined of a</strong>
```
a) char
b) int
c) double
d) structure
```
___
## Question 51
**Guess the output**
```C
#include <stdio.h>

#define 1ST_NAME(x) #x

int main(void)
{
    puts(1ST_NAME(nayab));
    return 0;
}
```
**Options**
```
a) nayab
b) "nayab"
c) Compile time error
d) None of the above
```

---
layout : post
title : pause() system call in C - explained with examples
---
## Introduction

The `pause()` system call is used to make the calling process or thread sleep until one of the following things happened.
 - The calling process receives the signal whose default behaviour is to kill the process.
 - The signal handler execution is finished.

In both the cases the pause() system call returns -1.

## Behaviour when the process catches signal

Consider the following program.

*file* : pause.c
```C
#include <stdio.h>
#include <unistd.h>

int main(void)
{
        int ret = 0;
        ret = pause();
        printf("Pause returned with %d\n", ret);
        return 0;
}
```
Compile the program using -
```bash
gcc pause.c -o pause
```

Run the program with `./pause`. From the other terminal, send signals to this process using `kill` command.

Examples:
```bash
kill -SIGKILL `pidof pause`	# Kills the process

OR

kill -SIGCHLD `pidof pause`	# Won't have any effect
```

The default behaviour of SIGCHLD, SIGCONT, SIGSTOP signals are NOT to terminate the process. So pause() system call won't return upon catching these signals. However the pause() function returns when it receives the signals whose default behaviour is to kill the process. Like SIGKILL, SIGTERM etc.

Please run `man 7 signal` to see all the signals and their default behaviours.

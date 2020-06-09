---
layout : post
title : pause() system call in C - explained with examples
---
## Introduction

The `pause()` system call is used to make the calling process or calling thread sleep until one of the following events happened.
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

Run the program with `./pause`. The program sleeps at line `ret = pause();`. From the other terminal, send signals to this process using `kill` command.

Examples:
```bash
kill -SIGKILL `pidof pause`	# Kills the process

OR

kill -SIGCHLD `pidof pause`	# Won't have any effect
```

The signals SIGCHLD, SIGCONT, SIGSTOP won't kill the process as the default behaviour of these signals are NOT to terminate the process. So pause() system call won't return upon catching these signals.

However the pause() function returns when it receives the signals whose default behaviour is to kill the process. Like SIGKILL, SIGTERM etc. For more information, please run `man 7 signal` command to see all the signals and their default behaviours.


## Behaviour when the process finishes signal handler execution

Consider the following program
```C
#include <stdio.h>
#include <signal.h>
#include <unistd.h>

void signal_handler(int signal)
{
        printf("Signal %d caught\n", signal);
}

int main(void)
{
        struct sigaction act;
        int ret = 0;

        act.sa_handler =  signal_handler;
        sigaction(SIGCONT, &act, NULL);
        ret = pause();
        if (-1 == ret)
                printf("Process exited\n");
        return 0;
}
```

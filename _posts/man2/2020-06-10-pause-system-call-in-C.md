---
layout : post
title : pause() system call in C - explained with examples
category : man2
date: 2020-06-10 07:33:03 +5:30
comments : true
google_adsense: true
excerpt : The explanation of pause() system call and it's behaviour in C programming language with examples.
keywords : pause() system call, pause() system call in Linux, pause() system call in C, pause system call example
image : /assets/img/pause_syscall.png
toc : true
---
## Introduction

The `pause()` system call is used to make the calling process or calling thread sleep until one of the following events happened.
 - The calling process receives the signal whose default behaviour is to kill the process. (OR)
 - The signal handler execution is finished.

In both the cases the pause() system call returns -1.
{% include image.html url="pause_syscall.png" description="pause() system call in C - explained with examples" %}

## Behaviour when the process catches signal

Consider the following program.

***file*** : pause.c
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

The signals *SIGCHLD, SIGCONT, SIGSTOP* won't kill the process as the default behaviour of these signals are NOT to terminate the process. Neither the signal handler is registered in the program. So pause() system call won't return upon catching these signals.

However the pause() function returns when it receives the signals whose default behaviour is to kill the process. Like *SIGKILL, SIGTERM* etc. For more information on signals and their default behaviours, please run `man 7 signal` command.


## Behaviour when the process finishes signal handler execution

Consider the following program

***file*** : pause_sigaction.c
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
A signal handler has been registered for the signal *SIGCONT*. When we pass this signal to the process, the *signal_handler* function is called. In this case the pause() returns when the signal_handler completes execution. This is true for all signals whether the signal default behaviour is to terminate the process or not.

Let's compile the program with -
```bash
gcc pause_sigaction.c -o pause_sigaction
```
Execute the program with `./pause_sigaction` in one terminal and in other terminal run the following command to send SIGCONT signal to the process.
```bash
kill -SIGCONT `pidof pause_sigaction`
```
The pause() is returned, signal number is printed in the signal_handler() and the process is exited.

Replace *SIGCONT* with *SIGALRM*, whose default behaviour is to terminate the process, in the above program. Re-compile and run the program. Pass the SIGALRM signal to the process using the kill command. The same behaviour can be observed.

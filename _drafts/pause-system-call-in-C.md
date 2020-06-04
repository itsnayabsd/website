---
layout : post
title : pause() system call in C - explained with examples
---
file : pause.c
```
#include <stdio.h>
#include <unistd.h>

int main(void)
{
        pause();
        return 0;
}
```

```
gcc pause.c -o pause
```

Signals whose default behaviour is not termination of process :

SIGCHLD, SIGCONT, SIGSTOP

The default behaviour of all the signals except above signals is to terminate the calling process.

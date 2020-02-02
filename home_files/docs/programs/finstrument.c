#include "finstrument.h"
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>

int fins_indx = 0;

void __cyg_profile_func_enter (void *this_fn, void *call_site)
{
    struct timeval start;
    fins_indx++;
    printf("%p : Entered\n", this_fn);
    gettimeofday(&start, NULL);
    t_value_usec[fins_indx] = (unsigned long) start.tv_usec / 1000 + (unsigned long) start.tv_sec * 1000;
}

void __cyg_profile_func_exit  (void *this_fn, void *call_site)
{
    struct timeval stop;
    gettimeofday(&stop, NULL);
    printf("%p : Exited with time elapsed :", this_fn);
    printf("%lu m.sec\n", (unsigned long) stop.tv_usec / 1000 + (unsigned long) stop.tv_sec * 1000 - t_value_usec[fins_indx]);
    fins_indx--;
}


#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>

unsigned long t_value_usec[2014];
int indx = 0;

void __cyg_profile_func_enter (void *this_fn, void *call_site) __attribute__((no_instrument_function));
void __cyg_profile_func_exit  (void *this_fn, void *call_site) __attribute__((no_instrument_function));

void __cyg_profile_func_enter (void *this_fn, void *call_site)
{
	struct timeval start;
	indx++;
	printf("%p : Entered\n", this_fn);
	gettimeofday(&start, NULL);
	t_value_usec[indx] = (unsigned long) start.tv_usec / 1000 + (unsigned long) start.tv_sec * 1000;
}

void __cyg_profile_func_exit  (void *this_fn, void *call_site)
{
	struct timeval stop;
	gettimeofday(&stop, NULL);
	printf("%p : Exited with time elapsed :", this_fn);
	printf("%lu m.sec\n", (unsigned long) stop.tv_usec / 1000 + (unsigned long) stop.tv_sec * 1000 - t_value_usec[indx]);
	indx--;
}

void func1(void)
{
	usleep(30000);
}

void func2(void)
{
	sleep(1);
}

int main(void)
{
	func1();
	func2();
	return 0;
}

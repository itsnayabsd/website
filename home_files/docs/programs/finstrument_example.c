#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>

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

#include <stdio.h>
/* A simple function to print an integer */
int func1(int a)
{
	printf("%d\n", a);
	return 0;
}
/* A simple function to print an integer */
int func2(int a)
{
	printf("%d\n", a);
	return 0;
}
/* A simple function to print an integer */
int func3(int a)
{
	printf("%d\n", a);
	return 0;
}

/* A func whose parameter is array of function pointers */
int func(int (**funcp)(int a))
{
	funcp[1](8);
	funcp[2](9);
	return 0;
}

/* Typedef for array of function pointers to use as return value */
typedef int (**funcret) (int (**funcp)(int a));

/* Function which used above typedef to return array of function pointers.
 * This fuctions argument is also array of function pointers */
funcret fn(int (**funcp)(int a))
{
	return funcp;
}

int main(void)
{
	/* A simple funciton pointer example */
	int (*funcptr)(int a) = func1;
	funcptr(10);//prints 10

	/* Array of function pointers passed as argument to function */
	int (*funcp[])(int a) = {func1, func2, func3};
	func(funcp);//prints 8 and 9

	/* Array of func pointers passed to fn which returns again array of function pointers
	 * and then again passing the return value to a function*/
	func(fn(funcp));// prints 8 and 9
	return 0;
}

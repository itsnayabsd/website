#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{
	if (argc < 2) {
		printf("./a.out \"string to encrypt\"\n");
		return 0;
	}
	unsigned char pass[1024];
	int i, k = 0, len;

	memset(pass, 0, sizeof(pass));
	fgets(pass, 1024, stdin);
	pass[strlen(pass) - 1] = 0;

	unsigned char ch;
	len = strlen(pass);
	for (i = 0; argv[1][i]; i++) {
		if (k == len)
			k = 0;
		printf("%02X", (unsigned char) (argv[1][i] - pass[k++]));
	}
	puts("");
	return 0;
}

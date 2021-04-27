#include <stdio.h>
#include <string.h>

unsigned int seed_len = 83;

void decrypt_str(unsigned char *encrypted_seed, unsigned char *pass)
{
	unsigned int c = 0;
	int i = 0, index = 0;
	int pass_len = strlen(pass);
	for (i = 0; i < 2 * seed_len; i = i + 2) {
		index = (index == pass_len)?0:index;
		sscanf(encrypted_seed + i, "%2X", &c);
		printf("%c", c + pass[index++]);
	}
	puts("");
}
int main(void)
{
	unsigned char encrypted_seed[1024] = "112E3D100D33EA3DF2031E292B0200EE3D44F603112FEA0E0F3D3835B1FA1A24390A0DEE313C00F311E038000B362F47B1F2113239FD0431EA39FFFB11233EBB09334143B1FE0D383308103BEA430AFE0E2F36";
	unsigned char pass[1024];
       
	memset(pass, 0, sizeof(pass));

	fgets(pass, 1024, stdin);
	pass[strlen(pass) - 1] = 0;
	decrypt_str(encrypted_seed, pass);
	return 0;
}

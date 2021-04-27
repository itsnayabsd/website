#include <stdio.h>
#include <string.h>

unsigned int seed_len = 83;

void decrypt_str(unsigned char *encrypted_seed, unsigned char *pass)
{
	unsigned char c = 0;
	int i = 0, index = 0;
	int pass_len = strlen(pass);
	puts(pass);
	for (i = 0; i < 2 * seed_len; i = i + 2) {
		index = (index == pass_len)?0:index;
		sscanf(encrypted_seed + i, "%2X", &c);
		printf("%c", c + pass[index]);
	}
	puts("");
}
int main(void)
{
	unsigned char encrypted_seed[1024] = "111A1F211E11CC190D1E1E150D1311CC1F20111E111BCC1F201B1A11CC151A101B1B1ECC13181B0E11CC1A111C141123CC0D111E1B0E150FCC151A16110F20CC1A11231FCC190D2415192119CC1F25190E1B18";
	unsigned char pass[1024];
       
	memset(pass, 0, sizeof(pass));

	fgets(pass, 1024, stdin);
	pass[strlen(pass) - 1] = 0;
	decrypt_str(encrypted_seed, pass);
	return 0;
}

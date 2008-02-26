#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define WORD_MAX	256
#define MEAN_MAX	4096

int fread_str(FILE* fp, char* buf)
{
	int		i = 0;
	char	c;

	do
	{
		c = fgetc(fp);
		buf[i] = c;
		i++;
	} while (c != 0);

	return i - 1;
}

int main(void)
{
	char	filename_idx[] = "/usr/share/stardict/dic/stardict-langdao-ec-gb-2.4.2/langdao-ec-gb.idx";
	FILE*	fp;
	char	idx[WORD_MAX];
	int		i;
	
	fp = fopen(filename_idx, "rb");
	i = fread_str(fp, idx);
	printf("got idx: %i, %s\n", i, idx);
	fclose(fp);
	
	return 0;
}

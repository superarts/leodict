#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

//	#define DICT_IDX	"/usr/share/stardict/dic/stardict-langdao-ec-gb-2.4.2/langdao-ec-gb.idx"
//	#define DICT_TXT	"/usr/share/stardict/dic/stardict-langdao-ec-gb-2.4.2/langdao-ec-gb.txt"

#define WORD_MAX	256
#define MEAN_MAX	4096

char g_name[WORD_MAX] = "dict_data";
char g_fidx[WORD_MAX] = "";
char g_ftxt[WORD_MAX] = "";

int fread_str(FILE* fp, char* buf)
{
	int		i = 0;
	char	c;

	do
	{
		c = fgetc(fp);
#if 0
		if (c == '\'')
		{
			buf[i] = '\\';
			i++;
		}
#endif
		buf[i] = c;
		i++;
	} while (c != 0);

	return i - 1;
}

int fread_dat(FILE* fp, int count, char* buf)
{
	int		i;
	char	c;

	for (i = 0; i < count; i++)
	{
		c = fgetc(fp);

		//	filter: bypass lua block comment sign [[ or ]]
		if (i >= 1)
		{
			if ((c == '[') && (buf[i - 1] == '['))
			{
				c = ' ';
			}
			if ((c == ']') && (buf[i - 1] == ']'))
			{
				c = ' ';
			}
		}
			
		buf[i] = c;
	}
	buf[count] = 0;

	return i - 1;
}

uint32_t fread_u32(FILE* fp)
{
	unsigned char	c1, c2, c3, c4;

	c1 = fgetc(fp);
	c2 = fgetc(fp);
	c3 = fgetc(fp);
	c4 = fgetc(fp);

	return c1 * 0x1000000 + c2 * 0x10000 + c3 * 0x100 + c4;
}

int	get_idx(FILE* fp)
{
	//	char	filename_data[] = DICT_TXT;
	FILE*		fp_data;
	static int	counter;
	char		idx[WORD_MAX];
	char		meaning[MEAN_MAX];
	int			ret, pos, size;

	ret = fread_str(fp, idx);
	pos = fread_u32(fp);
	size = fread_u32(fp);
	//	printf("got idx: %s(%i) at %i for %i\n", idx, ret, pos, size);

	fp_data = fopen(g_ftxt, "rb");
	fseek(fp_data, pos, SEEK_SET);
	fread_dat(fp_data, size, meaning);
	//	printf("got meaning: %i, %i, %s\n", size, strlen(meaning), meaning);
	fclose(fp_data);

	if (true)
	{
		//	printf("%s['%s'][0] = %i;\n", g_name, idx, pos);
		//	printf("%s['%s'][1] = %i;\n", g_name, idx, size);
		
		//	printf("%s[%i] = '%s';\n", g_name, counter, idx);

		//	printf("%s\t%i\t%i\n", idx, pos, size);

		printf("\t%s\t\n%s\t\n", idx, meaning);
	}
	counter++;

	return ret;
}

int main(int argc, char** argv)
{
	//	char	filename_idx[] = DICT_IDX;
	FILE*	fp;
	int		i, filesize;

	if (argc < 4)
	{
		printf("usage: dict2lua var_name idx_name txt_name\n");
		return -1;
	}
	strcpy(g_name, argv[1]);
	strcpy(g_fidx, argv[2]);
	strcpy(g_ftxt, argv[3]);

	printf("%s = [[\n", g_name);
	fp = fopen(g_fidx, "rb");

	//	get filesize
	fseek(fp, 0, SEEK_END);
	filesize = ftell(fp);
	fseek(fp, 0, SEEK_SET);

	while (ftell(fp) < filesize)
	{
		i = get_idx(fp);
		//	i = ftell(fp); printf("%i\n", i);
	}
	fclose(fp);
	printf("]]\n");
	
	return 0;
}

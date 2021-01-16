#include <stdio.h>

int somaArray(int *array, int size);

int main(int argc, char const *argv[])
{	
	int vector[10] = {100, 200, 300, 500, 900, 1000, 500, 500, 1000, 2000};
	printf("%d\n", somaArray(vector, 10));
	return 0;
}
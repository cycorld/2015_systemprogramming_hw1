#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void copyij(int *src, int *dat, int array_size) {
  int i, j;
  for(i = 0; i < array_size; i++)
    for(j = 0; j < array_size; j++)
      dat[i * array_size + j] = src[i * array_size + j];
}

int main(int argc, char **argv) {
  int array_size = atoi(argv[1]);
  clock_t start_time, end_time;
  //printf( "RAND_MAX = %d\n", RAND_MAX);
  int sample[array_size][array_size];
  int target[array_size][array_size];
  int i, j;
  for(i = 0; i < array_size; i++)
    for(j = 0; j < array_size; j++)
      sample[i][j] = rand();
  // IJ_START
  start_time = clock();
  // START Code
  copyij(sample, target, array_size);
  // END CODE
  end_time = clock();
  printf("%f", ((double)(end_time-start_time)) / CLOCKS_PER_SEC);
  // IJ_END
}

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    int n = argc > 1 ? atoi(argv[1]) : 128;
    if (n < 1 || n > 100000) return 2;
    int *values = malloc((size_t)n * sizeof(*values));
    if (!values) return 3;
    unsigned state = 0x12345678u;
    for (int i = 0; i < n; ++i) {
        state = state * 1664525u + 1013904223u;
        values[i] = (int)(state % (unsigned)(n * 3 + 1));
    }
    for (int i = 1; i < n; ++i) {
        int value = values[i];
        int j = i;
        while (j > 0 && values[j - 1] > value) {
            values[j] = values[j - 1];
            --j;
        }
        values[j] = value;
    }
    printf("sorting size=%d checksum=%d\n", n, values[n / 2]);
    free(values);
    return 0;
}

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    int n = argc > 1 ? atoi(argv[1]) : 16;
    if (n < 1 || n > 512) return 2;
    double *a = calloc((size_t)n * n, sizeof(*a));
    double *b = calloc((size_t)n * n, sizeof(*b));
    double *c = calloc((size_t)n * n, sizeof(*c));
    if (!a || !b || !c) return 3;
    for (int i = 0; i < n * n; ++i) {
        a[i] = (double)((i % 17) + 1) / 17.0;
        b[i] = (double)((i % 13) + 1) / 13.0;
    }
    for (int i = 0; i < n; ++i)
        for (int k = 0; k < n; ++k)
            for (int j = 0; j < n; ++j)
                c[i * n + j] += a[i * n + k] * b[k * n + j];
    printf("matrix size=%d checksum=%.6f\n", n, c[(n - 1) * n + (n - 1)]);
    free(a); free(b); free(c);
    return 0;
}

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    int n = argc > 1 ? atoi(argv[1]) : 10000;
    if (n < 1 || n > 10000000) return 2;
    unsigned state = 0x9e3779b9u;
    long score = 0;
    for (int i = 0; i < n; ++i) {
        state = state * 1103515245u + 12345u;
        unsigned value = state >> 24;
        if ((value & 7u) == 0u) score += 3;
        else if ((value & 1u) == 0u) score -= 1;
        else score += (value & 3u);
    }
    printf("branch-intensive size=%d score=%ld\n", n, score);
    return 0;
}

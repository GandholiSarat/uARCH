#include <stdio.h>
#include <stdlib.h>

typedef struct Node { int value; struct Node *next; } Node;

int main(int argc, char **argv) {
    int n = argc > 1 ? atoi(argv[1]) : 128;
    if (n < 1 || n > 100000) return 2;
    Node *head = NULL;
    for (int i = n - 1; i >= 0; --i) {
        Node *node = malloc(sizeof(*node));
        if (!node) return 3;
        node->value = (i * 37) % (n + 11);
        node->next = head;
        head = node;
    }
    long checksum = 0;
    for (int pass = 0; pass < 3; ++pass)
        for (Node *node = head; node; node = node->next)
            checksum += node->value + pass;
    printf("linked-list size=%d checksum=%ld\n", n, checksum);
    while (head) {
        Node *next = head->next;
        free(head);
        head = next;
    }
    return 0;
}

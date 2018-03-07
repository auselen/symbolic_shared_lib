#include <stdio.h>

int bar();
int baz();

int foo() {
    return FOO;
}

int main() {
    printf("%d =? %d =? %d\n", foo(), bar(), baz());
    return 0;
}

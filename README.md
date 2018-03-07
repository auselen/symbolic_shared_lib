# symbolic_shared_lib
Demonstrate result of linking shared libraries with and without symbolic flag.
```
$ cat foo.c
int foo() {
    return FOO;
}

int FNAME() {
	return foo();
}

$ cat main.c
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

$ make
gcc -Wall -fPIC -I. -shared -Wl,-Bsymbolic -DFNAME=bar -DFOO=1 foo.c -o bar_sym.so
gcc -Wall -fPIC -I. -shared -Wl,-Bsymbolic -DFNAME=baz -DFOO=2 foo.c -o baz_sym.so
gcc -Wall -fPIC -I. -DFOO=0 -o main_sym main.c bar_sym.so baz_sym.so
gcc -Wall -fPIC -I. -shared -DFNAME=bar -DFOO=1 foo.c -o bar.so
gcc -Wall -fPIC -I. -shared -DFNAME=baz -DFOO=2 foo.c -o baz.so
gcc -Wall -fPIC -I. -DFOO=0 -o main main.c bar.so baz.so
with symbolic linking
LD_LIBRARY_PATH=. ./main_sym
0 =? 1 =? 2
without symbolic linking
LD_LIBRARY_PATH=. ./main
0 =? 0 =? 0
```


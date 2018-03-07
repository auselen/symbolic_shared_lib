CC=gcc
CFLAGS=-Wall -fPIC -I.
LDFLAGS=-L.

all: main_sym main
	@echo "with symbolic linking"
	LD_LIBRARY_PATH=. ./main_sym
	@echo "without symbolic linking"
	LD_LIBRARY_PATH=. ./main

main_sym: main.c bar_sym.so baz_sym.so
	$(CC) ${CFLAGS} -DFOO=0 -o main_sym main.c bar_sym.so baz_sym.so

bar_sym.so: foo.c
	$(CC) ${CFLAGS} -shared -Wl,-Bsymbolic -DFNAME=bar -DFOO=1 foo.c -o bar_sym.so

baz_sym.so: foo.c
	$(CC) ${CFLAGS} -shared -Wl,-Bsymbolic -DFNAME=baz -DFOO=2 foo.c -o baz_sym.so

main: main.c bar.so baz.so
	$(CC) ${CFLAGS} -DFOO=0 -o main main.c bar.so baz.so

bar.so: foo.c
	$(CC) ${CFLAGS} -shared -DFNAME=bar -DFOO=1 foo.c -o bar.so

baz.so: foo.c
	$(CC) ${CFLAGS} -shared -DFNAME=baz -DFOO=2 foo.c -o baz.so

clean:
	rm -f main main_sym *.o *.so

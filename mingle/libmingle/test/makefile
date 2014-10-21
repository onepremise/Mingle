MINGLELIB=libmingle.a

SRC := $(wildcard test-*.c)
SRC += progname.c

OBJ = $(SRC:.c=.o)

#INCLUDES = -isysteminclude -I/mingw/x86_64-w64-mingw32/include
INCLUDES = -isysteminclude -I../include
OPTIMISATIONS = -g
CFLAGS = -Wall -D__WIN32__ -D__MINGW32__ -D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO
LFLAGS= -L.. -lmingle.dll -mconsole

export PATH := $(PATH):$(shell pwd)/../.libs

export srcdir := $(shell pwd)

MAIN = $(SRC:test-%.c=test-%.exe)

default: $(MAIN) progname.o

check: $(MAIN)
	bash test-runner.sh $$test || exit 1;

debug: OPTIMISATIONS = -g
debug: $(MAIN)

test-%.exe: test-%.o
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ $< $(LIBS) $(LFLAGS) -lws2_32 -liconv

progname.o:
	gcc $(INCLUDES) $(CFLAGS) $(OPTIMISATIONS) -c progname.c -o $@
	
test-filenamecat.exe: test-filenamecat.o progname.o
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ $< progname.o $(LIBS) $(LFLAGS) -lws2_32 -liconv

.c.o:
	gcc $(INCLUDES) $(CFLAGS) $(OPTIMISATIONS) -c $< -o $@

clean:
	rm -f $(MAIN)
	rm -f $(OBJ)

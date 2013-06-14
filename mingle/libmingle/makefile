MINGLELIB=libmingle.a

SRC = uname.c
OBJ = $(SRC:.c=.o)

INCLUDES = -I.

CFLAGS = -Wall -O3 -D__MINGW32__

default: $(MINGLELIB)

.c.o:
	gcc $(INCLUDES) $(CFLAGS) -c $< -o $@

$(MINGLELIB): $(OBJ)
	ar rcs $(MINGLELIB) $(OBJ)

clean:
	rm -f $(OBJ) $(MINGLELIB)
	
install:
	cp sys/* /mingw/x86_64-w64-mingw32/include/sys
	cp $(MINGLELIB) /mingw/x86_64-w64-mingw32/lib
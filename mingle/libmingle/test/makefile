MINGLELIB=libmingle.a

SRC = test-lstat.c test-poll.c test-fcntl.c test-dup.c test-dup2.c test-accept.c \
      test-alloca-opt.c test-getpeername.c test-getsockopt.c test-stat.c \
      test-stat-time.c test-nanosleep.c test-select.c test-raise.c \
      test-sigprocmask.c test-gettimeofday.c test-fsync.c \
      test-random.c test-random_r.c test-isatty.c test-ftruncate.c \
      test-gethostname.c test-getsockname.c test-shutdown.c test-send.c \
      test-sendto.c test-recv.c test-recvfrom.c test-time.c test-times.c
OBJ = $(SRC:.c=.o)

#INCLUDES = -isysteminclude -I/mingw/x86_64-w64-mingw32/include
INCLUDES = -I../include
OPTIMISATIONS = -O3
CFLAGS = -Wall -D__MINGW32__ -D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO
LFLAGS= -L.. -lmingle -mconsole

MAIN = test-lstat.exe test-poll.exe test-fcntl.exe test-dup.exe test-dup2.exe \
       test-accept.exe test-alloca-opt.exe test-getpeername.exe test-getsockopt.exe \
       test-stat.exe test-stat-time.exe test-nanosleep.exe test-select.exe \
       test-raise.exe test-sigprocmask.exe test-gettimeofday.exe test-fsync.exe \
       test-random.exe test-random_r.exe test-isatty.exe test-ftruncate.exe \
       test-gethostname.exe test-getsockname.exe test-shutdown.exe test-send.exe \
       test-sendto.exe test-recv.exe test-recvfrom.exe test-time.exe test-times.exe

default: $(MAIN)

check: $(MAIN)
	bash test-runner.sh $$test || exit 1;

debug: OPTIMISATIONS = -g
debug: $(MAIN)

test-lstat.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-lstat.o $(LIBS) $(LFLAGS)
	
test-poll.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-poll.o $(LIBS) $(LFLAGS) -lws2_32
	
test-fcntl.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-fcntl.o $(LIBS) $(LFLAGS) -lws2_32
	
test-dup.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-dup.o $(LIBS) $(LFLAGS) -lws2_32
	
test-dup2.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-dup2.o $(LIBS) $(LFLAGS) -lws2_32

test-accept.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-accept.o $(LIBS) $(LFLAGS) -lws2_32

test-alloca-opt.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-alloca-opt.o $(LIBS) $(LFLAGS) -lws2_32
	
test-getpeername.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-getpeername.o $(LIBS) $(LFLAGS) -lws2_32
	
test-getsockopt.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-getsockopt.o $(LIBS) $(LFLAGS) -lws2_32
	
test-stat.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-stat.o $(LIBS) $(LFLAGS) -lws2_32
	
test-stat-time.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-stat-time.o $(LIBS) $(LFLAGS) -lws2_32
	
test-nanosleep.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-nanosleep.o $(LIBS) $(LFLAGS) -lws2_32

test-select.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-select.o $(LIBS) $(LFLAGS) -lws2_32

test-raise.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-raise.o $(LIBS) $(LFLAGS) -lws2_32

test-sigprocmask.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-sigprocmask.o $(LIBS) $(LFLAGS) -lws2_32

test-gettimeofday.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-gettimeofday.o $(LIBS) $(LFLAGS) -lws2_32

test-fsync.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-fsync.o $(LIBS) $(LFLAGS) -lws2_32
	
test-random.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-random.o $(LIBS) $(LFLAGS) -lws2_32
	
test-random_r.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-random_r.o $(LIBS) $(LFLAGS) -lws2_32
	
test-isatty.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-isatty.o $(LIBS) $(LFLAGS) -lws2_32
	
test-ftruncate.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-ftruncate.o $(LIBS) $(LFLAGS) -lws2_32
	
test-gethostname.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-gethostname.o $(LIBS) $(LFLAGS) -lws2_32
	
test-getsockname.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-getsockname.o $(LIBS) $(LFLAGS) -lws2_32

test-shutdown.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-shutdown.o $(LIBS) $(LFLAGS) -lws2_32
	
test-send.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-send.o $(LIBS) $(LFLAGS) -lws2_32
	
test-sendto.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-sendto.o $(LIBS) $(LFLAGS) -lws2_32
	
test-recv.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-recv.o $(LIBS) $(LFLAGS) -lws2_32
	
test-recvfrom.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-recvfrom.o $(LIBS) $(LFLAGS) -lws2_32
	
test-time.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-time.o $(LIBS) $(LFLAGS) -lws2_32

test-times.exe: $(OBJ)
	x86_64-w64-mingw32-gcc  $(CFLAGS) -o $@ test-times.o $(LIBS) $(LFLAGS) -lws2_32
	
.c.o:
	gcc $(INCLUDES) $(CFLAGS) $(OPTIMISATIONS) -c $< -o $@

clean:
	rm -f $(MAIN)
	rm -f $(OBJ)

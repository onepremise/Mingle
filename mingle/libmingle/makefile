MINGLELIB=libmingle.a

SRC = uname.c msvc-inval.c msvc-nothrow.c fcntl.c writev.c stat.c stat-time.c fstat.c \
      lstat.c nanosleep.c readlink.c realpath.c pipe.c poll.c binary-io.c symlink.c socket.c \
      sig-handler.c sigprocmask.c inet_ntop.c setsockopt.c listen.c waitpid.c unlink.c \
      unlinkat.c open.c select.c sockets.c inet_pton.c openat.c openat-die.c \
      openat-proc.c save-cwd.c exitfail.c filenamecat-lgpl.c chdir-long.c close.c \
      cloexec.c dirname-lgpl.c fd-hook.c malloc.c malloca.c alloca.c calloc.c connect.c bind.c \
      accept.c write.c read.c ioctl.c getdtablesize.c dup.c dup2.c fchdir.c getcwd.c \
      getcwd-lgpl.c realloc.c basename-lgpl.c dirfd.c lseek.c getpeername.c fsync.c\
      getsockopt.c sigaction.c times.c time_r.c raise.c timespec.c gettime.c gettimeofday.c\
      random.c random_r.c isatty.c ftruncate.c mktime.c gethostname.c getsockname.c \
      shutdown.c send.c sendto.c recv.c recvfrom.c
OBJ = $(SRC:.c=.o)

#INCLUDES = -isysteminclude -I/mingw/x86_64-w64-mingw32/include
INCLUDES = -Iinclude
OPTIMISATIONS = -O3
CFLAGS = -Wall -D__MINGW32__ -D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO

default: $(MINGLELIB)

debug: OPTIMISATIONS = -g
debug: $(MINGLELIB)

check: $(MINGLELIB)
	cd test ; make check
	
.c.o:
	gcc $(INCLUDES) $(CFLAGS) $(OPTIMISATIONS) -c $< -o $@

$(MINGLELIB): $(OBJ)
	ar rcs $(MINGLELIB) $(OBJ)

clean:
	rm -f $(OBJ) $(MINGLELIB)
	cd test ; make clean
	
install:
	if [ -a /mingw/include/mingle ]; then rm -rf /mingw/mingle; fi;
	mkdir -p /mingw/include/mingle
	cp -rf include/* /mingw/include/mingle
	cp $(MINGLELIB) /mingw/lib
MINGLELIB=libmingle
MINGLEDLLLIB=$(MINGLELIB).dll.a
MINGLEDLL=$(MINGLELIB).dll

SRC = error.c uname.c msvc-inval.c msvc-nothrow.c fcntl.c writev.c stat.c \
	  stat-time.c fstat.c lstat.c nanosleep.c readlink.c pipe.c \
	  poll.c binary-io.c symlink.c socket.c sig-handler.c sigprocmask.c \
	  inet_ntop.c setsockopt.c listen.c waitpid.c unlink.c unlinkat.c open.c \
	  select.c sockets.c inet_pton.c openat.c openat-die.c openat-proc.c \
	  save-cwd.c exitfail.c filenamecat-lgpl.c chdir-long.c close.c \
	  cloexec.c dirname-lgpl.c fd-hook.c malloc.c malloca.c alloca.c calloc.c \
	  connect.c bind.c accept.c write.c read.c ioctl.c getdtablesize.c getrusage.c \
	  dup.c dup2.c fchdir.c getcwd.c getcwd-lgpl.c realloc.c basename-lgpl.c \
	  dirfd.c lseek.c getpeername.c fsync.c getsockopt.c sigaction.c times.c \
	  time_r.c raise.c timespec.c gettime.c gettimeofday.c random.c \
	  random_r.c regex.c isatty.c ftruncate.c lock.c threadlib.c tls.c \
	  mktime.c gethostname.c getsockname.c shutdown.c send.c sendto.c recv.c \
	  recvfrom.c pathconversion.c c-ctype.c c-string-manip.c nl_langinfo.c \
	  fdopen.c fflush.c fprintf.c fpurge.c freading.c fseterr.c stdio-read.c \
	  stdio-write.c perror.c printf.c sprintf.c snprintf.c fopen.c fclose.c memrchr.c \
	  fd-safer.c vasnprintf.c printf-args.c printf-frexp.c printf-frexpl.c \
	  printf-parse.c isnan.c isnanf.c isnanl.c dup-safer.c strerror-override.c \
	  strerror.c strerror_r.c xsize.c fseek.c fseeko.c remove.c canonicalize-lgpl.c

OBJ = $(SRC:.c=.o)

#INCLUDES = -isysteminclude -I/mingw/x86_64-w64-mingw32/include
INCLUDES = -Iinclude
OPTIMISATIONS = -g
CFLAGS = -Wall -D__MINGW32__ -D_WIN64 -DMS_WIN64 -D__USE_MINGW_ANSI_STDIO 
LDFLAGS = -Wl,--enable-auto-image-base -Wl,-lws2_32
DEPDIR = .deps

default: $(DEPDIR)/ $(MINGLEDLL)

debug: OPTIMISATIONS = -g
debug: $(MINGLEDLL)

check: $(MINGLEDLL)
	cd test ; make check
    
.c.o:
	libtool --tag=CC --mode=compile x86_64-w64-mingw32-gcc $(INCLUDES) $(CFLAGS) $(OPTIMISATIONS) -MT $(@:.o=.lo) -MD -MP -MF .deps/$*.Tpo -c $< -o $@
	
$(MINGLEDLL): $(OBJ)
	libtool -v --tag=CC --mode=link x86_64-w64-mingw32-gcc -no-undefined -version-info 1:1:1 -o libmingle.la -rpath /mingw/lib $(OBJ:.o=.lo) $(LDFLAGS)

$(DEPDIR)/:
	mkdir $@
	
clean:
	rm -f $(OBJ) $(OBJ:.o=.lo) $(MINGLELIB)
	cd .deps ; rm -f $(OBJ:.o=.Tpo)
	cd .libs ; rm -f $(OBJ) $(MINGLELIB).* *.dll
	cd test ; make clean
	
install:
	if [ -a /mingw/include/mingle ]; then rm -rf /mingw/mingle; fi;
	mkdir -p /mingw/include/mingle
	cp -rf include/* /mingw/include/mingle
	cp .libs/$(MINGLELIB).la /mingw/lib
	cp .libs/$(MINGLELIB).a /mingw/lib
	cp .libs/$(MINGLELIB).dll.a /mingw/lib
	cp .libs/$(MINGLELIB)*.dll /mingw/bin
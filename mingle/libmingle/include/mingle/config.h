#ifndef _MINGLE_CONFIG
#define _MINGLE_CONFIG

#include<string.h>

#define hstrerror strerror

#undef S_ISSOCK
#define S_ISSOCK(m) (m?FALSE:FALSE)

#ifndef __MINGLE__
#define __MINGLE__ 1
#endif

/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.ac by autoheader.  */

/* Define if building universal (internal helper macro) */
/* #undef AC_APPLE_UNIVERSAL_BUILD */

/* Define to the number of bits in type 'ptrdiff_t'. */
/* #undef BITSIZEOF_PTRDIFF_T */

/* Define to the number of bits in type 'sig_atomic_t'. */
/* #undef BITSIZEOF_SIG_ATOMIC_T */

/* Define to the number of bits in type 'size_t'. */
/* #undef BITSIZEOF_SIZE_T */

/* Define to the number of bits in type 'wchar_t'. */
/* #undef BITSIZEOF_WCHAR_T */

/* Define to the number of bits in type 'wint_t'. */
/* #undef BITSIZEOF_WINT_T */

/* Define if you wish *printf() functions that have a safe handling of
   non-IEEE-754 'long double' values. */
#define CHECK_PRINTF_SAFE 1

/* Define to 1 for strict checking in test-snprintf.c. */
#define CHECK_SNPRINTF_POSIX 1

/* Define to 1 for strict checking in test-vsnprintf.c. */
#define CHECK_VSNPRINTF_POSIX 1

/* Define to 1 if chown fails to change ctime when at least one argument was
   not -1. */
/* #undef CHOWN_CHANGE_TIME_BUG */

/* Define if chown is not POSIX compliant regarding IDs of -1. */
/* #undef CHOWN_FAILS_TO_HONOR_ID_OF_NEGATIVE_ONE */

/* Define if chown modifies symlinks. */
#define CHOWN_MODIFIES_SYMLINK 1

/* Define to 1 if chown mishandles trailing slash. */
/* #undef CHOWN_TRAILING_SLASH_BUG */

/* Define to one of `_getb67', `GETB67', `getb67' for Cray-2 and Cray-YMP
   systems. This function is required for `alloca.c' support on those systems.
   */
/* #undef CRAY_STACKSEG_END */

/* Define to 1 if using `alloca.c'. */
/* #undef C_ALLOCA */

/* Define as the bit index in the word where to find bit 0 of the exponent of
   'double'. */
#define DBL_EXPBIT0_BIT 20

/* Define as the word index where to find the exponent of 'double'. */
#define DBL_EXPBIT0_WORD 1

/* Define as the bit index in the word where to find the sign of 'double'. */
/* #undef DBL_SIGNBIT_BIT */

/* Define as the word index where to find the sign of 'double'. */
/* #undef DBL_SIGNBIT_WORD */

/* the name of the file descriptor member of DIR */
/* #undef DIR_FD_MEMBER_NAME */

#ifdef DIR_FD_MEMBER_NAME
# define DIR_TO_FD(Dir_p) ((Dir_p)->DIR_FD_MEMBER_NAME)
#else
# define DIR_TO_FD(Dir_p) -1
#endif


/* Define to 1 if // is a file system root distinct from /. */
#define DOUBLE_SLASH_IS_DISTINCT_ROOT 1

/* Define if struct dirent has a member d_ino that actually works. */
/* #undef D_INO_IN_DIRENT */

/* Define to 1 if translation of program messages to the user's native
   language is requested. */
/* #undef ENABLE_NLS */

/* Define to 1 if your platform has fchownat, but it does not reject an empty
   file name. */
/* #undef FCHOWNAT_EMPTY_FILENAME_BUG */

/* Define to 1 if your platform has fchownat, but it cannot perform lchown
   tasks. */
/* #undef FCHOWNAT_NOFOLLOW_BUG */

/* Define this to 1 if F_DUPFD behavior does not match POSIX */
/* #undef FCNTL_DUPFD_BUGGY */

/* Define as the bit index in the word where to find bit 0 of the exponent of
   'float'. */
#define FLT_EXPBIT0_BIT 23

/* Define as the word index where to find the exponent of 'float'. */
#define FLT_EXPBIT0_WORD 0

/* Define as the bit index in the word where to find the sign of 'float'. */
/* #undef FLT_SIGNBIT_BIT */

/* Define as the word index where to find the sign of 'float'. */
/* #undef FLT_SIGNBIT_WORD */

/* Define to 1 if fopen() fails to recognize a trailing slash. */
#define FOPEN_TRAILING_SLASH_BUG 1

/* Define to 1 if the system's ftello function has the Solaris bug. */
/* #undef FTELLO_BROKEN_AFTER_SWITCHING_FROM_READ_TO_WRITE */

/* Define to 1 if fflush is known to work on stdin as per POSIX.1-2008, 0 if
   fflush is known to not work, -1 if unknown. */
#define FUNC_FFLUSH_STDIN 0

/* Define to 1 if mkdir mistakenly creates a directory given with a trailing
   dot component. */
#define FUNC_MKDIR_DOT_BUG 1

/* Define to 1 if nl_langinfo (YESEXPR) returns a non-empty string. */
/* #undef FUNC_NL_LANGINFO_YESEXPR_WORKS */

/* Define to 1 if realpath() can malloc memory, always gives an absolute path,
   and handles trailing slash correctly. */
/* #undef FUNC_REALPATH_WORKS */

/* Define to 1 if ungetc is broken when used on arbitrary bytes. */
/* #undef FUNC_UNGETC_BROKEN */

/* Define to 1 if futimesat mishandles a NULL file name. */
/* #undef FUTIMESAT_NULL_BUG */

/* Define to the type of elements in the array set by `getgroups'. Usually
   this is either `int' or `gid_t'. */
#define GETGROUPS_T int

/* Define this to 1 if getgroups(0,NULL) does not return the number of groups.
   */
/* #undef GETGROUPS_ZERO_BUG */

/* Define if gettimeofday clobbers the localtime buffer. */
/* #undef GETTIMEOFDAY_CLOBBERS_LOCALTIME */

/* Define this to 'void' or 'struct timezone' to match the system's
   declaration of the second argument to gettimeofday. */
#define GETTIMEOFDAY_TIMEZONE void

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module areadlinkat shall be considered present. */
#define GNULIB_AREADLINKAT 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module canonicalize-lgpl shall be considered present. */
#define GNULIB_CANONICALIZE_LGPL 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module faccessat shall be considered present. */
#define GNULIB_FACCESSAT 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module fchmodat shall be considered present. */
#define GNULIB_FCHMODAT 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module fchownat shall be considered present. */
#define GNULIB_FCHOWNAT 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module fdopendir shall be considered present. */
#define GNULIB_FDOPENDIR 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module fd-safer-flag shall be considered present. */
#define GNULIB_FD_SAFER_FLAG IN_GNULIB_TESTS

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module fflush shall be considered present. */
#define GNULIB_FFLUSH 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module filenamecat shall be considered present. */
#define GNULIB_FILENAMECAT IN_GNULIB_TESTS

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module fscanf shall be considered present. */
#define GNULIB_FSCANF 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module getcwd shall be considered present. */
#define GNULIB_GETCWD 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module lock shall be considered present. */
#define GNULIB_LOCK 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module malloc-gnu shall be considered present. */
#define GNULIB_MALLOC_GNU 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module nonblocking shall be considered present. */
#define GNULIB_NONBLOCKING 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module openat shall be considered present. */
#define GNULIB_OPENAT 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module realloc-gnu shall be considered present. */
#define GNULIB_REALLOC_GNU IN_GNULIB_TESTS

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module scanf shall be considered present. */
#define GNULIB_SCANF 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module sigpipe shall be considered present. */
#define GNULIB_SIGPIPE 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module snprintf shall be considered present. */
#define GNULIB_SNPRINTF 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module statat shall be considered present. */
#define GNULIB_STATAT 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module strerror shall be considered present. */
#define GNULIB_STRERROR 1

/* Define to 1 when the gnulib module accept should be tested. */
#define GNULIB_TEST_ACCEPT 1

/* Define to 1 when the gnulib module acosf should be tested. */
#define GNULIB_TEST_ACOSF 1

/* Define to 1 when the gnulib module acosl should be tested. */
#define GNULIB_TEST_ACOSL 1

/* Define to 1 when the gnulib module alphasort should be tested. */
#define GNULIB_TEST_ALPHASORT 1

/* Define to 1 when the gnulib module asinf should be tested. */
#define GNULIB_TEST_ASINF 1

/* Define to 1 when the gnulib module asinl should be tested. */
#define GNULIB_TEST_ASINL 1

/* Define to 1 when the gnulib module atan2f should be tested. */
#define GNULIB_TEST_ATAN2F 1

/* Define to 1 when the gnulib module atanf should be tested. */
#define GNULIB_TEST_ATANF 1

/* Define to 1 when the gnulib module atanl should be tested. */
#define GNULIB_TEST_ATANL 1

/* Define to 1 when the gnulib module atoll should be tested. */
#define GNULIB_TEST_ATOLL 1

/* Define to 1 when the gnulib module bind should be tested. */
#define GNULIB_TEST_BIND 1

/* Define to 1 when the gnulib module btowc should be tested. */
#define GNULIB_TEST_BTOWC 1

/* Define to 1 when the gnulib module calloc-posix should be tested. */
#define GNULIB_TEST_CALLOC_POSIX 1

/* Define to 1 when the gnulib module canonicalize_file_name should be tested.
   */
#define GNULIB_TEST_CANONICALIZE_FILE_NAME 1

/* Define to 1 when the gnulib module cbrt should be tested. */
#define GNULIB_TEST_CBRT 1

/* Define to 1 when the gnulib module cbrtf should be tested. */
#define GNULIB_TEST_CBRTF 1

/* Define to 1 when the gnulib module cbrtl should be tested. */
#define GNULIB_TEST_CBRTL 1

/* Define to 1 when the gnulib module ceil should be tested. */
#define GNULIB_TEST_CEIL 1

/* Define to 1 when the gnulib module ceilf should be tested. */
#define GNULIB_TEST_CEILF 1

/* Define to 1 when the gnulib module ceill should be tested. */
#define GNULIB_TEST_CEILL 1

/* Define to 1 when the gnulib module chdir should be tested. */
#define GNULIB_TEST_CHDIR 1

/* Define to 1 when the gnulib module chown should be tested. */
#define GNULIB_TEST_CHOWN 1

/* Define to 1 when the gnulib module cloexec should be tested. */
#define GNULIB_TEST_CLOEXEC 1

/* Define to 1 when the gnulib module close should be tested. */
#define GNULIB_TEST_CLOSE 1

/* Define to 1 when the gnulib module closedir should be tested. */
#define GNULIB_TEST_CLOSEDIR 1

/* Define to 1 when the gnulib module connect should be tested. */
#define GNULIB_TEST_CONNECT 1

/* Define to 1 when the gnulib module copysign should be tested. */
#define GNULIB_TEST_COPYSIGN 1

/* Define to 1 when the gnulib module copysignf should be tested. */
#define GNULIB_TEST_COPYSIGNF 1

/* Define to 1 when the gnulib module copysignl should be tested. */
#define GNULIB_TEST_COPYSIGNL 1

/* Define to 1 when the gnulib module cosf should be tested. */
#define GNULIB_TEST_COSF 1

/* Define to 1 when the gnulib module coshf should be tested. */
#define GNULIB_TEST_COSHF 1

/* Define to 1 when the gnulib module cosl should be tested. */
#define GNULIB_TEST_COSL 1

/* Define to 1 when the gnulib module dirfd should be tested. */
#define GNULIB_TEST_DIRFD 1

/* Define to 1 when the gnulib module dprintf should be tested. */
#define GNULIB_TEST_DPRINTF 1

/* Define to 1 when the gnulib module dup should be tested. */
#define GNULIB_TEST_DUP 1

/* Define to 1 when the gnulib module dup2 should be tested. */
#define GNULIB_TEST_DUP2 1

/* Define to 1 when the gnulib module duplocale should be tested. */
#define GNULIB_TEST_DUPLOCALE 1

/* Define to 1 when the gnulib module environ should be tested. */
#define GNULIB_TEST_ENVIRON 1

/* Define to 1 when the gnulib module euidaccess should be tested. */
#define GNULIB_TEST_EUIDACCESS 1

/* Define to 1 when the gnulib module exp2 should be tested. */
#define GNULIB_TEST_EXP2 1

/* Define to 1 when the gnulib module exp2f should be tested. */
#define GNULIB_TEST_EXP2F 1

/* Define to 1 when the gnulib module exp2l should be tested. */
#define GNULIB_TEST_EXP2L 1

/* Define to 1 when the gnulib module expf should be tested. */
#define GNULIB_TEST_EXPF 1

/* Define to 1 when the gnulib module expl should be tested. */
#define GNULIB_TEST_EXPL 1

/* Define to 1 when the gnulib module expm1 should be tested. */
#define GNULIB_TEST_EXPM1 1

/* Define to 1 when the gnulib module expm1f should be tested. */
#define GNULIB_TEST_EXPM1F 1

/* Define to 1 when the gnulib module expm1l should be tested. */
#define GNULIB_TEST_EXPM1L 1

/* Define to 1 when the gnulib module fabsf should be tested. */
#define GNULIB_TEST_FABSF 1

/* Define to 1 when the gnulib module fabsl should be tested. */
#define GNULIB_TEST_FABSL 1

/* Define to 1 when the gnulib module faccessat should be tested. */
#define GNULIB_TEST_FACCESSAT 1

/* Define to 1 when the gnulib module fchdir should be tested. */
#define GNULIB_TEST_FCHDIR 1

/* Define to 1 when the gnulib module fchmodat should be tested. */
#define GNULIB_TEST_FCHMODAT 1

/* Define to 1 when the gnulib module fchownat should be tested. */
#define GNULIB_TEST_FCHOWNAT 1

/* Define to 1 when the gnulib module fclose should be tested. */
#define GNULIB_TEST_FCLOSE 1

/* Define to 1 when the gnulib module fcntl should be tested. */
#define GNULIB_TEST_FCNTL 1

/* Define to 1 when the gnulib module fdatasync should be tested. */
#define GNULIB_TEST_FDATASYNC 1

/* Define to 1 when the gnulib module fdopen should be tested. */
#define GNULIB_TEST_FDOPEN 1

/* Define to 1 when the gnulib module fdopendir should be tested. */
#define GNULIB_TEST_FDOPENDIR 1

/* Define to 1 when the gnulib module fflush should be tested. */
#define GNULIB_TEST_FFLUSH 1

/* Define to 1 when the gnulib module floor should be tested. */
#define GNULIB_TEST_FLOOR 1

/* Define to 1 when the gnulib module floorf should be tested. */
#define GNULIB_TEST_FLOORF 1

/* Define to 1 when the gnulib module floorl should be tested. */
#define GNULIB_TEST_FLOORL 1

/* Define to 1 when the gnulib module fma should be tested. */
#define GNULIB_TEST_FMA 1

/* Define to 1 when the gnulib module fmaf should be tested. */
#define GNULIB_TEST_FMAF 1

/* Define to 1 when the gnulib module fmal should be tested. */
#define GNULIB_TEST_FMAL 1

/* Define to 1 when the gnulib module fmod should be tested. */
#define GNULIB_TEST_FMOD 1

/* Define to 1 when the gnulib module fmodf should be tested. */
#define GNULIB_TEST_FMODF 1

/* Define to 1 when the gnulib module fmodl should be tested. */
#define GNULIB_TEST_FMODL 1

/* Define to 1 when the gnulib module fopen should be tested. */
#define GNULIB_TEST_FOPEN 1

/* Define to 1 when the gnulib module fprintf-posix should be tested. */
#define GNULIB_TEST_FPRINTF_POSIX 1

/* Define to 1 when the gnulib module fpurge should be tested. */
#define GNULIB_TEST_FPURGE 1

/* Define to 1 when the gnulib module freopen should be tested. */
#define GNULIB_TEST_FREOPEN 1

/* Define to 1 when the gnulib module frexp should be tested. */
#define GNULIB_TEST_FREXP 1

/* Define to 1 when the gnulib module frexpf should be tested. */
#define GNULIB_TEST_FREXPF 1

/* Define to 1 when the gnulib module frexpl should be tested. */
#define GNULIB_TEST_FREXPL 1

/* Define to 1 when the gnulib module fseek should be tested. */
#define GNULIB_TEST_FSEEK 1

/* Define to 1 when the gnulib module fseeko should be tested. */
#define GNULIB_TEST_FSEEKO 1

/* Define to 1 when the gnulib module fstat should be tested. */
#define GNULIB_TEST_FSTAT 1

/* Define to 1 when the gnulib module fstatat should be tested. */
#define GNULIB_TEST_FSTATAT 1

/* Define to 1 when the gnulib module fsync should be tested. */
#define GNULIB_TEST_FSYNC 1

/* Define to 1 when the gnulib module ftell should be tested. */
#define GNULIB_TEST_FTELL 1

/* Define to 1 when the gnulib module ftello should be tested. */
#define GNULIB_TEST_FTELLO 1

/* Define to 1 when the gnulib module ftruncate should be tested. */
#define GNULIB_TEST_FTRUNCATE 1

/* Define to 1 when the gnulib module futimens should be tested. */
#define GNULIB_TEST_FUTIMENS 1

/* Define to 1 when the gnulib module getaddrinfo should be tested. */
#define GNULIB_TEST_GETADDRINFO 1

/* Define to 1 when the gnulib module getcwd should be tested. */
#define GNULIB_TEST_GETCWD 1

/* Define to 1 when the gnulib module getdelim should be tested. */
#define GNULIB_TEST_GETDELIM 1

/* Define to 1 when the gnulib module getdtablesize should be tested. */
#define GNULIB_TEST_GETDTABLESIZE 1

/* Define to 1 when the gnulib module getgroups should be tested. */
#define GNULIB_TEST_GETGROUPS 1

/* Define to 1 when the gnulib module gethostname should be tested. */
#define GNULIB_TEST_GETHOSTNAME 1

/* Define to 1 when the gnulib module getline should be tested. */
#define GNULIB_TEST_GETLINE 1

/* Define to 1 when the gnulib module getlogin should be tested. */
#define GNULIB_TEST_GETLOGIN 1

/* Define to 1 when the gnulib module getlogin_r should be tested. */
#define GNULIB_TEST_GETLOGIN_R 1

/* Define to 1 when the gnulib module getpagesize should be tested. */
#define GNULIB_TEST_GETPAGESIZE 1

/* Define to 1 when the gnulib module getpeername should be tested. */
#define GNULIB_TEST_GETPEERNAME 1

/* Define to 1 when the gnulib module getrusage should be tested. */
#define GNULIB_TEST_GETRUSAGE 1

/* Define to 1 when the gnulib module getsockname should be tested. */
#define GNULIB_TEST_GETSOCKNAME 1

/* Define to 1 when the gnulib module getsockopt should be tested. */
#define GNULIB_TEST_GETSOCKOPT 1

/* Define to 1 when the gnulib module getsubopt should be tested. */
#define GNULIB_TEST_GETSUBOPT 1

/* Define to 1 when the gnulib module gettimeofday should be tested. */
#define GNULIB_TEST_GETTIMEOFDAY 1

/* Define to 1 when the gnulib module grantpt should be tested. */
#define GNULIB_TEST_GRANTPT 1

/* Define to 1 when the gnulib module group-member should be tested. */
#define GNULIB_TEST_GROUP_MEMBER 1

/* Define to 1 when the gnulib module hypot should be tested. */
#define GNULIB_TEST_HYPOT 1

/* Define to 1 when the gnulib module hypotf should be tested. */
#define GNULIB_TEST_HYPOTF 1

/* Define to 1 when the gnulib module hypotl should be tested. */
#define GNULIB_TEST_HYPOTL 1

/* Define to 1 when the gnulib module ilogb should be tested. */
#define GNULIB_TEST_ILOGB 1

/* Define to 1 when the gnulib module ilogbf should be tested. */
#define GNULIB_TEST_ILOGBF 1

/* Define to 1 when the gnulib module ilogbl should be tested. */
#define GNULIB_TEST_ILOGBL 1

/* Define to 1 when the gnulib module ioctl should be tested. */
#define GNULIB_TEST_IOCTL 1

/* Define to 1 when the gnulib module isatty should be tested. */
#define GNULIB_TEST_ISATTY 1

/* Define to 1 when the gnulib module isfinite should be tested. */
#define GNULIB_TEST_ISFINITE 1

/* Define to 1 when the gnulib module isinf should be tested. */
#define GNULIB_TEST_ISINF 1

/* Define to 1 when the gnulib module isnan should be tested. */
#define GNULIB_TEST_ISNAN 1

/* Define to 1 when the gnulib module isnand should be tested. */
#define GNULIB_TEST_ISNAND 1

/* Define to 1 when the gnulib module isnanf should be tested. */
#define GNULIB_TEST_ISNANF 1

/* Define to 1 when the gnulib module isnanl should be tested. */
#define GNULIB_TEST_ISNANL 1

/* Define to 1 when the gnulib module iswblank should be tested. */
#define GNULIB_TEST_ISWBLANK 1

/* Define to 1 when the gnulib module iswctype should be tested. */
#define GNULIB_TEST_ISWCTYPE 1

/* Define to 1 when the gnulib module lchown should be tested. */
#define GNULIB_TEST_LCHOWN 1

/* Define to 1 when the gnulib module ldexpf should be tested. */
#define GNULIB_TEST_LDEXPF 1

/* Define to 1 when the gnulib module ldexpl should be tested. */
#define GNULIB_TEST_LDEXPL 1

/* Define to 1 when the gnulib module link should be tested. */
#define GNULIB_TEST_LINK 1

/* Define to 1 when the gnulib module linkat should be tested. */
#define GNULIB_TEST_LINKAT 1

/* Define to 1 when the gnulib module listen should be tested. */
#define GNULIB_TEST_LISTEN 1

/* Define to 1 when the gnulib module localeconv should be tested. */
#define GNULIB_TEST_LOCALECONV 1

/* Define to 1 when the gnulib module log should be tested. */
#define GNULIB_TEST_LOG 1

/* Define to 1 when the gnulib module log10 should be tested. */
#define GNULIB_TEST_LOG10 1

/* Define to 1 when the gnulib module log10f should be tested. */
#define GNULIB_TEST_LOG10F 1

/* Define to 1 when the gnulib module log10l should be tested. */
#define GNULIB_TEST_LOG10L 1

/* Define to 1 when the gnulib module log1p should be tested. */
#define GNULIB_TEST_LOG1P 1

/* Define to 1 when the gnulib module log1pf should be tested. */
#define GNULIB_TEST_LOG1PF 1

/* Define to 1 when the gnulib module log1pl should be tested. */
#define GNULIB_TEST_LOG1PL 1

/* Define to 1 when the gnulib module log2 should be tested. */
#define GNULIB_TEST_LOG2 1

/* Define to 1 when the gnulib module log2f should be tested. */
#define GNULIB_TEST_LOG2F 1

/* Define to 1 when the gnulib module log2l should be tested. */
#define GNULIB_TEST_LOG2L 1

/* Define to 1 when the gnulib module logb should be tested. */
#define GNULIB_TEST_LOGB 1

/* Define to 1 when the gnulib module logbf should be tested. */
#define GNULIB_TEST_LOGBF 1

/* Define to 1 when the gnulib module logbl should be tested. */
#define GNULIB_TEST_LOGBL 1

/* Define to 1 when the gnulib module logf should be tested. */
#define GNULIB_TEST_LOGF 1

/* Define to 1 when the gnulib module logl should be tested. */
#define GNULIB_TEST_LOGL 1

/* Define to 1 when the gnulib module lseek should be tested. */
#define GNULIB_TEST_LSEEK 1

/* Define to 1 when the gnulib module lstat should be tested. */
#define GNULIB_TEST_LSTAT 1

/* Define to 1 when the gnulib module malloc-posix should be tested. */
#define GNULIB_TEST_MALLOC_POSIX 1

/* Define to 1 when the gnulib module mbrlen should be tested. */
#define GNULIB_TEST_MBRLEN 1

/* Define to 1 when the gnulib module mbrtowc should be tested. */
#define GNULIB_TEST_MBRTOWC 1

/* Define to 1 when the gnulib module mbsinit should be tested. */
#define GNULIB_TEST_MBSINIT 1

/* Define to 1 when the gnulib module mbsnrtowcs should be tested. */
#define GNULIB_TEST_MBSNRTOWCS 1

/* Define to 1 when the gnulib module mbsrtowcs should be tested. */
#define GNULIB_TEST_MBSRTOWCS 1

/* Define to 1 when the gnulib module mbtowc should be tested. */
#define GNULIB_TEST_MBTOWC 1

/* Define to 1 when the gnulib module memchr should be tested. */
#define GNULIB_TEST_MEMCHR 1

/* Define to 1 when the gnulib module mempcpy should be tested. */
#define GNULIB_TEST_MEMPCPY 1

/* Define to 1 when the gnulib module memrchr should be tested. */
#define GNULIB_TEST_MEMRCHR 1

/* Define to 1 when the gnulib module mkdirat should be tested. */
#define GNULIB_TEST_MKDIRAT 1

/* Define to 1 when the gnulib module mkdtemp should be tested. */
#define GNULIB_TEST_MKDTEMP 1

/* Define to 1 when the gnulib module mkfifo should be tested. */
#define GNULIB_TEST_MKFIFO 1

/* Define to 1 when the gnulib module mkfifoat should be tested. */
#define GNULIB_TEST_MKFIFOAT 1

/* Define to 1 when the gnulib module mknod should be tested. */
#define GNULIB_TEST_MKNOD 1

/* Define to 1 when the gnulib module mknodat should be tested. */
#define GNULIB_TEST_MKNODAT 1

/* Define to 1 when the gnulib module mkstemp should be tested. */
#define GNULIB_TEST_MKSTEMP 1

/* Define to 1 when the gnulib module mktime should be tested. */
#define GNULIB_TEST_MKTIME 1

/* Define to 1 when the gnulib module modf should be tested. */
#define GNULIB_TEST_MODF 1

/* Define to 1 when the gnulib module modff should be tested. */
#define GNULIB_TEST_MODFF 1

/* Define to 1 when the gnulib module modfl should be tested. */
#define GNULIB_TEST_MODFL 1

/* Define to 1 when the gnulib module nanosleep should be tested. */
#define GNULIB_TEST_NANOSLEEP 1

/* Define to 1 when the gnulib module nl_langinfo should be tested. */
#define GNULIB_TEST_NL_LANGINFO 1

/* Define to 1 when the gnulib module nonblocking should be tested. */
#define GNULIB_TEST_NONBLOCKING 1

/* Define to 1 when the gnulib module open should be tested. */
#define GNULIB_TEST_OPEN 1

/* Define to 1 when the gnulib module openat should be tested. */
#define GNULIB_TEST_OPENAT 1

/* Define to 1 when the gnulib module opendir should be tested. */
#define GNULIB_TEST_OPENDIR 1

/* Define to 1 when the gnulib module pclose should be tested. */
#define GNULIB_TEST_PCLOSE 1

/* Define to 1 when the gnulib module perror should be tested. */
#define GNULIB_TEST_PERROR 1

/* Define to 1 when the gnulib module pipe should be tested. */
#define GNULIB_TEST_PIPE 1

/* Define to 1 when the gnulib module poll should be tested. */
#define GNULIB_TEST_POLL 1

/* Define to 1 when the gnulib module popen should be tested. */
#define GNULIB_TEST_POPEN 1

/* Define to 1 when the gnulib module posix_openpt should be tested. */
#define GNULIB_TEST_POSIX_OPENPT 1

/* Define to 1 when the gnulib module posix_spawn should be tested. */
#define GNULIB_TEST_POSIX_SPAWN 1

/* Define to 1 when the gnulib module posix_spawnattr_destroy should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_DESTROY 1

/* Define to 1 when the gnulib module posix_spawnattr_getflags should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_GETFLAGS 1

/* Define to 1 when the gnulib module posix_spawnattr_getpgroup should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_GETPGROUP 1

/* Define to 1 when the gnulib module posix_spawnattr_getschedparam should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_GETSCHEDPARAM 1

/* Define to 1 when the gnulib module posix_spawnattr_getschedpolicy should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_GETSCHEDPOLICY 1

/* Define to 1 when the gnulib module posix_spawnattr_getsigdefault should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_GETSIGDEFAULT 1

/* Define to 1 when the gnulib module posix_spawnattr_getsigmask should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_GETSIGMASK 1

/* Define to 1 when the gnulib module posix_spawnattr_init should be tested.
   */
#define GNULIB_TEST_POSIX_SPAWNATTR_INIT 1

/* Define to 1 when the gnulib module posix_spawnattr_setflags should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_SETFLAGS 1

/* Define to 1 when the gnulib module posix_spawnattr_setpgroup should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_SETPGROUP 1

/* Define to 1 when the gnulib module posix_spawnattr_setschedparam should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_SETSCHEDPARAM 1

/* Define to 1 when the gnulib module posix_spawnattr_setschedpolicy should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_SETSCHEDPOLICY 1

/* Define to 1 when the gnulib module posix_spawnattr_setsigdefault should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_SETSIGDEFAULT 1

/* Define to 1 when the gnulib module posix_spawnattr_setsigmask should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWNATTR_SETSIGMASK 1

/* Define to 1 when the gnulib module posix_spawnp should be tested. */
#define GNULIB_TEST_POSIX_SPAWNP 1

/* Define to 1 when the gnulib module posix_spawn_file_actions_addclose should
   be tested. */
#define GNULIB_TEST_POSIX_SPAWN_FILE_ACTIONS_ADDCLOSE 1

/* Define to 1 when the gnulib module posix_spawn_file_actions_adddup2 should
   be tested. */
#define GNULIB_TEST_POSIX_SPAWN_FILE_ACTIONS_ADDDUP2 1

/* Define to 1 when the gnulib module posix_spawn_file_actions_addopen should
   be tested. */
#define GNULIB_TEST_POSIX_SPAWN_FILE_ACTIONS_ADDOPEN 1

/* Define to 1 when the gnulib module posix_spawn_file_actions_destroy should
   be tested. */
#define GNULIB_TEST_POSIX_SPAWN_FILE_ACTIONS_DESTROY 1

/* Define to 1 when the gnulib module posix_spawn_file_actions_init should be
   tested. */
#define GNULIB_TEST_POSIX_SPAWN_FILE_ACTIONS_INIT 1

/* Define to 1 when the gnulib module powf should be tested. */
#define GNULIB_TEST_POWF 1

/* Define to 1 when the gnulib module pread should be tested. */
#define GNULIB_TEST_PREAD 1

/* Define to 1 when the gnulib module printf-posix should be tested. */
#define GNULIB_TEST_PRINTF_POSIX 1

/* Define to 1 when the gnulib module pthread_sigmask should be tested. */
#define GNULIB_TEST_PTHREAD_SIGMASK 1

/* Define to 1 when the gnulib module ptsname should be tested. */
#define GNULIB_TEST_PTSNAME 1

/* Define to 1 when the gnulib module ptsname_r should be tested. */
#define GNULIB_TEST_PTSNAME_R 1

/* Define to 1 when the gnulib module putenv should be tested. */
#define GNULIB_TEST_PUTENV 1

/* Define to 1 when the gnulib module pwrite should be tested. */
#define GNULIB_TEST_PWRITE 1

/* Define to 1 when the gnulib module raise should be tested. */
#define GNULIB_TEST_RAISE 1

/* Define to 1 when the gnulib module random should be tested. */
#define GNULIB_TEST_RANDOM 1

/* Define to 1 when the gnulib module random_r should be tested. */
#define GNULIB_TEST_RANDOM_R 1

/* Define to 1 when the gnulib module rawmemchr should be tested. */
#define GNULIB_TEST_RAWMEMCHR 1

/* Define to 1 when the gnulib module read should be tested. */
#define GNULIB_TEST_READ 1

/* Define to 1 when the gnulib module readdir should be tested. */
#define GNULIB_TEST_READDIR 1

/* Define to 1 when the gnulib module readlink should be tested. */
#define GNULIB_TEST_READLINK 1

/* Define to 1 when the gnulib module readlinkat should be tested. */
#define GNULIB_TEST_READLINKAT 1

/* Define to 1 when the gnulib module realloc-posix should be tested. */
#define GNULIB_TEST_REALLOC_POSIX 1

/* Define to 1 when the gnulib module realpath should be tested. */
#define GNULIB_TEST_REALPATH 1

/* Define to 1 when the gnulib module recv should be tested. */
#define GNULIB_TEST_RECV 1

/* Define to 1 when the gnulib module recvfrom should be tested. */
#define GNULIB_TEST_RECVFROM 1

/* Define to 1 when the gnulib module remainder should be tested. */
#define GNULIB_TEST_REMAINDER 1

/* Define to 1 when the gnulib module remainderf should be tested. */
#define GNULIB_TEST_REMAINDERF 1

/* Define to 1 when the gnulib module remainderl should be tested. */
#define GNULIB_TEST_REMAINDERL 1

/* Define to 1 when the gnulib module remove should be tested. */
#define GNULIB_TEST_REMOVE 1

/* Define to 1 when the gnulib module rename should be tested. */
#define GNULIB_TEST_RENAME 1

/* Define to 1 when the gnulib module renameat should be tested. */
#define GNULIB_TEST_RENAMEAT 1

/* Define to 1 when the gnulib module rewinddir should be tested. */
#define GNULIB_TEST_REWINDDIR 1

/* Define to 1 when the gnulib module rint should be tested. */
#define GNULIB_TEST_RINT 1

/* Define to 1 when the gnulib module rintf should be tested. */
#define GNULIB_TEST_RINTF 1

/* Define to 1 when the gnulib module rintl should be tested. */
#define GNULIB_TEST_RINTL 1

/* Define to 1 when the gnulib module rmdir should be tested. */
#define GNULIB_TEST_RMDIR 1

/* Define to 1 when the gnulib module round should be tested. */
#define GNULIB_TEST_ROUND 1

/* Define to 1 when the gnulib module roundf should be tested. */
#define GNULIB_TEST_ROUNDF 1

/* Define to 1 when the gnulib module roundl should be tested. */
#define GNULIB_TEST_ROUNDL 1

/* Define to 1 when the gnulib module scandir should be tested. */
#define GNULIB_TEST_SCANDIR 1

/* Define to 1 when the gnulib module secure_getenv should be tested. */
#define GNULIB_TEST_SECURE_GETENV 1

/* Define to 1 when the gnulib module select should be tested. */
#define GNULIB_TEST_SELECT 1

/* Define to 1 when the gnulib module send should be tested. */
#define GNULIB_TEST_SEND 1

/* Define to 1 when the gnulib module sendto should be tested. */
#define GNULIB_TEST_SENDTO 1

/* Define to 1 when the gnulib module setenv should be tested. */
#define GNULIB_TEST_SETENV 1

/* Define to 1 when the gnulib module setlocale should be tested. */
#define GNULIB_TEST_SETLOCALE 1

/* Define to 1 when the gnulib module setsockopt should be tested. */
#define GNULIB_TEST_SETSOCKOPT 1

/* Define to 1 when the gnulib module shutdown should be tested. */
#define GNULIB_TEST_SHUTDOWN 1

/* Define to 1 when the gnulib module sigaction should be tested. */
#define GNULIB_TEST_SIGACTION 1

/* Define to 1 when the gnulib module signbit should be tested. */
#define GNULIB_TEST_SIGNBIT 1

/* Define to 1 when the gnulib module sigprocmask should be tested. */
#define GNULIB_TEST_SIGPROCMASK 1

/* Define to 1 when the gnulib module sinf should be tested. */
#define GNULIB_TEST_SINF 1

/* Define to 1 when the gnulib module sinhf should be tested. */
#define GNULIB_TEST_SINHF 1

/* Define to 1 when the gnulib module sinl should be tested. */
#define GNULIB_TEST_SINL 1

/* Define to 1 when the gnulib module sleep should be tested. */
#define GNULIB_TEST_SLEEP 1

/* Define to 1 when the gnulib module snprintf should be tested. */
#define GNULIB_TEST_SNPRINTF 1

/* Define to 1 when the gnulib module socket should be tested. */
#define GNULIB_TEST_SOCKET 1

/* Define to 1 when the gnulib module sprintf-posix should be tested. */
#define GNULIB_TEST_SPRINTF_POSIX 1

/* Define to 1 when the gnulib module sqrtf should be tested. */
#define GNULIB_TEST_SQRTF 1

/* Define to 1 when the gnulib module sqrtl should be tested. */
#define GNULIB_TEST_SQRTL 1

/* Define to 1 when the gnulib module stat should be tested. */
#define GNULIB_TEST_STAT 1

/* Define to 1 when the gnulib module stpcpy should be tested. */
#define GNULIB_TEST_STPCPY 1

/* Define to 1 when the gnulib module stpncpy should be tested. */
#define GNULIB_TEST_STPNCPY 1

/* Define to 1 when the gnulib module strchrnul should be tested. */
#define GNULIB_TEST_STRCHRNUL 1

/* Define to 1 when the gnulib module strdup should be tested. */
#define GNULIB_TEST_STRDUP 1

/* Define to 1 when the gnulib module strerror should be tested. */
#define GNULIB_TEST_STRERROR 1

/* Define to 1 when the gnulib module strerror_r should be tested. */
#define GNULIB_TEST_STRERROR_R 1

/* Define to 1 when the gnulib module strncat should be tested. */
#define GNULIB_TEST_STRNCAT 1

/* Define to 1 when the gnulib module strndup should be tested. */
#define GNULIB_TEST_STRNDUP 1

/* Define to 1 when the gnulib module strnlen should be tested. */
#define GNULIB_TEST_STRNLEN 1

/* Define to 1 when the gnulib module strpbrk should be tested. */
#define GNULIB_TEST_STRPBRK 1

/* Define to 1 when the gnulib module strptime should be tested. */
#define GNULIB_TEST_STRPTIME 1

/* Define to 1 when the gnulib module strsignal should be tested. */
#define GNULIB_TEST_STRSIGNAL 1

/* Define to 1 when the gnulib module strstr should be tested. */
#define GNULIB_TEST_STRSTR 1

/* Define to 1 when the gnulib module strtod should be tested. */
#define GNULIB_TEST_STRTOD 1

/* Define to 1 when the gnulib module strtok_r should be tested. */
#define GNULIB_TEST_STRTOK_R 1

/* Define to 1 when the gnulib module strtoll should be tested. */
#define GNULIB_TEST_STRTOLL 1

/* Define to 1 when the gnulib module strtoull should be tested. */
#define GNULIB_TEST_STRTOULL 1

/* Define to 1 when the gnulib module symlink should be tested. */
#define GNULIB_TEST_SYMLINK 1

/* Define to 1 when the gnulib module symlinkat should be tested. */
#define GNULIB_TEST_SYMLINKAT 1

/* Define to 1 when the gnulib module system-posix should be tested. */
#define GNULIB_TEST_SYSTEM_POSIX 1

/* Define to 1 when the gnulib module tanf should be tested. */
#define GNULIB_TEST_TANF 1

/* Define to 1 when the gnulib module tanhf should be tested. */
#define GNULIB_TEST_TANHF 1

/* Define to 1 when the gnulib module tanl should be tested. */
#define GNULIB_TEST_TANL 1

/* Define to 1 when the gnulib module tcgetsid should be tested. */
#define GNULIB_TEST_TCGETSID 1

/* Define to 1 when the gnulib module time_r should be tested. */
#define GNULIB_TEST_TIME_R 1

/* Define to 1 when the gnulib module tmpfile should be tested. */
#define GNULIB_TEST_TMPFILE 1

/* Define to 1 when the gnulib module towctrans should be tested. */
#define GNULIB_TEST_TOWCTRANS 1

/* Define to 1 when the gnulib module trunc should be tested. */
#define GNULIB_TEST_TRUNC 1

/* Define to 1 when the gnulib module truncf should be tested. */
#define GNULIB_TEST_TRUNCF 1

/* Define to 1 when the gnulib module truncl should be tested. */
#define GNULIB_TEST_TRUNCL 1

/* Define to 1 when the gnulib module tsearch should be tested. */
#define GNULIB_TEST_TSEARCH 1

/* Define to 1 when the gnulib module ttyname_r should be tested. */
#define GNULIB_TEST_TTYNAME_R 1

/* Define to 1 when the gnulib module unlink should be tested. */
#define GNULIB_TEST_UNLINK 1

/* Define to 1 when the gnulib module unlinkat should be tested. */
#define GNULIB_TEST_UNLINKAT 1

/* Define to 1 when the gnulib module unlockpt should be tested. */
#define GNULIB_TEST_UNLOCKPT 1

/* Define to 1 when the gnulib module unsetenv should be tested. */
#define GNULIB_TEST_UNSETENV 1

/* Define to 1 when the gnulib module usleep should be tested. */
#define GNULIB_TEST_USLEEP 1

/* Define to 1 when the gnulib module utimensat should be tested. */
#define GNULIB_TEST_UTIMENSAT 1

/* Define to 1 when the gnulib module vdprintf should be tested. */
#define GNULIB_TEST_VDPRINTF 1

/* Define to 1 when the gnulib module vfprintf-posix should be tested. */
#define GNULIB_TEST_VFPRINTF_POSIX 1

/* Define to 1 when the gnulib module vfscanf should be tested. */
#define GNULIB_TEST_VFSCANF 1

/* Define to 1 when the gnulib module vprintf-posix should be tested. */
#define GNULIB_TEST_VPRINTF_POSIX 1

/* Define to 1 when the gnulib module vscanf should be tested. */
#define GNULIB_TEST_VSCANF 1

/* Define to 1 when the gnulib module vsnprintf should be tested. */
#define GNULIB_TEST_VSNPRINTF 1

/* Define to 1 when the gnulib module vsprintf-posix should be tested. */
#define GNULIB_TEST_VSPRINTF_POSIX 1

/* Define to 1 when the gnulib module waitpid should be tested. */
#define GNULIB_TEST_WAITPID 1

/* Define to 1 when the gnulib module wcpcpy should be tested. */
#define GNULIB_TEST_WCPCPY 1

/* Define to 1 when the gnulib module wcpncpy should be tested. */
#define GNULIB_TEST_WCPNCPY 1

/* Define to 1 when the gnulib module wcrtomb should be tested. */
#define GNULIB_TEST_WCRTOMB 1

/* Define to 1 when the gnulib module wcscasecmp should be tested. */
#define GNULIB_TEST_WCSCASECMP 1

/* Define to 1 when the gnulib module wcscat should be tested. */
#define GNULIB_TEST_WCSCAT 1

/* Define to 1 when the gnulib module wcschr should be tested. */
#define GNULIB_TEST_WCSCHR 1

/* Define to 1 when the gnulib module wcscmp should be tested. */
#define GNULIB_TEST_WCSCMP 1

/* Define to 1 when the gnulib module wcscoll should be tested. */
#define GNULIB_TEST_WCSCOLL 1

/* Define to 1 when the gnulib module wcscpy should be tested. */
#define GNULIB_TEST_WCSCPY 1

/* Define to 1 when the gnulib module wcscspn should be tested. */
#define GNULIB_TEST_WCSCSPN 1

/* Define to 1 when the gnulib module wcsdup should be tested. */
#define GNULIB_TEST_WCSDUP 1

/* Define to 1 when the gnulib module wcslen should be tested. */
#define GNULIB_TEST_WCSLEN 1

/* Define to 1 when the gnulib module wcsncasecmp should be tested. */
#define GNULIB_TEST_WCSNCASECMP 1

/* Define to 1 when the gnulib module wcsncat should be tested. */
#define GNULIB_TEST_WCSNCAT 1

/* Define to 1 when the gnulib module wcsncmp should be tested. */
#define GNULIB_TEST_WCSNCMP 1

/* Define to 1 when the gnulib module wcsncpy should be tested. */
#define GNULIB_TEST_WCSNCPY 1

/* Define to 1 when the gnulib module wcsnlen should be tested. */
#define GNULIB_TEST_WCSNLEN 1

/* Define to 1 when the gnulib module wcsnrtombs should be tested. */
#define GNULIB_TEST_WCSNRTOMBS 1

/* Define to 1 when the gnulib module wcspbrk should be tested. */
#define GNULIB_TEST_WCSPBRK 1

/* Define to 1 when the gnulib module wcsrchr should be tested. */
#define GNULIB_TEST_WCSRCHR 1

/* Define to 1 when the gnulib module wcsrtombs should be tested. */
#define GNULIB_TEST_WCSRTOMBS 1

/* Define to 1 when the gnulib module wcsspn should be tested. */
#define GNULIB_TEST_WCSSPN 1

/* Define to 1 when the gnulib module wcsstr should be tested. */
#define GNULIB_TEST_WCSSTR 1

/* Define to 1 when the gnulib module wcstok should be tested. */
#define GNULIB_TEST_WCSTOK 1

/* Define to 1 when the gnulib module wcswidth should be tested. */
#define GNULIB_TEST_WCSWIDTH 1

/* Define to 1 when the gnulib module wcsxfrm should be tested. */
#define GNULIB_TEST_WCSXFRM 1

/* Define to 1 when the gnulib module wctob should be tested. */
#define GNULIB_TEST_WCTOB 1

/* Define to 1 when the gnulib module wctomb should be tested. */
#define GNULIB_TEST_WCTOMB 1

/* Define to 1 when the gnulib module wctrans should be tested. */
#define GNULIB_TEST_WCTRANS 1

/* Define to 1 when the gnulib module wctype should be tested. */
#define GNULIB_TEST_WCTYPE 1

/* Define to 1 when the gnulib module wcwidth should be tested. */
#define GNULIB_TEST_WCWIDTH 1

/* Define to 1 when the gnulib module wmemchr should be tested. */
#define GNULIB_TEST_WMEMCHR 1

/* Define to 1 when the gnulib module wmemcmp should be tested. */
#define GNULIB_TEST_WMEMCMP 1

/* Define to 1 when the gnulib module wmemcpy should be tested. */
#define GNULIB_TEST_WMEMCPY 1

/* Define to 1 when the gnulib module wmemmove should be tested. */
#define GNULIB_TEST_WMEMMOVE 1

/* Define to 1 when the gnulib module wmemset should be tested. */
#define GNULIB_TEST_WMEMSET 1

/* Define to 1 when the gnulib module write should be tested. */
#define GNULIB_TEST_WRITE 1

/* Define to 1 when the gnulib module _Exit should be tested. */
#define GNULIB_TEST__EXIT 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module unistr/u8-mbtoucr shall be considered present. */
#define GNULIB_UNISTR_U8_MBTOUCR 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module unistr/u8-uctomb shall be considered present. */
#define GNULIB_UNISTR_U8_UCTOMB 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module vfscanf shall be considered present. */
#define GNULIB_VFSCANF 1

/* Define to a C preprocessor expression that evaluates to 1 or 0, depending
   whether the gnulib module vscanf shall be considered present. */
#define GNULIB_VSCANF 1

/* Define to 1 if you have the `access' function. */
#define HAVE_ACCESS 1

/* Define to 1 if you have the `acosf' function. */
#define HAVE_ACOSF 1

/* Define to 1 if you have 'alloca' after including <alloca.h>, a header that
   may be supplied by this distribution. */
#define HAVE_ALLOCA 1

/* Define to 1 if you have <alloca.h> and it should be used (not on Ultrix).
   */
/* #undef HAVE_ALLOCA_H */

/* Define to 1 if you have the `alphasort' function. */
/* #undef HAVE_ALPHASORT */

/* Define to 1 if you have the <arpa/inet.h> header file. */
/* #undef HAVE_ARPA_INET_H */

/* Define to 1 if you have the `asinf' function. */
#define HAVE_ASINF 1

/* Define to 1 if you have the `atan2f' function. */
#define HAVE_ATAN2F 1

/* Define to 1 if you have the `atanf' function. */
#define HAVE_ATANF 1

/* Define to 1 if you have the `atexit' function. */
#define HAVE_ATEXIT 1

/* Define to 1 if you have the `atoll' function. */
#define HAVE_ATOLL 1

/* Define to 1 if you have the <bp-sym.h> header file. */
/* #undef HAVE_BP_SYM_H */

/* Define to 1 if you have the 'btowc' function. */
#define HAVE_BTOWC 1

/* Define to 1 if nanosleep mishandles large arguments. */
/* #undef HAVE_BUG_BIG_NANOSLEEP */

/* Define if the 'calloc' function is POSIX compliant. */
/* #undef HAVE_CALLOC_POSIX */

/* Define to 1 if you have the 'canonicalize_file_name' function. */
/* #undef HAVE_CANONICALIZE_FILE_NAME */

/* Define to 1 if you have the 'catgets' function. */
/* #undef HAVE_CATGETS */

/* Define to 1 if you have the `cbrt' function. */
#define HAVE_CBRT 1

/* Define to 1 if you have the `cbrtf' function. */
#define HAVE_CBRTF 1

/* Define to 1 if you have the `cbrtl' function. */
#define HAVE_CBRTL 1

/* Define to 1 if you have the Mac OS X function CFLocaleCopyCurrent in the
   CoreFoundation framework. */
/* #undef HAVE_CFLOCALECOPYCURRENT */

/* Define to 1 if you have the Mac OS X function CFPreferencesCopyAppValue in
   the CoreFoundation framework. */
/* #undef HAVE_CFPREFERENCESCOPYAPPVALUE */

/* Define to 1 if you have the 'chown' function. */
/* #undef HAVE_CHOWN */

/* Define to 1 if you have the `chsize' function. */
#define HAVE_CHSIZE 1

/* Define to 1 if you have the `clock_gettime' function. */
/* #undef HAVE_CLOCK_GETTIME */

/* Define to 1 if you have the `clock_settime' function. */
/* #undef HAVE_CLOCK_SETTIME */

/* Define to 1 if you have the `closedir' function. */
#define HAVE_CLOSEDIR 1

/* Define to 1 if you have the `confstr' function. */
/* #undef HAVE_CONFSTR */

/* Define if the copysignf function is declared in <math.h> and available in
   libc. */
/* #undef HAVE_COPYSIGNF_IN_LIBC */

/* Define if the copysignl function is declared in <math.h> and available in
   libc. */
/* #undef HAVE_COPYSIGNL_IN_LIBC */

/* Define if the copysign function is declared in <math.h> and available in
   libc. */
/* #undef HAVE_COPYSIGN_IN_LIBC */

/* Define to 1 if you have the `cosf' function. */
#define HAVE_COSF 1

/* Define to 1 if you have the `coshf' function. */
#define HAVE_COSHF 1

/* Define if the GNU dcgettext() function is already present or preinstalled.
   */
/* #undef HAVE_DCGETTEXT */

/* Define to 1 if you have the declaration of `alarm', and to 0 if you don't.
   */
#define HAVE_DECL_ALARM 0

/* Define to 1 if you have the declaration of `ceilf', and to 0 if you don't.
   */
#define HAVE_DECL_CEILF 1

/* Define to 1 if you have the declaration of `ceill', and to 0 if you don't.
   */
#define HAVE_DECL_CEILL 1

/* Define to 1 if you have the declaration of `copysign', and to 0 if you
   don't. */
/* #undef HAVE_DECL_COPYSIGN */

/* Define to 1 if you have the declaration of `copysignf', and to 0 if you
   don't. */
/* #undef HAVE_DECL_COPYSIGNF */

/* Define to 1 if you have the declaration of `copysignl', and to 0 if you
   don't. */
/* #undef HAVE_DECL_COPYSIGNL */

/* Define to 1 if you have the declaration of `dirfd', and to 0 if you don't.
   */
#define HAVE_DECL_DIRFD 0

/* Define to 1 if you have the declaration of `fchdir', and to 0 if you don't.
   */
#define HAVE_DECL_FCHDIR 0

/* Define to 1 if you have the declaration of `fdatasync', and to 0 if you
   don't. */
#define HAVE_DECL_FDATASYNC 0

/* Define to 1 if you have the declaration of `fdopendir', and to 0 if you
   don't. */
#define HAVE_DECL_FDOPENDIR 0

/* Define to 1 if you have the declaration of `floorf', and to 0 if you don't.
   */
#define HAVE_DECL_FLOORF 1

/* Define to 1 if you have the declaration of `floorl', and to 0 if you don't.
   */
#define HAVE_DECL_FLOORL 1

/* Define to 1 if you have the declaration of `fpurge', and to 0 if you don't.
   */
#define HAVE_DECL_FPURGE 0

/* Define to 1 if you have the declaration of `freeaddrinfo', and to 0 if you
   don't. */
#define HAVE_DECL_FREEADDRINFO 1

/* Define to 1 if you have the declaration of `fseeko', and to 0 if you don't.
   */
#define HAVE_DECL_FSEEKO 1

/* Define to 1 if you have the declaration of `ftello', and to 0 if you don't.
   */
#define HAVE_DECL_FTELLO 1

/* Define to 1 if you have the declaration of `gai_strerror', and to 0 if you
   don't. */
#define HAVE_DECL_GAI_STRERROR 1

/* Define to 1 if you have the declaration of `gai_strerrorA', and to 0 if you
   don't. */
#define HAVE_DECL_GAI_STRERRORA 1

/* Define to 1 if you have the declaration of `getaddrinfo', and to 0 if you
   don't. */
#define HAVE_DECL_GETADDRINFO 1

/* Define to 1 if you have the declaration of `getcwd', and to 0 if you don't.
   */
#define HAVE_DECL_GETCWD 1

/* Define to 1 if you have the declaration of `getc_unlocked', and to 0 if you
   don't. */
#define HAVE_DECL_GETC_UNLOCKED 0

/* Define to 1 if you have the declaration of `getdelim', and to 0 if you
   don't. */
#define HAVE_DECL_GETDELIM 0

/* Define to 1 if you have the declaration of `getenv', and to 0 if you don't.
   */
#define HAVE_DECL_GETENV 1

/* Define to 1 if you have the declaration of `getline', and to 0 if you
   don't. */
#define HAVE_DECL_GETLINE 0

/* Define to 1 if you have the declaration of `getlogin', and to 0 if you
   don't. */
#define HAVE_DECL_GETLOGIN 0

/* Define to 1 if you have the declaration of `getlogin_r', and to 0 if you
   don't. */
#define HAVE_DECL_GETLOGIN_R 0

/* Define to 1 if you have the declaration of `getnameinfo', and to 0 if you
   don't. */
#define HAVE_DECL_GETNAMEINFO 1

/* Define to 1 if you have the declaration of `imaxabs', and to 0 if you
   don't. */
#define HAVE_DECL_IMAXABS 1

/* Define to 1 if you have the declaration of `imaxdiv', and to 0 if you
   don't. */
#define HAVE_DECL_IMAXDIV 1

/* Define to 1 if you have the declaration of `inet_ntop', and to 0 if you
   don't. */
#define HAVE_DECL_INET_NTOP 0

/* Define to 1 if you have the declaration of `inet_pton', and to 0 if you
   don't. */
#define HAVE_DECL_INET_PTON 0

/* Define to 1 if you have the declaration of `isblank', and to 0 if you
   don't. */
#define HAVE_DECL_ISBLANK 1

/* Define to 1 if you have the declaration of `isfinite', and to 0 if you
   don't. */
#define HAVE_DECL_ISFINITE 1

/* Define to 1 if you have the declaration of `isinf', and to 0 if you don't.
   */
#define HAVE_DECL_ISINF 1

/* Define to 1 if you have the declaration of `iswblank', and to 0 if you
   don't. */
#define HAVE_DECL_ISWBLANK 1

/* Define to 1 if you have the declaration of `localtime_r', and to 0 if you
   don't. */
#define HAVE_DECL_LOCALTIME_R 0

/* Define to 1 if you have the declaration of `logb', and to 0 if you don't.
   */
#define HAVE_DECL_LOGB 1

/* Define to 1 if you have the declaration of `mbrlen', and to 0 if you don't.
   */
/* #undef HAVE_DECL_MBRLEN */

/* Define to 1 if you have the declaration of `mbrtowc', and to 0 if you
   don't. */
/* #undef HAVE_DECL_MBRTOWC */

/* Define to 1 if you have the declaration of `mbsinit', and to 0 if you
   don't. */
/* #undef HAVE_DECL_MBSINIT */

/* Define to 1 if you have the declaration of `mbsrtowcs', and to 0 if you
   don't. */
/* #undef HAVE_DECL_MBSRTOWCS */

/* Define to 1 if you have the declaration of `memrchr', and to 0 if you
   don't. */
#define HAVE_DECL_MEMRCHR 0

/* Define to 1 if you have the declaration of `program_invocation_name', and
   to 0 if you don't. */
#define HAVE_DECL_PROGRAM_INVOCATION_NAME 0

/* Define to 1 if you have the declaration of `program_invocation_short_name',
   and to 0 if you don't. */
#define HAVE_DECL_PROGRAM_INVOCATION_SHORT_NAME 0

/* Define to 1 if you have the declaration of `remainderl', and to 0 if you
   don't. */
#define HAVE_DECL_REMAINDERL 1

/* Define to 1 if you have the declaration of `rintf', and to 0 if you don't.
   */
#define HAVE_DECL_RINTF 1

/* Define to 1 if you have the declaration of `round', and to 0 if you don't.
   */
#define HAVE_DECL_ROUND 1

/* Define to 1 if you have the declaration of `roundf', and to 0 if you don't.
   */
#define HAVE_DECL_ROUNDF 1

/* Define to 1 if you have the declaration of `roundl', and to 0 if you don't.
   */
#define HAVE_DECL_ROUNDL 1

/* Define to 1 if you have the declaration of `setenv', and to 0 if you don't.
   */
#define HAVE_DECL_SETENV 0

/* Define to 1 if you have the declaration of `sleep', and to 0 if you don't.
   */
#define HAVE_DECL_SLEEP 0

/* Define to 1 if you have the declaration of `snprintf', and to 0 if you
   don't. */
#define HAVE_DECL_SNPRINTF 1

/* Define to 1 if you have the declaration of `stpncpy', and to 0 if you
   don't. */
#define HAVE_DECL_STPNCPY 0

/* Define to 1 if you have the declaration of `strdup', and to 0 if you don't.
   */
#define HAVE_DECL_STRDUP 1

/* Define to 1 if you have the declaration of `strerror_r', and to 0 if you
   don't. */
#define HAVE_DECL_STRERROR_R 0

/* Define to 1 if you have the declaration of `strncasecmp', and to 0 if you
   don't. */
#define HAVE_DECL_STRNCASECMP 1

/* Define to 1 if you have the declaration of `strndup', and to 0 if you
   don't. */
#define HAVE_DECL_STRNDUP 0

/* Define to 1 if you have the declaration of `strnlen', and to 0 if you
   don't. */
#define HAVE_DECL_STRNLEN 1

/* Define to 1 if you have the declaration of `strsignal', and to 0 if you
   don't. */
#define HAVE_DECL_STRSIGNAL 0

/* Define to 1 if you have the declaration of `strtod', and to 0 if you don't.
   */
#define HAVE_DECL_STRTOD 1

/* Define to 1 if you have the declaration of `strtoimax', and to 0 if you
   don't. */
#define HAVE_DECL_STRTOIMAX 1

/* Define to 1 if you have the declaration of `strtok_r', and to 0 if you
   don't. */
#define HAVE_DECL_STRTOK_R 0

/* Define to 1 if you have the declaration of `strtoll', and to 0 if you
   don't. */
/* #undef HAVE_DECL_STRTOLL */

/* Define to 1 if you have the declaration of `strtoull', and to 0 if you
   don't. */
/* #undef HAVE_DECL_STRTOULL */

/* Define to 1 if you have the declaration of `strtoumax', and to 0 if you
   don't. */
#define HAVE_DECL_STRTOUMAX 1

/* Define to 1 if you have the declaration of `sys_siglist', and to 0 if you
   don't. */
#define HAVE_DECL_SYS_SIGLIST 0

/* Define to 1 if you have the declaration of `tcgetsid', and to 0 if you
   don't. */
#define HAVE_DECL_TCGETSID 0

/* Define to 1 if you have the declaration of `towlower', and to 0 if you
   don't. */
/* #undef HAVE_DECL_TOWLOWER */

/* Define to 1 if you have the declaration of `trunc', and to 0 if you don't.
   */
#define HAVE_DECL_TRUNC 1

/* Define to 1 if you have the declaration of `truncf', and to 0 if you don't.
   */
#define HAVE_DECL_TRUNCF 1

/* Define to 1 if you have the declaration of `truncl', and to 0 if you don't.
   */
#define HAVE_DECL_TRUNCL 1

/* Define to 1 if you have the declaration of `ttyname_r', and to 0 if you
   don't. */
#define HAVE_DECL_TTYNAME_R 0

/* Define to 1 if you have the declaration of `unsetenv', and to 0 if you
   don't. */
#define HAVE_DECL_UNSETENV 0

/* Define to 1 if you have the declaration of `vsnprintf', and to 0 if you
   don't. */
#define HAVE_DECL_VSNPRINTF 1

/* Define to 1 if you have the declaration of `wcrtomb', and to 0 if you
   don't. */
/* #undef HAVE_DECL_WCRTOMB */

/* Define to 1 if you have the declaration of `wcsrtombs', and to 0 if you
   don't. */
/* #undef HAVE_DECL_WCSRTOMBS */

/* Define to 1 if you have the declaration of `wctob', and to 0 if you don't.
   */
/* #undef HAVE_DECL_WCTOB */

/* Define to 1 if you have the declaration of `wcwidth', and to 0 if you
   don't. */
#define HAVE_DECL_WCWIDTH 0

/* Define to 1 if you have the declaration of `_putenv', and to 0 if you
   don't. */
#define HAVE_DECL__PUTENV 1

/* Define to 1 if you have the declaration of `_snprintf', and to 0 if you
   don't. */
#define HAVE_DECL__SNPRINTF 1

/* Define to 1 if you have the declaration of `_sys_siglist', and to 0 if you
   don't. */
#define HAVE_DECL__SYS_SIGLIST 0

/* Define to 1 if you have the <dirent.h> header file. */
#define HAVE_DIRENT_H 1

/* Define to 1 if you have the `dirfd' function. */
/* #undef HAVE_DIRFD */

/* Define to 1 if you have the 'dprintf' function. */
/* #undef HAVE_DPRINTF */

/* Define to 1 if you have the 'dup2' function. */
#define HAVE_DUP2 1

/* Define to 1 if you have the 'duplocale' function. */
/* #undef HAVE_DUPLOCALE */

/* Define to 1 if you have the `eaccess' function. */
/* #undef HAVE_EACCESS */

/* Define if you have the declaration of environ. */
#define HAVE_ENVIRON_DECL 1

/* Define to 1 if you have the `euidaccess' function. */
/* #undef HAVE_EUIDACCESS */

/* Define to 1 if you have the `exp2f' function. */
#define HAVE_EXP2F 1

/* Define to 1 if you have the `exp2l' function. */
#define HAVE_EXP2L 1

/* Define to 1 if you have the `expf' function. */
#define HAVE_EXPF 1

/* Define to 1 if you have the `expm1f' function. */
#define HAVE_EXPM1F 1

/* Define to 1 if you have the 'faccessat' function. */
/* #undef HAVE_FACCESSAT */

/* Define to 1 if you have the 'fchdir' function. */
/* #undef HAVE_FCHDIR */

/* Define to 1 if you have the 'fchmodat' function. */
/* #undef HAVE_FCHMODAT */

/* Define to 1 if you have the 'fchown' function. */
/* #undef HAVE_FCHOWN */

/* Define to 1 if you have the 'fcntl' function. */
/* #undef HAVE_FCNTL */

/* Define to 1 if you have the `fdatasync' function. */
/* #undef HAVE_FDATASYNC */

/* Define to 1 if you have the 'fdopendir' function. */
/* #undef HAVE_FDOPENDIR */

/* Define to 1 if you have the <features.h> header file. */
/* #undef HAVE_FEATURES_H */

/* Define to 1 if you have the 'fegetround' function. */
#define HAVE_FEGETROUND 1

/* Define to 1 if you have the 'ffs' function. */
/* #undef HAVE_FFS */

/* Define to 1 if you have the `flockfile' function. */
/* #undef HAVE_FLOCKFILE */

/* Define if the both the floorf() and ceilf() functions exist. */
#define HAVE_FLOORF_AND_CEILF 1

/* Define if the both the floorl() and ceill() functions exist. */
/* #undef HAVE_FLOORL_AND_CEILL */

/* Define to 1 if you have the `fmodf' function. */
#define HAVE_FMODF 1

/* Define to 1 if you have the `fmodl' function. */
#define HAVE_FMODL 1

/* Define to 1 if you have the 'fpurge' function. */
/* #undef HAVE_FPURGE */

/* Define if the frexp() function is available and works. */
/* #undef HAVE_FREXP */

/* Define if the frexpl() function is available. */
/* #undef HAVE_FREXPL */

/* Define if the frexpl function is available in libc. */
/* #undef HAVE_FREXPL_IN_LIBC */

/* Define if the frexp function is available in libc. */
/* #undef HAVE_FREXP_IN_LIBC */

/* Define to 1 if fseeko (and presumably ftello) exists and is declared. */
#define HAVE_FSEEKO 1

/* Define to 1 if you have the 'fstatat' function. */
/* #undef HAVE_FSTATAT */

/* Define to 1 if you have the 'fsync' function. */
/* #undef HAVE_FSYNC */

/* Define to 1 if you have the 'ftruncate' function. */
#define HAVE_FTRUNCATE 1

/* Define to 1 if you have the `funlockfile' function. */
/* #undef HAVE_FUNLOCKFILE */

/* Define to 1 if you have the 'futimens' function. */
/* #undef HAVE_FUTIMENS */

/* Define to 1 if you have the 'futimes' function. */
/* #undef HAVE_FUTIMES */

/* Define to 1 if you have the 'futimesat' function. */
/* #undef HAVE_FUTIMESAT */

/* Define to 1 if you have the 'getcwd' function. */
#define HAVE_GETCWD 1

/* Define to 1 if you have the 'getdelim' function. */
/* #undef HAVE_GETDELIM */

/* Define to 1 if you have the 'getdtablesize' function. */
/* #undef HAVE_GETDTABLESIZE */

/* Define to 1 if you have the 'getegid' function. */
/* #undef HAVE_GETEGID */

/* Define to 1 if you have the 'getgrouplist' function. */
/* #undef HAVE_GETGROUPLIST */

/* Define to 1 if your system has a working `getgroups' function. */
/* #undef HAVE_GETGROUPS */

/* Define to 1 if you have the `gethostbyname' function. */
/* #undef HAVE_GETHOSTBYNAME */

/* Define to 1 if you have the `gethostname' function. */
/* #undef HAVE_GETHOSTNAME */

/* Define to 1 if you have the 'getlogin' function. */
#define HAVE_GETLOGIN 1

/* Define to 1 if you have the 'getlogin_r' function. */
/* #undef HAVE_GETLOGIN_R */

/* Define to 1 if you have the <getopt.h> header file. */
#define HAVE_GETOPT_H 1

/* Define to 1 if you have the `getopt_long_only' function. */
/* #undef HAVE_GETOPT_LONG_ONLY */

/* Define to 1 if you have the `getpagesize' function. */
#define HAVE_GETPAGESIZE 1

/* Define to 1 if you have the `getppriv' function. */
/* #undef HAVE_GETPPRIV */

/* Define to 1 if you have the 'getpwnam_r' function. */
/* #undef HAVE_GETPWNAM_R */

/* Define to 1 if you have the 'getrlimit' function. */
/* #undef HAVE_GETRLIMIT */

/* Define to 1 if you have the 'getrusage' function. */
/* #undef HAVE_GETRUSAGE */

/* Define to 1 if you have the `getservbyname' function. */
/* #undef HAVE_GETSERVBYNAME */

/* Define to 1 if you have the 'getsubopt' function. */
/* #undef HAVE_GETSUBOPT */

/* Define if the GNU gettext() function is already present or preinstalled. */
/* #undef HAVE_GETTEXT */

/* Define to 1 if you have the 'gettimeofday' function. */
#define HAVE_GETTIMEOFDAY 1

/* Define to 1 if you have the <glob.h> header file. */
/* #undef HAVE_GLOB_H */

/* Define to 1 if you have the `grantpt' function. */
/* #undef HAVE_GRANTPT */

/* Define to 1 if you have the <grp.h> header file. */
/* #undef HAVE_GRP_H */

/* Define to 1 if you have the `hypotf' function. */
#define HAVE_HYPOTF 1

/* Define to 1 if you have the `hypotl' function. */
#define HAVE_HYPOTL 1

/* Define if you have the iconv() function and it works. */
#define HAVE_ICONV 1

/* Define to 1 if you have the <iconv.h> header file. */
/* #undef HAVE_ICONV_H */

/* Define if you have if_nameindex. */
/* #undef HAVE_IF_NAMEINDEX */

/* Define to 1 if you have the 'imaxabs' function. */
#define HAVE_IMAXABS 1

/* Define to 1 if you have the 'imaxdiv' function. */
#define HAVE_IMAXDIV 1

/* Define to 1 if you have the `inet_ntop' function. */
/* #undef HAVE_INET_NTOP */

/* Define to 1 if you have the `inet_pton' function. */
/* #undef HAVE_INET_PTON */

/* Define to 1 if you have the 'initstate' function. */
/* #undef HAVE_INITSTATE */

/* Define to 1 if the compiler supports one of the keywords 'inline',
   '__inline__', '__inline' and effectively inlines functions marked as such.
   */
/* #undef HAVE_INLINE */

/* Define if you have the 'intmax_t' type in <stdint.h> or <inttypes.h>. */
#define HAVE_INTMAX_T 1

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define if <inttypes.h> exists, doesn't clash with <sys/types.h>, and
   declares uintmax_t. */
#define HAVE_INTTYPES_H_WITH_UINTMAX 1

/* Define to 1 if you have the `ioctl' function. */
/* #undef HAVE_IOCTL */

/* Define to 1 if <sys/socket.h> defines AF_INET. */
#define HAVE_IPV4 1

/* Define to 1 if <sys/socket.h> defines AF_INET6. */
#define HAVE_IPV6 1

/* Define to 1 if you have the 'isblank' function. */
#define HAVE_ISBLANK 1

/* Define if the isnan(double) function is available in libc. */
#define HAVE_ISNAND_IN_LIBC 1

/* Define if the isnan(float) function is available in libc. */
#define HAVE_ISNANF_IN_LIBC 1

/* Define if the isnan(long double) function is available in libc. */
/* #undef HAVE_ISNANL_IN_LIBC */

/* Define to 1 if you have the `issetugid' function. */
/* #undef HAVE_ISSETUGID */

/* Define to 1 if you have the 'iswblank' function. */
#define HAVE_ISWBLANK 1

/* Define to 1 if you have the 'iswcntrl' function. */
#define HAVE_ISWCNTRL 1

/* Define to 1 if you have the 'iswctype' function. */
#define HAVE_ISWCTYPE 1

/* Define if you have <langinfo.h> and nl_langinfo(CODESET). */
/* #undef HAVE_LANGINFO_CODESET */

/* Define to 1 if you have the <langinfo.h> header file. */
/* #undef HAVE_LANGINFO_H */

/* Define to 1 if you have the 'lchmod' function. */
/* #undef HAVE_LCHMOD */

/* Define to 1 if you have the `lchown' function. */
/* #undef HAVE_LCHOWN */

/* Define if your <locale.h> file defines LC_MESSAGES. */
/* #undef HAVE_LC_MESSAGES */

/* Define if the ldexpl() function is available. */
#define HAVE_LDEXPL 1

/* Define if the ldexpl function is available in libc. */
#define HAVE_LDEXPL_IN_LIBC 1

/* Define if the ldexp function is available in libc. */
#define HAVE_LDEXP_IN_LIBC 1

/* Define to 1 if you have the <libgen.h> header file. */
#define HAVE_LIBGEN_H 1

/* Define to 1 if you have the <libintl.h> header file. */
/* #undef HAVE_LIBINTL_H */

/* Define to 1 if you have the 'link' function. */
/* #undef HAVE_LINK */

/* Define to 1 if you have the 'linkat' function. */
/* #undef HAVE_LINKAT */

/* Define to 1 if you have the 'localtime_r' function. */
/* #undef HAVE_LOCALTIME_R */

/* Define to 1 if you have the `log10f' function. */
#define HAVE_LOG10F 1

/* Define to 1 if you have the `log10l' function. */
#define HAVE_LOG10L 1

/* Define to 1 if you have the `log1p' function. */
#define HAVE_LOG1P 1

/* Define to 1 if you have the `log1pf' function. */
#define HAVE_LOG1PF 1

/* Define to 1 if you have the `log1pl' function. */
#define HAVE_LOG1PL 1

/* Define to 1 if the log2() function is available in libc or libm. */
#define HAVE_LOG2 1

/* Define to 1 if you have the `log2f' function. */
#define HAVE_LOG2F 1

/* Define to 1 if you have the `log2l' function. */
#define HAVE_LOG2L 1

/* Define to 1 if you have the `logf' function. */
#define HAVE_LOGF 1

/* Define to 1 if the system has the type 'long long int'. */
#define HAVE_LONG_LONG_INT 1

/* Define to 1 if you have the 'lstat' function. */
/* #undef HAVE_LSTAT */

/* Define to 1 if you have the 'lutimes' function. */
/* #undef HAVE_LUTIMES */

/* Define to 1 if your system has a GNU libc compatible 'malloc' function, and
   to 0 otherwise. */
#define HAVE_MALLOC_GNU 1

/* Define if the 'malloc' function is POSIX compliant. */
/* #undef HAVE_MALLOC_POSIX */

/* Define to 1 if mmap()'s MAP_ANONYMOUS flag is available after including
   config.h and <sys/mman.h>. */
/* #undef HAVE_MAP_ANONYMOUS */

/* Define to 1 if you have the <math.h> header file. */
#define HAVE_MATH_H 1

/* Define to 1 if you have the 'mbrlen' function. */
#define HAVE_MBRLEN 1

/* Define to 1 if you have the 'mbrtowc' function. */
#define HAVE_MBRTOWC 1

/* Define to 1 if you have the 'mbsinit' function. */
#define HAVE_MBSINIT 1

/* Define to 1 if you have the 'mbsnrtowcs' function. */
/* #undef HAVE_MBSNRTOWCS */

/* Define to 1 if you have the 'mbsrtowcs' function. */
#define HAVE_MBSRTOWCS 1

/* Define to 1 if <wchar.h> declares mbstate_t. */
#define HAVE_MBSTATE_T 1

/* Define to 1 if you have the 'memchr' function. */
#define HAVE_MEMCHR 1

/* Define to 1 if you have the `memcpy' function. */
#define HAVE_MEMCPY 1

/* Define to 1 if you have the `memmove' function. */
#define HAVE_MEMMOVE 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the `mempcpy' function. */
#define HAVE_MEMPCPY 1

/* Define to 1 if you have the `memrchr' function. */
/* #undef HAVE_MEMRCHR */

/* Define to 1 if you have the `memset' function. */
#define HAVE_MEMSET 1

/* Define to 1 if getcwd minimally works, that is, its result can be trusted
   when it succeeds. */
#define HAVE_MINIMALLY_WORKING_GETCWD 1

/* Define to 1 if <limits.h> defines the MIN and MAX macros. */
/* #undef HAVE_MINMAX_IN_LIMITS_H */

/* Define to 1 if <sys/param.h> defines the MIN and MAX macros. */
/* #undef HAVE_MINMAX_IN_SYS_PARAM_H */

/* Define to 1 if you have the 'mkdirat' function. */
/* #undef HAVE_MKDIRAT */

/* Define to 1 if you have the `mkdtemp' function. */
/* #undef HAVE_MKDTEMP */

/* Define to 1 if you have the 'mkfifo' function. */
/* #undef HAVE_MKFIFO */

/* Define to 1 if you have the 'mkfifoat' function. */
/* #undef HAVE_MKFIFOAT */

/* Define to 1 if you have the 'mknod' function. */
/* #undef HAVE_MKNOD */

/* Define to 1 if you have the 'mknodat' function. */
/* #undef HAVE_MKNODAT */

/* Define to 1 if you have the 'mkstemp' function. */
/* #undef HAVE_MKSTEMP */

/* Define to 1 if you have the 'mprotect' function. */
#define HAVE_MPROTECT 1

/* Define to 1 if you have the 'mquery' function. */
/* #undef HAVE_MQUERY */

/* Define to 1 on MSVC platforms that have the "invalid parameter handler"
   concept. */
/* #undef HAVE_MSVC_INVALID_PARAMETER_HANDLER */

/* Define to 1 if you have the 'nanotime' function. */
/* #undef HAVE_NANOTIME */

/* Define to 1 if you have the <netdb.h> header file. */
/* #undef HAVE_NETDB_H */

/* Define to 1 if you have the <netinet/in.h> header file. */
/* #undef HAVE_NETINET_IN_H */

/* Define to 1 if you have the <net/if.h> header file. */
/* #undef HAVE_NET_IF_H */

/* Define to 1 if you have the 'newlocale' function. */
/* #undef HAVE_NEWLOCALE */

/* Define to 1 if you have the `nl_langinfo' function. */
/* #undef HAVE_NL_LANGINFO */

/* Define to 1 if you have the 'openat' function. */
/* #undef HAVE_OPENAT */

/* Define to 1 if you have the `opendir' function. */
#define HAVE_OPENDIR 1

/* Define to 1 if you have the <OS.h> header file. */
/* #undef HAVE_OS_H */

/* Define to 1 if getcwd works, except it sometimes fails when it shouldn't,
   setting errno to ERANGE, ENAMETOOLONG, or ENOENT. */
/* #undef HAVE_PARTLY_WORKING_GETCWD */

/* Define to 1 if you have the <paths.h> header file. */
/* #undef HAVE_PATHS_H */

/* Define to 1 if you have the 'pclose' function. */
#define HAVE_PCLOSE 1

/* Define to 1 if you have the 'pipe' function. */
/* #undef HAVE_PIPE */

/* Define to 1 if you have the 'poll' function and it works. */
/* #undef HAVE_POLL */

/* Define to 1 if you have the <poll.h> header file. */
/* #undef HAVE_POLL_H */

/* Define to 1 if you have the 'popen' function. */
#define HAVE_POPEN 1

/* Define if the ttyname_r function has a POSIX compliant declaration. */
/* #undef HAVE_POSIXDECL_TTYNAME_R */

/* Define to 1 if you have the 'posix_openpt' function. */
/* #undef HAVE_POSIX_OPENPT */

/* Define to 1 if you have the 'posix_spawn' function. */
/* #undef HAVE_POSIX_SPAWN */

/* Define to 1 if the system has the type `posix_spawnattr_t'. */
/* #undef HAVE_POSIX_SPAWNATTR_T */

/* Define to 1 if the system has the type `posix_spawn_file_actions_t'. */
/* #undef HAVE_POSIX_SPAWN_FILE_ACTIONS_T */

/* Define to 1 if you have the `powf' function. */
#define HAVE_POWF 1

/* Define to 1 if you have the 'pread' function. */
/* #undef HAVE_PREAD */

/* Define to 1 if you have the <priv.h> header file. */
/* #undef HAVE_PRIV_H */

/* Define to 1 if you have the `pthread_atfork' function. */
/* #undef HAVE_PTHREAD_ATFORK */

/* Define if the <pthread.h> defines PTHREAD_MUTEX_RECURSIVE. */
#define HAVE_PTHREAD_MUTEX_RECURSIVE 1

/* Define if the POSIX multithreading library has read/write locks. */
#define HAVE_PTHREAD_RWLOCK 1

/* Define to 1 if the pthread_sigmask function can be used (despite bugs). */
/* #undef HAVE_PTHREAD_SIGMASK */

/* Define to 1 if you have the `ptsname' function. */
/* #undef HAVE_PTSNAME */

/* Define to 1 if you have the 'ptsname_r' function. */
/* #undef HAVE_PTSNAME_R */

/* Define to 1 if you have the 'pwrite' function. */
/* #undef HAVE_PWRITE */

/* Define to 1 if you have the `raise' function. */
#define HAVE_RAISE 1

/* Define to 1 if you have the `random' function. */
/* #undef HAVE_RANDOM */

/* Define to 1 if you have the <random.h> header file. */
/* #undef HAVE_RANDOM_H */

/* Define to 1 if you have the `random_r' function. */
/* #undef HAVE_RANDOM_R */

/* Define to 1 if you have the `rawmemchr' function. */
/* #undef HAVE_RAWMEMCHR */

/* Define to 1 if accept is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_ACCEPT */

/* Define to 1 if accept4 is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_ACCEPT4 */

/* Define to 1 if acosf is declared even after undefining macros. */
#define HAVE_RAW_DECL_ACOSF 1

/* Define to 1 if acosl is declared even after undefining macros. */
#define HAVE_RAW_DECL_ACOSL 1

/* Define to 1 if alphasort is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_ALPHASORT */

/* Define to 1 if asinf is declared even after undefining macros. */
#define HAVE_RAW_DECL_ASINF 1

/* Define to 1 if asinl is declared even after undefining macros. */
#define HAVE_RAW_DECL_ASINL 1

/* Define to 1 if atanf is declared even after undefining macros. */
#define HAVE_RAW_DECL_ATANF 1

/* Define to 1 if atanl is declared even after undefining macros. */
#define HAVE_RAW_DECL_ATANL 1

/* Define to 1 if atoll is declared even after undefining macros. */
#define HAVE_RAW_DECL_ATOLL 1

/* Define to 1 if bind is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_BIND */

/* Define to 1 if btowc is declared even after undefining macros. */
#define HAVE_RAW_DECL_BTOWC 1

/* Define to 1 if canonicalize_file_name is declared even after undefining
   macros. */
/* #undef HAVE_RAW_DECL_CANONICALIZE_FILE_NAME */

/* Define to 1 if cbrt is declared even after undefining macros. */
#define HAVE_RAW_DECL_CBRT 1

/* Define to 1 if cbrtf is declared even after undefining macros. */
#define HAVE_RAW_DECL_CBRTF 1

/* Define to 1 if cbrtl is declared even after undefining macros. */
#define HAVE_RAW_DECL_CBRTL 1

/* Define to 1 if ceilf is declared even after undefining macros. */
#define HAVE_RAW_DECL_CEILF 1

/* Define to 1 if ceill is declared even after undefining macros. */
#define HAVE_RAW_DECL_CEILL 1

/* Define to 1 if chdir is declared even after undefining macros. */
#define HAVE_RAW_DECL_CHDIR 1

/* Define to 1 if chown is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_CHOWN */

/* Define to 1 if closedir is declared even after undefining macros. */
#define HAVE_RAW_DECL_CLOSEDIR 1

/* Define to 1 if connect is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_CONNECT */

/* Define to 1 if copysign is declared even after undefining macros. */
#define HAVE_RAW_DECL_COPYSIGN 1

/* Define to 1 if copysignf is declared even after undefining macros. */
#define HAVE_RAW_DECL_COPYSIGNF 1

/* Define to 1 if copysignl is declared even after undefining macros. */
#define HAVE_RAW_DECL_COPYSIGNL 1

/* Define to 1 if cosf is declared even after undefining macros. */
#define HAVE_RAW_DECL_COSF 1

/* Define to 1 if coshf is declared even after undefining macros. */
#define HAVE_RAW_DECL_COSHF 1

/* Define to 1 if cosl is declared even after undefining macros. */
#define HAVE_RAW_DECL_COSL 1

/* Define to 1 if dirfd is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_DIRFD */

/* Define to 1 if dprintf is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_DPRINTF */

/* Define to 1 if dup is declared even after undefining macros. */
#define HAVE_RAW_DECL_DUP 1

/* Define to 1 if dup2 is declared even after undefining macros. */
#define HAVE_RAW_DECL_DUP2 1

/* Define to 1 if dup3 is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_DUP3 */

/* Define to 1 if duplocale is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_DUPLOCALE */

/* Define to 1 if endusershell is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_ENDUSERSHELL */

/* Define to 1 if environ is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_ENVIRON */

/* Define to 1 if euidaccess is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_EUIDACCESS */

/* Define to 1 if exp2 is declared even after undefining macros. */
#define HAVE_RAW_DECL_EXP2 1

/* Define to 1 if exp2f is declared even after undefining macros. */
#define HAVE_RAW_DECL_EXP2F 1

/* Define to 1 if exp2l is declared even after undefining macros. */
#define HAVE_RAW_DECL_EXP2L 1

/* Define to 1 if expf is declared even after undefining macros. */
#define HAVE_RAW_DECL_EXPF 1

/* Define to 1 if expl is declared even after undefining macros. */
#define HAVE_RAW_DECL_EXPL 1

/* Define to 1 if expm1 is declared even after undefining macros. */
#define HAVE_RAW_DECL_EXPM1 1

/* Define to 1 if expm1f is declared even after undefining macros. */
#define HAVE_RAW_DECL_EXPM1F 1

/* Define to 1 if expm1l is declared even after undefining macros. */
#define HAVE_RAW_DECL_EXPM1L 1

/* Define to 1 if fabsf is declared even after undefining macros. */
#define HAVE_RAW_DECL_FABSF 1

/* Define to 1 if fabsl is declared even after undefining macros. */
#define HAVE_RAW_DECL_FABSL 1

/* Define to 1 if faccessat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FACCESSAT */

/* Define to 1 if fchdir is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FCHDIR */

/* Define to 1 if fchmodat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FCHMODAT */

/* Define to 1 if fchownat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FCHOWNAT */

/* Define to 1 if fcntl is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FCNTL */

/* Define to 1 if fdatasync is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FDATASYNC */

/* Define to 1 if fdopendir is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FDOPENDIR */

/* Define to 1 if ffs is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FFS */

/* Define to 1 if ffsl is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FFSL */

/* Define to 1 if ffsll is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FFSLL */

/* Define to 1 if floorf is declared even after undefining macros. */
#define HAVE_RAW_DECL_FLOORF 1

/* Define to 1 if floorl is declared even after undefining macros. */
#define HAVE_RAW_DECL_FLOORL 1

/* Define to 1 if fma is declared even after undefining macros. */
#define HAVE_RAW_DECL_FMA 1

/* Define to 1 if fmaf is declared even after undefining macros. */
#define HAVE_RAW_DECL_FMAF 1

/* Define to 1 if fmal is declared even after undefining macros. */
#define HAVE_RAW_DECL_FMAL 1

/* Define to 1 if fmod is declared even after undefining macros. */
#define HAVE_RAW_DECL_FMOD 1

/* Define to 1 if fmodf is declared even after undefining macros. */
#define HAVE_RAW_DECL_FMODF 1

/* Define to 1 if fmodl is declared even after undefining macros. */
#define HAVE_RAW_DECL_FMODL 1

/* Define to 1 if fpurge is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FPURGE */

/* Define to 1 if freeaddrinfo is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FREEADDRINFO */

/* Define to 1 if frexpf is declared even after undefining macros. */
#define HAVE_RAW_DECL_FREXPF 1

/* Define to 1 if frexpl is declared even after undefining macros. */
#define HAVE_RAW_DECL_FREXPL 1

/* Define to 1 if fseeko is declared even after undefining macros. */
#define HAVE_RAW_DECL_FSEEKO 1

/* Define to 1 if fstat is declared even after undefining macros. */
#define HAVE_RAW_DECL_FSTAT 1

/* Define to 1 if fstatat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FSTATAT */

/* Define to 1 if fsync is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FSYNC */

/* Define to 1 if ftello is declared even after undefining macros. */
#define HAVE_RAW_DECL_FTELLO 1

/* Define to 1 if ftruncate is declared even after undefining macros. */
#define HAVE_RAW_DECL_FTRUNCATE 1

/* Define to 1 if futimens is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_FUTIMENS */

/* Define to 1 if gai_strerror is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GAI_STRERROR */

/* Define to 1 if getaddrinfo is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETADDRINFO */

/* Define to 1 if getcwd is declared even after undefining macros. */
#define HAVE_RAW_DECL_GETCWD 1

/* Define to 1 if getdelim is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETDELIM */

/* Define to 1 if getdomainname is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETDOMAINNAME */

/* Define to 1 if getdtablesize is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETDTABLESIZE */

/* Define to 1 if getgroups is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETGROUPS */

/* Define to 1 if gethostname is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETHOSTNAME */

/* Define to 1 if getline is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETLINE */

/* Define to 1 if getloadavg is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETLOADAVG */

/* Define to 1 if getlogin is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETLOGIN */

/* Define to 1 if getlogin_r is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETLOGIN_R */

/* Define to 1 if getnameinfo is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETNAMEINFO */

/* Define to 1 if getpagesize is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETPAGESIZE */

/* Define to 1 if getpeername is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETPEERNAME */

/* Define to 1 if getrusage is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETRUSAGE */

/* Define to 1 if gets is declared even after undefining macros. */
#define HAVE_RAW_DECL_GETS 1

/* Define to 1 if getsockname is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETSOCKNAME */

/* Define to 1 if getsockopt is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETSOCKOPT */

/* Define to 1 if getsubopt is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETSUBOPT */

/* Define to 1 if gettimeofday is declared even after undefining macros. */
#define HAVE_RAW_DECL_GETTIMEOFDAY 1

/* Define to 1 if getusershell is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GETUSERSHELL */

/* Define to 1 if grantpt is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GRANTPT */

/* Define to 1 if group_member is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_GROUP_MEMBER */

/* Define to 1 if hypotf is declared even after undefining macros. */
#define HAVE_RAW_DECL_HYPOTF 1

/* Define to 1 if hypotl is declared even after undefining macros. */
#define HAVE_RAW_DECL_HYPOTL 1

/* Define to 1 if ilogb is declared even after undefining macros. */
#define HAVE_RAW_DECL_ILOGB 1

/* Define to 1 if ilogbf is declared even after undefining macros. */
#define HAVE_RAW_DECL_ILOGBF 1

/* Define to 1 if ilogbl is declared even after undefining macros. */
#define HAVE_RAW_DECL_ILOGBL 1

/* Define to 1 if imaxabs is declared even after undefining macros. */
#define HAVE_RAW_DECL_IMAXABS 1

/* Define to 1 if imaxdiv is declared even after undefining macros. */
#define HAVE_RAW_DECL_IMAXDIV 1

/* Define to 1 if inet_ntop is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_INET_NTOP */

/* Define to 1 if inet_pton is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_INET_PTON */

/* Define to 1 if initstate is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_INITSTATE */

/* Define to 1 if initstate_r is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_INITSTATE_R */

/* Define to 1 if ioctl is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_IOCTL */

/* Define to 1 if isatty is declared even after undefining macros. */
#define HAVE_RAW_DECL_ISATTY 1

/* Define to 1 if isblank is declared even after undefining macros. */
#define HAVE_RAW_DECL_ISBLANK 1

/* Define to 1 if iswctype is declared even after undefining macros. */
#define HAVE_RAW_DECL_ISWCTYPE 1

/* Define to 1 if lchmod is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_LCHMOD */

/* Define to 1 if lchown is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_LCHOWN */

/* Define to 1 if ldexpf is declared even after undefining macros. */
#define HAVE_RAW_DECL_LDEXPF 1

/* Define to 1 if ldexpl is declared even after undefining macros. */
#define HAVE_RAW_DECL_LDEXPL 1

/* Define to 1 if link is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_LINK */

/* Define to 1 if linkat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_LINKAT */

/* Define to 1 if listen is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_LISTEN */

/* Define to 1 if log is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOG 1

/* Define to 1 if log10 is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOG10 1

/* Define to 1 if log10f is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOG10F 1

/* Define to 1 if log10l is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOG10L 1

/* Define to 1 if log1p is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOG1P 1

/* Define to 1 if log1pf is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOG1PF 1

/* Define to 1 if log1pl is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOG1PL 1

/* Define to 1 if log2 is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOG2 1

/* Define to 1 if log2f is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOG2F 1

/* Define to 1 if log2l is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOG2L 1

/* Define to 1 if logb is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOGB 1

/* Define to 1 if logbf is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOGBF 1

/* Define to 1 if logbl is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOGBL 1

/* Define to 1 if logf is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOGF 1

/* Define to 1 if logl is declared even after undefining macros. */
#define HAVE_RAW_DECL_LOGL 1

/* Define to 1 if lseek is declared even after undefining macros. */
#define HAVE_RAW_DECL_LSEEK 1

/* Define to 1 if lstat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_LSTAT */

/* Define to 1 if mbrlen is declared even after undefining macros. */
#define HAVE_RAW_DECL_MBRLEN 1

/* Define to 1 if mbrtowc is declared even after undefining macros. */
#define HAVE_RAW_DECL_MBRTOWC 1

/* Define to 1 if mbsinit is declared even after undefining macros. */
#define HAVE_RAW_DECL_MBSINIT 1

/* Define to 1 if mbsnrtowcs is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MBSNRTOWCS */

/* Define to 1 if mbsrtowcs is declared even after undefining macros. */
#define HAVE_RAW_DECL_MBSRTOWCS 1

/* Define to 1 if memmem is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MEMMEM */

/* Define to 1 if mempcpy is declared even after undefining macros. */
#define HAVE_RAW_DECL_MEMPCPY 1

/* Define to 1 if memrchr is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MEMRCHR */

/* Define to 1 if mkdirat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MKDIRAT */

/* Define to 1 if mkdtemp is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MKDTEMP */

/* Define to 1 if mkfifo is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MKFIFO */

/* Define to 1 if mkfifoat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MKFIFOAT */

/* Define to 1 if mknod is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MKNOD */

/* Define to 1 if mknodat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MKNODAT */

/* Define to 1 if mkostemp is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MKOSTEMP */

/* Define to 1 if mkostemps is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MKOSTEMPS */

/* Define to 1 if mkstemp is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MKSTEMP */

/* Define to 1 if mkstemps is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_MKSTEMPS */

/* Define to 1 if modf is declared even after undefining macros. */
#define HAVE_RAW_DECL_MODF 1

/* Define to 1 if modff is declared even after undefining macros. */
#define HAVE_RAW_DECL_MODFF 1

/* Define to 1 if modfl is declared even after undefining macros. */
#define HAVE_RAW_DECL_MODFL 1

/* Define to 1 if nl_langinfo is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_NL_LANGINFO */

/* Define to 1 if openat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_OPENAT */

/* Define to 1 if opendir is declared even after undefining macros. */
#define HAVE_RAW_DECL_OPENDIR 1

/* Define to 1 if pclose is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_PCLOSE */

/* Define to 1 if pipe is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_PIPE */

/* Define to 1 if pipe2 is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_PIPE2 */

/* Define to 1 if poll is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_POLL */

/* Define to 1 if popen is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_POPEN */

/* Define to 1 if posix_openpt is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_OPENPT */

/* Define to 1 if posix_spawn is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWN */

/* Define to 1 if posix_spawnattr_destroy is declared even after undefining
   macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_DESTROY */

/* Define to 1 if posix_spawnattr_getflags is declared even after undefining
   macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_GETFLAGS */

/* Define to 1 if posix_spawnattr_getpgroup is declared even after undefining
   macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_GETPGROUP */

/* Define to 1 if posix_spawnattr_getschedparam is declared even after
   undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_GETSCHEDPARAM */

/* Define to 1 if posix_spawnattr_getschedpolicy is declared even after
   undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_GETSCHEDPOLICY */

/* Define to 1 if posix_spawnattr_getsigdefault is declared even after
   undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_GETSIGDEFAULT */

/* Define to 1 if posix_spawnattr_getsigmask is declared even after undefining
   macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_GETSIGMASK */

/* Define to 1 if posix_spawnattr_init is declared even after undefining
   macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_INIT */

/* Define to 1 if posix_spawnattr_setflags is declared even after undefining
   macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_SETFLAGS */

/* Define to 1 if posix_spawnattr_setpgroup is declared even after undefining
   macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_SETPGROUP */

/* Define to 1 if posix_spawnattr_setschedparam is declared even after
   undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_SETSCHEDPARAM */

/* Define to 1 if posix_spawnattr_setschedpolicy is declared even after
   undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_SETSCHEDPOLICY */

/* Define to 1 if posix_spawnattr_setsigdefault is declared even after
   undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_SETSIGDEFAULT */

/* Define to 1 if posix_spawnattr_setsigmask is declared even after undefining
   macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNATTR_SETSIGMASK */

/* Define to 1 if posix_spawnp is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWNP */

/* Define to 1 if posix_spawn_file_actions_addclose is declared even after
   undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWN_FILE_ACTIONS_ADDCLOSE */

/* Define to 1 if posix_spawn_file_actions_adddup2 is declared even after
   undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWN_FILE_ACTIONS_ADDDUP2 */

/* Define to 1 if posix_spawn_file_actions_addopen is declared even after
   undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWN_FILE_ACTIONS_ADDOPEN */

/* Define to 1 if posix_spawn_file_actions_destroy is declared even after
   undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWN_FILE_ACTIONS_DESTROY */

/* Define to 1 if posix_spawn_file_actions_init is declared even after
   undefining macros. */
/* #undef HAVE_RAW_DECL_POSIX_SPAWN_FILE_ACTIONS_INIT */

/* Define to 1 if powf is declared even after undefining macros. */
#define HAVE_RAW_DECL_POWF 1

/* Define to 1 if pread is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_PREAD */

/* Define to 1 if pselect is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_PSELECT */

/* Define to 1 if pthread_sigmask is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_PTHREAD_SIGMASK */

/* Define to 1 if ptsname is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_PTSNAME */

/* Define to 1 if ptsname_r is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_PTSNAME_R */

/* Define to 1 if pwrite is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_PWRITE */

/* Define to 1 if random is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_RANDOM */

/* Define to 1 if random_r is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_RANDOM_R */

/* Define to 1 if rawmemchr is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_RAWMEMCHR */

/* Define to 1 if readdir is declared even after undefining macros. */
#define HAVE_RAW_DECL_READDIR 1

/* Define to 1 if readlink is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_READLINK */

/* Define to 1 if readlinkat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_READLINKAT */

/* Define to 1 if realpath is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_REALPATH */

/* Define to 1 if recv is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_RECV */

/* Define to 1 if recvfrom is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_RECVFROM */

/* Define to 1 if remainder is declared even after undefining macros. */
#define HAVE_RAW_DECL_REMAINDER 1

/* Define to 1 if remainderf is declared even after undefining macros. */
#define HAVE_RAW_DECL_REMAINDERF 1

/* Define to 1 if remainderl is declared even after undefining macros. */
#define HAVE_RAW_DECL_REMAINDERL 1

/* Define to 1 if renameat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_RENAMEAT */

/* Define to 1 if rewinddir is declared even after undefining macros. */
#define HAVE_RAW_DECL_REWINDDIR 1

/* Define to 1 if rint is declared even after undefining macros. */
#define HAVE_RAW_DECL_RINT 1

/* Define to 1 if rintf is declared even after undefining macros. */
#define HAVE_RAW_DECL_RINTF 1

/* Define to 1 if rintl is declared even after undefining macros. */
#define HAVE_RAW_DECL_RINTL 1

/* Define to 1 if rmdir is declared even after undefining macros. */
#define HAVE_RAW_DECL_RMDIR 1

/* Define to 1 if round is declared even after undefining macros. */
#define HAVE_RAW_DECL_ROUND 1

/* Define to 1 if roundf is declared even after undefining macros. */
#define HAVE_RAW_DECL_ROUNDF 1

/* Define to 1 if roundl is declared even after undefining macros. */
#define HAVE_RAW_DECL_ROUNDL 1

/* Define to 1 if rpmatch is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_RPMATCH */

/* Define to 1 if scandir is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SCANDIR */

/* Define to 1 if secure_getenv is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SECURE_GETENV */

/* Define to 1 if select is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SELECT */

/* Define to 1 if send is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SEND */

/* Define to 1 if sendto is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SENDTO */

/* Define to 1 if setenv is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SETENV */

/* Define to 1 if sethostname is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SETHOSTNAME */

/* Define to 1 if setlocale is declared even after undefining macros. */
#define HAVE_RAW_DECL_SETLOCALE 1

/* Define to 1 if setsockopt is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SETSOCKOPT */

/* Define to 1 if setstate is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SETSTATE */

/* Define to 1 if setstate_r is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SETSTATE_R */

/* Define to 1 if setusershell is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SETUSERSHELL */

/* Define to 1 if shutdown is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SHUTDOWN */

/* Define to 1 if sigaction is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SIGACTION */

/* Define to 1 if sigaddset is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SIGADDSET */

/* Define to 1 if sigdelset is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SIGDELSET */

/* Define to 1 if sigemptyset is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SIGEMPTYSET */

/* Define to 1 if sigfillset is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SIGFILLSET */

/* Define to 1 if sigismember is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SIGISMEMBER */

/* Define to 1 if sigpending is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SIGPENDING */

/* Define to 1 if sigprocmask is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SIGPROCMASK */

/* Define to 1 if sinf is declared even after undefining macros. */
#define HAVE_RAW_DECL_SINF 1

/* Define to 1 if sinhf is declared even after undefining macros. */
#define HAVE_RAW_DECL_SINHF 1

/* Define to 1 if sinl is declared even after undefining macros. */
#define HAVE_RAW_DECL_SINL 1

/* Define to 1 if sleep is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SLEEP */

/* Define to 1 if snprintf is declared even after undefining macros. */
#define HAVE_RAW_DECL_SNPRINTF 1

/* Define to 1 if socket is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SOCKET */

/* Define to 1 if sqrtf is declared even after undefining macros. */
#define HAVE_RAW_DECL_SQRTF 1

/* Define to 1 if sqrtl is declared even after undefining macros. */
#define HAVE_RAW_DECL_SQRTL 1

/* Define to 1 if srandom is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SRANDOM */

/* Define to 1 if srandom_r is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SRANDOM_R */

/* Define to 1 if stat is declared even after undefining macros. */
#define HAVE_RAW_DECL_STAT 1

/* Define to 1 if stpcpy is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_STPCPY */

/* Define to 1 if stpncpy is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_STPNCPY */

/* Define to 1 if strcasecmp is declared even after undefining macros. */
#define HAVE_RAW_DECL_STRCASECMP 1

/* Define to 1 if strcasestr is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_STRCASESTR */

/* Define to 1 if strchrnul is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_STRCHRNUL */

/* Define to 1 if strdup is declared even after undefining macros. */
#define HAVE_RAW_DECL_STRDUP 1

/* Define to 1 if strerror_r is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_STRERROR_R */

/* Define to 1 if strncasecmp is declared even after undefining macros. */
#define HAVE_RAW_DECL_STRNCASECMP 1

/* Define to 1 if strncat is declared even after undefining macros. */
#define HAVE_RAW_DECL_STRNCAT 1

/* Define to 1 if strndup is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_STRNDUP */

/* Define to 1 if strnlen is declared even after undefining macros. */
#define HAVE_RAW_DECL_STRNLEN 1

/* Define to 1 if strpbrk is declared even after undefining macros. */
#define HAVE_RAW_DECL_STRPBRK 1

/* Define to 1 if strsep is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_STRSEP */

/* Define to 1 if strsignal is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_STRSIGNAL */

/* Define to 1 if strtod is declared even after undefining macros. */
#define HAVE_RAW_DECL_STRTOD 1

/* Define to 1 if strtoimax is declared even after undefining macros. */
#define HAVE_RAW_DECL_STRTOIMAX 1

/* Define to 1 if strtok_r is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_STRTOK_R */

/* Define to 1 if strtoll is declared even after undefining macros. */
#define HAVE_RAW_DECL_STRTOLL 1

/* Define to 1 if strtoull is declared even after undefining macros. */
#define HAVE_RAW_DECL_STRTOULL 1

/* Define to 1 if strtoumax is declared even after undefining macros. */
#define HAVE_RAW_DECL_STRTOUMAX 1

/* Define to 1 if strverscmp is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_STRVERSCMP */

/* Define to 1 if symlink is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SYMLINK */

/* Define to 1 if symlinkat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_SYMLINKAT */

/* Define to 1 if tanf is declared even after undefining macros. */
#define HAVE_RAW_DECL_TANF 1

/* Define to 1 if tanhf is declared even after undefining macros. */
#define HAVE_RAW_DECL_TANHF 1

/* Define to 1 if tanl is declared even after undefining macros. */
#define HAVE_RAW_DECL_TANL 1

/* Define to 1 if tcgetsid is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_TCGETSID */

/* Define to 1 if tdelete is declared even after undefining macros. */
#define HAVE_RAW_DECL_TDELETE 1

/* Define to 1 if tfind is declared even after undefining macros. */
#define HAVE_RAW_DECL_TFIND 1

/* Define to 1 if times is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_TIMES */

/* Define to 1 if tmpfile is declared even after undefining macros. */
#define HAVE_RAW_DECL_TMPFILE 1

/* Define to 1 if towctrans is declared even after undefining macros. */
#define HAVE_RAW_DECL_TOWCTRANS 1

/* Define to 1 if trunc is declared even after undefining macros. */
#define HAVE_RAW_DECL_TRUNC 1

/* Define to 1 if truncf is declared even after undefining macros. */
#define HAVE_RAW_DECL_TRUNCF 1

/* Define to 1 if truncl is declared even after undefining macros. */
#define HAVE_RAW_DECL_TRUNCL 1

/* Define to 1 if tsearch is declared even after undefining macros. */
#define HAVE_RAW_DECL_TSEARCH 1

/* Define to 1 if ttyname_r is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_TTYNAME_R */

/* Define to 1 if twalk is declared even after undefining macros. */
#define HAVE_RAW_DECL_TWALK 1

/* Define to 1 if uname is declared even after undefining macros. */
#define HAVE_RAW_DECL_UNAME 1

/* Define to 1 if unlink is declared even after undefining macros. */
#define HAVE_RAW_DECL_UNLINK 1

/* Define to 1 if unlinkat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_UNLINKAT */

/* Define to 1 if unlockpt is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_UNLOCKPT */

/* Define to 1 if unsetenv is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_UNSETENV */

/* Define to 1 if usleep is declared even after undefining macros. */
#define HAVE_RAW_DECL_USLEEP 1

/* Define to 1 if utimensat is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_UTIMENSAT */

/* Define to 1 if vdprintf is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_VDPRINTF */

/* Define to 1 if vsnprintf is declared even after undefining macros. */
#define HAVE_RAW_DECL_VSNPRINTF 1

/* Define to 1 if waitpid is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_WAITPID */

/* Define to 1 if wcpcpy is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_WCPCPY */

/* Define to 1 if wcpncpy is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_WCPNCPY */

/* Define to 1 if wcrtomb is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCRTOMB 1

/* Define to 1 if wcscasecmp is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_WCSCASECMP */

/* Define to 1 if wcscat is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSCAT 1

/* Define to 1 if wcschr is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSCHR 1

/* Define to 1 if wcscmp is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSCMP 1

/* Define to 1 if wcscoll is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSCOLL 1

/* Define to 1 if wcscpy is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSCPY 1

/* Define to 1 if wcscspn is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSCSPN 1

/* Define to 1 if wcsdup is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSDUP 1

/* Define to 1 if wcslen is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSLEN 1

/* Define to 1 if wcsncasecmp is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_WCSNCASECMP */

/* Define to 1 if wcsncat is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSNCAT 1

/* Define to 1 if wcsncmp is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSNCMP 1

/* Define to 1 if wcsncpy is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSNCPY 1

/* Define to 1 if wcsnlen is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSNLEN 1

/* Define to 1 if wcsnrtombs is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_WCSNRTOMBS */

/* Define to 1 if wcspbrk is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSPBRK 1

/* Define to 1 if wcsrchr is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSRCHR 1

/* Define to 1 if wcsrtombs is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSRTOMBS 1

/* Define to 1 if wcsspn is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSSPN 1

/* Define to 1 if wcsstr is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSSTR 1

/* Define to 1 if wcstok is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSTOK 1

/* Define to 1 if wcswidth is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_WCSWIDTH */

/* Define to 1 if wcsxfrm is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCSXFRM 1

/* Define to 1 if wctob is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCTOB 1

/* Define to 1 if wctrans is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCTRANS 1

/* Define to 1 if wctype is declared even after undefining macros. */
#define HAVE_RAW_DECL_WCTYPE 1

/* Define to 1 if wcwidth is declared even after undefining macros. */
/* #undef HAVE_RAW_DECL_WCWIDTH */

/* Define to 1 if wmemchr is declared even after undefining macros. */
#define HAVE_RAW_DECL_WMEMCHR 1

/* Define to 1 if wmemcmp is declared even after undefining macros. */
#define HAVE_RAW_DECL_WMEMCMP 1

/* Define to 1 if wmemcpy is declared even after undefining macros. */
#define HAVE_RAW_DECL_WMEMCPY 1

/* Define to 1 if wmemmove is declared even after undefining macros. */
#define HAVE_RAW_DECL_WMEMMOVE 1

/* Define to 1 if wmemset is declared even after undefining macros. */
#define HAVE_RAW_DECL_WMEMSET 1

/* Define to 1 if _Exit is declared even after undefining macros. */
#define HAVE_RAW_DECL__EXIT 1

/* Define to 1 if you have the `readdir' function. */
#define HAVE_READDIR 1

/* Define to 1 if you have the 'readlink' function. */
/* #undef HAVE_READLINK */

/* Define to 1 if you have the 'readlinkat' function. */
/* #undef HAVE_READLINKAT */

/* Define to 1 if your system has a GNU libc compatible 'realloc' function,
   and to 0 otherwise. */
#define HAVE_REALLOC_GNU 1

/* Define if the 'realloc' function is POSIX compliant. */
/* #undef HAVE_REALLOC_POSIX */

/* Define to 1 if you have the 'realpath' function. */
/* #undef HAVE_REALPATH */

/* Define to 1 if the remainder() function is available in libc or libm. */
/* #undef HAVE_REMAINDER */

/* Define to 1 if you have the 'renameat' function. */
/* #undef HAVE_RENAMEAT */

/* Define to 1 if you have the `revoke' function. */
/* #undef HAVE_REVOKE */

/* Define to 1 if you have the `rewinddir' function. */
#define HAVE_REWINDDIR 1

/* Define to 1 if you have run the test for working tzset. */
#define HAVE_RUN_TZSET_TEST 1

/* Define to 1 if 'long double' and 'double' have the same representation. */
/* #undef HAVE_SAME_LONG_DOUBLE_AS_DOUBLE */

/* Define to 1 if the system has the type `sa_family_t'. */
/* #undef HAVE_SA_FAMILY_T */

/* Define to 1 if you have the `scandir' function. */
/* #undef HAVE_SCANDIR */

/* Define to 1 if you have the <sched.h> header file. */
#define HAVE_SCHED_H 1

/* Define to 1 if you have the `sched_setparam' function. */
/* #undef HAVE_SCHED_SETPARAM */

/* Define to 1 if you have the `sched_setscheduler' function. */
/* #undef HAVE_SCHED_SETSCHEDULER */

/* Define to 1 if you have the <search.h> header file. */
#define HAVE_SEARCH_H 1

/* Define to 1 if you have the 'secure_getenv' function. */
/* #undef HAVE_SECURE_GETENV */

/* Define to 1 if you have the `setegid' function. */
/* #undef HAVE_SETEGID */

/* Define to 1 if you have the 'setenv' function. */
/* #undef HAVE_SETENV */

/* Define to 1 if you have the `seteuid' function. */
/* #undef HAVE_SETEUID */

/* Define to 1 if you have the `setlocale' function. */
#define HAVE_SETLOCALE 1

/* Define to 1 if you have the 'setrlimit' function. */
/* #undef HAVE_SETRLIMIT */

/* Define to 1 if you have the 'shutdown' function. */
/* #undef HAVE_SHUTDOWN */

/* Define to 1 if you have the 'sigaction' function. */
/* #undef HAVE_SIGACTION */

/* Define to 1 if you have the 'sigaltstack' function. */
/* #undef HAVE_SIGALTSTACK */

/* Define to 1 if the system has the type `siginfo_t'. */
/* #undef HAVE_SIGINFO_T */

/* Define to 1 if you have the 'siginterrupt' function. */
/* #undef HAVE_SIGINTERRUPT */

/* Define to 1 if 'sig_atomic_t' is a signed integer type. */
/* #undef HAVE_SIGNED_SIG_ATOMIC_T */

/* Define to 1 if 'wchar_t' is a signed integer type. */
/* #undef HAVE_SIGNED_WCHAR_T */

/* Define to 1 if 'wint_t' is a signed integer type. */
/* #undef HAVE_SIGNED_WINT_T */

/* Define to 1 if the system has the type `sigset_t'. */
#define HAVE_SIGSET_T 1

/* Define to 1 if the system has the type `sig_atomic_t'. */
#define HAVE_SIG_ATOMIC_T 1

/* Define to 1 if you have the `sinf' function. */
#define HAVE_SINF 1

/* Define to 1 if you have the `sinhf' function. */
#define HAVE_SINHF 1

/* Define to 1 if you have the 'sleep' function. */
#define HAVE_SLEEP 1

/* Define to 1 if you have the `snprintf' function. */
#define HAVE_SNPRINTF 1

/* Define if the return value of the snprintf function is the number of of
   bytes (excluding the terminating NUL) that would have been produced if the
   buffer had been large enough. */
/* #undef HAVE_SNPRINTF_RETVAL_C99 */

/* Define to 1 if you have the <spawn.h> header file. */
/* #undef HAVE_SPAWN_H */

/* Define to 1 if you have the `sqrtf' function. */
#define HAVE_SQRTF 1

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define if <stdint.h> exists, doesn't clash with <sys/types.h>, and declares
   uintmax_t. */
#define HAVE_STDINT_H_WITH_UINTMAX 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the `stpcpy' function. */
/* #undef HAVE_STPCPY */

/* Define if you have the stpncpy() function and it works. */
/* #undef HAVE_STPNCPY */

/* Define to 1 if you have the `strcasecmp' function. */
#define HAVE_STRCASECMP 1

/* Define to 1 if you have the `strchrnul' function. */
/* #undef HAVE_STRCHRNUL */

/* Define to 1 if you have the `strcspn' function. */
#define HAVE_STRCSPN 1

/* Define to 1 if you have the 'strdup' function. */
#define HAVE_STRDUP 1

/* Define to 1 if you have the 'strerror_r' function. */
/* #undef HAVE_STRERROR_R */

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the `strncasecmp' function. */
#define HAVE_STRNCASECMP 1

/* Define to 1 if you have the 'strndup' function. */
/* #undef HAVE_STRNDUP */

/* Define to 1 if you have the `strnlen' function. */
#define HAVE_STRNLEN 1

/* Define to 1 if you have the `strpbrk' function. */
#define HAVE_STRPBRK 1

/* Define to 1 if you have the 'strptime' function. */
/* #undef HAVE_STRPTIME */

/* Define to 1 if you have the `strsignal' function. */
/* #undef HAVE_STRSIGNAL */

/* Define to 1 if you have the 'strtoimax' function. */
#define HAVE_STRTOIMAX 1

/* Define to 1 if you have the `strtok_r' function. */
/* #undef HAVE_STRTOK_R */

/* Define to 1 if you have the `strtol' function. */
#define HAVE_STRTOL 1

/* Define to 1 if you have the `strtoll' function. */
#define HAVE_STRTOLL 1

/* Define to 1 if you have the `strtoul' function. */
#define HAVE_STRTOUL 1

/* Define to 1 if you have the `strtoull' function. */
#define HAVE_STRTOULL 1

/* Define to 1 if you have the 'strtoumax' function. */
#define HAVE_STRTOUMAX 1

/* Define to 1 if the system has the type `struct addrinfo'. */
#define HAVE_STRUCT_ADDRINFO 1

/* Define if there is a member named d_type in the struct describing directory
   headers. */
/* #undef HAVE_STRUCT_DIRENT_D_TYPE */

/* Define to 1 if `decimal_point' is a member of `struct lconv'. */
#define HAVE_STRUCT_LCONV_DECIMAL_POINT 1

/* Define to 1 if the system has the type `struct random_data'. */
/* #undef HAVE_STRUCT_RANDOM_DATA */

/* Define to 1 if `sa_sigaction' is a member of `struct sigaction'. */
/* #undef HAVE_STRUCT_SIGACTION_SA_SIGACTION */

/* Define to 1 if `sa_len' is a member of `struct sockaddr'. */
/* #undef HAVE_STRUCT_SOCKADDR_SA_LEN */

/* Define to 1 if the system has the type `struct sockaddr_storage'. */
#define HAVE_STRUCT_SOCKADDR_STORAGE 1

/* Define to 1 if `ss_family' is a member of `struct sockaddr_storage'. */
#define HAVE_STRUCT_SOCKADDR_STORAGE_SS_FAMILY 1

/* Define to 1 if `st_atimensec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_ATIMENSEC */

/* Define to 1 if `st_atimespec.tv_nsec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_ATIMESPEC_TV_NSEC */

/* Define to 1 if `st_atim.st__tim.tv_nsec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_ATIM_ST__TIM_TV_NSEC */

/* Define to 1 if `st_atim.tv_nsec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_ATIM_TV_NSEC */

/* Define to 1 if `st_birthtimensec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_BIRTHTIMENSEC */

/* Define to 1 if `st_birthtimespec.tv_nsec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_BIRTHTIMESPEC_TV_NSEC */

/* Define to 1 if `st_birthtim.tv_nsec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_BIRTHTIM_TV_NSEC */

/* Define to 1 if the system has the type `struct tms'. */
/* #undef HAVE_STRUCT_TMS */

/* Define if struct utimbuf is declared -- usually in <utime.h>. Some systems
   have utime.h but don't declare the struct anywhere. */
#define HAVE_STRUCT_UTIMBUF 1

/* Define to 1 if the system has the type `struct utsname'. */
#define HAVE_STRUCT_UTSNAME 1

/* Define to 1 if you have the 'symlink' function. */
/* #undef HAVE_SYMLINK */

/* Define to 1 if you have the 'symlinkat' function. */
/* #undef HAVE_SYMLINKAT */

/* Define to 1 if you have the <sys/bitypes.h> header file. */
/* #undef HAVE_SYS_BITYPES_H */

/* Define to 1 if you have the <sys/cdefs.h> header file. */
#define HAVE_SYS_CDEFS_H 1

/* Define to 1 if you have the <sys/filio.h> header file. */
/* #undef HAVE_SYS_FILIO_H */

/* Define to 1 if you have the <sys/inttypes.h> header file. */
/* #undef HAVE_SYS_INTTYPES_H */

/* Define to 1 if you have the <sys/ioctl.h> header file. */
/* #undef HAVE_SYS_IOCTL_H */

/* Define to 1 if you have the <sys/mman.h> header file. */
/* #undef HAVE_SYS_MMAN_H */

/* Define to 1 if you have the <sys/param.h> header file. */
#define HAVE_SYS_PARAM_H 1

/* Define to 1 if you have the <sys/resource.h> header file. */
/* #undef HAVE_SYS_RESOURCE_H */

/* Define to 1 if you have the <sys/select.h> header file. */
/* #undef HAVE_SYS_SELECT_H */

/* Define to 1 if you have the <sys/socket.h> header file. */
/* #undef HAVE_SYS_SOCKET_H */

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/timeb.h> header file. */
#define HAVE_SYS_TIMEB_H 1

/* Define to 1 if you have the <sys/times.h> header file. */
/* #undef HAVE_SYS_TIMES_H */

/* Define to 1 if you have the <sys/time.h> header file. */
#define HAVE_SYS_TIME_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <sys/uio.h> header file. */
/* #undef HAVE_SYS_UIO_H */

/* Define to 1 if you have the <sys/utsname.h> header file. */
#define HAVE_SYS_UTSNAME_H 1

/* Define to 1 if you have the <sys/wait.h> header file. */
/* #undef HAVE_SYS_WAIT_H */

/* Define to 1 if you have the `tanf' function. */
#define HAVE_TANF 1

/* Define to 1 if you have the `tanhf' function. */
#define HAVE_TANHF 1

/* Define to 1 if you have the `tcgetsid' function. */
/* #undef HAVE_TCGETSID */

/* Define to 1 if you have the <termios.h> header file. */
/* #undef HAVE_TERMIOS_H */

/* Define to 1 if you have the `timer_settime' function. */
/* #undef HAVE_TIMER_SETTIME */

/* Define to 1 if you have the 'times' function. */
/* #undef HAVE_TIMES */

/* Define if struct tm has the tm_gmtoff member. */
/* #undef HAVE_TM_GMTOFF */

/* Define to 1 if you have the `towlower' function. */
#define HAVE_TOWLOWER 1

/* Define to 1 if you have the `tsearch' function. */
#define HAVE_TSEARCH 1

/* Define to 1 if you have the `ttyname' function. */
/* #undef HAVE_TTYNAME */

/* Define to 1 if you have the `ttyname_r' function. */
/* #undef HAVE_TTYNAME_R */

/* Define to 1 if you have the `uname' function. */
/* #undef HAVE_UNAME */

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to 1 if you have the 'unlinkat' function. */
/* #undef HAVE_UNLINKAT */

/* Define to 1 if you have the `unlockpt' function. */
/* #undef HAVE_UNLOCKPT */

/* Define to 1 if you have the `unsetenv' function. */
/* #undef HAVE_UNSETENV */

/* Define to 1 if the system has the type 'unsigned long long int'. */
#define HAVE_UNSIGNED_LONG_LONG_INT 1

/* Define to 1 if you have the `uselocale' function. */
/* #undef HAVE_USELOCALE */

/* Define to 1 if you have the 'usleep' function. */
#define HAVE_USLEEP 1

/* Define to 1 if you have the 'utimensat' function. */
/* #undef HAVE_UTIMENSAT */

/* Define to 1 if you have the <utime.h> header file. */
#define HAVE_UTIME_H 1

/* Define to 1 if you have the 'vasnprintf' function. */
/* #undef HAVE_VASNPRINTF */

/* Define to 1 if you have the 'vdprintf' function. */
/* #undef HAVE_VDPRINTF */

/* Define to 1 if you have the `vfork' function. */
/* #undef HAVE_VFORK */

/* Define to 1 if you have the `vsnprintf' function. */
#define HAVE_VSNPRINTF 1

/* Define to 1 if you have the `waitid' function. */
/* #undef HAVE_WAITID */

/* Define to 1 if you have the <wchar.h> header file. */
#define HAVE_WCHAR_H 1

/* Define if you have the 'wchar_t' type. */
#define HAVE_WCHAR_T 1

/* Define to 1 if you have the 'wcpcpy' function. */
/* #undef HAVE_WCPCPY */

/* Define to 1 if you have the 'wcpncpy' function. */
/* #undef HAVE_WCPNCPY */

/* Define to 1 if you have the 'wcrtomb' function. */
#define HAVE_WCRTOMB 1

/* Define to 1 if you have the 'wcscasecmp' function. */
/* #undef HAVE_WCSCASECMP */

/* Define to 1 if you have the 'wcscat' function. */
#define HAVE_WCSCAT 1

/* Define to 1 if you have the 'wcschr' function. */
#define HAVE_WCSCHR 1

/* Define to 1 if you have the 'wcscmp' function. */
#define HAVE_WCSCMP 1

/* Define to 1 if you have the 'wcscoll' function. */
#define HAVE_WCSCOLL 1

/* Define to 1 if you have the 'wcscpy' function. */
#define HAVE_WCSCPY 1

/* Define to 1 if you have the 'wcscspn' function. */
#define HAVE_WCSCSPN 1

/* Define to 1 if you have the 'wcsdup' function. */
#define HAVE_WCSDUP 1

/* Define to 1 if you have the 'wcslen' function. */
#define HAVE_WCSLEN 1

/* Define to 1 if you have the 'wcsncasecmp' function. */
/* #undef HAVE_WCSNCASECMP */

/* Define to 1 if you have the 'wcsncat' function. */
#define HAVE_WCSNCAT 1

/* Define to 1 if you have the 'wcsncmp' function. */
#define HAVE_WCSNCMP 1

/* Define to 1 if you have the 'wcsncpy' function. */
#define HAVE_WCSNCPY 1

/* Define to 1 if you have the 'wcsnlen' function. */
#define HAVE_WCSNLEN 1

/* Define to 1 if you have the 'wcsnrtombs' function. */
/* #undef HAVE_WCSNRTOMBS */

/* Define to 1 if you have the 'wcspbrk' function. */
#define HAVE_WCSPBRK 1

/* Define to 1 if you have the 'wcsrchr' function. */
#define HAVE_WCSRCHR 1

/* Define to 1 if you have the 'wcsrtombs' function. */
#define HAVE_WCSRTOMBS 1

/* Define to 1 if you have the 'wcsspn' function. */
#define HAVE_WCSSPN 1

/* Define to 1 if you have the 'wcsstr' function. */
#define HAVE_WCSSTR 1

/* Define to 1 if you have the 'wcstok' function. */
#define HAVE_WCSTOK 1

/* Define to 1 if you have the 'wcswidth' function. */
/* #undef HAVE_WCSWIDTH */

/* Define to 1 if you have the 'wcsxfrm' function. */
#define HAVE_WCSXFRM 1

/* Define to 1 if you have the 'wctob' function. */
#define HAVE_WCTOB 1

/* Define to 1 if you have the <wctype.h> header file. */
#define HAVE_WCTYPE_H 1

/* Define to 1 if you have the 'wcwidth' function. */
/* #undef HAVE_WCWIDTH */

/* Define to 1 if you have the <winsock2.h> header file. */
#define HAVE_WINSOCK2_H 1

/* Define if you have the 'wint_t' type. */
#define HAVE_WINT_T 1

/* Define to 1 if you have the 'wmemchr' function. */
#define HAVE_WMEMCHR 1

/* Define to 1 if you have the 'wmemcpy' function. */
#define HAVE_WMEMCPY 1

/* Define to 1 if you have the 'wmempcpy' function. */
#define HAVE_WMEMPCPY 1

/* Define to 1 if fstatat (..., 0) works. For example, it does not work in AIX
   7.1. */
/* #undef HAVE_WORKING_FSTATAT_ZERO_FLAG */

/* Define to 1 if O_NOATIME works. */
#define HAVE_WORKING_O_NOATIME 0

/* Define to 1 if O_NOFOLLOW works. */
#define HAVE_WORKING_O_NOFOLLOW 0

/* Define if you have the posix_spawn and posix_spawnp functions and they
   work. */
/* #undef HAVE_WORKING_POSIX_SPAWN */

/* Define if utimes works properly. */
/* #undef HAVE_WORKING_UTIMES */

/* Define to 1 if you have the <ws2tcpip.h> header file. */
#define HAVE_WS2TCPIP_H 1

/* Define to 1 if you have the <xlocale.h> header file. */
/* #undef HAVE_XLOCALE_H */

/* Define to 1 if the system has the type `_Bool'. */
#define HAVE__BOOL 1

/* Define to 1 if you have the `_Exit' function. */
#define HAVE__EXIT 1

/* Define to 1 if you have the `_fseeki64' function. */
#define HAVE__FSEEKI64 1

/* Define to 1 if you have the `_ftelli64' function. */
/* #undef HAVE__FTELLI64 */

/* Define to 1 if you have the `_ftime' function. */
#define HAVE__FTIME 1

/* Define to 1 if you have the '_set_invalid_parameter_handler' function. */
/* #undef HAVE__SET_INVALID_PARAMETER_HANDLER */

/* Define to 1 if you have the '__fpurge' function. */
/* #undef HAVE___FPURGE */

/* Define to 1 if you have the '__freading' function. */
/* #undef HAVE___FREADING */

/* Define to 1 if you have the '__fseterr' function. */
/* #undef HAVE___FSETERR */

/* Define to 1 if you have the `__secure_getenv' function. */
/* #undef HAVE___SECURE_GETENV */

/* Define to 1 if you have the '__xpg_strerror_r' function. */
/* #undef HAVE___XPG_STRERROR_R */

/* Define HOST_NAME_MAX when <limits.h> does not define it. */
#define HOST_NAME_MAX 256

/* Define as const if the declaration of iconv() needs const. */
#define ICONV_CONST

/* Define to a symbolic name denoting the flavor of iconv_open()
   implementation. */
/* #undef ICONV_FLAVOR */

/* Define to 1 if isatty() may fail without setting errno. */
/* #undef ISATTY_FAILS_WITHOUT_SETTING_ERRNO */

/* Define as the bit index in the word where to find bit 0 of the exponent of
   'long double'. */
#define LDBL_EXPBIT0_BIT 0

/* Define as the word index where to find the exponent of 'long double'. */
#define LDBL_EXPBIT0_WORD 2

/* Define as the bit index in the word where to find the sign of 'long
   double'. */
/* #undef LDBL_SIGNBIT_BIT */

/* Define as the word index where to find the sign of 'long double'. */
/* #undef LDBL_SIGNBIT_WORD */

/* Define to 1 if linkat fails to recognize a trailing slash. */
/* #undef LINKAT_TRAILING_SLASH_BUG */

/* Define to 1 if 'link(2)' dereferences symbolic links, 0 if it creates hard
   links to symlinks, -1 if it depends on the variable __xpg4, and -2 if
   unknown. */
#define LINK_FOLLOWS_SYMLINKS 0

/* Define to 1 if lseek does not detect pipes. */
#define LSEEK_PIPE_BROKEN 1

/* Define to 1 if 'lstat' dereferences a symlink specified with a trailing
   slash. */
/* #undef LSTAT_FOLLOWS_SLASHED_SYMLINK */

/* If malloc(0) is != NULL, define this to 1. Otherwise define this to 0. */
#define MALLOC_0_IS_NONNULL 1

/* Define to a substitute value for mmap()'s MAP_ANONYMOUS flag. */
/* #undef MAP_ANONYMOUS */

/* Define if the mbrtowc function has the NULL pwc argument bug. */
/* #undef MBRTOWC_NULL_ARG1_BUG */

/* Define if the mbrtowc function has the NULL string argument bug. */
/* #undef MBRTOWC_NULL_ARG2_BUG */

/* Define if the mbrtowc function does not return 0 for a NUL character. */
/* #undef MBRTOWC_NUL_RETVAL_BUG */

/* Define if the mbrtowc function returns a wrong return value. */
#define MBRTOWC_RETVAL_BUG 1

/* Define to 1 if mkfifo does not reject trailing slash */
/* #undef MKFIFO_TRAILING_SLASH_BUG */

/* Define to 1 if mknod cannot create a fifo without super-user privileges */
/* #undef MKNOD_FIFO_BUG */

/* Define if the vasnprintf implementation needs special code for the 'a' and
   'A' directives. */
#define NEED_PRINTF_DIRECTIVE_A 1

/* Define if the vasnprintf implementation needs special code for the 'F'
   directive. */
#define NEED_PRINTF_DIRECTIVE_F 1

/* Define if the vasnprintf implementation needs special code for the 'ls'
   directive. */
/* #undef NEED_PRINTF_DIRECTIVE_LS */

/* Define if the vasnprintf implementation needs special code for 'double'
   arguments. */
#define NEED_PRINTF_DOUBLE 1

/* Define if the vasnprintf implementation needs special code for surviving
   out-of-memory conditions. */
#define NEED_PRINTF_ENOMEM 1

/* Define if the vasnprintf implementation needs special code for the ' flag.
   */
#define NEED_PRINTF_FLAG_GROUPING 1

/* Define if the vasnprintf implementation needs special code for the '-'
   flag. */
/* #undef NEED_PRINTF_FLAG_LEFTADJUST */

/* Define if the vasnprintf implementation needs special code for the 0 flag.
   */
#define NEED_PRINTF_FLAG_ZERO 1

/* Define if the vasnprintf implementation needs special code for infinite
   'double' arguments. */
#define NEED_PRINTF_INFINITE_DOUBLE 1

/* Define if the vasnprintf implementation needs special code for infinite
   'long double' arguments. */
/* #undef NEED_PRINTF_INFINITE_LONG_DOUBLE */

/* Define if the vasnprintf implementation needs special code for 'long
   double' arguments. */
#define NEED_PRINTF_LONG_DOUBLE 1

/* Define if the vasnprintf implementation needs special code for supporting
   large precisions without arbitrary bounds. */
#define NEED_PRINTF_UNBOUNDED_PRECISION 1

/* Define to 1 if your C compiler doesn't accept -c and -o together. */
/* #undef NO_MINUS_C_MINUS_O */

/* Define to 1 if open() fails to recognize a trailing slash. */
/* #undef OPEN_TRAILING_SLASH_BUG */

/* Name of package */
#define PACKAGE "dummy"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""

/* Define to the full name of this package. */
#define PACKAGE_NAME "dummy"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "dummy 0"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "dummy"

/* Define to the home page for this package. */
#define PACKAGE_URL ""

/* Define to the version of this package. */
#define PACKAGE_VERSION "0"

/* Define if <inttypes.h> exists and defines unusable PRI* macros. */
/* #undef PRI_MACROS_BROKEN */

/* Define to the type that is the result of default argument promotions of
   type mode_t. */
#define PROMOTED_MODE_T int

/* Define if the pthread_in_use() detection is hard. */
/* #undef PTHREAD_IN_USE_DETECTION_HARD */

/* Define to 1 if pthread_sigmask(), when it fails, returns -1 and sets errno.
   */
/* #undef PTHREAD_SIGMASK_FAILS_WITH_ERRNO */

/* Define to 1 if pthread_sigmask() may returns 0 and have no effect. */
/* #undef PTHREAD_SIGMASK_INEFFECTIVE */

/* Define to 1 if pthread_sigmask() unblocks signals incorrectly. */
/* #undef PTHREAD_SIGMASK_UNBLOCK_BUG */

/* Define to l, ll, u, ul, ull, etc., as suitable for constants of type
   'ptrdiff_t'. */
/* #undef PTRDIFF_T_SUFFIX */

/* Define to 1 if readlink fails to recognize a trailing slash. */
/* #undef READLINK_TRAILING_SLASH_BUG */

/* Define if rename does not work when the destination file exists, as on
   Cygwin 1.5 or Windows. */
#define RENAME_DEST_EXISTS_BUG 1

/* Define if rename fails to leave hard links alone, as on NetBSD 1.6 or
   Cygwin 1.5. */
/* #undef RENAME_HARD_LINK_BUG */

/* Define if rename does not correctly handle slashes on the destination
   argument, such as on Solaris 10 or NetBSD 1.6. */
#define RENAME_TRAILING_SLASH_DEST_BUG 1

/* Define if rename does not correctly handle slashes on the source argument,
   such as on Solaris 9 or cygwin 1.5. */
/* #undef RENAME_TRAILING_SLASH_SOURCE_BUG */

/* Define to 1 if gnulib's fchdir() replacement is used. */
#define REPLACE_FCHDIR 1

/* Define if fprintf is overridden by a POSIX compliant gnulib implementation.
   */
#define REPLACE_FPRINTF_POSIX 1

/* Define to 1 if stat needs help when passed a directory name with a trailing
   slash */
#define REPLACE_FUNC_STAT_DIR 1

/* Define to 1 if stat needs help when passed a file name with a trailing
   slash */
/* #undef REPLACE_FUNC_STAT_FILE */

/* Define if the iconv() functions are enhanced to handle the
   UTF-{16,32}{BE,LE} encodings. */
/* #undef REPLACE_ICONV_UTF */

/* Define if nl_langinfo exists but is overridden by gnulib. */
/* #undef REPLACE_NL_LANGINFO */

/* Define to 1 if open() should work around the inability to open a directory.
   */
#define REPLACE_OPEN_DIRECTORY 1

/* Define if printf is overridden by a POSIX compliant gnulib implementation.
   */
#define REPLACE_PRINTF_POSIX 1

/* Define to 1 if strerror(0) does not return a message implying success. */
/* #undef REPLACE_STRERROR_0 */

/* Define if vasnprintf exists but is overridden by gnulib. */
/* #undef REPLACE_VASNPRINTF */

/* Define if vfprintf is overridden by a POSIX compliant gnulib
   implementation. */
//#define REPLACE_VFPRINTF_POSIX 1

/* Define if vprintf is overridden by a POSIX compliant gnulib implementation.
   */
#define REPLACE_VPRINTF_POSIX 1

/* Define to l, ll, u, ul, ull, etc., as suitable for constants of type
   'sig_atomic_t'. */
/* #undef SIG_ATOMIC_T_SUFFIX */

/* Define as the maximum value of type 'size_t', if the system doesn't define
   it. */
#ifndef SIZE_MAX
/* # undef SIZE_MAX */
#endif

/* Define to l, ll, u, ul, ull, etc., as suitable for constants of type
   'size_t'. */
/* #undef SIZE_T_SUFFIX */

/* If using the C implementation of alloca, define if you know the
   direction of stack growth for your system; otherwise it will be
   automatically deduced at runtime.
    STACK_DIRECTION > 0 => grows toward higher addresses
    STACK_DIRECTION < 0 => grows toward lower addresses
    STACK_DIRECTION = 0 => direction of growth unknown */
/* #undef STACK_DIRECTION */

/* Define to 1 if the `S_IS*' macros in <sys/stat.h> do not work properly. */
/* #undef STAT_MACROS_BROKEN */

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Define to 1 if strerror_r returns char *. */
/* #undef STRERROR_R_CHAR_P */

/* Define to 1 if the type of the st_atim member of a struct stat is struct
   timespec. */
/* #undef TYPEOF_STRUCT_STAT_ST_ATIM_IS_STRUCT_TIMESPEC */

/* Define if tzset clobbers localtime's static buffer. */
/* #undef TZSET_CLOBBERS_LOCALTIME */

/* Define to 1 if unlink (dir) cannot possibly succeed. */
#define UNLINK_CANNOT_UNLINK_DIR 1

/* Define to 1 if unlink() on a parent directory may succeed */
/* #undef UNLINK_PARENT_BUG */

/* Define to the prefix of C symbols at the assembler and linker level, either
   an underscore or empty. */
#define USER_LABEL_PREFIX

/* Define if the POSIX multithreading library can be used. */
#define USE_POSIX_THREADS 1

/* Define if references to the POSIX multithreading library should be made
   weak. */
/* #undef USE_POSIX_THREADS_WEAK */

/* Define if the GNU Pth multithreading library can be used. */
/* #undef USE_PTH_THREADS */

/* Define if references to the GNU Pth multithreading library should be made
   weak. */
/* #undef USE_PTH_THREADS_WEAK */

/* Define if the old Solaris multithreading library can be used. */
/* #undef USE_SOLARIS_THREADS */

/* Define if references to the old Solaris multithreading library should be
   made weak. */
/* #undef USE_SOLARIS_THREADS_WEAK */

/* Enable extensions on AIX 3, Interix.  */
#ifndef _ALL_SOURCE
# define _ALL_SOURCE 1
#endif
/* Enable general extensions on OS X.  */
#ifndef _DARWIN_C_SOURCE
# define _DARWIN_C_SOURCE 1
#endif
/* Enable GNU extensions on systems that have them.  */
#ifndef _GNU_SOURCE
# define _GNU_SOURCE 1
#endif
/* Enable threading extensions on Solaris.  */
#ifndef _POSIX_PTHREAD_SEMANTICS
# define _POSIX_PTHREAD_SEMANTICS 1
#endif
/* Enable extensions on HP NonStop.  */
#ifndef _TANDEM_SOURCE
# define _TANDEM_SOURCE 1
#endif
/* Enable X/Open extensions if necessary.  HP-UX 11.11 defines
   mbstate_t only if _XOPEN_SOURCE is defined to 500, regardless of
   whether compiling with -Ae or -D_HPUX_SOURCE=1.  */
#ifndef _XOPEN_SOURCE
/* # undef _XOPEN_SOURCE */
#endif
/* Enable general extensions on Solaris.  */
#ifndef __EXTENSIONS__
# define __EXTENSIONS__ 1
#endif


/* Define if the native Windows multithreading API can be used. */
/* #undef USE_WINDOWS_THREADS */

/* Version number of package */
#define VERSION "0"

/* Define to 1 if unsetenv returns void instead of int. */
/* #undef VOID_UNSETENV */

/* Define to l, ll, u, ul, ull, etc., as suitable for constants of type
   'wchar_t'. */
/* #undef WCHAR_T_SUFFIX */

/* Define if the wcsrtombs function has the NULL destination argument bug. */
#define WCSRTOMBS_NULL_ARG_BUG 1

/* Define if the wcsrtombs function may set the source pointer to NULL without
   NUL-terminating the destination. */
/* #undef WCSRTOMBS_TERMINATION_BUG */

/* Define if WSAStartup is needed. */
#define WINDOWS_SOCKETS 1

/* Define to l, ll, u, ul, ull, etc., as suitable for constants of type
   'wint_t'. */
/* #undef WINT_T_SUFFIX */

/* Define WORDS_BIGENDIAN to 1 if your processor stores words with the most
   significant byte first (like Motorola and SPARC, unlike Intel). */
#if defined AC_APPLE_UNIVERSAL_BUILD
# if defined __BIG_ENDIAN__
#  define WORDS_BIGENDIAN 1
# endif
#else
# ifndef WORDS_BIGENDIAN
/* #  undef WORDS_BIGENDIAN */
# endif
#endif

/* Enable large inode numbers on Mac OS X 10.5. */
#define _DARWIN_USE_64_BIT_INODE 1

/* Number of bits in a file offset, on hosts where this is settable. */
#define _FILE_OFFSET_BITS 64

/* Define to 1 if Gnulib overrides 'struct stat' on Windows so that struct
   stat.st_size becomes 64-bit. */
#define _GL_WINDOWS_64_BIT_ST_SIZE 1

/* Define to 1 to make fseeko visible on some hosts (e.g. glibc 2.2). */
/* #undef _LARGEFILE_SOURCE */

/* Define for large files, on AIX-style hosts. */
/* #undef _LARGE_FILES */

/* Define to 1 on Solaris. */
/* #undef _LCONV_C99 */

/* Define to 1 if on MINIX. */
/* #undef _MINIX */

/* Define to 1 to make NetBSD features available. MINIX 3 needs this. */
/* #undef _NETBSD_SOURCE */

/* The _Noreturn keyword of C11.  */
#if ! (defined _Noreturn \
       || (defined __STDC_VERSION__ && 201112 <= __STDC_VERSION__))
# if (3 <= __GNUC__ || (__GNUC__ == 2 && 8 <= __GNUC_MINOR__) \
      || 0x5110 <= __SUNPRO_C)
#  define _Noreturn __attribute__ ((__noreturn__))
# elif defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn
# endif
#endif


/* Define to 2 if the system does not provide POSIX.1 features except with
   this defined. */
/* #undef _POSIX_1_SOURCE */

/* Define to 1 in order to get the POSIX compatible declarations of socket
   functions. */
/* #undef _POSIX_PII_SOCKET */

/* Define to 1 if you need to in order for 'stat' and other things to work. */
/* #undef _POSIX_SOURCE */

/* Define if you want <regex.h> to include <limits.h>, so that it consistently
   overrides <limits.h>'s RE_DUP_MAX. */
#define _REGEX_INCLUDE_LIMITS_H 1

/* Define if you want regoff_t to be at least as wide POSIX requires. */
#define _REGEX_LARGE_OFFSETS 1

/* Define to rpl_ if the getopt replacement functions and variables should be
   used. */
/* #undef __GETOPT_PREFIX */

/* Please see the Gnulib manual for how to use these macros.

   Suppress extern inline with HP-UX cc, as it appears to be broken; see
   <http://lists.gnu.org/archive/html/bug-texinfo/2013-02/msg00030.html>.

   Suppress extern inline with Sun C in standards-conformance mode, as it
   mishandles inline functions that call each other.  E.g., for 'inline void f
   (void) { } inline void g (void) { f (); }', c99 incorrectly complains
   'reference to static identifier "f" in extern inline function'.
   This bug was observed with Sun C 5.12 SunOS_i386 2011/11/16.

   Suppress the use of extern inline on Apple's platforms, as Libc at least
   through Libc-825.26 (2013-04-09) is incompatible with it; see, e.g.,
   <http://lists.gnu.org/archive/html/bug-gnulib/2012-12/msg00023.html>.
   Perhaps Apple will fix this some day.  */
#if ((__GNUC__ \
      ? defined __GNUC_STDC_INLINE__ && __GNUC_STDC_INLINE__ \
      : (199901L <= __STDC_VERSION__ \
         && !defined __HP_cc \
         && !(defined __SUNPRO_C && __STDC__))) \
     && !defined __APPLE__)
# define _GL_INLINE inline
# define _GL_EXTERN_INLINE extern inline
#elif (2 < __GNUC__ + (7 <= __GNUC_MINOR__) && !defined __STRICT_ANSI__ \
       && !defined __APPLE__)
# if __GNUC_GNU_INLINE__
   /* __gnu_inline__ suppresses a GCC 4.2 diagnostic.  */
#  define _GL_INLINE extern inline __attribute__ ((__gnu_inline__))
# else
#  define _GL_INLINE extern inline
# endif
# define _GL_EXTERN_INLINE extern
#else
# define _GL_INLINE static _GL_UNUSED
# define _GL_EXTERN_INLINE static _GL_UNUSED
#endif

#if 4 < __GNUC__ + (6 <= __GNUC_MINOR__)
# if defined __GNUC_STDC_INLINE__ && __GNUC_STDC_INLINE__
#  define _GL_INLINE_HEADER_CONST_PRAGMA
# else
#  define _GL_INLINE_HEADER_CONST_PRAGMA \
     _Pragma ("GCC diagnostic ignored \"-Wsuggest-attribute=const\"")
# endif
  /* Suppress GCC's bogus "no previous prototype for 'FOO'"
     and "no previous declaration for 'FOO'"  diagnostics,
     when FOO is an inline function in the header; see
     <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=54113>.  */
# define _GL_INLINE_HEADER_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wmissing-prototypes\"") \
    _Pragma ("GCC diagnostic ignored \"-Wmissing-declarations\"") \
    _GL_INLINE_HEADER_CONST_PRAGMA
# define _GL_INLINE_HEADER_END \
    _Pragma ("GCC diagnostic pop")
#else
# define _GL_INLINE_HEADER_BEGIN
# define _GL_INLINE_HEADER_END
#endif

/* Define to a replacement function name for fnmatch(). */
#define fnmatch posix_fnmatch

/* Define to rpl_free if the replacement function should be used. */
/* #undef free */

/* Define to `int' if <sys/types.h> doesn't define. */
#define gid_t int

/* A replacement for va_copy, if needed.  */
#define gl_va_copy(a,b) ((a) = (b))

/* Define to rpl_gmtime if the replacement function should be used. */
/* #undef gmtime */

/* Define to `__inline__' or `__inline' if that's what the C compiler
   calls it, or to nothing if 'inline' is not supported under any name.  */
#ifndef __cplusplus
/* #undef inline */
#endif

/* Define to long or long long if <stdint.h> and <inttypes.h> don't define. */
/* #undef intmax_t */

/* Work around a bug in Apple GCC 4.0.1 build 5465: In C99 mode, it supports
   the ISO C 99 semantics of 'extern inline' (unlike the GNU C semantics of
   earlier versions), but does not display it by setting __GNUC_STDC_INLINE__.
   __APPLE__ && __MACH__ test for Mac OS X.
   __APPLE_CC__ tests for the Apple compiler and its version.
   __STDC_VERSION__ tests for the C99 mode.  */
#if defined __APPLE__ && defined __MACH__ && __APPLE_CC__ >= 5465 && !defined __cplusplus && __STDC_VERSION__ >= 199901L && !defined __GNUC_STDC_INLINE__
# define __GNUC_STDC_INLINE__ 1
#endif

/* Define to rpl_localtime if the replacement function should be used. */
/* #undef localtime */

/* Define to a type if <wchar.h> does not define. */
/* #undef mbstate_t */

/* Define to rpl_memcmp if the replacement function should be used. */
/* #undef memcmp */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef mode_t */

/* Define to the type of st_nlink in struct stat, or a supertype. */
#define nlink_t int

/* Define to `long int' if <sys/types.h> does not define. */
/* #undef off_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef pid_t */

/* Define as the type of the result of subtracting two pointers, if the system
   doesn't define it. */
/* #undef ptrdiff_t */

/* Define to rpl_re_comp if the replacement should be used. */
#define re_comp rpl_re_comp

/* Define to rpl_re_compile_fastmap if the replacement should be used. */
#define re_compile_fastmap rpl_re_compile_fastmap

/* Define to rpl_re_compile_pattern if the replacement should be used. */
#define re_compile_pattern rpl_re_compile_pattern

/* Define to rpl_re_exec if the replacement should be used. */
#define re_exec rpl_re_exec

/* Define to rpl_re_match if the replacement should be used. */
#define re_match rpl_re_match

/* Define to rpl_re_match_2 if the replacement should be used. */
#define re_match_2 rpl_re_match_2

/* Define to rpl_re_search if the replacement should be used. */
#define re_search rpl_re_search

/* Define to rpl_re_search_2 if the replacement should be used. */
#define re_search_2 rpl_re_search_2

/* Define to rpl_re_set_registers if the replacement should be used. */
#define re_set_registers rpl_re_set_registers

/* Define to rpl_re_set_syntax if the replacement should be used. */
#define re_set_syntax rpl_re_set_syntax

/* Define to rpl_re_syntax_options if the replacement should be used. */
#define re_syntax_options rpl_re_syntax_options

/* Define to rpl_regcomp if the replacement should be used. */
#define regcomp rpl_regcomp

/* Define to rpl_regerror if the replacement should be used. */
#define regerror rpl_regerror

/* Define to rpl_regexec if the replacement should be used. */
#define regexec rpl_regexec

/* Define to rpl_regfree if the replacement should be used. */
#define regfree rpl_regfree

/* Define to the equivalent of the C99 'restrict' keyword, or to
   nothing if this is not supported.  Do not define if restrict is
   supported directly.  */
#define restrict __restrict
/* Work around a bug in Sun C++: it does not support _Restrict or
   __restrict__, even though the corresponding Sun C compiler ends up with
   "#define restrict _Restrict" or "#define restrict __restrict__" in the
   previous line.  Perhaps some future version of Sun C++ will work with
   restrict; if so, hopefully it defines __RESTRICT like Sun C does.  */
#if defined __SUNPRO_CC && !defined __RESTRICT
# define _Restrict
# define __restrict__
#endif

/* Define as an integer type suitable for memory locations that can be
   accessed atomically even in the presence of asynchronous signals. */
/* #undef sig_atomic_t */

/* Define to `unsigned int' if <sys/types.h> does not define. */
/* #undef size_t */

/* type to use in place of socklen_t if not defined */
/* #undef socklen_t */

/* Define as a signed type of the same size as size_t. */
/* #undef ssize_t */

/* Define to rpl_tzset if the wrapper function should be used. */
/* #undef tzset */

/* Define to `int' if <sys/types.h> doesn't define. */
#define uid_t int

/* Define as a marker that can be attached to declarations that might not
    be used.  This helps to reduce warnings, such as from
    GCC -Wunused-parameter.  */
#if __GNUC__ >= 3 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 7)
# define _GL_UNUSED __attribute__ ((__unused__))
#else
# define _GL_UNUSED
#endif
/* The name _UNUSED_PARAMETER_ is an earlier spelling, although the name
   is a misnomer outside of parameter lists.  */
#define _UNUSED_PARAMETER_ _GL_UNUSED

/* The __pure__ attribute was added in gcc 2.96.  */
#if __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 96)
# define _GL_ATTRIBUTE_PURE __attribute__ ((__pure__))
#else
# define _GL_ATTRIBUTE_PURE /* empty */
#endif

/* The __const__ attribute was added in gcc 2.95.  */
#if __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 95)
# define _GL_ATTRIBUTE_CONST __attribute__ ((__const__))
#else
# define _GL_ATTRIBUTE_CONST /* empty */
#endif


/* Define to an unsigned 32-bit type if <sys/types.h> lacks this type. */
/* #undef useconds_t */

/* Define as a macro for copying va_list variables. */
/* #undef va_copy */

#endif

#ifndef _MINGLE_STAT
#define _MINGLE_STAT

#include <mingle/config.h>
#include_next<sys/stat.h>
#include<errno.h>

#undef S_ISLNK
#define S_IFLNK    0120000 /* Symbolic link */
#define S_ISLNK(m) (((m) & S_IFMT) == S_IFLNK)

int mingw_lstat(const char *file_name, struct stat *buf);
int mingw_stat(const char *file_name, struct stat *buf);
int mingw_fstat(int fd, struct stat *buf);

#define lstat mingw_lstat

#endif
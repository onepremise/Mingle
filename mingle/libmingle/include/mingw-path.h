#if __GNUC__ >= 3
#pragma GCC system_header
#endif

#ifndef _GL_MINGW_PATH_H
#define _GL_MINGW_PATH_H

#if defined __cplusplus
# define _GL_EXTERN_C extern "C"
#else
# define _GL_EXTERN_C extern
#endif

#include <sys/types.h>

#define PATH_CONVERSION_LEN 1024

typedef struct Fstab
{
    char dest[PATH_CONVERSION_LEN];
    char link[PATH_CONVERSION_LEN];
} Fstab;

_GL_EXTERN_C int doesFileExist(const char *filename);

_GL_EXTERN_C char *mingw_rootpath();
_GL_EXTERN_C char *msys_rootpath();

_GL_EXTERN_C void readFstab();
_GL_EXTERN_C int getNumMounts();
_GL_EXTERN_C Fstab *getMounts();
_GL_EXTERN_C char *resolveMounts(const char *path, char *resolved, int size);

_GL_EXTERN_C char *mingw_resolveRoot(const char *oldpath, char *newpath, int size);

_GL_EXTERN_C char *mingw_realpath(const char *testpath, char *destination, int size);
_GL_EXTERN_C char *msys_realpath(const char *testpath, char *destination, int size);

_GL_EXTERN_C int mingw_posx2winpath(const char *mingwpath, char *destination, int size);

_GL_EXTERN_C int mkpath(const char *s, mode_t mode);
_GL_EXTERN_C int rmpath(const char *s);

#endif
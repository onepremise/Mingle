#ifndef _MINGLE_UIO
#define _MINGLE_UIO

#include <mingle/config.h>

#if defined __cplusplus
# define _GL_EXTERN_C extern "C"
#else
# define _GL_EXTERN_C extern
#endif

struct iovec {
    char  *iov_base;
    int  iov_len;
};

_GL_EXTERN_C ssize_t readv(int, const struct iovec *, int);
_GL_EXTERN_C ssize_t writev (int FileDescriptor, const struct iovec * iov, int iovCount);

#endif
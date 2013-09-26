#ifndef _MINGLE_UIO
#define _MINGLE_UIO

#include <mingle/config.h>

struct iovec {
    char  *iov_base;
    int  iov_len;
};

ssize_t readv(int, const struct iovec *, int);
ssize_t writev (int FileDescriptor, const struct iovec * iov, int iovCount);

#endif
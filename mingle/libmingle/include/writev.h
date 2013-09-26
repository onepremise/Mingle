#define MINGW_CLEAR_ERRNO {WSASetLastError(errno = 0);}
#define MINGW_CAPTURE_ERRNO {errno = WSAGetLastError(); WSASetLastError(errno);}

int writev (int FileDescriptor, const struct iovec * iov, int iovCount);
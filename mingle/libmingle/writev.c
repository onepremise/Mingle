#include<sys/uio.h>
#include<errno.h>
#include<winsock2.h>

//Version from Monotone, http://www.monotone.ca/
#define MINGW_CLEAR_ERRNO {WSASetLastError(errno = 0);}
#define MINGW_CAPTURE_ERRNO {errno = WSAGetLastError(); WSASetLastError(errno);}

//Version from Monotone, http://www.monotone.ca/
ssize_t m_writev(int FileDescriptor, const struct iovec * iov, int iovCount)
{
       size_t total_len = 0;
       int bytes_written = 0;
       int i = 0, r = 0;
       char *buf = NULL, *p = NULL;

       for(; i < iovCount; i)
               total_len = iov[i].iov_len;

       p = buf = (char *)alloca(total_len);

       for(; i < iovCount; i)
       {
               memcpy(p, iov[i].iov_base, iov[i].iov_len);
               p = iov[i].iov_len;
       }

       MINGW_CLEAR_ERRNO
       r = send(FileDescriptor, buf, total_len, 0);
       MINGW_CAPTURE_ERRNO;
       return r;
}

//QEMU low level functions www.qemu.org
/* helper function for iov_send_recv() */
static ssize_t readv_writev(int fd, const struct iovec *iov, int iov_cnt, int do_write)
{
    unsigned i = 0;
    ssize_t ret = 0;
    while (i < iov_cnt) {
        ssize_t r = do_write
            ? write(fd, iov[i].iov_base, iov[i].iov_len)
            : read(fd, iov[i].iov_base, iov[i].iov_len);
        if (r > 0) {
            ret += r;
        } else if (!r) {
            break;
        } else if (errno == EINTR) {
            continue;
        } else {
            /* else it is some "other" error,
             * only return if there was no data processed. */
            if (ret == 0) {
                ret = -1;
            }
            break;
        }
        i++;
    }
    return ret;
}

//QEMU low level functions www.qemu.org
ssize_t readv(int fd, const struct iovec *iov, int iov_cnt)
{
    return readv_writev(fd, iov, iov_cnt, 0);
}

//QEMU low level functions www.qemu.org
ssize_t writev(int fd, const struct iovec *iov, int iov_cnt)
{
    return readv_writev(fd, iov, iov_cnt, 1);
}